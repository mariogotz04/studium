/* Private Lernpläne: Adapter zum bestehenden Lernstand, Ansicht, Tagesliste und PDF-Export. */
let lpVorschau=null,lpEntwurf=null,lpWoche='',lpDatei=null,lpPdfStand='',lpExportWoche='',lpErfolgTimer=false;
const lpArt={lesen:'Skript',aufgaben:'Aufgaben',quiz:'Quiz',karten:'Karten',probe:'Probeklausur'};
function lpPrüfungen(){return Lernplan.exams(fristen().filter(f=>f.art==='klausur').map(f=>({...f,modules:f.module?.length?f.module:f.modul?[f.modul]:[],duration:f.amtlich?.dauer||klausurInfo(f.modul).dauer})),heuteIso());}
function lpPlan(id=db.get('einst:lernplan',{}).version){
 const p=id?db.get('lernplan:version:'+id,null):null;if(!p)return null;
 const ids=new Set(p.units.map(u=>u.id)),all=[...p.units,...Object.values(db.objekt('lernplan:extra:'+id+':')).filter(u=>!ids.has(u.id))];
 return {...p,mode:'weekly',legacy:p.mode!=='weekly',config:Lernplan.config({...p.config,mode:'weekly'},heuteIso()),units:all};
}
function lpKatalog(plan=lpPlan()){
 const bekannt=plan?new Set(plan.known):null;
 return LERNEN.map(m=>{const r=lernreihe(m.name),st=kartenStand(m.name),exam=klausurInfo(m.name);
  return {name:m.name,pdf:m.pdf,typ:exam.typ,duration:exam.dauer,sections:r.abschnitte.map(s=>{
   const items=[];
   for(const [type,list] of [['aufgaben',s.aufgaben],['quiz',s.quiz],['karten',s.karten]])for(const x of list){
    const saved=type==='aufgaben'?aufgabeStand(x):type==='quiz'?quizStand(x):st[x.id];
    const current=type==='aufgaben'?saved?.s==='ok':type==='quiz'?saved?.ok===true:karteGelernt(saved);
    const extra=bekannt&&!bekannt.has(m.name+'|'+type+'|'+x.id);
    items.push({id:x.id,type,title:type==='aufgaben'?x.t:ohneTags(x.q||x.f||''),
     min:type==='aufgaben'?aufgabeMinuten(x):type==='quiz'?2:.6,ok:current||(s.abgeschlossen&&!extra),seen:!!saved,
     due:type==='karten'&&!!saved&&saved.due<=Date.now(),dueAt:saved?.due||0,reached:r.erreicht(x),source:type==='aufgaben'?x.q:x.s});
   }
   return {key:s.key,label:s.kurz,title:s.quelle?.t||s.kurz,source:s.quelle||null,complete:s.abgeschlossen&&items.every(x=>x.ok),items};
  })};});
}
function lpAktivitäten(){return Object.entries(db.objekt('aktiv:')).map(([k,v])=>({...v,tag:k.slice(0,10)}));}
function lpStand(u,catalog=lpKatalog(),plan=lpPlan()){
 return Lernplan.status({...u,date:lpDatum(u,plan),since:u.since||plan?.created||0},catalog,{manual:db.get('lernplan:manuell:'+u.id,false),latch:db.get('lernplan:abschluss:'+u.id,false),activities:u.review?lpAktivitäten():[]});
}
function lpDatum(u,plan=lpPlan()){
 if(!plan)return u.week!==undefined?u.week:u.date||null;
 const weekly=db.get('lernplan:wochen:'+plan.id,null);
 if(weekly?.weeks&&Object.hasOwn(weekly.weeks,u.id))return weekly.weeks[u.id];
 if(!plan.legacy&&u.week!==undefined)return u.week;
 const automatic=db.get('lernplan:automatik:'+plan.id,null);
 if(automatic?.v===3&&automatic.weeks&&Object.hasOwn(automatic.weeks,u.id))return automatic.weeks[u.id];
 if(automatic?.dates&&Object.hasOwn(automatic.dates,u.id)){const d=automatic.dates[u.id];return plan.mode==='weekly'&&d?Lernplan.week(d):d;}
 if(u.week!==undefined)return u.week;
 const d=db.get('lernplan:datum:'+plan.id+':'+u.id,null)||u.date||null;
 return plan.mode==='weekly'&&d?Lernplan.week(d):d;
}
function lernplanMerken(){
 if(lpErfolgTimer)return;lpErfolgTimer=true;
 queueMicrotask(()=>{lpErfolgTimer=false;const p=lpPlan();if(!p)return;const c=lpKatalog(p);
  for(const u of p.units)if(!db.get('lernplan:abschluss:'+u.id,false)&&lpStand(u,c,p).success)db.set('lernplan:abschluss:'+u.id,{t:Date.now()});
  if(lpDatei&&!pdfAnsicht.hidden&&lpPdfStand!==lpSignatur(p,c)){
   const h=document.getElementById('pdfhinweis');h.hidden=false;h.innerHTML='Dein Lernplan oder Fortschritt hat sich geändert. <button class="btn klein" id="lp-pdf-neu">Aktuellen Plan laden</button>';
   document.getElementById('lp-pdf-neu').onclick=()=>lpPdf(false);
  }
 });
}
function lpVorlesungen(){return PLAN.termine.map(t=>({...t,min:minuten(t.bis)-minuten(t.von)}));}
function lpTageswechsel(p){
 const today=heuteIso();if(!p)return false;
 const current=Lernplan.week(today),previous=db.get('lernplan:wochen:'+p.id,null);
 if(previous?.v===3&&previous.week>=current){
  if(db.get('lernplan:tag:'+p.id,'')<today){db.set('lernplan:tag:'+p.id,today);return true;}return false;
 }
 const cat=lpKatalog(p),weeks=Object.fromEntries(p.units.map(u=>[u.id,lpDatum(u,p)]));
 const states=new Map(p.units.map(u=>[u.id,lpStand(u,cat,p)])),status=u=>states.get(u.id);
 const missed=p.units.filter(u=>{const original=u.week||((u.originalDate||u.date)?Lernplan.week(u.originalDate||u.date):null);return !status(u).done&&(weeks[u.id]?weeks[u.id]<current:original&&original<current);});
 const shifts=Lernplan.carryWeekly(p,today,status,weeks,lpVorlesungen()),nextWeeks={...weeks,...shifts},moved=Object.values(shifts).filter(Boolean).length;
 const note=Object.keys(shifts).length?{week:current,day:today,detected:missed.length,moved}:previous?.note||null;
 // Fällige Karten werden einmal pro Woche nur im verbleibenden Wochenbudget ergänzt.
 const currentUnits=p.units.filter(u=>nextWeeks[u.id]===current);
 let free=Lernplan.weeklyCapacity(p.config,current,lpVorlesungen(),today,currentUnits.filter(u=>status(u).done).reduce((n,u)=>n+Lernplan.cost(u,p.config),0))-currentUnits.reduce((n,u)=>n+Lernplan.cost(u,p.config),0);
 const covered=new Set(p.units.filter(u=>u.type==='karten'&&(nextWeeks[u.id]===current||u.fällig&&!status(u).done)).flatMap(u=>u.targets.map(id=>u.module+'|'+id)));
 for(const m of cat){
  const exam=p.exams.find(e=>e.modules.includes(m.name)&&e.date>today);if(!exam||free<5)continue;
  const cards=m.sections.flatMap(s=>s.items).filter(x=>x.type==='karten'&&x.due&&x.reached&&!covered.has(m.name+'|'+x.id));
  const picked=[];let min=0;for(const x of cards){if(Math.ceil(min+x.min)>Math.min(free,p.config.block))break;picked.push(x);min+=x.min;}
  if(!picked.length)continue;
  const u={id:Lernplan.hash([m.name,'faellig',current,picked.map(x=>x.id+':'+x.dueAt).join(',')].join('|')),module:m.name,type:'karten',section:'faellig',label:'Fällige Wiederholung',title:picked.length+' fällige Karteikarten',targets:picked.map(x=>x.id),min:Math.max(5,Math.ceil(min)),review:true,fällig:true,notBefore:today,date:null,week:current,deadline:exam.date,exam:exam.id,pdf:m.pdf,source:null,since:Date.now()};
  if(Lernplan.cost(u,p.config)>free||p.units.some(x=>x.id===u.id)||!Lernplan.fitsWeek(p.config,[...currentUnits.map(x=>({...x,week:current})),u],current,{today,status:x=>states.get(x.id)||{done:false},lectures:lpVorlesungen()}))continue;
  db.set('lernplan:extra:'+p.id+':'+u.id,u);nextWeeks[u.id]=current;currentUnits.push(u);free-=Lernplan.cost(u,p.config);
 }
 db.set('lernplan:wochen:'+p.id,{v:3,week:current,day:today,weeks:nextWeeks,note});
 db.set('lernplan:tag:'+p.id,today);lernplanMerken();return true;
}
function lpHinweisHtml(p=lpPlan()){
 const note=p&&db.get('lernplan:wochen:'+p.id,null)?.note;if(!note)return '';
 return `<p class="hinweis" role="status">Zum Wochenwechsel angepasst am ${fmtDate(note.day)}: ${note.detected} offene Einheiten aus früheren Wochen erkannt, ${note.moved} Einheiten innerhalb des Wochenbudgets neu verteilt. Erledigte Einheiten bleiben erhalten.</p>`;
}
function lpAnzeigePlan(p,c){
 const missing=p.units.filter(u=>!lpDatum(u,p)&&!lpStand(u,c,p).done).reduce((n,u)=>n+Lernplan.cost(u,p.config),0);
 const warnings=[];
 if(p.overbooked)warnings.push('Erledigte Einheiten belegen in einer Woche mehr als das neue Budget. Ihre Historie bleibt erhalten.');
 if(missing)warnings.push(`${missing} Minuten haben vor den Klausuren noch keine passende Woche. Sie bleiben sichtbar offen; dein Wochenbudget wird eingehalten.`);
 const squeezed=p.units.filter(u=>!u.review&&lpDatum(u,p)&&!lpStand(u,c,p).done&&Lernplan.add(lpDatum(u,p),6)>=Lernplan.add(u.deadline,-10)).length;
 if(squeezed)warnings.push(`${squeezed} Einheiten liegen in Wochen, die sich mit der Wiederholungsphase überschneiden.`);
 const expired=p.units.filter(u=>!lpStand(u,c,p).done&&u.deadline<=heuteIso()).length;
 if(expired)warnings.push(`Bei ${expired} offenen Einheiten ist die Klausurfrist bereits verstrichen. Prüfe die Klausurtermine und die Neuplanung.`);
 return {...p,warnings,missing};
}
function lernplanAutomatikPrüfen(){
 if(document.visibilityState!=='visible'||location.hash.startsWith('#lernen')||document.activeElement?.matches('input,textarea,select'))return;
 const p=lpPlan();if(!p)return;
 if(lpTageswechsel(p)){
  document.getElementById('datum').textContent=new Date().toLocaleDateString('de-DE',{weekday:'long',day:'numeric',month:'long'});
  if(!pdfAnsicht.hidden)lernplanMerken();
  else if(!location.hash||location.hash==='#start'||location.hash.startsWith('#termine/lernplan'))neuZeichnen();
 }
}
function lernplanAutomatikStarten(){
 setInterval(lernplanAutomatikPrüfen,30000);
 document.addEventListener('visibilitychange',lernplanAutomatikPrüfen);
 window.addEventListener('pageshow',lernplanAutomatikPrüfen);
}
function lpSignatur(p,c=lpKatalog(p)){return Lernplan.hash(JSON.stringify({id:p.id,config:p.config,units:p.units.map(u=>[u.id,lpDatum(u,p),lpStand(u,c,p)])}));}
function lpStart(u,p=lpPlan()){
 if(!u)return;if(u.notBefore>heuteIso())return meldung('Diese Wiederholung ist ab '+fmtDate(u.notBefore)+' vorgesehen.');const cat=lpKatalog(p),m=cat.find(m=>m.name===u.module),s=m?.sections.find(s=>s.key===u.section);
 const real=LERNEN.find(m=>m.name===u.module),r=lernreihe(u.module);
 if(!real){location.hash='#lernen';return meldung('Dieses Modul ist nicht mehr verfügbar.');}
 if(u.type==='lesen'){
  const first=s?.items[0],x=[...(real.aufgaben||[]),...(real.quiz||[]),...(DECKS.find(d=>d.name===u.module)?.cards||[])].find(x=>x.id===first?.id);
  if(x&&!r.erreicht(x))return meldung('Dieser Abschnitt kommt später. Schließe zuerst den aktuellen Abschnitt ab.');
  if(m.pdf&&s?.source)pdfOeffnen(m.pdf+'#page='+s.source.p,u.module+' · '+u.label);else location.hash='#lernen/'+encodeURIComponent(u.module);return;
 }
 if(u.type==='probe'){probeStarten(real,false);return;}
 const pool=u.type==='aufgaben'?real.aufgaben:u.type==='quiz'?real.quiz:DECKS.find(d=>d.name===u.module)?.cards;
 const targets=(pool||[]).filter(x=>u.targets.includes(x.id)&&r.erreicht(x));
 if(!targets.length){location.hash='#lernen/'+encodeURIComponent(u.module);return meldung('Die Ziele sind entfernt oder noch gesperrt. Mach mit dem aktuellen Abschnitt weiter.');}
 if(u.type==='aufgaben'){
  const target=targets.find(x=>aufgabeStand(x)?.s!=='ok')||targets[0];location.hash='#lernen/'+encodeURIComponent(u.module)+'/aufgabe/'+target.id;
 }else if(u.type==='quiz')quizStarten(real,{ids:targets.map(x=>x.id)});
 else kartenMitIds(u.module,targets.map(x=>x.id),u.fällig?'fällig':'plan');
}
function lpFreigegeben(u){
 if(u.notBefore>heuteIso())return false;
 const r=lernreihe(u.module),m=LERNEN.find(m=>m.name===u.module),d=DECKS.find(d=>d.name===u.module);
 if(u.type==='probe')return true;
 const pool=u.type==='aufgaben'?m?.aufgaben:u.type==='quiz'?m?.quiz:d?.cards;
 if(u.type==='lesen'){const s=r.abschnitte.find(s=>s.key===u.section);return !s||!r.schritt||s.s<r.schritt.s||s.s===r.schritt.s&&s.nr<=r.schritt.nr;}
 return (pool||[]).some(x=>u.targets.includes(x.id)&&r.erreicht(x));
}
function lpTagesvorschläge(tag){
 let p=lpPlan();if(!p)return null;lpTageswechsel(p);p=lpPlan();const w=Lernplan.week(tag);
 return p.units.filter(u=>lpDatum(u,p)===w).map(u=>({key:'lernplan:'+u.id,art:'lernplan',modul:u.module,kapitel:u.id,plan:p.id,
  titel:u.module+' · '+u.label+' · '+lpArt[u.type],text:`Dein Wochenziel · KW ${Lernplan.kw(w)} · ca. ${u.min} Min. · ${u.title}`,link:'#termine/lernplan/'+w,ids:u.targets}));
}
function lpStartWocheHtml(){
 const p=lpPlan();if(!p)return '';const c=lpKatalog(p),w=Lernplan.week(heuteIso()),us=p.units.filter(u=>lpDatum(u,p)===w),done=us.filter(u=>lpStand(u,c,p).done),open=us.filter(u=>!lpStand(u,c,p).done),minutes=open.reduce((n,u)=>n+Lernplan.cost(u,p.config),0);
 return `<div class="panel lp-startwoche"><div class="kasten-titel"><h2>Diese Woche</h2><span class="tagesfortschritt">${done.length} von ${us.length} erledigt</span></div>${lpHinweisHtml(p)}
 <p><b>Noch ${open.length} Einheiten · ca. ${minutes} Min. einschließlich Pausen</b></p><p class="muted">Du entscheidest, an welchen Tagen du deine Wochenziele erledigst. Innerhalb eines Fachs bleibt die Abschnittsreihenfolge erhalten.</p>
 ${[...new Set(us.map(u=>u.module))].map(name=>{const tasks=us.filter(u=>u.module===name),left=tasks.filter(u=>!lpStand(u,c,p).done),next=left.find(lpFreigegeben),index=next?tagesliste.findIndex(v=>v.kapitel===next.id):-1;return `<div class="lp-startmodul"><div><b>${esc(name)}</b><span>${tasks.length-left.length}/${tasks.length} Einheiten · noch ca. ${left.reduce((n,u)=>n+Lernplan.cost(u,p.config),0)} Min.</span></div>${next?`<button class="btn" data-los="${index}">Starten</button>`:`<span class="muted">${left.length?(left.some(u=>u.notBefore>heuteIso())?'Weitere Ziele ab ihrer Wiederholungsphase':'Zuerst frühere Abschnitte bearbeiten'):'Erledigt'}</span>`}</div>`;}).join('')||'<p class="muted">Für diese Woche sind keine Einheiten eingeplant.</p>'}
 ${p.units.some(u=>!lpDatum(u,p)&&!lpStand(u,c,p).done)?'<p class="hinweis">Es gibt noch Einheiten ohne passende Woche. Prüfe die offenen Ziele im Lernplan.</p>':''}
 <p><a class="btn primary" href="#termine/lernplan/${w}">Alle Wochenaufgaben ansehen</a></p></div>`;
}
function lpTagesstand(v){const p=lpPlan(v.plan),u=p?.units.find(u=>u.id===v.kapitel);if(!u)return {fertig:false,n:0,ziel:1};const s=lpStand(u,lpKatalog(p),p);return {fertig:s.done,automatisch:s.success,n:s.n,ziel:s.total};}
function lpManuell(id,render=true){const p=lpPlan(),u=p?.units.find(u=>u.id===id);if(!u)return;db.set('lernplan:manuell:'+id,!db.get('lernplan:manuell:'+id,false));if(render)lernplanSeite(lpWoche);}
function lpStandard(){return Lernplan.config({mode:'weekly',start:heuteIso(),weeklyMinutes:1500,buffer:.05,block:35,exams:lpPrüfungen().map(e=>e.id)},heuteIso());}
function lpFormConfig(form,today=heuteIso()){
 const f=new FormData(form),off=String(f.get('off')||'').split(/[\s,;]+/).filter(Boolean),valid=d=>/^\d{4}-\d{2}-\d{2}$/.test(d)&&Number.isFinite(Date.parse(d+'T12:00:00Z'))&&new Date(d+'T12:00:00Z').toISOString().slice(0,10)===d;
 if(off.some(d=>!valid(d)))throw new Error('Freie Tage bitte als JJJJ-MM-TT eingeben.');
 if(!valid(f.get('start')))throw new Error('Bitte ein gültiges Startdatum eingeben.');
 return Lernplan.config({mode:'weekly',start:f.get('start'),weeklyMinutes:Math.round(+f.get('weeklyHours')*60),block:+f.get('block'),pause:+f.get('pause'),buffer:+f.get('buffer')/100,off,exams:f.getAll('exam'),focus:f.get('focus'),reading:f.has('reading'),lectures:false},today);
}
function lpBedarfHtml(c,catalog,exams,p){
 const old=p?{...p,units:p.units.map(u=>({...u,week:lpDatum(u,p)}))}:null;
 const b=Lernplan.weeklyBudget(c,catalog,exams,{old,status:u=>lpStand(u,catalog,p),today:heuteIso(),lectures:lpVorlesungen()}),format=n=>`${Math.floor(n/60)} Std.${n%60?' '+n%60+' Min.':''}`;
 const reserve=Math.ceil(c.weeklyMinutes*c.buffer),usable=Math.floor(c.weeklyMinutes*(1-c.buffer));
 return `<h2>Dein Wochenbudget</h2><p class="lp-bedarf-zahl"><b>${format(c.weeklyMinutes)}</b><span>${c.weeklyMinutes} Minuten pro Woche · du teilst sie selbst ein</span></p>
 <div class="lp-bedarf-anteile"><p><b>${format(usable)}</b><span>für Wochenaufgaben einschließlich Pausen verfügbar</span></p><p><b>${format(reserve)}</b><span>als ${Math.round(c.buffer*100)} % Reserve freigehalten</span></p></div>
 ${b.state==='empty'?'<p>Wähle deine Klausuren, um die Wochenziele zu berechnen.</p>':b.state==='impossible'?'<p class="hinweis">Für einzelne Einheiten gibt es vor der Klausur keine passende Woche. Prüfe Startdatum, freie Tage, Klausurtermine und die Einheitenlänge.</p>':`<p>Der Richtwert für den vollständigen bekannten Stoff liegt bei <b>${format(b.weekly)} pro Woche</b>${b.reviewReserved?' einschließlich einer freien Wiederholungsphase':''}.</p>${b.missing?`<p class="hinweis">Bei deinem Budget haben ${b.missing} Minuten noch keine passende Woche. Die Vorschau zeigt die verbleibende Lücke.</p>`:b.squeezed?'<p class="hinweis">Die Einheiten passen ins Budget; einige Wochen überschneiden sich mit der Wiederholungsphase.</p>':'<p>Der bekannte Stoff lässt sich mit diesem Budget vollständig einplanen.</p>'}`}
 <p class="muted">Das Budget gilt für deine verfügbare Zeit neben den Vorlesungen. Die Zeitansätze sind Schätzungen. ${c.buffer<.1?'Mit wenig Reserve bleibt weniger Spielraum zum Nachholen.':''} Eine neue Planung wird erst nach der Vorschau und deinem Übernehmen gespeichert.</p>`;
}
function lpForm(c){const exam=lpPrüfungen();return `<form id="lp-form" class="formular">
 <label>Startdatum<input type="date" name="start" required value="${esc(c.start)}"></label>
 <label>Verfügbare Stunden pro Woche<input type="number" name="weeklyHours" min="0" max="70" step="any" required value="${c.weeklyMinutes/60}"><span class="muted">Einschließlich Pausen und Reserve, neben deinen Vorlesungen.</span></label>
 <label>Einheit in Minuten<input type="number" name="block" min="15" max="90" value="${c.block}" required></label>
 <label>Pause je längerer Einheit<input type="number" name="pause" min="0" max="30" value="${c.pause}" required></label>
 <label>Zeitreserve in Prozent<input type="number" name="buffer" min="0" max="50" step="1" value="${Math.round((c.buffer??.2)*100)}" required><span class="muted">Wird freigehalten, nicht als Lernzeit verplant.</span></label>
 <label>Schwerpunkt<select name="focus"><option value="">Gleichmäßig</option>${alleModule.map(m=>`<option${m===c.focus?' selected':''}>${esc(m)}</option>`).join('')}</select></label>
 <label class="ganz">Freie Tage, optional (ein Datum je Zeile, JJJJ-MM-TT)<textarea name="off" rows="3" placeholder="2026-12-24">${esc(c.off.join('\n'))}</textarea></label>

 <label class="ganz schalter"><input type="checkbox" name="reading"${c.reading?' checked':''}>Skriptlektüre als eigene Einheit einplanen</label>
 <fieldset class="ganz"><legend>Klausuren</legend>${exam.map(e=>`<label class="schalter"><input name="exam" type="checkbox" value="${e.id}"${c.exams.includes(e.id)?' checked':''}>${esc(e.title)} · ${fmtDate(e.date)} · ${esc(e.modules.join(' + '))}</label>`).join('')||'<p>Trage zuerst eine Klausur mit Datum und Modul ein.</p>'}</fieldset>
 <p class="muted ganz">Die vorgegebenen Zeiten sind ein veränderbares Beispiel. Deine eingestellte Zeitreserve bleibt als Puffer frei; Nachholen nutzt sie bei Bedarf. Pausen zählen zum Budget. Aufgabenzeiten sind Schätzungen, Quiz etwa 2 Min. und Karten etwa 0,6 Min.</p>
 <div class="ganz row"><button class="btn primary"${exam.length?'':' disabled'}>Vorschau berechnen</button><span id="lp-formfehler" role="alert"></span></div></form>`;}
function lpEinheit(u,p,c){
 const s=lpStand(u,c,p),free=lpFreigegeben(u),w=lpDatum(u,p),m=c.find(m=>m.name===u.module),source=m?.sections.find(s=>s.key===u.section)?.source;
 const window=w?Lernplan.windowFor(u,w,p.config):null,dates=window?[window.from>w?'Ab '+fmtDate(window.from):'',window.until<Lernplan.add(w,6)?'Spätestens '+fmtDate(window.until):''].filter(Boolean).join(' · '):'';
 return `<div class="lp-einheit${s.done?' erledigt':''}" id="lp-${u.id}"><button class="haken${s.done?' an':''}" data-lp-haken="${u.id}" aria-label="${s.manual?'Manuellen Haken entfernen':'Manuell erledigt markieren'}: ${esc(u.title)}" aria-pressed="${s.done}">${s.done?'✓':''}</button>
 <div class="was"><b>${esc(u.label)} · ${esc(lpArt[u.type])}</b><span>${esc(u.title)} · ca. ${u.min} Min.${u.min>=20?' + '+p.config.pause+' Min. Pause':''}</span>
 <span>${s.success?'Erfolgreich abgeschlossen':s.manual?'Manuell erledigt':s.worked?'Bearbeitet, noch offen':u.notBefore>heuteIso()?'Verfügbar ab '+fmtDate(u.notBefore):free?'Offen':'Zuerst den vorherigen Abschnitt abschließen'}${s.total>1?' · '+s.n+'/'+s.total+' Ziele':''}</span>
 ${dates?`<span class="lp-frist">${esc(dates)}</span>`:''}${!s.done&&u.deadline<=heuteIso()?'<span class="hinweis">Klausurfrist bereits verstrichen</span>':''}${source?quellenLink(m.pdf,source):''}</div>
 <button class="btn" data-lp-start="${u.id}"${free?'':' disabled'}>${u.type==='lesen'?'Lesen':s.done?'Noch einmal':'Starten'}</button></div>`;
}
function lpWochenliste(p,c,w){
 const us=p.units.filter(u=>lpDatum(u,p)===w),done=us.filter(u=>lpStand(u,c,p).done),open=us.filter(u=>!lpStand(u,c,p).done),total=us.reduce((n,u)=>n+Lernplan.cost(u,p.config),0),remaining=open.reduce((n,u)=>n+Lernplan.cost(u,p.config),0),budget=Lernplan.weeklyCapacity(p.config,w,lpVorlesungen(),p.config.start,done.reduce((n,u)=>n+Lernplan.cost(u,p.config),0));
 return `<p class="lp-wochenfortschritt"><b>${done.length} von ${us.length} Einheiten erledigt</b> · noch ${open.length} Einheiten mit ca. ${remaining} Min. einschließlich Pausen</p>
 <progress class="lp-fortschritt" value="${done.length}" max="${Math.max(1,us.length)}" aria-label="Fortschritt dieser Woche"></progress>
 <p class="muted">${Lernplan.add(w,6)<p.config.start?'Abgeschlossene Wochenhistorie · '+total+' Min. ursprüngliche Ziele.':total+' / '+budget+' Min. belegt · '+Math.max(0,budget-total)+' Min. frei einschließlich Reserve.'} Du entscheidest, wann du diese Woche lernst. Fristen und Beginn der Wiederholungen stehen bei den betreffenden Einheiten.</p>
 ${[...new Set(us.map(u=>u.module))].map(name=>{const tasks=us.filter(u=>u.module===name),finished=tasks.filter(u=>lpStand(u,c,p).done).length;return `<details class="lp-wochenmodul" open><summary><b>${esc(name)}</b><span>${finished}/${tasks.length} erledigt · ca. ${tasks.filter(u=>!lpStand(u,c,p).done).reduce((n,u)=>n+Lernplan.cost(u,p.config),0)} Min. offen</span></summary>${tasks.map(u=>lpEinheit(u,p,c)).join('')}</details>`;}).join('')||'<p class="muted">Für diese Woche sind keine Einheiten eingeplant.</p>'}`;
}
function lpKapitel(c){return c.map(m=>{const chapters=new Map();for(const s of m.sections){const k=s.label.replace(/Abschnitt (\d+)\.\d+/, 'Kapitel $1');if(!chapters.has(k))chapters.set(k,[]);chapters.get(k).push(s);}
 return `<details class="lp-modul"><summary>${esc(m.name)} · ${m.sections.filter(s=>s.complete).length}/${m.sections.length} Abschnitte</summary>${[...chapters].map(([name,ss])=>`<p>${ss.every(s=>s.complete)?'☑':'☐'} <b>${esc(name)}</b> · ${ss.filter(s=>s.complete).length}/${ss.length} Abschnitte abgeschlossen</p>`).join('')}</details>`;}).join('');}
function lernplanSeite(woche){
 const today=heuteIso();let p=lpPlan();lpTageswechsel(p);p=lpPlan();lpWoche=woche&&/^\d{4}-\d{2}-\d{2}$/.test(woche)?Lernplan.week(woche):Lernplan.week(today);
 const c=lpKatalog(p),exams=lpPrüfungen(),cfg=lpEntwurf||p?.config||lpStandard();
 if(p)p=lpAnzeigePlan(p,c);
 kopf('Dein Wochenplan','Deine Aufgaben für die Woche – du teilst die Zeit selbst ein');
 const changed=p&&p.signature!==Lernplan.signature(c,exams,p.config),weeks=p?[...new Set([...p.units.map(u=>lpDatum(u,p)).filter(Boolean).map(Lernplan.week),Lernplan.week(today)])].sort():[];
 const missing=alleModule.filter(m=>!exams.some(e=>e.modules.includes(m)));
 termineView.innerHTML=`<div class="lp-kopf row"><a href="#termine">← Termine</a><span class="muted">${p?'Planversion '+(p.number||1):'Noch kein persönlicher Plan'}</span></div>
 ${lpHinweisHtml(p)}
 ${p?.legacy?'<p class="hinweis">Dein bisheriger Plan wird nach Wochen angezeigt. Lernstand und Ziele bleiben erhalten. Für eine neue Verteilung prüfe die Neuplanung mit einem Wochenbudget.</p>':''}
 ${changed?'<div class="hinweis">Klausuren oder Inhalte haben sich geändert. Prüfe eine Neuplanung; erreichte Abschlüsse bleiben erhalten.</div>':''}
 <section class="panel lp-bedarf" id="lp-wochenbedarf" aria-live="polite">${lpBedarfHtml(cfg,c,exams,p)}</section>
 <details class="panel"${!p||lpVorschau?' open':''}><summary><b>${p?'Zeitbudget und Neuplanung':'Deinen Lernplan erstellen'}</b></summary>${lpForm(cfg)}</details>
 ${lpVorschau?`<div class="panel lp-vorschau"><h2>Vorschau der ${p?'Neuplanung':'Planung'}</h2><p>${lpVorschau.units.length} Einheiten bis ${fmtDate(lpVorschau.end)}. ${p?'Erledigte Einheiten und ihr Lernstand bleiben erhalten.':'Erst nach Übernehmen wird dein persönlicher Plan gespeichert.'}</p>
 ${lpVorschau.warnings.map(w=>`<p class="hinweis">${esc(w)}</p>`).join('')}${p?`<p>${lpVorschau.units.filter(u=>{const old=p.units.find(x=>x.id===u.id);return old&&lpDatum(old,p)!==u.week;}).length} vorhandene Einheiten werden verschoben.</p>`:''}
 <p>${lpVorschau.units.filter(u=>u.week).slice(0,5).map(u=>esc('KW '+Lernplan.kw(u.week)+' · '+u.module+' · '+u.label+' · '+lpArt[u.type])).join('<br>')}</p>
 <div class="row"><button class="btn primary" id="lp-uebernehmen">${p?'Neuplanung übernehmen':'Plan übernehmen'}</button><button class="btn" id="lp-verwerfen">Vorschau verwerfen</button></div></div>`:''}
 ${p?`<div class="panel"><div class="kasten-titel"><h2>Dein Plan</h2><a href="#start">Wochenübersicht auf Start →</a></div>
 <p>Kapitel sind abgeschlossen, wenn Aufgaben selbst gelöst, Quizfragen richtig und Karten gelernt sind. Manuelle Haken zählen als eigene Bearbeitung und ändern den Lernpfad nicht.</p>
 <div class="row"><button class="btn primary" id="lp-pdf">PDF öffnen</button><button class="btn" id="lp-download">PDF herunterladen</button><button class="btn" id="lp-wochenpdf">Diese Woche als PDF</button></div>
 <p class="muted">Die PDF übernimmt den aktuellen Stand. Bereits heruntergeladene Fassungen ändern sich nicht automatisch.</p>
 ${p.warnings.map(w=>`<p class="hinweis">${esc(w)}</p>`).join('')}${missing.length?`<p class="muted">Termin fehlt: ${esc(missing.join(', '))}. Diese Module sind noch nicht eingeplant.</p>`:''}</div>
 <div class="panel"><div class="kasten-titel lp-wochenkopf"><h2>Wochenaufgaben</h2><select id="lp-woche" aria-label="Woche auswählen">${weeks.map(w=>`<option value="${w}"${w===lpWoche?' selected':''}>KW ${Lernplan.kw(w)} · ${fmtDate(w)}</option>`).join('')}</select></div>
 ${lpWochenliste(p,c,lpWoche)}</div>
 ${p.units.some(u=>!lpDatum(u,p)&&!lpStand(u,c,p).done)?`<details class="panel"><summary>Noch ohne Termin</summary>${p.units.filter(u=>!lpDatum(u,p)&&!lpStand(u,c,p).done).map(u=>lpEinheit(u,p,c)).join('')}</details>`:''}
 <details class="panel"><summary>Kapitel und Fortschritt</summary>${lpKapitel(c.filter(m=>p.exams.some(e=>e.modules.includes(m.name))))}</details>
 ${p.units.filter(u=>lpDatum(u,p)&&lpDatum(u,p)<Lernplan.week(today)&&!lpStand(u,c,p).done).length?'<p class="hinweis">Es gibt offene Einheiten aus früheren Wochen. Prüfe das Wochenbudget und die Neuplanung.</p>':''}`:'<p class="muted">Dein Plan wird privat gespeichert und mit dem bestehenden Lernstand synchronisiert.</p>'}`;
 const form=document.getElementById('lp-form');let bedarfTimer;
 form.oninput=()=>{
  clearTimeout(bedarfTimer);lpVorschau=null;termineView.querySelector('.lp-vorschau')?.remove();
  bedarfTimer=setTimeout(()=>{
   if(!form.isConnected)return;
   const output=document.getElementById('lp-wochenbedarf');
   if(!form.checkValidity()){output.innerHTML='<h2>Lernzeit und Reserve pro Woche</h2><p>Vervollständige die gültigen Angaben für die Berechnung.</p>';return;}
   try{
    const config=lpFormConfig(form,today);
    if(config.start<today&&!p)throw new Error('Das Startdatum darf nicht in der Vergangenheit liegen.');
    lpEntwurf=config;output.innerHTML=lpBedarfHtml(config,c,exams,p);document.getElementById('lp-formfehler').textContent='';
   }catch(err){output.innerHTML='<h2>Lernzeit und Reserve pro Woche</h2><p>'+esc(err.message)+'</p>';}
  },250);
 };
 form.onsubmit=e=>{
  e.preventDefault();clearTimeout(bedarfTimer);
  try{lpEntwurf=lpFormConfig(form,today);}catch(err){document.getElementById('lp-formfehler').textContent=err.message;return;}
  if(!lpEntwurf.exams.length){document.getElementById('lp-formfehler').textContent='Bitte mindestens eine Klausur auswählen.';return;}
  if(lpEntwurf.start<today&&!p){document.getElementById('lp-formfehler').textContent='Das Startdatum darf nicht in der Vergangenheit liegen.';return;}
  try{const old=p?{...p,units:p.units.map(u=>({...u,week:lpDatum(u,p)}))}:null;
   lpVorschau=Lernplan.create(lpEntwurf,c,exams,{old,status:u=>lpStand(u,c,p),today,lectures:lpVorlesungen(),version:neueId()});lernplanSeite(lpWoche);
  }catch(err){document.getElementById('lp-formfehler').textContent=err.message;}
 };
 document.getElementById('lp-uebernehmen')?.addEventListener('click',()=>{
  const v=lpVorschau;for(const u of v.units)if(!u.since)u.since=v.created;
  db.set('lernplan:version:'+v.id,v);
  if(!localStorage.getItem('db:lernplan:version:'+v.id)){meldung('Der Gerätespeicher ist voll. Dein bisheriger Plan bleibt aktiv. Sichere deinen Lernstand und schaffe Speicherplatz.',8000);return;}
  db.set('einst:lernplan',{version:v.id});db.set('lernplan:tag:'+v.id,today);
  const versions=Object.entries(db.objekt('lernplan:version:')).sort((a,b)=>b[1].created-a[1].created);
  for(const [id] of versions.slice(2))if(id!==v.id)db.set('lernplan:version:'+id,null);
  lpVorschau=null;lpEntwurf=null;lernplanMerken();lernplanSeite(lpWoche);meldung('Dein Lernplan ist gespeichert.');
 });
 document.getElementById('lp-verwerfen')?.addEventListener('click',()=>{lpVorschau=null;lpEntwurf=null;lernplanSeite(lpWoche);});
 document.getElementById('lp-woche')?.addEventListener('change',e=>{location.hash='#termine/lernplan/'+e.target.value;});
 termineView.querySelectorAll('[data-lp-start]').forEach(b=>b.onclick=()=>lpStart(p.units.find(u=>u.id===b.dataset.lpStart),p));
 termineView.querySelectorAll('[data-lp-haken]').forEach(b=>b.onclick=()=>lpManuell(b.dataset.lpHaken));
 document.getElementById('lp-pdf')?.addEventListener('click',()=>lpPdf(false));
 document.getElementById('lp-download')?.addEventListener('click',()=>lpPdf(true));
 document.getElementById('lp-wochenpdf')?.addEventListener('click',()=>lpPdf(true,lpWoche));
 lernplanMerken();
}
async function lpPdf(download=false,week=''){
 let p=lpPlan();if(!p)return;lpTageswechsel(p);p=lpAnzeigePlan(lpPlan(),lpKatalog());const buttons=[...termineView.querySelectorAll('#lp-pdf,#lp-download,#lp-wochenpdf')];buttons.forEach(b=>b.disabled=true);
 try{
  const shareButton=document.getElementById(week?'lp-wochenpdf':'lp-download');
  if(APP&&download&&lpDatei&&lpExportWoche===week&&lpPdfStand===lpSignatur(p)) { await pdfSichern(lpDatei,shareButton);return; }
  if(!window.LernplanPDF)await new Promise((resolve,reject)=>{const s=document.createElement('script');s.src='lernplan-pdf.js'+new URL(document.querySelector('script[src^="lernplan-ui.js"]').src).search;s.onload=resolve;s.onerror=()=>reject(Error('Die PDF-Funktion konnte nicht geladen werden.'));document.head.appendChild(s);});
  const c=lpKatalog(p),bytes=await LernplanPDF.create({plan:p,catalog:c,week,status:u=>lpStand(u,c,p),date:u=>lpDatum(u,p),base:new URL(location.pathname,location.origin).href,lectures:lpVorlesungen()});
  if(lpDatei){URL.revokeObjectURL(lpDatei);pdfDateien.delete(lpDatei);}lpDatei=URL.createObjectURL(new Blob([bytes],{type:'application/pdf'}));lpPdfStand=lpSignatur(p,c);lpExportWoche=week;
  if(download&&APP)await pdfSichern(lpDatei,shareButton);
  else if(download){const a=Object.assign(document.createElement('a'),{href:lpDatei,download:'Lernplan'+(week?' KW '+Lernplan.kw(week):'')+' Stand '+heuteIso()+'.pdf'});a.setAttribute('data-pdf-direkt','');document.body.appendChild(a);a.click();a.remove();}
  else await pdfOeffnen(lpDatei,'Dein Lernplan');
 }catch(e){meldung(e.message||'Die PDF konnte nicht erzeugt werden.',6000);}finally{buttons.forEach(b=>b.disabled=false);}
}

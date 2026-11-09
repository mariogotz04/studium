/* Private Lernpläne: Adapter zum bestehenden Lernstand, Ansicht, Tagesliste und PDF-Export. */
let lpVorschau=null,lpEntwurf=null,lpWoche='',lpDatei=null,lpPdfStand='',lpExportWoche='',lpErfolgTimer=false;
const lpArt={lesen:'Skript',aufgaben:'Aufgaben',quiz:'Quiz',karten:'Karten',probe:'Probeklausur'};
function lpPrüfungen(){return Lernplan.exams(fristen().filter(f=>f.art==='klausur').map(f=>({...f,modules:f.module?.length?f.module:f.modul?[f.modul]:[],duration:f.amtlich?.dauer||klausurInfo(f.modul).dauer})),heuteIso());}
function lpPlan(id=db.get('einst:lernplan',{}).version){const p=id?db.get('lernplan:version:'+id,null):null;if(!p)return null;
 const ids=new Set(p.units.map(u=>u.id));return {...p,units:[...p.units,...Object.values(db.objekt('lernplan:extra:'+id+':')).filter(u=>!ids.has(u.id))]};}
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
 if(!plan)return u.date||null;
 const automatic=db.get('lernplan:automatik:'+plan.id,null);
 if(automatic?.dates&&Object.hasOwn(automatic.dates,u.id))return automatic.dates[u.id];
 return db.get('lernplan:datum:'+plan.id+':'+u.id,null)||u.date||null;
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
 const previous=db.get('lernplan:automatik:'+p.id,null);
 if(previous?.v===2&&previous.day>=today&&db.get('lernplan:tag:'+p.id,'')>=today)return false;
 const cat=lpKatalog(p),dates=Object.fromEntries(p.units.map(u=>[u.id,lpDatum(u,p)]));
 const states=new Map(p.units.map(u=>[u.id,lpStand(u,cat,p)])),status=u=>states.get(u.id);
 const missed=p.units.filter(u=>!status(u).done&&(dates[u.id]?dates[u.id]<today:(u.originalDate||u.date||p.config.start)<today));
 const shifts=Lernplan.carry(p,today,status,dates,lpVorlesungen()),nextDates={...dates,...shifts};
 const moved=Object.values(shifts).filter(Boolean).length;
 const note=Object.keys(shifts).length?{day:today,detected:missed.length,moved}:previous?.note||null;
 // Eine zusammenhängende Terminverteilung synchronisieren; keine halben Tagespläne aus zwei Geräten mischen.
 db.set('lernplan:automatik:'+p.id,{v:2,day:today,dates:nextDates,note});
 // Neu fällige Karten aus dem freigegebenen Stoff nutzen nur noch freien Tagespuffer.
 let free=Lernplan.capacity(p.config,today,lpVorlesungen())-p.units.filter(u=>lpDatum(u,p)===today).reduce((s,u)=>s+Lernplan.cost(u,p.config),0);
 const covered=new Set(p.units.filter(u=>u.type==='karten'&&(lpDatum(u,p)===today||u.fällig&&!lpStand(u,cat,p).done)).flatMap(u=>u.targets.map(id=>u.module+'|'+id)));
 for(const m of cat){
  const exam=p.exams.find(e=>e.modules.includes(m.name)&&e.date>today);if(!exam||free<5)continue;
  const cards=m.sections.flatMap(s=>s.items).filter(x=>x.type==='karten'&&x.due&&x.reached&&!covered.has(m.name+'|'+x.id));
  const picked=[];let min=0;for(const x of cards){if(Math.ceil(min+x.min)>Math.min(free,p.config.block))break;picked.push(x);min+=x.min;}
  if(!picked.length)continue;
  const u={id:Lernplan.hash([m.name,'faellig','karten',picked.map(x=>x.id).join(','),'due-'+picked.map(x=>x.id+':'+x.dueAt).join(',')].join('|')),module:m.name,type:'karten',section:'faellig',label:'Fällige Wiederholung',title:picked.length+' fällige Karteikarten',targets:picked.map(x=>x.id),min:Math.max(5,Math.ceil(min)),review:true,fällig:true,notBefore:today,date:today,deadline:exam.date,exam:exam.id,pdf:m.pdf,source:null,since:Date.now()};
  if(Lernplan.cost(u,p.config)>free||p.units.some(x=>x.id===u.id))continue;
  db.set('lernplan:extra:'+p.id+':'+u.id,u);free-=Lernplan.cost(u,p.config);
 }
 db.set('lernplan:tag:'+p.id,today);
 lernplanMerken();return true;
}
function lpHinweisHtml(p=lpPlan()){
 const note=p&&db.get('lernplan:automatik:'+p.id,null)?.note;if(!note)return '';
 return `<p class="hinweis" role="status">Automatisch angepasst am ${fmtDate(note.day)}: ${note.detected} nicht erledigte ${note.detected===1?'Einheit erkannt':'Einheiten erkannt'}, ${note.moved} offene ${note.moved===1?'Einheit auf einen neuen Lerntag verteilt':'Einheiten auf neue Lerntage verteilt'}. Erledigte Einheiten bleiben erhalten.</p>`;
}
function lpAnzeigePlan(p,c){
 const missing=p.units.filter(u=>!lpDatum(u,p)&&!lpStand(u,c,p).done).reduce((n,u)=>n+Lernplan.cost(u,p.config),0);
 const warnings=p.warnings.filter(w=>!/^\d+ (Minuten passen|Einheiten liegen)/.test(w));
 if(missing)warnings.push(`${missing} Minuten haben vor den Klausuren noch keinen passenden Termin. Bitte erhöhe bei Bedarf deine Lernzeit oder passe freie Tage und Einheitenlänge an.`);
 const squeezed=p.units.filter(u=>!u.review&&lpDatum(u,p)&&lpDatum(u,p)>=heuteIso()&&lpDatum(u,p)>=Lernplan.add(u.deadline,-10)).length;
 if(squeezed)warnings.push(`${squeezed} Einheiten liegen in der vorgesehenen Wiederholungsphase. Dafür bleibt weniger Wiederholungszeit.`);
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
 if(!u)return;const cat=lpKatalog(p),m=cat.find(m=>m.name===u.module),s=m?.sections.find(s=>s.key===u.section);
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
 const r=lernreihe(u.module),m=LERNEN.find(m=>m.name===u.module),d=DECKS.find(d=>d.name===u.module);
 if(u.type==='probe')return true;
 const pool=u.type==='aufgaben'?m?.aufgaben:u.type==='quiz'?m?.quiz:d?.cards;
 if(u.type==='lesen'){const s=r.abschnitte.find(s=>s.key===u.section);return !s||!r.schritt||s.s<r.schritt.s||s.s===r.schritt.s&&s.nr<=r.schritt.nr;}
 return (pool||[]).some(x=>u.targets.includes(x.id)&&r.erreicht(x));
}
function lpTagesvorschläge(tag){
 let p=lpPlan();if(!p)return null;lpTageswechsel(p);p=lpPlan();
 return p.units.filter(u=>lpDatum(u,p)===tag).map(u=>({key:'lernplan:'+u.id,art:'lernplan',modul:u.module,kapitel:u.id,plan:p.id,
  titel:u.module+' · '+u.label+' · '+lpArt[u.type],text:`Aus deinem Lernplan · KW ${Lernplan.kw(tag)} · ca. ${u.min} Min. · ${u.title}`,link:'#termine/lernplan/'+Lernplan.week(tag),ids:u.targets}));
}
function lpTagesstand(v){const p=lpPlan(v.plan),u=p?.units.find(u=>u.id===v.kapitel);if(!u)return {fertig:false,n:0,ziel:1};const s=lpStand(u,lpKatalog(p),p);return {fertig:s.done,automatisch:s.success,n:s.n,ziel:s.total};}
function lpManuell(id,render=true){const p=lpPlan(),u=p?.units.find(u=>u.id===id);if(!u)return;db.set('lernplan:manuell:'+id,!db.get('lernplan:manuell:'+id,false));if(render)lernplanSeite(lpWoche);}
function lpStandard(){return Lernplan.config({start:heuteIso(),minutes:[60,60,60,60,60,90,0],block:35,exams:lpPrüfungen().map(e=>e.id)},heuteIso());}
function lpFormConfig(form,today=heuteIso()){
 const f=new FormData(form),off=String(f.get('off')||'').split(/[\s,;]+/).filter(Boolean),valid=d=>/^\d{4}-\d{2}-\d{2}$/.test(d)&&Number.isFinite(Date.parse(d+'T12:00:00Z'))&&new Date(d+'T12:00:00Z').toISOString().slice(0,10)===d;
 if(off.some(d=>!valid(d)))throw new Error('Freie Tage bitte als JJJJ-MM-TT eingeben.');
 if(!valid(f.get('start')))throw new Error('Bitte ein gültiges Startdatum eingeben.');
 return Lernplan.config({start:f.get('start'),block:+f.get('block'),pause:+f.get('pause'),buffer:+f.get('buffer')/100,minutes:Array.from({length:7},(_,i)=>+f.get('min'+i)),off,exams:f.getAll('exam'),focus:f.get('focus'),reading:f.has('reading'),lectures:f.has('lectures')},today);
}
function lpBedarfHtml(c,catalog,exams,p){
 const old=p?{...p,units:p.units.map(u=>({...u,date:lpDatum(u,p)}))}:null;
 const b=Lernplan.weeklyBudget(c,catalog,exams,{old,status:u=>lpStand(u,catalog,p),today:heuteIso(),lectures:lpVorlesungen()});
 if(b.state==='empty')return '<h2>Lernzeit und Reserve pro Woche</h2><p>Wähle deine Klausuren aus, um den Wochenbedarf zu berechnen.</p>';
 if(b.state==='impossible')return '<h2>Lernzeit und Reserve pro Woche</h2><p class="hinweis">Mit diesen Lerntagen und Terminen lässt sich der Plan auch mit dem höchsten Tagesbudget nicht vollständig verteilen. Prüfe zusätzliche Lerntage, freie Tage, Startdatum und die Länge einzelner Einheiten.</p><p class="muted">Aktuell eingetragen: '+b.current+' Min./Woche. Die Tagesgrenze liegt bei 600 Minuten, mit Vorlesungen gegebenenfalls darunter.</p>';
 const extra=Math.max(0,b.weekly-b.current),hours=Math.floor(b.weekly/60),minutes=b.weekly%60,format=n=>`${Math.floor(n/60)} Std.${n%60?' '+n%60+' Min.':''}`,buffer=Math.round((c.buffer??.2)*100);
 const comparison=extra?`Für den Richtwert fehlen noch <b>${extra} Min./Woche</b>.`:b.missing?`Bei deiner aktuellen Verteilung haben noch <b>${b.missing} Minuten</b> keinen Termin. Prüfe die Tagesverteilung und die Vorschau.`:'Dein eingetragenes Wochenbudget reicht für die berechnete Planung aus.';
 return `<h2>Lernzeit und Reserve pro Woche</h2><p class="lp-bedarf-zahl">ca. <b>${b.weekly} Min./Woche</b><span>${hours} Std.${minutes?' '+minutes+' Min.':''} verfügbares Wochenbudget einschließlich Reserve</span></p>
 <div class="lp-bedarf-anteile"><p><b>${format(b.scheduledWeeklyMax)}</b><span>höchstens pro Woche für Lernen und Pausen verplant</span></p><p><b>${format(b.reserveWeekly)}</b><span>zusätzlich als ${buffer} % Reserve in einer vollen Woche freigehalten</span></p></div>
 <p>Aktuell eingetragen: <b>${b.current} Min./Woche</b>. ${comparison}</p>
 <p class="muted">${b.balanced?'Richtwert bei gleichmäßiger Verteilung auf sieben Lerntage.':'Richtwert für deine aktuelle Tagesverteilung auf '+b.days+' Lerntage.'} Freie Tage${c.lectures?', Vorlesungen':''} und Klausurtermine sind berücksichtigt. ${b.reviewReserved?'Die letzten zehn Tage vor jeder Klausur bleiben für Wiederholung frei.':'Die vorgesehene Wiederholungsphase bleibt dabei verkürzt.'} ${buffer<10?'Mit weniger als 10 % Reserve bleibt wenig Spielraum zum Nachholen.':''}</p>
 <p class="muted">Verteile die Minuten unten selbst. Der Bedarf aktualisiert sich bei Änderungen; prüfe danach die Vorschau. Gilt für den derzeit bekannten Lernstoff.</p>`;
}
function lpForm(c){const exam=lpPrüfungen();return `<form id="lp-form" class="formular">
 <label>Startdatum<input type="date" name="start" required value="${esc(c.start)}"></label>
 <label>Einheit in Minuten<input type="number" name="block" min="15" max="90" value="${c.block}" required></label>
 <label>Pause je längerer Einheit<input type="number" name="pause" min="0" max="30" value="${c.pause}" required></label>
 <label>Zeitreserve in Prozent<input type="number" name="buffer" min="0" max="50" step="1" value="${Math.round((c.buffer??.2)*100)}" required><span class="muted">Wird freigehalten, nicht als Lernzeit verplant.</span></label>
 <label>Schwerpunkt<select name="focus"><option value="">Gleichmäßig</option>${alleModule.map(m=>`<option${m===c.focus?' selected':''}>${esc(m)}</option>`).join('')}</select></label>
 <fieldset class="ganz lp-budget"><legend>Lernminuten je Wochentag</legend>${['Mo','Di','Mi','Do','Fr','Sa','So'].map((t,i)=>`<label>${t}<input aria-label="Lernminuten ${t}" name="min${i}" type="number" min="0" max="600" required value="${c.minutes[i]}"></label>`).join('')}</fieldset>
 <label class="ganz">Freie Tage (ein Datum je Zeile, JJJJ-MM-TT)<textarea name="off" rows="3" placeholder="2026-12-24">${esc(c.off.join('\n'))}</textarea></label>
 <label class="ganz schalter"><input type="checkbox" name="lectures"${c.lectures?' checked':''}>Vorlesungszeiten berücksichtigen (höchstens 8 Stunden Vorlesung und Lernen zusammen)</label>
 <label class="ganz schalter"><input type="checkbox" name="reading"${c.reading?' checked':''}>Skriptlektüre als eigene Einheit einplanen</label>
 <fieldset class="ganz"><legend>Klausuren</legend>${exam.map(e=>`<label class="schalter"><input name="exam" type="checkbox" value="${e.id}"${c.exams.includes(e.id)?' checked':''}>${esc(e.title)} · ${fmtDate(e.date)} · ${esc(e.modules.join(' + '))}</label>`).join('')||'<p>Trage zuerst eine Klausur mit Datum und Modul ein.</p>'}</fieldset>
 <p class="muted ganz">Die vorgegebenen Zeiten sind ein veränderbares Beispiel. Deine eingestellte Zeitreserve bleibt als Puffer frei; Nachholen nutzt sie bei Bedarf. Pausen zählen zum Budget. Aufgabenzeiten sind Schätzungen, Quiz etwa 2 Min. und Karten etwa 0,6 Min.</p>
 <div class="ganz row"><button class="btn primary"${exam.length?'':' disabled'}>Vorschau berechnen</button><span id="lp-formfehler" role="alert"></span></div></form>`;}
function lpEinheit(u,p,c){const s=lpStand(u,c,p),free=lpFreigegeben(u),d=lpDatum(u,p),m=c.find(m=>m.name===u.module),source=m?.sections.find(s=>s.key===u.section)?.source;return `<div class="lp-einheit${s.done?' erledigt':''}" id="lp-${u.id}">
 <button class="haken${s.done?' an':''}" data-lp-haken="${u.id}" aria-label="${s.manual?'Manuellen Haken entfernen':'Manuell erledigt markieren'}: ${esc(u.title)}" aria-pressed="${s.done}">${s.done?'✓':''}</button>
 <div class="was"><b>${esc(u.module)} · ${esc(u.label)}</b><span>${esc(lpArt[u.type])} · ca. ${u.min} Min.${u.min>=20?' + '+p.config.pause+' Min. Pause':''} · ${esc(u.title)}</span>
 <span>${s.success?'Erfolgreich abgeschlossen':s.manual?'Manuell erledigt':s.worked?'Bearbeitet, noch offen':free?'Offen':'Wartet auf den vorherigen Abschnitt'}${s.total>1?' · '+s.n+'/'+s.total+' Ziele':''}${u.date&&d!==u.date?' · '+(d?'Verschoben vom ':'Ursprünglich geplant am ')+fmtDate(u.originalDate||u.date):''}</span>
 ${source?quellenLink(m.pdf,source):''}</div><button class="btn" data-lp-start="${u.id}"${free?'':' disabled'}>${u.type==='lesen'?'Lesen':s.done?'Noch einmal':'Starten'}</button></div>`;}
function lpKapitel(c){return c.map(m=>{const chapters=new Map();for(const s of m.sections){const k=s.label.replace(/Abschnitt (\d+)\.\d+/, 'Kapitel $1');if(!chapters.has(k))chapters.set(k,[]);chapters.get(k).push(s);}
 return `<details class="lp-modul"><summary>${esc(m.name)} · ${m.sections.filter(s=>s.complete).length}/${m.sections.length} Abschnitte</summary>${[...chapters].map(([name,ss])=>`<p>${ss.every(s=>s.complete)?'☑':'☐'} <b>${esc(name)}</b> · ${ss.filter(s=>s.complete).length}/${ss.length} Abschnitte abgeschlossen</p>`).join('')}</details>`;}).join('');}
function lernplanSeite(woche){
 const today=heuteIso();let p=lpPlan();lpTageswechsel(p);p=lpPlan();lpWoche=woche&&/^\d{4}-\d{2}-\d{2}$/.test(woche)?Lernplan.week(woche):Lernplan.week(today);
 const c=lpKatalog(p),exams=lpPrüfungen(),cfg=lpEntwurf||p?.config||lpStandard();
 if(p)p=lpAnzeigePlan(p,c);
 kopf('Lernplan','Deine Klausuren, Wochen und nächsten Schritte');
 const changed=p&&p.signature!==Lernplan.signature(c,exams,p.config),weeks=p?[...new Set([...p.units.map(u=>lpDatum(u,p)).filter(Boolean).map(Lernplan.week),Lernplan.week(today)])].sort():[];
 const missing=alleModule.filter(m=>!exams.some(e=>e.modules.includes(m)));
 termineView.innerHTML=`<div class="lp-kopf row"><a href="#termine">← Termine</a><span class="muted">${p?'Planversion '+(p.number||1):'Noch kein persönlicher Plan'}</span></div>
 ${lpHinweisHtml(p)}
 ${changed?'<div class="hinweis">Klausuren oder Inhalte haben sich geändert. Prüfe eine Neuplanung; erreichte Abschlüsse bleiben erhalten.</div>':''}
 <section class="panel lp-bedarf" id="lp-wochenbedarf" aria-live="polite">${lpBedarfHtml(cfg,c,exams,p)}</section>
 <details class="panel"${!p||lpVorschau?' open':''}><summary><b>${p?'Zeitbudget und Neuplanung':'Deinen Lernplan erstellen'}</b></summary>${lpForm(cfg)}</details>
 ${lpVorschau?`<div class="panel lp-vorschau"><h2>Vorschau der ${p?'Neuplanung':'Planung'}</h2><p>${lpVorschau.units.length} Einheiten bis ${fmtDate(lpVorschau.end)}. ${p?'Erledigte Einheiten und der aktuelle Tag bleiben erhalten.':'Erst nach Übernehmen wird dein persönlicher Plan gespeichert.'}</p>
 ${lpVorschau.warnings.map(w=>`<p class="hinweis">${esc(w)}</p>`).join('')}${p?`<p>${lpVorschau.units.filter(u=>{const old=p.units.find(x=>x.id===u.id);return old&&lpDatum(old,p)!==u.date;}).length} vorhandene Einheiten werden verschoben.</p>`:''}
 <p>${lpVorschau.units.filter(u=>u.date).slice(0,5).map(u=>esc(fmtDate(u.date)+' · '+u.module+' · '+u.label+' · '+lpArt[u.type])).join('<br>')}</p>
 <div class="row"><button class="btn primary" id="lp-uebernehmen">${p?'Neuplanung übernehmen':'Plan übernehmen'}</button><button class="btn" id="lp-verwerfen">Vorschau verwerfen</button></div></div>`:''}
 ${p?`<div class="panel"><div class="kasten-titel"><h2>Dein Plan</h2><a href="#start">Heute lernen →</a></div>
 <p>Kapitel sind abgeschlossen, wenn Aufgaben selbst gelöst, Quizfragen richtig und Karten gelernt sind. Manuelle Haken zählen als eigene Bearbeitung und ändern den Lernpfad nicht.</p>
 <div class="row"><button class="btn primary" id="lp-pdf">PDF öffnen</button><button class="btn" id="lp-download">PDF herunterladen</button><button class="btn" id="lp-wochenpdf">Diese Woche als PDF</button></div>
 <p class="muted">Die PDF übernimmt den aktuellen Stand. Bereits heruntergeladene Fassungen ändern sich nicht automatisch.</p>
 ${p.warnings.map(w=>`<p class="hinweis">${esc(w)}</p>`).join('')}${missing.length?`<p class="muted">Termin fehlt: ${esc(missing.join(', '))}. Diese Module sind noch nicht eingeplant.</p>`:''}</div>
 <div class="panel"><div class="kasten-titel"><h2>Wochenplan</h2><select id="lp-woche" aria-label="Woche auswählen">${weeks.map(w=>`<option value="${w}"${w===lpWoche?' selected':''}>KW ${Lernplan.kw(w)} · ${fmtDate(w)}</option>`).join('')}</select></div>
 ${Array.from({length:7},(_,i)=>Lernplan.add(lpWoche,i)).map(d=>{const us=p.units.filter(u=>lpDatum(u,p)===d),min=us.reduce((s,u)=>s+Lernplan.cost(u,p.config),0),budget=Lernplan.capacity(p.config,d,lpVorlesungen());return `<section class="lp-tag${d===today?' heute':''}"><h3>${esc(langDatum(d))}${d===today?' · Heute':''}</h3><p class="muted">${min} / ${budget} Min. verplant · ${Math.max(0,budget-min)} Min. frei / Puffer für Wiederholung und neuen Stoff</p>${us.map(u=>lpEinheit(u,p,c)).join('')||'<p class="muted">Keine Einheit geplant.</p>'}</section>`;}).join('')}</div>
 ${p.units.some(u=>!lpDatum(u,p)&&!lpStand(u,c,p).done)?`<details class="panel"><summary>Noch ohne Termin</summary>${p.units.filter(u=>!lpDatum(u,p)&&!lpStand(u,c,p).done).map(u=>lpEinheit(u,p,c)).join('')}</details>`:''}
 <details class="panel"><summary>Kapitel und Fortschritt</summary>${lpKapitel(c.filter(m=>p.exams.some(e=>e.modules.includes(m.name))))}</details>
 ${p.units.filter(u=>lpDatum(u,p)<today&&!lpStand(u,c,p).done).length?'<p class="hinweis">Es gibt überfällige Einheiten ohne freien Puffer vor ihrer Klausur. Prüfe dein Zeitbudget und die Neuplanung.</p>':''}`:'<p class="muted">Dein Plan wird privat gespeichert und mit dem bestehenden Lernstand synchronisiert.</p>'}`;
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
  try{const old=p?{...p,units:p.units.map(u=>({...u,date:lpDatum(u,p)}))}:null;
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

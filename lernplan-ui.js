/* Aufgabenplan (seit 11.11.2026): Adapter zum Lernstand, Wochenansicht, Startseite und Wochen-PDF.
   Kein Zeitbudget. Der Plan verteilt alle offenen Aufgaben gleichmäßig bis 14 Tage vor jeder Klausur und
   passt sich automatisch an (neue Aufgaben, Wochenwechsel, geänderte Klausuren). Die laufende Woche bleibt stabil. */
let lpWoche='',lpDatei=null,lpPdfStand='',lpExportWoche='',lpErfolgTimer=false,lpCache=null,lpLäuft=false;
let lpAnsicht=null,lpRueckkehr;
const LP_KEY='lernplan:aufgabenplan';
const lpArt={aufgaben:'Aufgabe',probe:'Probeklausur',wiederholung:'Wiederholung'};
function lpPrüfungen(){return Lernplan.exams(fristen().filter(f=>f.art==='klausur').map(f=>({...f,modules:f.module?.length?f.module:f.modul?[f.modul]:[],duration:f.amtlich?.dauer||klausurInfo(f.modul).dauer})),heuteIso());}
function lpEinstellung(){return Lernplan.config(db.get('einst:aufgabenplan',{})||{});}
function lpPlan(){const p=db.get(LP_KEY,null);return p&&p.mode==='aufgaben'&&Array.isArray(p.units)?p:null;}
function lpKatalog(){
 if(lpCache&&Date.now()-lpCache.t<1500)return lpCache.c;
 const c=LERNEN.map(m=>{const r=lernreihe(m.name),exam=klausurInfo(m.name);
  return {name:m.name,pdf:m.pdf,blatt:m.ablatt||'',typ:exam.typ,duration:exam.dauer,sections:r.abschnitte.map(s=>({key:s.key,label:s.kurz,title:s.quelle?.t||s.kurz,source:s.quelle||null,complete:!!s.abgeschlossen,
   items:s.aufgaben.map(x=>{const st=aufgabeStand(x);return {id:x.id,title:x.t,art:x.art,nr:x.nr,min:aufgabeMinuten(x),ok:st?.s==='ok',seen:!!st,source:x.q||null,herkunft:x.h||'',vorlage:x.v||''};})}))};});
 lpCache={t:Date.now(),c};return c;
}
function lpAktivitäten(){return Object.entries(db.objekt('aktiv:')).map(([k,v])=>({...v,tag:k.slice(0,10)}));}
function lpStand(u,catalog=lpKatalog()){
 return Lernplan.status(u,catalog,{manual:db.get('lernplan:manuell:'+u.id,false),latch:db.get('lernplan:abschluss:'+u.id,false),activities:u.type==='probe'?lpAktivitäten():[]});
}
function lpDatum(u){return u.week||null;}
function lpAufgabe(u,c=lpKatalog()){if(u.type!=='aufgaben')return null;for(const s of c.find(m=>m.name===u.module)?.sections||[]){const x=s.items.find(x=>x.id===u.targets[0]);if(x)return {...x,label:s.label};}return null;}
function lpTitel(u,c=lpKatalog()){return u.type==='aufgaben'?lpAufgabe(u,c)?.title||'Entfernte Aufgabe':u.title;}
// Plan anlegen oder automatisch anpassen. Erledigtes bleibt als Historie, die laufende Woche bleibt stabil.
function lpAktualisieren(){
 if(lpLäuft)return lpPlan();
 const today=heuteIso(),exams=lpPrüfungen(),old=lpPlan(),cfg=lpEinstellung();
 if(!exams.length)return old;
 lpLäuft=true;
 try{
  const c=lpKatalog(),grund=Lernplan.needsUpdate(old,c,exams,today)||(old&&JSON.stringify(old.config)!==JSON.stringify(cfg)?'einstellung':'');
  if(!grund)return old;
  const p=Lernplan.create(cfg,c,exams,{old,status:u=>lpStand(u,c),today,version:neueId()});
  // Kompakt speichern: Titel und Quellen von Aufgaben kommen immer aktuell aus den Moduldaten.
  p.units=p.units.map(u=>{const {title,source,...rest}=u;return u.type==='aufgaben'?rest:{...rest,title};});
  p.note={day:today,grund,added:p.added||0,neu:!old};
  db.set(LP_KEY,p);
  if(!old)for(const k of Object.keys(db.objekt('lernplan:version:')))db.set('lernplan:version:'+k,null);
  return p;
 }catch(e){console.error(e);return old;}finally{lpLäuft=false;}
}
function lernplanMerken(){
 lpCache=null;if(lpErfolgTimer)return;lpErfolgTimer=true;
 queueMicrotask(()=>{lpErfolgTimer=false;const p=lpPlan();if(!p)return;const c=lpKatalog();
  for(const u of p.units)if(!db.get('lernplan:abschluss:'+u.id,false)&&lpStand(u,c).success)db.set('lernplan:abschluss:'+u.id,{t:Date.now()});
 });
}
function lpHinweisHtml(p=lpPlan()){
 const n=p?.note;if(!n||n.day!==heuteIso())return '';
 const text=n.neu?'Dein Aufgabenplan wurde automatisch erstellt.':n.grund==='woche'?'Neue Woche: Offene Aufgaben aus der Vorwoche sind auf die restlichen Wochen verteilt.':n.added?`${n.added} neue Aufgabe${n.added===1?'':'n'} automatisch ab nächster Woche eingeplant.`:n.grund==='einstellung'?'Der Plan ist nach deinen Einstellungen neu verteilt.':'Klausuren oder Aufgaben haben sich geändert; der Plan ist automatisch angepasst.';
 return `<p class="hinweis" role="status">${esc(text)} Erledigtes bleibt erhalten.</p>`;
}
function lernplanAutomatikPrüfen(){
 if(document.visibilityState!=='visible'||location.hash.startsWith('#lernen')||document.activeElement?.matches('input,textarea,select'))return;
 const vor=lpPlan(),p=lpAktualisieren();
 if(p&&p!==vor&&pdfAnsicht.hidden&&(!location.hash||location.hash==='#start'||location.hash.startsWith('#termine/lernplan')))neuZeichnen();
}
function lernplanAutomatikStarten(){
 setTimeout(lernplanAutomatikPrüfen,1500);
 setInterval(lernplanAutomatikPrüfen,30000);
 document.addEventListener('visibilitychange',lernplanAutomatikPrüfen);
 window.addEventListener('pageshow',lernplanAutomatikPrüfen);
}
function lpStart(u,p=lpPlan()){
 if(!u)return;if(u.notBefore&&u.notBefore>heuteIso())return meldung('Das ist ab '+fmtDate(u.notBefore)+' dran (Probephase).');
 const real=LERNEN.find(m=>m.name===u.module),r=lernreihe(u.module);
 if(!real){location.hash='#lernen';return meldung('Dieses Modul ist nicht mehr verfügbar.');}
 lpRueckkehrSpeichern(u,p);
 if(u.type==='probe'){probeStarten(real,false);if(!lpRueckkehrAktiv())lpRueckkehrLoeschen();return;}
 if(u.type==='wiederholung'){lpRueckkehrLoeschen();store.set('lernen:filter','offen');store.set('lernen:teil','aufgaben');location.hash='#lernen/'+encodeURIComponent(u.module);return;}
 const x=(real.aufgaben||[]).find(x=>x.id===u.targets[0]);
 if(!x){lpRueckkehrLoeschen();location.hash='#lernen/'+encodeURIComponent(u.module);return meldung('Diese Aufgabe gibt es nicht mehr. Der Plan passt sich beim nächsten Öffnen an.');}
 if(!r.erreicht(x)){lpRueckkehrLoeschen();return meldung('Diese Aufgabe kommt später. Löse zuerst die Aufgaben des vorherigen Abschnitts selbst.');}
 location.hash='#lernen/'+encodeURIComponent(u.module)+'/aufgabe/'+x.id;
}
function lpFreigegeben(u){
 if(!u)return false;if(u.notBefore&&u.notBefore>heuteIso())return false;
 if(u.type!=='aufgaben')return true;
 const m=LERNEN.find(m=>m.name===u.module),x=(m?.aufgaben||[]).find(x=>x.id===u.targets[0]);
 return !!x&&lernreihe(u.module).erreicht(x);
}
function lpWochenEinheiten(p,w){return p.units.filter(u=>u.week===w);}
function lpTagesvorschläge(tag){
 const p=lpAktualisieren()||lpPlan();if(!p)return [];const w=Lernplan.week(tag),c=lpKatalog();
 return lpWochenEinheiten(p,w).map(u=>({key:'lernplan:'+u.id,art:'lernplan',modul:u.module,kapitel:u.id,plan:p.id,
  titel:u.module+' · '+lpArt[u.type]+': '+lpTitel(u,c),text:`Wochenaufgabe KW ${Lernplan.kw(w)} · ca. ${Lernplan.duration(u.min)}`,link:'#termine/lernplan/'+w,ids:u.targets}));
}
function lpStartWocheHtml(){
 const p=lpPlan();if(!p)return '';const c=lpKatalog(),w=Lernplan.week(heuteIso()),us=lpWochenEinheiten(p,w),st=new Map(us.map(u=>[u.id,lpStand(u,c)]));
 const done=us.filter(u=>st.get(u.id).done),open=us.filter(u=>!st.get(u.id).done),minutes=open.reduce((n,u)=>n+u.min,0);
 return `<div class="panel lp-startwoche"><div class="kasten-titel"><h2>Diese Woche · KW ${Lernplan.kw(w)}</h2><span class="tagesfortschritt">${done.length} von ${us.length} erledigt</span></div>${lpHinweisHtml(p)}
 <p><b>Noch ${open.length} Aufgaben · ca. ${Lernplan.duration(minutes)}</b></p><p class="muted">Du entscheidest, an welchen Tagen du sie löst. Am besten handschriftlich im Wochen-PDF.</p>
 ${[...new Set(us.map(u=>u.module))].map(name=>{const tasks=us.filter(u=>u.module===name),left=tasks.filter(u=>!st.get(u.id).done),next=left.find(lpFreigegeben),index=next?tagesliste.findIndex(v=>v.kapitel===next.id):-1;return `<div class="lp-startmodul"><div><b>${esc(name)}</b><span>${tasks.length-left.length}/${tasks.length} erledigt · noch ca. ${Lernplan.duration(left.reduce((n,u)=>n+u.min,0))}</span></div>${next&&index>=0?`<button class="btn" data-los="${index}">Starten</button>`:`<span class="muted">${left.length?(left.some(u=>u.notBefore>heuteIso())?'Ab der Probephase':'Zuerst frühere Abschnitte lösen'):'Erledigt'}</span>`}</div>`;}).join('')||'<p class="muted">Für diese Woche sind keine Aufgaben eingeplant.</p>'}
 <div class="row" style="margin-top:12px"><button class="btn primary" data-lp-blatt="${w}">Aufgaben KW ${Lernplan.kw(w)} als PDF</button><a class="btn" href="#termine/lernplan/${w}">Wochenplan ansehen</a></div></div>`;
}
function lpTagesstand(v){const p=lpPlan(),u=p?.units.find(u=>u.id===v.kapitel);if(!u)return {fertig:false,n:0,ziel:1};const s=lpStand(u);return {fertig:s.done,automatisch:s.success,n:s.n,ziel:s.total};}
function lpManuell(id,render=true){const p=lpPlan(),u=p?.units.find(u=>u.id===id);if(!u)return;db.set('lernplan:manuell:'+id,!db.get('lernplan:manuell:'+id,false));if(render)lernplanSeite(lpWoche);}
function lpModulOffen(name){return db.get('einst:lernplan:modul:'+name,true)!==false;}
function lpModulMerken(el){
 if(!el.isConnected||!lpAnsicht)return;
 if(el.dataset.lpOffen===String(el.open))return;
 el.dataset.lpOffen=String(el.open);
 const key='einst:lernplan:modul:'+el.dataset.lpModul;
 if(db.get(key,true)!==el.open)db.set(key,el.open);
}
function lpAnsichtMerken(){
 if(!lpAnsicht)return;
 termineView.querySelectorAll('[data-lp-modul]').forEach(lpModulMerken);
 try{sessionStorage.setItem('studium:lernplan:scroll:'+lpAnsicht.plan+':'+lpAnsicht.week,String(window.scrollY));}catch{}
}
function lpAnsichtVerlassen(){lpAnsichtMerken();lpAnsicht=null;}
function lpRueckkehrLesen(){
 if(lpRueckkehr!==undefined)return lpRueckkehr;
 try{const v=JSON.parse(sessionStorage.getItem('studium:lernplan:rueckkehr')||'null');
  lpRueckkehr=v&&/^\d{4}-\d{2}-\d{2}$/.test(v.week)&&typeof v.module==='string'&&typeof v.unit==='string'&&['aufgaben','quiz','karten','probe'].includes(v.type)?v:null;
 }catch{lpRueckkehr=null;}
 return lpRueckkehr;
}
function lpRueckkehrLoeschen(){lpRueckkehr=null;try{sessionStorage.removeItem('studium:lernplan:rueckkehr');}catch{}}
function lpRueckkehrSpeichern(u,p){
 lpAnsichtMerken();const match=location.hash.match(/^#termine\/lernplan\/(\d{4}-\d{2}-\d{2})(?:\/|$)/);
 lpRueckkehr={plan:p.id,week:match?Lernplan.week(match[1]):lpDatum(u,p)||Lernplan.week(heuteIso()),module:u.module,unit:u.id,type:u.type};
 try{sessionStorage.setItem('studium:lernplan:rueckkehr',JSON.stringify(lpRueckkehr));}catch{}
}
function lpRueckkehrAktiv(){
 const c=lpRueckkehrLesen();if(!c)return false;
 try{const [view,name,part]=decodeURIComponent(location.hash.slice(1)).split('/');return view==='lernen'&&name===c.module&&part===({aufgaben:'aufgabe',quiz:'quiz',karten:'karteikarten',probe:'probe'}[c.type]);}catch{return false;}
}
function lpRueckweg(fallback){
 const c=lpRueckkehrLesen();return c&&lpRueckkehrAktiv()?'#termine/lernplan/'+c.week+'/ziel/'+encodeURIComponent(c.unit)+'/'+encodeURIComponent(c.module):fallback;
}
function lpRuecktext(fallback){return lpRueckkehrAktiv()?'Zum Wochenplan':fallback;}
function lpNavigationPruefen(){
 const c=lpRueckkehrLesen();if(!c||lpRueckkehrAktiv())return;
 const currentWeek=/^#termine\/lernplan\/?$/.test(location.hash)&&c.week===Lernplan.week(heuteIso());
 if(!currentWeek&&!new RegExp('^#termine/lernplan/'+c.week+'(?:/|$)').test(location.hash))lpRueckkehrLoeschen();
}
function lpAnsichtWiederherstellen(p,w){
 const view=lpAnsicht,c=lpRueckkehrLesen();let goal=null;
 try{const parts=decodeURIComponent(location.hash.slice(1)).split('/');if(parts[0]==='termine'&&parts[1]==='lernplan'&&parts[2]===w&&parts[3]==='ziel')goal={unit:parts[4],module:parts.slice(5).join('/')};}catch{}
 if(!goal&&c?.week===w)goal=c;
 let y=null;try{const value=sessionStorage.getItem('studium:lernplan:scroll:'+p.id+':'+w);if(value!==null&&Number.isFinite(+value))y=Math.max(0,+value);}catch{}
 if(goal)lpRueckkehrLoeschen();
 requestAnimationFrame(()=>{
  if(lpAnsicht!==view||termineView.hidden)return;
  if(goal){
   const unit=document.getElementById('lp-'+goal.unit),module=[...termineView.querySelectorAll('[data-lp-modul]')].find(el=>el.dataset.lpModul===goal.module)||unit?.closest('[data-lp-modul]');
   let target=module?.querySelector('summary')||document.getElementById('lp-woche');
   if(module?.open&&unit&&module.contains(unit))target=unit.classList.contains('erledigt')?[...module.querySelectorAll('.lp-einheit:not(.erledigt)')].find(el=>!el.querySelector('[data-lp-start]')?.disabled)||unit:unit;
   target?.scrollIntoView({block:'center'});
   (target?.querySelector('[data-lp-start]:not(:disabled)')||target?.querySelector('summary')||target)?.focus({preventScroll:true});
   history.replaceState(history.state,'','#termine/lernplan/'+w);
   lpAnsichtMerken();
  }else if(y!==null)window.scrollTo(0,y);
 });
}
function lpHerkunft(x){return !x?.herkunft?'':x.herkunft==='original'?'Original'+(x.vorlage?' · '+x.vorlage:''):x.herkunft==='variante'?'Von Claude erstellt · nach '+(x.vorlage||'Vorlage'):'Von Claude erstellt';}
function lpEinheit(u,p,c){
 const s=lpStand(u,c),free=lpFreigegeben(u),x=lpAufgabe(u,c),m=c.find(m=>m.name===u.module),source=x?.source,h=lpHerkunft(x);
 return `<div class="lp-einheit${s.done?' erledigt':''}" id="lp-${u.id}"><button class="haken${s.done?' an':''}" data-lp-haken="${u.id}" aria-label="${s.manual?'Manuellen Haken entfernen':'Manuell erledigt markieren'}: ${esc(lpTitel(u,c))}" aria-pressed="${s.done}">${s.done?'✓':''}</button>
 <div class="was"><b>${x?`Aufgabe ${x.nr||''} · `:''}${esc(lpTitel(u,c))}</b><span>${x?esc((x.art==='rechnen'?'Rechenaufgabe':'Verständnisfrage')+' · '+x.label):esc(u.label)} · ca. ${Lernplan.duration(u.min)}${h?` · <span class="herkunft ${x.herkunft}">${esc(h)}</span>`:''}</span>
 <span>${s.success?'Selbst gelöst':s.manual?'Manuell erledigt':s.worked?'Bearbeitet, noch nicht selbst gelöst':u.notBefore>heuteIso()?'Ab '+fmtDate(u.notBefore):free?'Offen':'Zuerst den vorherigen Abschnitt lösen'}${u.type==='wiederholung'&&s.total?' · '+s.n+'/'+s.total+' Aufgaben selbst gelöst':''}</span>
 ${source&&m?.pdf?quellenLink(m.pdf,source):''}</div>
 <button class="btn" data-lp-start="${u.id}"${free?'':' disabled'}>${s.done?'Noch einmal':'Starten'}</button></div>`;
}
function lpWochenliste(p,c,w){
 const us=lpWochenEinheiten(p,w),st=new Map(us.map(u=>[u.id,lpStand(u,c)])),done=us.filter(u=>st.get(u.id).done),open=us.filter(u=>!st.get(u.id).done);
 return `<p class="lp-wochenfortschritt"><b>${done.length} von ${us.length} erledigt</b> · noch ${open.length} mit ca. ${Lernplan.duration(open.reduce((n,u)=>n+u.min,0))} (Schätzung)</p>
 <progress class="lp-fortschritt" value="${done.length}" max="${Math.max(1,us.length)}" aria-label="Fortschritt dieser Woche"></progress>
 <div class="row" style="margin:10px 0 4px"><button class="btn primary" data-lp-blatt="${w}"${us.some(u=>u.type==='aufgaben')?'':' disabled'}>Aufgaben KW ${Lernplan.kw(w)} als PDF</button></div>
 <p class="muted">A4 mit Platz unter jeder Aufgabe zum handschriftlichen Lösen. Abgehakt wird hier, sobald du eine Aufgabe in der Plattform als „selbst gelöst“ bewertest.</p>
 ${[...new Set(us.map(u=>u.module))].map(name=>{const tasks=us.filter(u=>u.module===name),finished=tasks.filter(u=>st.get(u.id).done).length;return `<details class="lp-wochenmodul" data-lp-modul="${esc(name)}"${lpModulOffen(name)?' open':''}><summary><b>${esc(name)}</b><span>${finished}/${tasks.length} erledigt · ca. ${Lernplan.duration(tasks.filter(u=>!st.get(u.id).done).reduce((n,u)=>n+u.min,0))} offen</span></summary>${tasks.map(u=>lpEinheit(u,p,c)).join('')}</details>`;}).join('')||'<p class="muted">Für diese Woche ist nichts eingeplant.</p>'}`;
}
function lpKlausurenHtml(p,c){
 const today=heuteIso();
 return p.exams.map(e=>{const ende=Lernplan.add(e.date,-p.config.probe),us=p.units.filter(u=>u.exam===e.id&&u.type==='aufgaben'),offen=us.filter(u=>!lpStand(u,c).done);
  return `<div class="lp-startmodul"><div><b>${esc(e.title||e.modules.join(' + '))} · ${fmtDate(e.date)}</b><span>${ende>today?`Stoffphase bis ${fmtDate(Lernplan.add(ende,-1))}, Probephase ab ${fmtDate(ende)}`:`Probephase läuft`} · ${offen.length} von ${us.length} Aufgaben offen</span></div></div>`;}).join('');
}
function lernplanSeite(woche){
 lpAnsichtMerken();lpAnsicht=null;
 const today=heuteIso(),exams=lpPrüfungen(),cfg=lpEinstellung();let p=lpAktualisieren()||lpPlan();
 const c=lpKatalog();lpWoche=woche&&/^\d{4}-\d{2}-\d{2}$/.test(woche)?Lernplan.week(woche):Lernplan.week(today);
 kopf('Dein Wochenplan','Alle Aufgaben gleichmäßig bis zur Probephase verteilt – ohne festes Zeitbudget');
 const weeks=p?[...new Set([...p.units.map(u=>u.week).filter(Boolean),Lernplan.week(today)])].sort():[];
 const fehlt=alleModule.filter(m=>!exams.some(e=>e.modules.includes(m)));
 termineView.innerHTML=`<div class="lp-kopf row"><a href="#termine">← Termine</a><span class="muted">${p?'Stand '+fmtDate(p.note?.day||today):'Noch kein Plan'}</span></div>
 ${p?lpHinweisHtml(p):''}
 ${!exams.length?'<div class="panel"><p>Trag zuerst deine Klausuren mit Datum und Modul unter Termine ein. Dann entsteht der Plan automatisch.</p></div>':''}
 ${p?`<div class="panel"><div class="kasten-titel lp-wochenkopf"><h2>Wochenaufgaben</h2><select id="lp-woche" aria-label="Woche auswählen">${weeks.map(w=>`<option value="${w}"${w===lpWoche?' selected':''}>KW ${Lernplan.kw(w)} · ${fmtDate(w)}</option>`).join('')}</select></div>
 ${lpWochenliste(p,c,lpWoche)}</div>
 <div class="panel"><h2>So entsteht dein Plan</h2><p>Alle offenen Aufgaben werden Kapitel für Kapitel gleichmäßig auf die Wochen bis ${p.config.probe} Tage vor jeder Klausur verteilt. Die letzten ${p.config.probe} Tage gehören den Probeklausuren und den Aufgaben, die du noch nicht selbst gelöst hast.</p>
 <p>Kommen neue Aufgaben dazu, plant die Seite sie automatisch ab der nächsten Woche ein. Was du in einer Woche nicht schaffst, verteilt sie zum Wochenwechsel auf die restlichen Wochen.</p>
 ${lpKlausurenHtml(p,c)}${p.warnings.map(w=>`<p class="hinweis">${esc(w)}</p>`).join('')}${fehlt.length?`<p class="muted">Ohne Klausurtermin und daher nicht eingeplant: ${esc(fehlt.join(', '))}.</p>`:''}</div>`:''}
 ${exams.length?`<details class="panel"><summary><b>Einstellungen</b></summary><form id="lp-form" class="formular">
 <label>Probephase vor jeder Klausur (Tage)<input type="number" name="probe" min="0" max="28" value="${cfg.probe}" required></label>
 <fieldset class="ganz"><legend>Klausuren im Plan</legend>${exams.map(e=>`<label class="schalter"><input name="exam" type="checkbox" value="${e.id}"${!cfg.exams||cfg.exams.includes(e.id)?' checked':''}>${esc(e.title)} · ${fmtDate(e.date)} · ${esc(e.modules.join(' + '))}</label>`).join('')}</fieldset>
 <div class="ganz row"><button class="btn primary">Übernehmen</button></div></form></details>`:''}`;
 document.getElementById('lp-form')?.addEventListener('submit',e=>{e.preventDefault();const f=new FormData(e.target),ids=f.getAll('exam');
  db.set('einst:aufgabenplan',{probe:+f.get('probe'),exams:ids.length===exams.length?null:ids});lpCache=null;lernplanSeite(lpWoche);meldung('Plan neu verteilt.');});
 document.getElementById('lp-woche')?.addEventListener('change',e=>{location.hash='#termine/lernplan/'+e.target.value;});
 termineView.querySelectorAll('[data-lp-start]').forEach(b=>b.onclick=()=>lpStart(p.units.find(u=>u.id===b.dataset.lpStart),p));
 termineView.querySelectorAll('[data-lp-haken]').forEach(b=>b.onclick=()=>lpManuell(b.dataset.lpHaken));
 if(p){lpAnsicht={plan:p.id,week:lpWoche};termineView.querySelectorAll('[data-lp-modul]').forEach(el=>{el.dataset.lpOffen=String(el.open);el.addEventListener('toggle',()=>lpModulMerken(el));});lpAnsichtWiederherstellen(p,lpWoche);}
 lernplanMerken();
}
function lpBlattName(w){const y=Lernplan.kwYear(w);return 'Aufgaben KW '+Lernplan.kw(w)+(y!==Lernplan.kwYear(heuteIso())?' '+y:'')+'.pdf';}
async function lpBlattPdf(w,knopf){
 const p=lpPlan();if(!p)return;const c=lpKatalog(),us=lpWochenEinheiten(p,w).filter(u=>u.type==='aufgaben');
 if(!us.length)return meldung('In dieser Woche sind keine Aufgaben eingeplant.');
 const text=knopf?.textContent;if(knopf){knopf.disabled=true;knopf.textContent='PDF wird erstellt …';}
 try{
  if(!window.LernplanPDF)await new Promise((resolve,reject)=>{const s=document.createElement('script');s.src='lernplan-pdf.js'+new URL(document.querySelector('script[src^="lernplan-ui.js"]').src).search;s.onload=resolve;s.onerror=()=>reject(Error('Die PDF-Funktion konnte nicht geladen werden.'));document.head.appendChild(s);});
  const aufgaben=us.map(u=>{const m=LERNEN.find(m=>m.name===u.module),i=(m?.aufgaben||[]).findIndex(x=>x.id===u.targets[0]);if(i<0)return null;const x=m.aufgaben[i];
   return {modul:m.name,blatt:m.ablatt,seite:i,nr:x.nr||i+1,titel:x.t,art:x.art,kapitel:x.k,abschnitt:(lpAufgabe(u,c)||{}).label||'',herkunft:lpHerkunft({herkunft:x.h,vorlage:x.v}),original:x.h==='original',min:aufgabeMinuten(x),schritte:x.s.length,platz:x.platz||0,
    erledigt:lpStand(u,c).done,link:new URL(location.pathname,location.origin).href+'#lernen/'+encodeURIComponent(m.name)+'/aufgabe/'+x.id};}).filter(Boolean);
  const bytes=await LernplanPDF.wochenblatt({week:w,kw:Lernplan.kw(w),aufgaben,base:new URL(location.pathname,location.origin).href});
  if(lpDatei){URL.revokeObjectURL(lpDatei);pdfDateien.delete(lpDatei);}
  const name=lpBlattName(w);lpDatei=URL.createObjectURL(new Blob([bytes],{type:'application/pdf'}));pdfNamen.set(lpDatei,name);lpExportWoche=w;
  if(APP)await pdfSichern(lpDatei,knopf||document.body);
  else{const a=Object.assign(document.createElement('a'),{href:lpDatei,download:name});a.setAttribute('data-pdf-direkt','');document.body.appendChild(a);a.click();a.remove();}
 }catch(e){console.error(e);meldung(e.message||'Die PDF konnte nicht erzeugt werden.',6000);}finally{if(knopf){knopf.disabled=false;if(knopf.textContent==='PDF wird erstellt …')knopf.textContent=text;}}
}
document.addEventListener('click',e=>{const b=e.target.closest?.('[data-lp-blatt]');if(b){e.preventDefault();lpBlattPdf(b.dataset.lpBlatt,b);}});

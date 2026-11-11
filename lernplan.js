/* Reine Lernplanlogik (Aufgabenplan). Keine Browserdaten, kein Netz; dieselbe Logik für Ansicht und PDF.
   Seit 11.11.2026: kein Zeitbudget mehr. Alle offenen Aufgaben werden gleichmäßig auf die Wochen bis
   14 Tage vor der Klausur verteilt (Stoffphase); die letzten 14 Tage bleiben für Probeklausuren und
   das Wiederholen nicht selbst gelöster Aufgaben frei (Probephase). Neue Aufgaben werden automatisch
   eingeplant; die laufende Woche bleibt dabei stabil. */
(function(root){
'use strict';
const DAY=86400000;
const add=(s,n)=>new Date(Date.parse(s+'T12:00:00Z')+n*DAY).toISOString().slice(0,10);
const days=(a,b)=>Math.round((Date.parse(b+'T12:00:00Z')-Date.parse(a+'T12:00:00Z'))/DAY);
const weekday=s=>(new Date(s+'T12:00:00Z').getUTCDay()+6)%7;
const hash=s=>{let h=2166136261;for(const c of s){h^=c.charCodeAt(0);h=Math.imul(h,16777619);}return(h>>>0).toString(36);};
const week=s=>add(s,-weekday(s));
function kw(s){const d=new Date(s+'T12:00:00Z');d.setUTCDate(d.getUTCDate()+3-weekday(s));return Math.floor(Math.round((d-new Date(Date.UTC(d.getUTCFullYear(),0,1,12)))/DAY)/7)+1;}
// ISO-Jahr der Kalenderwoche (für Dateinamen wie „Aufgaben KW 2 2027“).
function kwYear(s){const d=new Date(s+'T12:00:00Z');d.setUTCDate(d.getUTCDate()+3-weekday(s));return d.getUTCFullYear();}
function duration(value){
 const number=Number(value),minutes=Number.isFinite(number)?Math.max(0,Math.round(number)):0,hours=Math.floor(minutes/60),rest=minutes%60;
 return hours?`${hours} Std.${rest?' '+rest+' Min.':''}`:`${rest} Min.`;
}
const PROBE_TAGE=14;
function config(c={}){
 const probe=Number.isFinite(+c.probe)&&c.probe!==null&&c.probe!==''?Math.max(0,Math.min(28,Math.round(+c.probe))):PROBE_TAGE;
 return {exams:Array.isArray(c.exams)?[...c.exams]:null,probe};
}
function exams(raw,today){
 const groups=new Map();
 for(const e of raw.filter(e=>e.datum>=today&&!e.erledigt&&e.modules?.length).sort((a,b)=>a.datum.localeCompare(b.datum))){
  const mods=[...new Set(e.modules)].sort(),key=e.datum+'|'+mods.join('|');
  if(!groups.has(key))groups.set(key,{id:hash(mods.join('|')+'|'+(e.amtlich?.nummer||e.titel||'')),date:e.datum,title:e.titel,modules:mods,duration:e.duration||90});
 }
 return [...groups.values()];
}
const cost=u=>u.min||0;
// Ausgewählte Klausuren: ohne ausdrückliche Auswahl alle bekannten.
const selected=(c,examination)=>examination.filter(e=>!c.exams||c.exams.includes(e.id));
// Gewicht einer Woche = Anzahl Lerntage in [von, bis); eine angebrochene Woche zählt anteilig.
function weekWeights(from,until){
 const out=[];if(from>=until)return out;
 for(let w=week(from);w<until;w=add(w,7)){
  const a=from>w?from:w,b=until<add(w,7)?until:add(w,7),n=days(a,b);if(n>0)out.push({week:w,weight:n});
 }
 return out;
}
// Verteilt eine geordnete Liste gleichmäßig nach Bearbeitungszeit auf gewichtete Wochen.
function spread(list,weeks){
 const total=list.reduce((s,x)=>s+Math.max(1,x.min),0),W=weeks.reduce((s,w)=>s+w.weight,0);
 const bounds=[];let acc=0;for(const w of weeks){acc+=w.weight;bounds.push(acc/W);}
 let before=0;const out=new Map();
 for(const x of list){
  const mid=(before+Math.max(1,x.min)/2)/Math.max(1,total);before+=Math.max(1,x.min);
  let i=bounds.findIndex(b=>mid<=b+1e-9);if(i<0)i=weeks.length-1;out.set(x.id,weeks[i].week);
 }
 return out;
}
function taskUnit(m,s,x,exam){
 return {id:hash([m.name,'aufgabe',x.id].join('|')),module:m.name,type:'aufgaben',section:s.key,label:s.label,title:x.title,targets:[x.id],
  min:Math.max(3,Math.round(x.min)),source:x.source||s.source||null,herkunft:x.herkunft||'',exam:exam.id,deadline:exam.date,review:false,notBefore:null,week:null};
}
/* Erstellt (oder aktualisiert) den Plan.
   catalog: [{name,pdf,sections:[{key,label,source,items:[{id,title,min,ok,source,herkunft}]}]}] in Lernreihenfolge.
   old: bisheriger Plan. Bleibt die Woche gleich, behalten Ziele der laufenden Woche ihre Woche; Neues kommt ab nächster Woche.
   status(u) → {done}. */
function create(c,catalog,examination,{old=null,status=()=>({done:false}),today,version='v1'}={}){
 c=config(c);const chosen=selected(c,examination),current=week(today);
 const stable=!!old&&old.lastWeek===current;
 const keep=new Map();
 for(const u of old?.units||[]){
  const done=!!status(u).done;
  // Erledigtes bleibt als Historie in seiner Woche; Ziele der laufenden Woche bleiben stabil.
  if(done&&u.week)keep.set(u.id,{...u});
  else if(stable&&u.week===current&&(u.type!=='aufgaben'||catalog.some(m=>m.name===u.module&&m.sections.some(s=>s.items.some(x=>x.id===u.targets[0])))))keep.set(u.id,{...u});
 }
 const units=[...keep.values()],warnings=[];
 for(const exam of chosen){
  const stoffEnde=add(exam.date,-c.probe),probeStart=stoffEnde<today?today:stoffEnde;
  const from=stable?add(current,7):today;
  for(const name of exam.modules){
   const m=catalog.find(m=>m.name===name);if(!m)continue;
   const open=[];
   for(const s of m.sections)for(const x of s.items){
    const u=taskUnit(m,s,x,exam);
    if(keep.has(u.id))continue;
    if(x.ok)continue;
    open.push(u);
   }
   let weeks=weekWeights(from<today?today:from,stoffEnde);
   if(!weeks.length){
    // Klausur zu nah für eine Stoffphase: Restliche Aufgaben bis zum Vortag verteilen.
    weeks=weekWeights(from<today?today:from,exam.date);
    if(open.length)warnings.push(`${name}: Bis zur Probephase bleibt keine Woche mehr. ${open.length} offene Aufgaben liegen in den letzten Tagen vor der Klausur.`);
   }
   if(!weeks.length){for(const u of open)units.push(u);continue;}
   const assigned=spread(open,weeks);
   for(const u of open){u.week=assigned.get(u.id);units.push(u);}
   // Probephase: zwei Probeklausuren und das Wiederholen nicht selbst gelöster Aufgaben.
   if(probeStart<exam.date){
    const probeDays=[probeStart,add(probeStart,Math.max(1,Math.floor(days(probeStart,exam.date)/2)))].filter(d=>d<exam.date);
    probeDays.forEach((d,i)=>{
     const id=hash([name,'probe',exam.id,i].join('|'));if(keep.has(id))return;
     units.push({id,module:name,type:'probe',section:'probe',label:'Probephase',title:`Probeklausur ${i+1} unter Zeitdruck, danach auswerten`,targets:['probe'],
      min:Math.round((m.duration||exam.duration||90)*.8)+20,exam:exam.id,deadline:exam.date,review:true,notBefore:d,week:week(d),source:null});
     const wid=hash([name,'wiederholung',exam.id,i].join('|'));if(keep.has(wid))return;
     units.push({id:wid,module:name,type:'wiederholung',section:'wiederholung',label:'Probephase',title:i?'Unsichere Aufgaben ein letztes Mal selbst lösen':'Nicht selbst gelöste Aufgaben erneut lösen',
      targets:[],min:60,exam:exam.id,deadline:exam.date,review:true,notBefore:d,week:week(d),source:null});
    });
   }
  }
 }
 // Wochenaufwand nur als Information; deutlich überdurchschnittliche Wochen werden genannt.
 const load={};for(const u of units)if(u.week&&u.week>=current&&!status(u).done&&!u.review)load[u.week]=(load[u.week]||0)+cost(u);
 const values=Object.values(load),avg=values.length?values.reduce((s,n)=>s+n,0)/values.length:0;
 for(const [w,n] of Object.entries(load).sort())if(values.length>2&&n>avg*1.4)warnings.push(`KW ${kw(w)} ist mit ca. ${duration(n)} deutlich voller als der Schnitt (${duration(avg)}), weil sich dort mehrere Klausurvorbereitungen überschneiden.`);
 const known=catalog.flatMap(m=>m.sections.flatMap(s=>s.items.map(x=>m.name+'|'+x.id)));
 const added=old?known.filter(k=>!old.known?.includes(k)).length:0;
 return {id:version,mode:'aufgaben',number:(old?.number||0)+1,created:Date.now(),config:c,exams:chosen,units,known,
  end:chosen.map(e=>e.date).sort().at(-1)||today,warnings,added,lastWeek:current,signature:signature(catalog,examination,c)};
}
// Ändert sich etwas, das die Verteilung betrifft? Dann wird automatisch neu geplant.
function signature(catalog,examination,c){c=config(c);return hash(JSON.stringify({e:selected(c,examination).map(e=>[e.id,e.date,e.modules]),p:c.probe,
 k:catalog.map(m=>[m.name,m.sections.map(s=>s.items.map(x=>x.id))])}));}
function needsUpdate(plan,catalog,examination,today){
 if(!plan||plan.mode!=='aufgaben')return 'neu';
 if(plan.lastWeek!==week(today))return 'woche';
 if(plan.signature!==signature(catalog,examination,plan.config))return 'inhalt';
 return '';
}
function status(u,catalog,{manual=false,latch=false,activities=[]}={}){
 const m=catalog.find(m=>m.name===u.module),items=m?.sections.flatMap(s=>s.items)||[];
 if(latch)return {done:true,success:true,manual:false,n:1,total:1};
 if(u.type==='probe'){
  const ok=activities.some(a=>a.modul===u.module&&a.art==='probe'&&a.fertig&&(!u.notBefore||a.tag>=u.notBefore));
  return {done:ok||!!manual,success:ok,manual:!!manual,n:ok?1:0,total:1};
 }
 if(u.type==='wiederholung'){
  const ok=items.length>0&&items.every(x=>x.ok);
  return {done:ok||!!manual,success:ok,manual:!!manual,n:items.filter(x=>x.ok).length,total:items.length};
 }
 const targets=u.targets.map(id=>items.find(x=>x.id===id)).filter(Boolean);
 const n=targets.filter(x=>x.ok).length,success=targets.length>0&&n===targets.length;
 return {done:success||!!manual,success,manual:!!manual,n,total:Math.max(1,targets.length),worked:targets.some(x=>x.seen)};
}
root.Lernplan={add,days,weekday,week,kw,kwYear,hash,config,exams,cost,duration,create,signature,needsUpdate,status,weekWeights,spread,PROBE_TAGE};
if(typeof module!=='undefined')module.exports=root.Lernplan;
})(typeof globalThis!=='undefined'?globalThis:this);

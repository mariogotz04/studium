const assert=require('node:assert/strict'),L=require('./lernplan.js');
const today='2026-11-06';
const item=(id,type='aufgaben',min=15,ok=false)=>({id,type,min,ok,title:id,reached:true});
const moduleData=name=>({name,pdf:'test.pdf',typ:'transfer',duration:90,sections:[
 {key:name+':1.1',label:'Abschnitt 1.1',complete:false,items:[item('a1'),item('a2'),item('q1','quiz',2),item('c1','karten',.6)]},
 {key:name+':1.2',label:'Abschnitt 1.2',complete:false,items:[item('a3'),item('q2','quiz',2)]}]});
const cat=['GET','Finanzierung','Investitionsrechnung'].map(moduleData);
const exams=L.exams([{datum:'2026-12-10',titel:'GET',modules:['GET']},{datum:'2026-12-08',titel:'Investition und Finanzierung',modules:['Finanzierung','Investitionsrechnung']},{datum:'2026-12-08',titel:'Duplikat',modules:['Investitionsrechnung','Finanzierung']}],today);
assert.equal(exams.length,2,'Gemeinsame und doppelte Klausuren');
const cfg=L.config({start:today,minutes:[150,150,150,150,150,150,0],block:35,exams:exams.map(e=>e.id),off:['2026-11-09']},today);
const plan=L.create(cfg,cat,exams,{today,version:'test'});
assert.equal(plan.missing,0);
for(const d of new Set(plan.units.map(u=>u.date).filter(Boolean))){
 assert(d<plan.end);assert(!cfg.off.includes(d));assert.notEqual(L.weekday(d),6);
 assert(plan.units.filter(u=>u.date===d).reduce((s,u)=>s+L.cost(u,cfg),0)<=Math.floor(L.capacity(cfg,d)*.8));
}
for(const m of cat){
 const newUnits=plan.units.filter(u=>u.module===m.name&&!u.review);
 const dates=newUnits.map(u=>u.date);assert.deepEqual(dates,[...dates].sort(),'Abschnitte bleiben der Reihe nach');
 const review=plan.units.filter(u=>u.module===m.name&&u.review);assert(review.length);assert(review.every(u=>u.date>=L.add(u.deadline,-10)));
}
const no=L.create({...cfg,minutes:[0,0,0,0,0,0,0]},cat,exams,{today});assert(no.missing>0);assert(no.units.every(u=>!u.date));assert(no.warnings.length);
const status=u=>L.status(u,cat);
const u=plan.units.find(u=>u.type==='aufgaben'&&!u.review);assert(!status(u).done);
for(const id of u.targets)cat.find(m=>m.name===u.module).sections.flatMap(s=>s.items).find(x=>x.id===id).ok=true;
assert(status(u).success);assert(L.status(u,cat,{latch:true}).success);
assert(!L.status({...u,type:'lesen'},cat).done);assert(L.status({...u,type:'lesen'},cat,{manual:true}).done);
assert(L.status(u,cat,{manual:true}).manual);
const removed={...u,targets:['entfernt']};assert(L.status(removed,cat).success,'Entfernte Ziele blockieren nicht');
const review=plan.units.find(u=>u.review&&u.type==='quiz');
assert(!L.status({...review,since:100},cat,{activities:[{art:'quiz',modul:review.module,t:99,tag:review.notBefore,fertig:true,fragen:review.targets.map(id=>({id}))}]}).done);
assert(L.status({...review,since:100},cat,{activities:[{art:'quiz',modul:review.module,t:101,tag:review.notBefore,fertig:true,fragen:review.targets.map(id=>({id}))}]}).done);
const replanned=L.create({...cfg,minutes:[180,180,180,180,180,180,0]},cat,exams,{old:plan,status,today,version:'neu'});
for(const old of plan.units.filter(u=>u.date<=today||status(u).done))assert(replanned.units.some(u=>u.id===old.id&&u.date===old.date),'Historie und aktueller Tag erhalten');
assert.equal(new Set(replanned.units.map(u=>u.id)).size,replanned.units.length);
const changed=exams.map(e=>({...e,date:L.add(e.date,1)}));assert.notEqual(L.signature(cat,exams,cfg),L.signature(cat,changed,cfg));
const next=L.add(today,1),carry=L.carry(plan,next,()=>({done:false}));
for(const [id,d] of Object.entries(carry)){assert(d>=next);assert(d<plan.units.find(u=>u.id===id).deadline);}
assert.equal(L.week('2027-01-03'),'2026-12-28');assert.equal(L.kw('2027-01-03'),53);assert.equal(L.add('2027-03-27',2),'2027-03-29');
console.log('OK: gemeinsame Klausuren; Kapazität/Pausen/Puffer; freie Tage; Reihenfolge; Wiederholungsphase; Überlast; Bewertungen/Entfernung; Historie; Neuplanung; Puffer-Nachholen; Kalendergrenzen.');
assert.equal(L.config({...cfg,pause:0},today).pause,0,'Pausen können ausgeschaltet werden');
assert.equal(L.capacity(cfg,'2026-11-05'),0,'Keine Kapazität vor Planbeginn');
const pre=L.status({...review,since:100},cat,{activities:[{art:'quiz',modul:review.module,t:101,tag:L.add(review.notBefore,-1),fertig:true,fragen:review.targets.map(id=>({id}))}]});
assert.equal(pre.done,false,'Neue Inhalte haken die spätere Klausurwiederholung nicht vorzeitig ab');
const historic=structuredClone(plan);historic.units[0].date=L.add(today,-1);
const again=L.create(cfg,cat,exams,{old:historic,status:()=>({done:false}),today});
assert(again.units.find(u=>u.id===historic.units[0].id).date>today,'Offene Altlasten werden bei Neuplanung neu verteilt');
const nextDay=L.add(today,1),shifts=L.carry(plan,nextDay,()=>({done:false}));
const merged=new Map();for(const unit of plan.units){const date=shifts[unit.id]||unit.date;if(date>=nextDay)merged.set(date,(merged.get(date)||0)+L.cost(unit,cfg));}
assert([...merged].every(([date,n])=>n<=L.capacity(cfg,date)),'Nachholen überzieht das Tagesbudget nicht');
(async()=>{
 const fs=require('node:fs'),path=require('node:path'),vm=require('node:vm');
 global.Lernplan=L;global.PDFLib=require('./vendor/pdf-lib-1.17.1.min.js');global.fontkit=require('./vendor/fontkit-1.1.1.min.js');
 const fetchBefore=global.fetch;global.fetch=async()=>({ok:true,arrayBuffer:async()=>fs.readFileSync(path.join(__dirname,'vendor/NotoSans-Regular.ttf'))});
 vm.runInThisContext(fs.readFileSync(path.join(__dirname,'lernplan-pdf.js'),'utf8'));
 try{
  const bytes=await LernplanPDF.create({plan,catalog:cat,status:u=>L.status(u,cat),date:u=>u.date,base:'https://lernen.test/'});
  const pdf=await PDFLib.PDFDocument.load(bytes);assert(pdf.getPageCount()>1);
  assert(pdf.getPages().some(p=>p.node.Annots()?.size()>0),'PDF enthält klickbare Zielverweise');
  assert(pdf.getPages().every(p=>Math.abs(p.getWidth()-595.28)<.01),'PDF im A4-Hochformat');
  console.log('OK: Lokale PDF-Erzeugung mit eingebetteter Schrift, mehreren A4-Seiten und Zielverweisen.');
 }finally{global.fetch=fetchBefore;}
})().catch(e=>{console.error(e);process.exitCode=1;});
const dueCat=structuredClone(cat);const dueCard=dueCat[0].sections[0].items.find(x=>x.type==='karten');Object.assign(dueCard,{due:true,dueAt:1000,ok:true});
const duePlan=L.create(cfg,dueCat,exams,{today});const firstDue=duePlan.units.find(u=>u.module===dueCat[0].name&&u.fällig);
assert.equal(firstDue.date,today,'Fällige Karten werden vor neuem Stoff eingeplant');
dueCard.dueAt=2000;const nextCycle=L.create(cfg,dueCat,exams,{today});
assert.notEqual(nextCycle.units.find(u=>u.module===dueCat[0].name&&u.fällig).id,firstDue.id,'Jede Wiederholungsfälligkeit hat ein eigenes Ziel');
const cycleReplan=L.create(cfg,dueCat,exams,{old:duePlan,status:u=>({done:u.id===firstDue.id}),today});
assert(cycleReplan.units.some(u=>u.fällig&&u.id!==firstDue.id&&u.notBefore===today),'Neue Fälligkeit bleibt bei Neuplanung sofort verfügbar');
// Automatische Neuverteilung: belegte Folgetage, Reihenfolge, Pausen, Ausfalltage und Nulltermine.
const followToday='2026-11-07';
const followConfig=L.config({start:'2026-11-06',minutes:[60,60,60,60,60,60,60],pause:0},followToday);
const followUnit=(id,date,min,extra={})=>({id,module:'GET',type:'aufgaben',section:'lernpfad:GET:1000:1',date,min,deadline:'2026-11-12',targets:[id],...extra});
const followPlan={config:followConfig,units:[followUnit('verpasst','2026-11-06',30),followUnit('heute','2026-11-07',60),followUnit('danach','2026-11-08',30,{section:'lernpfad:GET:1000:2'}),followUnit('fertig','2026-11-06',20),followUnit('voraus','2026-11-08',10)]};
const isDone=u=>({done:['fertig','voraus'].includes(u.id)});
const sourcePlan=JSON.stringify(followPlan),redistribution=L.carry(followPlan,followToday,isDone);
assert.equal(redistribution.verpasst,followToday,'Nicht erledigte Aufgabe kommt automatisch auf den nächsten passenden Tag');
assert(redistribution.heute>followToday,'Belegte Folgetage werden bei Bedarf automatisch verschoben');
assert(redistribution.danach>=redistribution.heute,'Spätere Abschnitte bleiben hinter ihrem Vorgänger');
assert(!Object.hasOwn(redistribution,'fertig')&&!Object.hasOwn(redistribution,'voraus'),'Fertige Einheiten bleiben an ihrem Datum');
assert.equal(JSON.stringify(followPlan),sourcePlan,'Keine Änderung an Quellplan oder Ziel-IDs');
const assignments=Object.fromEntries(followPlan.units.map(u=>[u.id,Object.hasOwn(redistribution,u.id)?redistribution[u.id]:u.date]));
for(const date of new Set(Object.values(assignments).filter(Boolean))){
 const sum=followPlan.units.filter(u=>assignments[u.id]===date).reduce((n,u)=>n+L.cost(u,followConfig),0);
 assert(sum<=L.capacity(followConfig,date),'Auch die Nachplanung hält das Tagesbudget ein');
}
assert.deepEqual(L.carry(followPlan,followToday,isDone,assignments),{},'Erneutes Prüfen am selben Tag verschiebt nichts doppelt');
const freePlan=structuredClone(followPlan);freePlan.config.off=[followToday,'2026-11-08'];
const freeShifts=L.carry(freePlan,followToday,isDone);assert.equal(freeShifts.verpasst,'2026-11-09','Freie Tage werden übersprungen');
const tightPlan={config:followConfig,units:[followUnit('zu-lang','2026-11-06',90,{deadline:'2026-11-08'}),followUnit('nachfolger','2026-11-07',10,{deadline:'2026-11-08',section:'lernpfad:GET:1000:2'})]};
const tight=L.carry(tightPlan,followToday,()=>({done:false}));assert.equal(tight['zu-lang'],null);assert.equal(tight.nachfolger,null,'Unmögliche Termine bleiben ausdrücklich offen, statt Lernreihenfolge oder Klausurdatum zu verletzen');
assert.deepEqual(L.carry({...followPlan,units:[followUnit('morgen','2026-11-08',30)]},followToday,()=>({done:false})),{},'Ohne verpasste Ziele bleibt die Tagesliste stabil');
const oldShifts={verpasst:'2026-11-10',heute:'2026-11-06'};
const repaired=L.carry(followPlan,followToday,isDone,oldShifts);
assert(repaired.verpasst<=repaired.heute,'Eine frühere Puffer-Verschiebung wird bei erneuter Nachplanung in die richtige Abschnittsfolge gebracht');
const reopened=L.carry(tightPlan,followToday,()=>({done:false}),{'zu-lang':null,nachfolger:null});
assert.deepEqual(reopened,{},'Explizit nicht einplanbare Ziele werden nicht auf alte Daten zurückgesetzt');
console.log('OK: Automatische Folgetage; kein Überbuchen; erledigte Historie; freie Tage; Reihenfolge; unveränderte IDs; offene Nulltermine; wiederholtes Öffnen.');
// Der öffentliche Adapter liest einen vollständigen automatischen Plan atomar, einschließlich Nullterminen.
{
 const fs=require('node:fs'),vm=require('node:vm'),path=require('node:path');
 const source=fs.readFileSync(path.join(__dirname,'lernplan-ui.js'),'utf8'),state=new Map();
 const adapter={db:{get:(key,fallback)=>state.get(key)??fallback,objekt:prefix=>Object.fromEntries([...state].filter(([k,v])=>k.startsWith(prefix)&&v!=null).map(([k,v])=>[k.slice(prefix.length),v]))}};
 vm.createContext(adapter);
 vm.runInContext(source.slice(source.indexOf('function lpPlan('),source.indexOf('function lpKatalog(')),adapter);
 vm.runInContext(source.slice(source.indexOf('function lpDatum('),source.indexOf('function lernplanMerken(')),adapter);
 state.set('einst:lernplan',{version:'lesen'});state.set('lernplan:version:lesen',{id:'lesen',units:followPlan.units});
 state.set('lernplan:datum:lesen:verpasst','2026-11-09');
 assert.equal(adapter.lpDatum(followPlan.units[0]),'2026-11-09','Alte Verschiebungen bleiben bis zur Migration lesbar');
 state.set('lernplan:automatik:lesen',{v:2,day:followToday,dates:{verpasst:null,heute:'2026-11-10'}});
 assert.equal(adapter.lpDatum(followPlan.units[0]),null,'Explizit ohne Termin überschreibt auch ein altes Verschiebedatum');
 assert.equal(adapter.lpDatum(followPlan.units[1]),'2026-11-10');
 state.set('lernplan:datum:lesen:heute','2026-11-08');
 assert.equal(adapter.lpDatum(followPlan.units[1]),'2026-11-10','Ein älteres Gerät zerlegt die atomare Verteilung nicht');
 state.set('lernplan:extra:lesen:extra',{...followPlan.units[0],id:'extra',date:followToday});
 assert(adapter.lpPlan('lesen').units.some(u=>u.id==='extra'),'Ergänzte Kartenrunden gehören ebenfalls zum Planstatus');
 console.log('OK: Adapter-Migration; Nulltermine; atomarer Geräteabgleich; ergänzte Einheiten.');
}

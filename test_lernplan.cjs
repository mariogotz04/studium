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
// Wochenbedarf: mit echten Klausurgrenzen simulieren, statt nur Gesamtminuten zu mitteln.
{
 const start='2026-11-09',budgetCat=['Früh','Spät'].map(name=>({name,typ:'transfer',duration:90,sections:[{
  key:name+':1.1',label:'Abschnitt 1.1',items:Array.from({length:60},(_,i)=>item(name+i,'aufgaben',20))
 }]})),budgetExams=[{id:'early',date:'2026-11-30',modules:['Früh'],duration:90},{id:'late',date:'2027-02-11',modules:['Spät'],duration:90}];
 const config=L.config({start,minutes:[60,60,60,60,60,90,0],reading:false,exams:['early','late']},start),before=JSON.stringify({config,budgetCat,budgetExams});
 const need=L.weeklyBudget(config,budgetCat,budgetExams,{today:start});
 assert.equal(need.state,'ready');assert(need.weekly>need.current);assert(need.reviewReserved);
 assert.equal(need.minutes[6],0,'Ein freier Wochentag bleibt in der Bedarfsschätzung frei');
 assert(need.minutes[5]>need.minutes[0],'Das Verhältnis der eingetragenen Tagesminuten bleibt Grundlage des Richtwerts');
 assert.equal(need.minutes.reduce((s,n)=>s+n,0),need.weekly);
 const sufficient=L.create({...config,minutes:need.minutes},budgetCat,budgetExams,{today:start});
 assert.equal(sufficient.missing,0,'Der empfohlene Wochenbedarf lässt sich vollständig einplanen');
 assert.equal(sufficient.warnings.length,0,'Die vollständige Wiederholungsphase bleibt frei');
 assert.equal(JSON.stringify({config,budgetCat,budgetExams}),before,'Die Bedarfsschätzung verändert weder Einstellungen noch Lernstand');
 const later=L.weeklyBudget(config,budgetCat,budgetExams.map(e=>({...e,date:'2027-02-11'})),{today:start});
 assert(later.weekly<need.weekly,'Eine frühe Klausur erhöht den Bedarf auch bei gleichem Gesamtumfang');
 const morePause=L.weeklyBudget({...config,pause:15},budgetCat,budgetExams,{today:start});
 assert(morePause.weekly>need.weekly,'Pausen zählen zum benötigten Wochenbudget');
 const allZero=L.weeklyBudget({...config,minutes:Array(7).fill(0)},budgetCat,budgetExams,{today:start});
 assert.equal(allZero.state,'ready');assert(allZero.balanced);assert(allZero.weekly>0);
 assert.equal(L.create({...config,minutes:allZero.minutes},budgetCat,budgetExams).missing,0,'Auch ohne eingetragenes Budget entsteht ein brauchbarer Richtwert');
 const off=Array.from({length:L.days(start,'2026-11-30')},(_,i)=>L.add(start,i));
 assert.equal(L.weeklyBudget({...config,off},budgetCat,budgetExams).state,'impossible','Keine falsche Minutenempfehlung ohne freie Termine');
 const lectures=off.map(d=>({d,min:480}));
 assert.equal(L.weeklyBudget({...config,lectures:true},budgetCat,budgetExams,{lectures}).state,'impossible','Vorlesungen können die Restkapazität vollständig belegen');
 assert.equal(L.weeklyBudget({...config,exams:[]},budgetCat,budgetExams).state,'empty');
 const lateConfig={...config,start:'2026-11-23',minutes:Array(7).fill(60)};
 const lateNeed=L.weeklyBudget(lateConfig,budgetCat,budgetExams);
 assert.equal(lateNeed.state,'ready');assert.equal(lateNeed.reviewReserved,false,'Bei spätem Start wird eine verkürzte Wiederholungsphase ehrlich ausgewiesen');
 assert.equal(L.create({...lateConfig,minutes:lateNeed.minutes},budgetCat,budgetExams).missing,0);
 const lower=L.weeklyBudget({...config,minutes:need.minutes},budgetCat,budgetExams);
 assert(Math.abs(lower.weekly-need.weekly)<=need.days,'Ganzzahlige Tagesminuten ändern den erneuten Richtwert höchstens um Rundungsminuten');
 const smallBuffer={...config,buffer:.05},smallNeed=L.weeklyBudget(smallBuffer,budgetCat,budgetExams);
 assert(smallNeed.weekly<need.weekly,'Weniger freigehaltene Reserve reduziert das verfügbare Wochenbudget');
 const smallPlan=L.create({...smallBuffer,minutes:smallNeed.minutes},budgetCat,budgetExams),weekly={};
 assert.equal(smallPlan.missing,0);assert.equal(smallPlan.warnings.length,0);
 assert.deepEqual(smallPlan.units.map(u=>[u.id,u.min,u.targets]),sufficient.units.map(u=>[u.id,u.min,u.targets]),'Eine andere Reserve ändert weder Lernstoff noch Zeitansätze, einschließlich Probeklausuren');
 for(const unit of smallPlan.units)weekly[L.week(unit.date)]=(weekly[L.week(unit.date)]||0)+L.cost(unit,smallBuffer);
 assert.equal(smallNeed.scheduledWeeklyMax,Math.max(...Object.values(weekly)),'Verplante Wochenzeit kommt aus den tatsächlichen Einheiten einschließlich Pausen');
 assert.equal(smallNeed.reserveWeekly,Math.ceil(smallNeed.weekly*.05));
 for(const date of new Set(smallPlan.units.map(u=>u.date)))assert(smallPlan.units.filter(u=>u.date===date).reduce((s,u)=>s+L.cost(u,smallBuffer),0)<=Math.floor(L.capacity(smallPlan.config,date)*.95),'Auch bei 5 % Reserve wird die verfügbare Kapazität eingehalten');
 assert.equal(L.config({buffer:0},start).buffer,0,'Null Prozent Reserve bleiben ausdrücklich möglich');
 assert.equal(L.config({},start).buffer,.2,'Bestehende Pläne und neue Beispiele behalten standardmäßig 20 % Reserve');
 assert.equal(L.config({buffer:1},start).buffer,.5);assert.equal(L.config({buffer:-1},start).buffer,0);
 console.log('OK: Wochenbedarf; frühe Klausuren; Pausen/Puffer; freie Lerntage; Vorlesungen; Nullbudget; unmögliche Pläne; Wiederholungsphase; unveränderte Quelldaten.');
}
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
  const weeklyPlan=L.create({...cfg,mode:'weekly',weeklyMinutes:900,buffer:.05},cat,exams,{today});
  const weeklyBytes=await LernplanPDF.create({plan:weeklyPlan,catalog:cat,week:L.week(today),status:u=>L.status(u,cat),date:u=>u.week,base:'https://lernen.test/'});
  const weeklyPdf=await PDFLib.PDFDocument.load(weeklyBytes);
  assert(weeklyPdf.getPageCount()>0);assert(weeklyPdf.getPages().some(p=>p.node.Annots()?.size()>0),'Wochenlisten-PDF enthält Zielverweise ohne Tageszuordnungen');
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
 const adapter={Lernplan:L,heuteIso:()=>followToday,db:{get:(key,fallback)=>state.get(key)??fallback,objekt:prefix=>Object.fromEntries([...state].filter(([k,v])=>k.startsWith(prefix)&&v!=null).map(([k,v])=>[k.slice(prefix.length),v]))}};
 vm.createContext(adapter);
 vm.runInContext(source.slice(source.indexOf('function lpPlan('),source.indexOf('function lpKatalog(')),adapter);
 vm.runInContext(source.slice(source.indexOf('function lpDatum('),source.indexOf('function lernplanMerken(')),adapter);
 state.set('einst:lernplan',{version:'lesen'});state.set('lernplan:version:lesen',{id:'lesen',units:followPlan.units});
 state.set('lernplan:datum:lesen:verpasst','2026-11-09');
 assert.equal(adapter.lpDatum(followPlan.units[0]),'2026-11-09','Alte Verschiebungen bleiben bis zur Migration lesbar');
 state.set('lernplan:automatik:lesen',{v:2,day:followToday,dates:{verpasst:null,heute:'2026-11-10'}});
 assert.equal(adapter.lpDatum(followPlan.units[0]),null,'Explizit ohne Termin überschreibt auch ein altes Verschiebedatum');
 assert.equal(adapter.lpDatum(followPlan.units[1]),'2026-11-09','Alte Tageszuordnungen werden als Zielwoche gelesen');
 state.set('lernplan:datum:lesen:heute','2026-11-08');
 assert.equal(adapter.lpDatum(followPlan.units[1]),'2026-11-09','Alte Tagesverschiebungen bleiben bis zur Wochenmigration konsistent');
 state.set('lernplan:wochen:lesen',{v:3,week:'2026-11-09',weeks:{verpasst:null,heute:'2026-11-16'}});
 state.set('lernplan:automatik:lesen',{v:2,dates:{verpasst:'2026-11-08',heute:'2026-11-10'}});
 assert.equal(adapter.lpDatum(followPlan.units[0]),null,'Explizite offene Wochenziele bleiben trotz älterer Tagesdaten ohne Termin');
 assert.equal(adapter.lpDatum(followPlan.units[1]),'2026-11-16','Ein älteres Gerät überschreibt die neue Wochenzuordnung nicht');
 state.set('lernplan:extra:lesen:extra',{...followPlan.units[0],id:'extra',date:followToday});
 assert(adapter.lpPlan('lesen').units.some(u=>u.id==='extra'),'Ergänzte Kartenrunden gehören ebenfalls zum Planstatus');
 adapter.Lernplan=L;
 vm.runInContext(source.slice(source.indexOf('function lpSignatur('),source.indexOf('function lpStart(')),adapter);
 const pdfPlan={id:'pdf',config:{buffer:.2},units:[]};
 assert.notEqual(adapter.lpSignatur(pdfPlan,[]),adapter.lpSignatur({...pdfPlan,config:{buffer:.05}},[]),'Eine geänderte Reserve aktualisiert die PDF auch bei unveränderten Lerntagen');
 assert.notEqual(adapter.lpSignatur(pdfPlan,[]),adapter.lpSignatur({...pdfPlan,id:'neu'},[]),'Eine neue Planversion gehört zum PDF-Stand');
 console.log('OK: Adapter-Migration; Nulltermine; atomarer Geräteabgleich; ergänzte Einheiten.');
}

// Ansicht und Rückkehr bleiben unabhängig vom Lernstand und von der Planversion erhalten.
{
 const fs=require('node:fs'),vm=require('node:vm'),path=require('node:path');
 const source=fs.readFileSync(path.join(__dirname,'lernplan-ui.js'),'utf8'),state=new Map(),session=new Map();
 const c={Lernplan:L,heuteIso:()=> '2026-11-09',lpDatum:u=>u.week,location:{hash:'#termine/lernplan/2026-11-16'},
  db:{get:(k,d)=>state.get(k)??d,set:(k,v)=>state.set(k,v)},
  sessionStorage:{getItem:k=>session.get(k)??null,setItem:(k,v)=>session.set(k,v),removeItem:k=>session.delete(k)},
  termineView:{querySelectorAll:()=>[]},window:{scrollY:315}};
 vm.createContext(c);vm.runInContext('let lpAnsicht=null,lpRueckkehr;'+source.slice(source.indexOf('function lpModulOffen('),source.indexOf('function lpStandard(')),c);
 assert(c.lpModulOffen('FET'));
 const el={isConnected:true,dataset:{lpModul:'FET'},open:false};
 vm.runInContext('lpAnsicht={plan:"test",week:"2026-11-16"}',c);c.lpModulMerken(el);
 assert.equal(c.lpModulOffen('FET'),false);
 state.set('einst:lernplan:modul:FET',true);c.lpModulMerken(el);assert(c.lpModulOffen('FET'),'Eine unveränderte Ansicht überschreibt keine neu synchronisierte Einstellung');
 state.set('einst:lernplan:modul:FET',false);
 c.lpAnsichtVerlassen();assert.equal(session.get('studium:lernplan:scroll:test:2026-11-16'),'315');
 el.open=true;c.lpModulMerken(el);assert.equal(c.lpModulOffen('FET'),false,'Eine ausgeblendete alte Ansicht überschreibt die Einstellung nicht');
 const u={id:'ziel',module:'technische Mechanik',type:'aufgaben',week:'2026-11-09'};
 c.lpRueckkehrSpeichern(u,{id:'test'});assert.equal(c.lpRueckkehrLesen().week,'2026-11-16','Ausgewählte Woche hat Vorrang');
 c.location.hash='#lernen/technische%20Mechanik/aufgabe/a1';c.lpNavigationPruefen();assert(c.lpRueckkehrAktiv());
 const target='#termine/lernplan/2026-11-16/ziel/ziel/technische%20Mechanik';
 assert.equal(c.lpRueckweg('#lernen'),target);assert.equal(c.lpRuecktext('Modul'),'Zum Wochenplan');
 vm.runInContext('lpRueckkehr=undefined',c);assert.equal(c.lpRueckweg('#lernen'),target,'Neuladen einer Übung erhält den Rückweg');
 c.location.hash=target;c.lpNavigationPruefen();assert(c.lpRueckkehrLesen());
 c.location.hash='#start';c.lpNavigationPruefen();assert.equal(c.lpRueckkehrLesen(),null);
 c.location.hash='#lernen/technische%20Mechanik/aufgabe/a1';assert.equal(c.lpRueckweg('#lernen'),'#lernen','Normaler Einstieg übernimmt keinen alten Rückweg');
 c.location.hash='#termine/lernplan';c.lpRueckkehrSpeichern(u,{id:'test'});
 c.location.hash='#lernen/technische%20Mechanik/quiz';assert.equal(c.lpRueckkehrAktiv(),false,'Der Rückweg gilt nur für das gestartete Lernformat');
 c.location.hash='#termine/lernplan';c.lpNavigationPruefen();assert(c.lpRueckkehrLesen(),'Browser-Zurück zur aktuellen Woche erhält das Ziel');
 console.log('OK: Fachlisten gespeichert; Wochenposition; gewählte Woche; Übungs-Neuladen; Browser-Zurück; normaler Einstieg ohne fremden Rückweg.');
}

// Wochenziele: ein Budget statt sieben Tagesbudgets, echte Fristen und stabile Wochen.
{
 const start='2026-11-09',modules=['GET','Finanzierung','Investitionsrechnung'].map(moduleData);
 const wc=L.config({mode:'weekly',start,weeklyMinutes:600,buffer:.05,exams:exams.map(e=>e.id)},start);
 const wp=L.create(wc,modules,exams,{today:start});
 assert.equal(wp.mode,'weekly');assert.equal(wp.missing,0);assert(wp.units.every(u=>u.week&&u.date===null));
 for(const w of new Set(wp.units.map(u=>u.week))){
  const used=wp.units.filter(u=>u.week===w).reduce((n,u)=>n+L.cost(u,wc),0);
  assert(used<=Math.floor(L.weeklyCapacity(wc,w)*.95),'Die Wochenziele halten das Budget samt Reserve ein');
  assert(L.fitsWeek(wc,wp.units.filter(u=>u.week===w),w,{today:start}),'Jede Wochenliste ist vor den echten Klausurfristen zeitlich möglich');
 }
 for(const m of modules){const dates=wp.units.filter(u=>u.module===m.name&&!u.review).map(u=>u.week);assert.deepEqual(dates,[...dates].sort());}
 const noTime=L.create({...wc,weeklyMinutes:0},modules,exams,{today:start});assert(noTime.missing>0);assert(noTime.units.every(u=>u.week===null));
 const need=L.weeklyBudget(wc,modules,exams,{today:start});assert.equal(need.state,'ready');
 assert.equal(L.create({...wc,weeklyMinutes:need.weekly},modules,exams,{today:start}).missing,0);
 const pauseCopy=L.create({...wc,pause:15},modules,exams,{today:start});assert(pauseCopy.units.every(u=>wp.units.find(x=>x.id===u.id)?.min===u.min),'Bearbeitungszeiten bleiben unabhängig vom Wochenbudget erhalten');
 const oneDay={...wc,start:'2026-11-15',weeklyMinutes:1500,buffer:0};assert.equal(L.weeklyCapacity(oneDay,'2026-11-09'),600,'Ein einziger verbleibender Kalendertag erzeugt kein volles Wochenbudget');
 assert.equal(L.weeklyCapacity(oneDay,'2026-11-09',[],oneDay.start,1200),1500,'Bereits erledigte Wochenzeit wird bei einer angefangenen Woche mitgezählt');
 const offWeek={...wc,off:Array.from({length:7},(_,i)=>L.add(start,i))};assert.equal(L.weeklyCapacity(offWeek,start),0);
 assert(L.create(offWeek,modules,exams,{today:start}).units.every(u=>u.week!==start),'Eine vollständig freie Woche enthält keine Ziele');
 const deadlineUnit=(id,min,extra={})=>({id,module:'GET',type:'aufgaben',section:'lernpfad:GET:1000:1',targets:[id],min,week:start,date:null,notBefore:start,deadline:'2026-11-10',exam:'exam',...extra});
 assert.equal(L.fitsWeek({...wc,weeklyMinutes:1500,buffer:0},[deadlineUnit('a',350),deadlineUnit('b',350)],start,{today:start}),false,'Vor einer Dienstagsklausur stehen nicht alle sieben Tage der Woche zur Verfügung');
 const window=L.windowFor(deadlineUnit('release',10,{review:true,notBefore:'2026-11-12',deadline:'2026-11-17'}),start,wc);
 assert.deepEqual(window,{from:'2026-11-12',until:'2026-11-15'});
 assert.equal(L.windowFor(deadlineUnit('history-window',10,{deadline:'2026-12-01'}),start,{...wc,start:'2026-11-16'}).from,start,'Ein neuer Planstart verändert kein historisches Wochenfenster');
 const next='2026-11-16',followConfig=L.config({mode:'weekly',start,weeklyMinutes:60,buffer:.2,pause:0},start),unit=(id,w,min,section=1)=>deadlineUnit(id,min,{week:w,deadline:'2026-12-07',section:'lernpfad:GET:1000:'+section});
 const follow={mode:'weekly',config:followConfig,exams:[{id:'exam',date:'2026-12-07'}],units:[unit('missed',start,30),unit('current',next,60),unit('later','2026-11-23',30,2),unit('done',start,20)]},done=u=>({done:u.id==='done'}),before=JSON.stringify(follow);
 assert.deepEqual(L.carryWeekly(follow,'2026-11-10',done),{},'Innerhalb einer Woche bleiben offene Ziele stehen');
 const changes=L.carryWeekly(follow,next,done);assert.equal(changes.missed,next);assert(changes.current>next);assert(changes.later>=changes.current);assert(!Object.hasOwn(changes,'done'));assert.equal(JSON.stringify(follow),before);
 const merged=Object.fromEntries(follow.units.map(u=>[u.id,Object.hasOwn(changes,u.id)?changes[u.id]:u.week]));
 for(const w of new Set(Object.values(merged).filter(Boolean)))assert(follow.units.filter(u=>merged[u.id]===w).reduce((n,u)=>n+L.cost(u,followConfig),0)<=60,'Auch beim Nachholen wird die Woche nicht überbucht');
 assert.deepEqual(L.carryWeekly(follow,next,done,merged),{},'Erneutes Öffnen derselben Woche verändert die Zuordnung nicht');
 assert.deepEqual(L.carryWeekly({...follow,units:[unit('never',null,20)]},next,done),{},'Nie eingeplante Einheiten werden nicht als verpasste Wochenziele behandelt');
 const cross={...follow,units:[unit('older',start,40),{...unit('current-other',next,50),module:'Finanzierung'}]};
 const crossChanges=L.carryWeekly(cross,next,()=>({done:false}));assert.equal(crossChanges.older,next,'Offene Vorwochenziele haben auch gegenüber einem anderen Fach Vorrang');assert(crossChanges['current-other']>next);
 const tight=L.carryWeekly({...follow,config:{...followConfig,weeklyMinutes:0}},next,done);assert.equal(tight.missed,null);assert.equal(tight.current,null);
 const history={...wp,units:wp.units.map((u,i)=>i?u:{...u,week:start})},isDone=u=>({done:u.id===history.units[0].id});
 const revised=L.create(wc,modules,exams,{old:history,status:isDone,today:next});assert.equal(revised.units.find(u=>u.id===history.units[0].id).week,start,'Fertige Wochenhistorie bleibt bei Neuplanung erhalten');
 const mixedModules=[['Gross',40],['Klein',10]].map(([name,n])=>({name,typ:'transfer',duration:90,sections:[{key:name+':1.1',label:'Abschnitt 1.1',items:Array.from({length:n},(_,i)=>item(name+i,'aufgaben',15))}]}));
 const mixed=L.create({...wc,weeklyMinutes:300,buffer:0,reading:false,exams:['mix']},mixedModules,[{id:'mix',date:'2026-12-10',modules:['Gross','Klein'],duration:90}],{today:start});
 assert.equal(new Set(mixed.units.filter(u=>u.week===start&&!u.review).map(u=>u.module)).size,2,'Eine größere Stoffmenge verdrängt ein anderes Fach nicht aus der ganzen Woche');
 console.log('OK: Freie Wochenziele; Wochenbudget/Reserve; Klausurfristen; Wiederholungsfenster; freie Wochen; Wochenwechsel; kein tägliches Verschieben; Historie und Nullzuordnungen.');
}

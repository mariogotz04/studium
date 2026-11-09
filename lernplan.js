/* Reine Lernplanlogik. Keine Browserdaten, kein Netz; dieselbe Logik für Ansicht und PDF. */
(function(root){
'use strict';
const DAY=86400000;
const add=(s,n)=>new Date(Date.parse(s+'T12:00:00Z')+n*DAY).toISOString().slice(0,10);
const days=(a,b)=>Math.round((Date.parse(b+'T12:00:00Z')-Date.parse(a+'T12:00:00Z'))/DAY);
const weekday=s=>(new Date(s+'T12:00:00Z').getUTCDay()+6)%7;
const hash=s=>{let h=2166136261;for(const c of s){h^=c.charCodeAt(0);h=Math.imul(h,16777619);}return(h>>>0).toString(36);};
const week=s=>add(s,-weekday(s));
function kw(s){const d=new Date(s+'T12:00:00Z');d.setUTCDate(d.getUTCDate()+3-weekday(s));return Math.ceil(((d-new Date(Date.UTC(d.getUTCFullYear(),0,1)))/DAY+1)/7);}
function config(c={},today){
 return {start:c.start||today,mode:c.mode==='weekly'?'weekly':'daily',weeklyMinutes:Math.max(0,Math.min(4200,Number.isFinite(c.weeklyMinutes)?c.weeklyMinutes:(c.minutes||[]).reduce((s,n)=>s+(+n||0),0))),minutes:Array.from({length:7},(_,i)=>Math.max(0,Math.min(600,+c.minutes?.[i]||0))),
  block:Math.max(15,Math.min(90,+c.block||35)),pause:Math.max(0,Math.min(30,Number.isFinite(+c.pause)?+c.pause:5)),buffer:Number.isFinite(c.buffer)?Math.max(0,Math.min(.5,c.buffer)):.2,
  off:[...new Set(c.off||[])].sort(),exams:c.exams||[],focus:c.focus||'',lectures:!!c.lectures,reading:c.reading!==false};
}
function exams(raw,today){
 const groups=new Map();
 for(const e of raw.filter(e=>e.datum>=today&&!e.erledigt&&e.modules?.length).sort((a,b)=>a.datum.localeCompare(b.datum))){
  const mods=[...new Set(e.modules)].sort(),key=e.datum+'|'+mods.join('|');
  if(!groups.has(key))groups.set(key,{id:hash(mods.join('|')+'|'+(e.amtlich?.nummer||e.titel||'')),date:e.datum,title:e.titel,modules:mods,duration:e.duration||90});
 }
 return [...groups.values()];
}
function capacity(c,date,lectures=[]){
 if(date<c.start||c.off.includes(date))return 0;
 let n=c.minutes[weekday(date)]||0;
 if(c.lectures)n=Math.min(n,Math.max(0,480-lectures.filter(t=>t.d===date).reduce((s,t)=>s+Math.max(0,t.min||0),0)));
 return n;
}
const cost=(u,c)=>u.min+(u.min>=20?c.pause:0);
function units(c,catalog,examination,old=null,status=()=>({done:false}),today=c.start){
 const kept=(old?.units||[]).filter(u=>u.date&&u.date<=today||status(u).done)
  .map(u=>u.date<today&&!status(u).done?{...u,date:null,originalDate:u.originalDate||u.date}:{...u});
 const covered=new Set(kept.filter(u=>!u.review).flatMap(u=>u.targets.map(id=>u.module+'|'+u.type+'|'+id)));
 const result=[...kept],types=['lesen','aufgaben','quiz','karten'];
 for(const m of catalog){
  const exam=examination.find(e=>e.modules.includes(m.name));if(!exam)continue;
  const push=(type,section,items,review=false,suffix='')=>{
   const targets=items.map(x=>x.id),id=hash([m.name,section?.key||'',type,targets.join(','),suffix].join('|'));
   const existing=result.find(u=>u.id===id);if(existing)return existing;
   const unit={id,module:m.name,type,section:section?.key||'',label:section?.label||'Erreichter Stoff',
    title:type==='lesen'?'Skript lesen und erklären':type==='aufgaben'?items.map(x=>x.title).join(' · '):type==='quiz'?`${items.length} ${items.length===1?'Quizfrage':'Quizfragen'}`:
     type==='karten'?`${items.length} ${items.length===1?'Karteikarte':'Karteikarten'}`:type==='probe'?'Probeklausur mit Auswertung':'Wiederholung',
    targets,min:Math.max(5,Math.ceil(items.reduce((s,x)=>s+x.min,0))),source:section?.source?{p:section.source.p,t:section.source.t}:null,pdf:m.pdf,
    exam:exam.id,deadline:exam.date,review,notBefore:review?add(exam.date,-10):c.start,date:null};result.push(unit);return unit;
  };
  for(const s of m.sections){
   for(const type of types){
    if(type==='lesen'){
     if(c.reading&&!s.complete&&!covered.has(m.name+'|lesen|'+s.key))push(type,s,[{id:s.key,min:10}]);continue;
    }
    const pool=s.items.filter(x=>x.type===type&&!x.ok&&!covered.has(m.name+'|'+type+'|'+x.id));
    let chunk=[],min=0;
    for(const x of pool){if(chunk.length&&min+x.min>c.block){push(type,s,chunk);chunk=[];min=0;}chunk.push(x);min+=x.min;}
    if(chunk.length)push(type,s,chunk);
   }
  }
  // Wiederholungsziele sind konkret. Zum Start entscheidet erneut der aktuelle Lernpfad.
  const eligible=m.sections.flatMap(s=>s.items).filter(x=>x.type==='aufgaben');
  const due=m.sections.flatMap(s=>s.items).filter(x=>x.type==='karten'&&x.due&&x.reached).slice(0,Math.max(1,Math.floor(c.block/.6)));
  if(due.length){const u=push('karten',{key:'faellig',label:'Fällige Wiederholung',source:null},due,true,'due-'+due.map(x=>x.id+':'+(x.dueAt||0)).join(','));if(u){u.notBefore=c.start;u.fällig=true;}}
  const reviewTypes=m.typ==='abfrage'?['quiz','karten','quiz']:m.typ==='gemischt'?['aufgaben','quiz','karten']:['aufgaben','aufgaben','quiz'];
  reviewTypes.forEach((type,i)=>{
   const pool=m.sections.flatMap(s=>s.items).filter(x=>x.type===type).sort((a,b)=>Number(a.ok)-Number(b.ok));
   let min=0;const selected=[];
   for(const x of [...pool.slice(i*2),...pool.slice(0,i*2)]){if(selected.length&&min+x.min>c.block)break;selected.push(x);min+=x.min;if(min>=c.block)break;}
   if(selected.length)push(type,{key:'wiederholung-'+i,label:'Klausurwiederholung',source:null},selected,true,'wdh-'+i);
  });
  if(eligible.length)push('probe',null,[{id:'probe',min:Math.round((m.duration||exam.duration)*.8)+20}],true,'probe');
 }
 return {units:result,known:catalog.flatMap(m=>m.sections.flatMap(s=>s.items.map(x=>m.name+'|'+x.type+'|'+x.id)))};
}
function create(c,catalog,examination,{old=null,status=()=>({done:false}),today=c.start,lectures=[],version='v1'}={}){
 c=config(c,today);if(c.mode==='weekly')return createWeekly(c,catalog,examination,{old,status,today,lectures,version});
 const selected=examination.filter(e=>c.exams.includes(e.id));
 const built=units(c,catalog,selected,old,status,today),all=built.units;
 const end=selected.map(e=>e.date).sort().at(-1)||c.start;
 if(days(c.start,end)>730)throw new Error('Bitte einen Planzeitraum von höchstens zwei Jahren wählen.');
 const queues=new Map(catalog.map(m=>[m.name,all.filter(u=>u.module===m.name&&!u.date&&!status(u).done)]));
 const start=old&&c.start<=today?add(today,1):c.start;
 const usage={};for(const u of all)if(u.date)usage[u.date]=(usage[u.date]||0)+cost(u,c);
 for(let d=start;d<end;d=add(d,1)){
  let free=Math.max(0,Math.floor(capacity(c,d,lectures)*(1-c.buffer))-(usage[d]||0)),last='',seen=new Set();
  while(free>0){
   const candidates=[];
   for(const [name,q] of queues){
    const u=q.find(u=>u.fällig&&u.deadline>d&&u.notBefore<=d)||q.find(u=>u.deadline>d&&u.notBefore<=d&&(!u.review||!q.some(x=>!x.review&&x!==u)));
    if(!u||cost(u,c)>free)continue;
    const group=selected.find(e=>e.id===u.exam),remaining=q.reduce((s,u)=>s+u.min,0);
    const urgent=remaining/Math.max(1,days(d,u.review?u.deadline:add(u.deadline,-10)));
    candidates.push({name,u,score:urgent/(group?.modules.length||1)*(name===c.focus?1.5:1)*(seen.has(name)?1:2)*(name===last?.5:1)});
   }
   candidates.sort((a,b)=>b.score-a.score||a.u.deadline.localeCompare(b.u.deadline)||a.name.localeCompare(b.name));
   const chosen=candidates[0];if(!chosen)break;
   chosen.u.date=d;free-=cost(chosen.u,c);usage[d]=(usage[d]||0)+cost(chosen.u,c);last=chosen.name;seen.add(last);
   queues.get(last).splice(queues.get(last).indexOf(chosen.u),1);
  }
 }
 const backlog=all.filter(u=>!u.date&&!status(u).done),warnings=[];
 const missing=backlog.reduce((s,u)=>s+cost(u,c),0);
 if(missing)warnings.push(`${missing} Minuten passen vor den Klausuren noch nicht in dein Zeitbudget. Lernzeit erhöhen, freie Tage prüfen oder frühere Einheiten einplanen.`);
 const squeezed=all.filter(u=>!u.review&&u.date&&u.date>=add(u.deadline,-10)&&u.date>=today);
 if(squeezed.length)warnings.push(`${squeezed.length} Einheiten liegen in der vorgesehenen Wiederholungsphase. Dafür bleibt weniger Wiederholungszeit.`);
 return {id:version,number:(old?.number||0)+1,created:Date.now(),config:c,exams:selected,units:all,known:built.known,end,warnings,missing,
  signature:signature(catalog,examination,c),lastDay:today};
}
function dayLimit(c,d,lectures=[]){
 if(d<c.start||c.off.includes(d))return 0;
 return c.lectures?Math.max(0,480-lectures.filter(t=>t.d===d).reduce((s,t)=>s+Math.max(0,t.min||0),0)):600;
}
function weeklyCapacity(c,w,lectures=[],from=c.start,spent=0){
 let available=0;for(let i=0;i<7;i++){const d=add(week(w),i);if(d>=from)available+=dayLimit(c,d,lectures);}
 return Math.min(c.weeklyMinutes,spent+available);
}
function windowFor(u,w,c){
 const start=c.start<=add(week(w),6)?c.start:week(w);
 const from=[week(w),start,u.notBefore||start].sort().at(-1),until=[add(week(w),6),add(u.deadline,-1)].sort()[0];
 return {from,until};
}
// Kalendertage prüfen nur, ob die Wochenziele vor ihren echten Fristen machbar sind.
// Die Einheiten erhalten ausschließlich eine Zielwoche, keinen vorgeschriebenen Lerntag.
function scheduleWeeks(c,input,examination,{today=c.start,status=()=>({done:false}),lectures=[],strict=false,floors={},reserve=c.buffer,priority=new Set()}={}){
 const all=input.map(u=>({...u})),done=new Map(all.map(u=>[u.id,!!status(u).done]));
 const start=[c.start,today].sort().at(-1),end=examination.map(e=>e.date).sort().at(-1)||start;
 const queues=new Map(),indices=new Map(all.map((u,i)=>[u.id,i])),usedWeeks={},usedDays={},usedModules={},lastDay={};let overbooked=0;
 const assigned=u=>u.week!==undefined?u.week:u.date?week(u.date):null;
 const order=(a,b)=>{
  if(!!a.review!==!!b.review)return a.review?1:-1;
  if(a.review)return (a.notBefore||start).localeCompare(b.notBefore||start)||indices.get(a.id)-indices.get(b.id);
  const aa=(a.section||'').match(/:(\d+):(\d+)$/),bb=(b.section||'').match(/:(\d+):(\d+)$/);
  if(aa&&bb&&(aa[1]!==bb[1]||aa[2]!==bb[2]))return +aa[1]-bb[1]||+aa[2]-bb[2];
  return indices.get(a.id)-indices.get(b.id);
 };
 const latest=u=>!u.review&&strict?week(add(u.deadline,-10)):u.deadline;
 const slot=(u,w)=>{
  const from=[start,w,u.notBefore||start,lastDay[u.module]||start,floors[u.id]||start].sort().at(-1);
  const until=[add(w,7),latest(u)].sort()[0],n=cost(u,c);
  for(let d=from;d<until;d=add(d,1))if(n<=dayLimit(c,d,lectures)-(usedDays[d]||0))return d;
  return null;
 };
 for(const u of all){
  const w=assigned(u);
  if(done.get(u.id)){
   u.week=w;
   if(w&&w>=week(start)){
    usedWeeks[w]=(usedWeeks[w]||0)+cost(u,c);
    usedModules[w+'|'+u.module]=(usedModules[w+'|'+u.module]||0)+cost(u,c);
   }
   continue;
  }
  u.date=null;u.week=null;
  if(!queues.has(u.module))queues.set(u.module,[]);queues.get(u.module).push(u);
 }
 for(const q of queues.values())q.sort(order);
 for(let w=week(start);w<end&&days(start,w)<=730;w=add(w,7)){
  const cap=Math.floor(weeklyCapacity(c,w,lectures,start,usedWeeks[w]||0)*(1-reserve));
  if((usedWeeks[w]||0)>cap)overbooked+=(usedWeeks[w]||0)-cap;
  let free=Math.max(0,cap-(usedWeeks[w]||0)),last='';
  while(free>0){
   const candidates=[];
   for(const [name,q] of queues){
    const u=q.find(u=>u.fällig&&cost(u,c)<=free&&slot(u,w))||q[0];if(!u||cost(u,c)>free)continue;
    const d=slot(u,w);if(!d)continue;
    const due=latest(u),remaining=q.reduce((s,x)=>s+cost(x,c),0);
    const urgent=due<=add(w,7)?1e9/Math.max(1,days(start,due)):0;
    const spread=1+(usedModules[w+'|'+name]||0)/Math.max(60,c.block*2);
    candidates.push({name,u,d,score:urgent+(priority.has(u.id)?1e8:0)+remaining/Math.max(1,days(w,due))*(name===c.focus?1.5:1)*(name===last?.85:1)/spread});
   }
   candidates.sort((a,b)=>b.score-a.score||a.u.deadline.localeCompare(b.u.deadline)||a.name.localeCompare(b.name));
   const chosen=candidates[0];if(!chosen)break;
   chosen.u.week=w;const n=cost(chosen.u,c);free-=n;usedWeeks[w]=(usedWeeks[w]||0)+n;usedDays[chosen.d]=(usedDays[chosen.d]||0)+n;
   usedModules[w+'|'+chosen.name]=(usedModules[w+'|'+chosen.name]||0)+n;
   if(!chosen.u.fällig)lastDay[chosen.name]=chosen.d;
   last=chosen.name;const q=queues.get(last);q.splice(q.indexOf(chosen.u),1);
  }
 }
 const missing=all.filter(u=>!u.week&&!done.get(u.id)).reduce((s,u)=>s+cost(u,c),0);
 const squeezed=all.filter(u=>!u.review&&!done.get(u.id)&&u.week&&add(u.week,6)>=add(u.deadline,-10)).length;
 return {units:all,missing,squeezed,overbooked,scheduledWeeklyMax:Math.max(0,...Object.values(usedWeeks))};
}
function createWeekly(c,catalog,examination,{old=null,status=()=>({done:false}),today=c.start,lectures=[],version='v1'}={}){
 c=config({...c,mode:'weekly'},today);const selected=examination.filter(e=>c.exams.includes(e.id)),end=selected.map(e=>e.date).sort().at(-1)||c.start;
 if(days(c.start,end)>730)throw new Error('Bitte einen Planzeitraum von höchstens zwei Jahren wählen.');
 const history=old?{...old,units:old.units.filter(u=>status(u).done)}:null;
 const built=units(c,catalog,selected,history,status,today);
 const options={status,today,lectures},reserved=scheduleWeeks(c,built.units,selected,{...options,strict:true});
 const relaxed=reserved.missing?scheduleWeeks(c,built.units,selected,options):reserved;
 const result=relaxed.missing<reserved.missing?relaxed:reserved,warnings=[];
 if(result.missing)warnings.push(`${result.missing} Minuten haben vor den Klausuren noch keine passende Woche. Dein Wochenbudget bleibt eingehalten; diese Einheiten bleiben sichtbar offen.`);
 if(result.squeezed)warnings.push(`${result.squeezed} Einheiten liegen in Wochen, die sich mit der vorgesehenen Wiederholungsphase überschneiden.`);
 if(result.overbooked)warnings.push('Erledigte Einheiten belegen in einer Woche mehr als das neue Budget. Ihre Historie bleibt erhalten.');
 return {id:version,mode:'weekly',number:(old?.number||0)+1,created:Date.now(),config:c,exams:selected,units:result.units,known:built.known,end,warnings,missing:result.missing,overbooked:result.overbooked,
  signature:signature(catalog,examination,c),lastWeek:week(today)};
}
function weeklyNeed(c,catalog,examination,options={}){
 const today=options.today||c.start;c=config({...c,mode:'weekly'},today);
 if(!examination.some(e=>c.exams.includes(e.id)))return {state:'empty'};
 const states=new Map(),status=u=>{if(!states.has(u.id))states.set(u.id,options.status?.(u)||{done:false});return states.get(u.id);};
 const cache=new Map(),run=weeklyMinutes=>{
  if(cache.has(weeklyMinutes))return cache.get(weeklyMinutes);
  const p=createWeekly({...c,weeklyMinutes},catalog,examination,{...options,today,status}),usage={};
  for(const u of p.units)if(u.week&&u.week>=week(today))usage[u.week]=(usage[u.week]||0)+cost(u,c);
  const result={fits:!p.missing&&!p.overbooked,missing:p.missing,squeezed:p.units.filter(u=>!u.review&&!status(u).done&&u.week&&add(u.week,6)>=add(u.deadline,-10)).length,scheduledWeeklyMax:Math.max(0,...Object.values(usage))};
  cache.set(weeklyMinutes,result);return result;
 };
 const current=run(c.weeklyMinutes),maximum=run(4200),base={current:c.weeklyMinutes,missing:current.missing,squeezed:current.squeezed};
 if(!maximum.fits)return {...base,state:'impossible'};
 const reviewReserved=!maximum.squeezed,works=r=>r.fits&&(!reviewReserved||!r.squeezed);let low=0,high=works(current)?c.weeklyMinutes:4200;
 while(low<high){const mid=Math.floor((low+high)/2);if(works(run(mid)))high=mid;else low=mid+1;}
 const target=run(high);return {...base,state:'ready',weekly:high,reviewReserved,scheduledWeeklyMax:target.scheduledWeeklyMax,reserveWeekly:Math.ceil(high*c.buffer)};
}
function carryWeekly(plan,today,status,weeks={},lectures=[]){
 const current=week(today),assigned=u=>Object.hasOwn(weeks,u.id)?weeks[u.id]:u.week!==undefined?u.week:u.date?week(u.date):null;
 const done=new Map(plan.units.map(u=>[u.id,!!status(u).done]));
 const late=u=>{const original=u.week||((u.originalDate||u.date)?week(u.originalDate||u.date):null);return !done.get(u.id)&&(assigned(u)?assigned(u)<current:original&&original<current);};
 if(!plan.units.some(late))return {};
 const floors=Object.fromEntries(plan.units.filter(u=>!done.get(u.id)).map(u=>[u.id,assigned(u)&&assigned(u)>current?assigned(u):current]));
 const original=new Map(plan.units.map(u=>[u.id,assigned(u)]));
 const priority=new Set(plan.units.filter(late).map(u=>u.id));
 const input=plan.units.map(u=>({...u,week:assigned(u)})),result=scheduleWeeks(plan.config,input,plan.exams,{today,status:u=>({done:done.get(u.id)}),lectures,floors,reserve:0,priority});
 return Object.fromEntries(result.units.filter(u=>!done.get(u.id)&&u.week!==original.get(u.id)).map(u=>[u.id,u.week]));
}
function fitsWeek(c,input,w,{today=c.start,status=()=>({done:false}),lectures=[]}={}){
 const examination=[...new Map(input.map(u=>[u.exam,{id:u.exam,date:u.deadline}])).values()];
 const result=scheduleWeeks(c,input,examination,{today,status,lectures,reserve:0,floors:Object.fromEntries(input.map(u=>[u.id,w]))});
 return !result.missing&&!result.overbooked&&result.units.every(u=>status(u).done||u.week===w);
}
function signature(catalog,examination,c){return hash(JSON.stringify({examination:examination.filter(e=>c.exams.includes(e.id)),
 catalog:catalog.map(m=>[m.name,m.typ,m.duration,m.sections.map(s=>[s.key,s.source,s.items.map(x=>[x.id,x.type,x.min])])])}));}
function weeklyBudget(c,catalog,examination,options={}){
 const today=options.today||c.start;c=config(c,today);
 if(c.mode==='weekly')return weeklyNeed(c,catalog,examination,options);
 if(!examination.some(e=>c.exams.includes(e.id)))return {state:'empty'};
 // Die eingegebenen Minuten geben nur das Verhältnis der Lerntage vor. Bei null Minuten
 // dient eine gleichmäßige Woche als Ausgangspunkt, ohne die Eingabefelder zu verändern.
 const weights=c.minutes.some(Boolean)?c.minutes:c.minutes.map(()=>1),active=weights.map((n,i)=>n?i:-1).filter(i=>i>=0);
 const distribute=total=>{
  const minutes=weights.map(()=>0);let left=total,open=[...active];
  while(open.length){
   const sum=open.reduce((s,i)=>s+weights[i],0),full=open.filter(i=>left*weights[i]/sum>=600);
   if(full.length){for(const i of full){minutes[i]=600;left-=600;}open=open.filter(i=>!full.includes(i));continue;}
   const shares=open.map(i=>({i,n:left*weights[i]/sum}));
   for(const {i,n} of shares)minutes[i]=Math.floor(n);
   const rest=total-minutes.reduce((s,n)=>s+n,0);
   shares.sort((a,b)=>(b.n-Math.floor(b.n))-(a.n-Math.floor(a.n))||a.i-b.i);
   for(const {i} of shares.slice(0,rest))minutes[i]++;
   break;
  }
  return minutes;
 };
 const states=new Map(),status=u=>{if(!states.has(u.id))states.set(u.id,options.status?.(u)||{done:false});return states.get(u.id);};
 const cache=new Map(),run=minutes=>{
  const key=minutes.join(',');if(cache.has(key))return cache.get(key);
  const plan=create({...c,minutes},catalog,examination,{...options,today,status}),usage={},weekly={};
  for(const u of plan.units)if(u.date&&u.date>=today){usage[u.date]=(usage[u.date]||0)+cost(u,c);weekly[week(u.date)]=(weekly[week(u.date)]||0)+cost(u,c);}
  const fits=!plan.missing&&Object.entries(usage).every(([d,n])=>n<=Math.floor(capacity(plan.config,d,options.lectures)*(1-c.buffer)));
  const squeezed=plan.units.filter(u=>!u.review&&u.date&&u.date>=today&&u.date>=add(u.deadline,-10)).length;
  const result={fits,missing:plan.missing,squeezed,scheduledWeeklyMax:Math.max(0,...Object.values(weekly))};cache.set(key,result);return result;
 };
 const current=run(c.minutes),maximum=run(weights.map(n=>n?600:0));
 const base={current:c.minutes.reduce((s,n)=>s+n,0),missing:current.missing,squeezed:current.squeezed,days:active.length,balanced:!c.minutes.some(Boolean)};
 if(!maximum.fits)return {...base,state:'impossible',missingAtMaximum:maximum.missing};
 // Die komplette Wiederholungsphase bleibt frei, sofern das mit diesen Lerntagen möglich ist.
 const reviewReserved=!maximum.squeezed,works=result=>result.fits&&(!reviewReserved||!result.squeezed);
 let low=0,high=600*active.length;
 if(works(current))high=base.current;
 while(low<high){const mid=Math.floor((low+high)/2);if(works(run(distribute(mid))))high=mid;else low=mid+1;}
 const minutes=distribute(high),check=run(minutes);
 return {...base,state:'ready',weekly:high,minutes,reviewReserved,squeezedAtTarget:check.squeezed,scheduledWeeklyMax:check.scheduledWeeklyMax,reserveWeekly:Math.ceil(high*c.buffer)};
}
function status(u,catalog,{manual=false,latch=false,activities=[]}={}){
 const m=catalog.find(m=>m.name===u.module),items=m?.sections.flatMap(s=>s.items)||[],targets=u.targets.map(id=>items.find(x=>x.type===u.type&&x.id===id)).filter(Boolean);
 if(latch)return {done:true,success:true,n:u.targets.length,total:u.targets.length,manual:false};
 if(u.type==='lesen')return {done:!!manual,success:false,manual:!!manual,n:manual?1:0,total:1};
 if(u.review){
  const kind=u.type==='karten'?'kartenrunde':u.type==='aufgaben'?'aufgabe':u.type==='probe'?'probe':'quiz';
    const after=activities.filter(a=>a.modul===u.module&&a.t>= (u.since||0)&&a.art===kind&&(!u.notBefore||a.tag>=u.notBefore));
  const complete=u.type==='probe'?after.some(a=>a.fertig&&(!u.date||a.tag>=u.date)):
   targets.length===0?true:targets.every(t=>after.some(a=>u.type==='aufgaben'?a.id===t.id&&a.status==='ok':a.fertig&&(a.ids||a.fragen?.map(f=>f.id)||[]).includes(t.id)));
  return {done:!!manual||complete,success:complete,manual:!!manual,n:complete?targets.length:0,total:Math.max(1,targets.length)};
 }
 const n=targets.filter(x=>x.ok).length,success=n===targets.length;
 const seen=targets.filter(x=>x.seen).length;
 return {done:success||!!manual,success,manual:!!manual,n,total:targets.length,worked:seen>0};
}
function carry(plan,today,status,dates={},lectures=[]){
 const assigned=u=>Object.hasOwn(dates,u.id)?dates[u.id]:u.date;
 const done=new Map(plan.units.map(u=>[u.id,!!status(u).done]));
 const late=u=>!done.get(u.id)&&(assigned(u)?assigned(u)<today:(u.originalDate||u.date||plan.config.start)<today);
 if(!plan.units.some(late))return {};
 const result={},usage={},queues=new Map(),indices=new Map(plan.units.map((u,i)=>[u.id,i]));
 const typeOrder={lesen:0,aufgaben:1,quiz:2,karten:3,probe:4};
 const section=u=>(u.section||'').match(/:(\d+):(\d+)$/)?.slice(1).map(Number);
 // Abschnittsfolge auch nach älteren Puffer-Verschiebungen erhalten.
 const order=(a,b)=>{
  if(!!a.review!==!!b.review)return a.review?1:-1;
  if(a.review)return (assigned(a)||a.notBefore||today).localeCompare(assigned(b)||b.notBefore||today)||indices.get(a.id)-indices.get(b.id);
  const x=section(a),y=section(b);
  if(x&&y&&(x[0]!==y[0]||x[1]!==y[1]))return x[0]-y[0]||x[1]-y[1];
  if(a.section===b.section)return (typeOrder[a.type]??9)-(typeOrder[b.type]??9)||indices.get(a.id)-indices.get(b.id);
  return indices.get(a.id)-indices.get(b.id);
 };
 for(const u of plan.units){
  const d=assigned(u);
  if(done.get(u.id)){if(d&&d>=today)usage[d]=(usage[d]||0)+cost(u,plan.config);continue;}
  if(!queues.has(u.module))queues.set(u.module,[]);
  queues.get(u.module).push(u);result[u.id]=null;
 }
 for(const q of queues.values())q.sort(order);
 const end=plan.units.map(u=>u.deadline).filter(Boolean).sort().at(-1)||today;
 for(let d=today;d<end&&days(today,d)<=730;d=add(d,1)){
  let free=Math.max(0,capacity(plan.config,d,lectures)-(usage[d]||0)),last='';
  while(free>0){
   const candidates=[];
   for(const [name,q] of queues){
    // Abgelaufene / zu große Ziele bleiben sichtbar offen und sperren ihren späteren Stoff.
    const floor=u=>[today,u.notBefore||today,assigned(u)&&assigned(u)>=today&&(u.originalDate||u.date||assigned(u))>=today?assigned(u):today].sort().at(-1);
    const u=q.find(u=>u.fällig&&u.deadline>d&&floor(u)<=d&&cost(u,plan.config)<=free)||q[0];
    if(!u||u.deadline<=d||cost(u,plan.config)>free)continue;
    const earliest=floor(u);
    if(earliest>d)continue;
    const remaining=q.reduce((s,u)=>s+cost(u,plan.config),0);
    const score=remaining/Math.max(1,days(d,u.deadline))*(late(u)?2:1)*(name===last?.7:1);
    candidates.push({name,u,score});
   }
   candidates.sort((a,b)=>b.score-a.score||a.u.deadline.localeCompare(b.u.deadline)||a.name.localeCompare(b.name));
   const chosen=candidates[0];if(!chosen)break;
   result[chosen.u.id]=d;free-=cost(chosen.u,plan.config);last=chosen.name;
   const q=queues.get(last);q.splice(q.indexOf(chosen.u),1);
  }
 }
 return Object.fromEntries(Object.entries(result).filter(([id,d])=>d!==assigned(plan.units[indices.get(id)])));
}
root.Lernplan={add,days,weekday,week,kw,hash,config,exams,capacity,cost,create,status,signature,weeklyBudget,carry,weeklyCapacity,windowFor,carryWeekly,fitsWeek};
if(typeof module!=='undefined')module.exports=root.Lernplan;
})(typeof globalThis!=='undefined'?globalThis:this);

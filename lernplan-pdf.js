/* Lokale, durchsuchbare A4-PDF mit eingebetteter Schrift und klickbaren Aufgaben-/Quellenverweisen. */
(function(root){
let loading;
const load=()=>loading||(loading=(async()=>{
 for(const [name,url] of [['PDFLib','vendor/pdf-lib-1.17.1.min.js'],['fontkit','vendor/fontkit-1.1.1.min.js']])if(!root[name])await new Promise((ok,no)=>{const s=document.createElement('script');s.src=url;s.onload=ok;s.onerror=()=>no(Error('PDF-Bibliothek konnte nicht geladen werden.'));document.head.appendChild(s);});
 const r=await fetch('vendor/NotoSans-Regular.ttf');if(!r.ok)throw Error('Die PDF-Schrift konnte nicht geladen werden.');return new Uint8Array(await r.arrayBuffer());
})().catch(e=>{loading=null;throw e;}));
async function create({plan,catalog,week='',status,date,base,lectures=[]}){
 const fontBytes=await load(),{PDFDocument,rgb,PDFString}=root.PDFLib,doc=await PDFDocument.create();
 doc.registerFontkit(root.fontkit);const font=await doc.embedFont(fontBytes,{subset:true});
 const stamp=new Date().toLocaleString('de-DE',{timeZone:'Europe/Berlin',dateStyle:'medium',timeStyle:'short'});
 doc.setTitle('Dein Lernplan'+(week?' - KW '+Lernplan.kw(week):''));doc.setLanguage('de-DE');doc.setCreator('Meine Lernplattform');
 const ink=rgb(.12,.16,.17),teal=rgb(.1,.4,.38),muted=rgb(.39,.43,.44),line=rgb(.84,.85,.83),paper=rgb(.96,.95,.92);
 let page,y,section='',dayTitle='';const W=595.28,H=841.89,left=42,right=W-42,width=right-left;
 const clean=s=>String(s??'').replace(/<[^>]*>/g,'').replace(/&amp;/g,'&').replace(/&nbsp;/g,' ').replace(/[\u2010-\u2015]/g,'-').replace(/[\r\n]+/g,' ');
 const text=(s,x,yy,size=10,color=ink)=>page.drawText(clean(s),{x,y:yy,size,font,color});
 const wrap=(s,size=10,max=width)=>{
  const lines=[];let current='';for(const word of clean(s).split(/\s+/)){
   if(font.widthOfTextAtSize(word,size)>max){if(current)lines.push(current);current='';let part='';for(const char of word){if(font.widthOfTextAtSize(part+char,size)>max){lines.push(part);part='';}part+=char;}current=part;continue;}
   if(current&&font.widthOfTextAtSize(current+' '+word,size)>max){lines.push(current);current=word;}else current+=(current?' ':'')+word;
  }if(current)lines.push(current);return lines;
 };
 function newPage(title){page=doc.addPage([W,H]);text('DEIN LERNPLAN',left,H-40,9,teal);let yy=H-68;for(const l of wrap(title,17)){text(l,left,yy,17);yy-=23;}text('Planversion '+(plan.number||1)+' · Stand '+stamp,left,yy-1,8,muted);page.drawLine({start:{x:left,y:yy-13},end:{x:right,y:yy-13},thickness:.7,color:line});y=yy-35;}
 function need(h,repeat=true){if(y-h<56){newPage(section+' · Fortsetzung');if(dayTitle&&repeat){text(dayTitle+' · Fortsetzung',left,y,11,teal);y-=26;}}}
 function para(s,size=10,color=ink){for(const l of wrap(s,size)){need(size+5);text(l,left,y,size,color);y-=size+5;}y-=6;}
 function link(url,x,yy,w,h=14){const ref=doc.context.register(doc.context.obj({Type:'Annot',Subtype:'Link',Rect:[x,yy-3,x+w,yy+h-3],Border:[0,0,0],A:{Type:'Action',S:'URI',URI:PDFString.of(url)}}));page.node.addAnnot(ref);}
 const dformat=d=>new Date(d+'T12:00:00Z').toLocaleDateString('de-DE',{timeZone:'Europe/Berlin',weekday:'short',day:'2-digit',month:'2-digit',year:'numeric'});
 const check=(x,yy,done)=>{page.drawRectangle({x,y:yy-1,width:11,height:11,borderColor:done?teal:muted,borderWidth:.8});if(done){page.drawLine({start:{x:x+2,y:yy+4},end:{x:x+4.5,y:yy+1.5},thickness:1.5,color:teal});page.drawLine({start:{x:x+4.5,y:yy+1.5},end:{x:x+9,y:yy+8},thickness:1.5,color:teal});}};
 if(!week){
  section='Klausuren und Kapitel';newPage(section);
  para('Dein gemeinsamer Plan bis '+dformat(plan.end)+'. Kästchen zeigen den Fortschritt beim Erstellen dieser PDF. Neue Haken erscheinen in einer neu erzeugten Fassung.');
  para('Kapitelabschluss: alle Aufgaben selbst gelöst, Quizfragen richtig und Karten gelernt. Manuelle Haken ersetzen keinen fachlichen Abschluss.',9,muted);
  for(const e of plan.exams){need(42);text(dformat(e.date),left,y,11,teal);y-=17;para(e.title+' · '+e.modules.join(' + '),10);}
  for(const w of plan.warnings)para(w,9,teal);
  for(const m of catalog.filter(m=>plan.exams.some(e=>e.modules.includes(m.name)))){
   need(45);y-=8;text(m.name,left,y,13,teal);y-=24;const chapters=new Map();
   for(const s of m.sections){const key=s.label.replace(/Abschnitt (\d+)\.\d+/,'Kapitel $1');if(!chapters.has(key))chapters.set(key,[]);chapters.get(key).push(s);}
   for(const [name,ss] of chapters){need(25);const n=ss.filter(s=>s.complete).length;check(left,y,n===ss.length);text(name+' · '+n+'/'+ss.length+' Abschnitte abgeschlossen',left+20,y,10);y-=25;}
  }
 }
 const allWeeks=week?[week]:[...new Set(plan.units.map(u=>date(u)).filter(Boolean).map(Lernplan.week))].sort();
 for(const w of allWeeks){dayTitle='';section='KW '+Lernplan.kw(w)+' · '+dformat(w)+' bis '+dformat(Lernplan.add(w,6));newPage(section);
  para('Die Grundplanung enthält 20 % Puffer. Beim Nachholen wird dieser Puffer bei Bedarf genutzt.',9,muted);
  for(let i=0;i<7;i++){
   const d=Lernplan.add(w,i),us=plan.units.filter(u=>date(u)===d),cap=Lernplan.capacity(plan.config,d,lectures),min=us.reduce((s,u)=>s+Lernplan.cost(u,plan.config),0);
   dayTitle=dformat(d);need(68,false);page.drawRectangle({x:left,y:y-10,width,height:27,color:paper});text(dformat(d),left+8,y,11,teal);y-=29;
   text(min+' / '+cap+' Min. verplant · '+Math.max(0,cap-min)+' Min. frei / Puffer',left,y,8.5,muted);y-=22;
   if(!us.length){text('Keine Einheit geplant.',left+20,y,10,muted);y-=27;continue;}
   for(const u of us){const source=catalog.find(m=>m.name===u.module)?.sections.find(s=>s.key===u.section)?.source,currentPdf=catalog.find(m=>m.name===u.module)?.pdf;const st=status(u),heading=wrap(u.module+' · '+u.label+' · '+u.min+' Min.'+(u.min>=20?' + '+plan.config.pause+' Min. Pause':''),10,width-26);
    const body=wrap(u.title,9,width-26),state=st.success?'Erfolgreich abgeschlossen':st.manual?'Manuell erledigt':st.worked?'Bearbeitet, noch offen':'Offen';
    const height=(heading.length+body.length)*14+38+(source?16:0);need(height);
    check(left,y,st.done);for(const l of heading){text(l,left+22,y,10,teal);y-=14;}for(const l of body){text(l,left+22,y,9);y-=14;}
    text(state+(st.total>1?' · '+st.n+'/'+st.total+' Ziele':''),left+22,y,8,muted);y-=15;
    const startUrl=base+'#termine/lernplan/start/'+u.id+'/'+encodeURIComponent(u.module);
    text('In der Plattform starten',left+22,y,8,teal);link(startUrl,left+22,y,120,10);
    if(source){const label='Lernskript S. '+source.p+' · '+source.t;const ls=wrap(label,8,width-175);
     text(ls[0],left+160,y,8,teal);link(new URL(currentPdf,base).href+'#page='+source.p,left+160,y,Math.min(330,font.widthOfTextAtSize(ls[0],8)),10);}
    y-=23;
   }
   need(20);page.drawLine({start:{x:left+22,y:y},end:{x:right,y:y},color:line,thickness:.5});y-=24;
  }
 }
 const pending=plan.units.filter(u=>!date(u)&&!status(u).done);
 if(pending.length&&!week){dayTitle='';section='Noch ohne Termin';newPage(section);para('Diese Einheiten passen noch nicht ins Zeitbudget. Sie sind nicht ausgelassen; passe das Budget an und prüfe die Neuplanung.',10,teal);
  for(const u of pending)para(u.module+' · '+u.label+' · '+u.title+' · '+u.min+' Min.',9);
 }
 if(!doc.getPageCount())newPage('Keine Einheiten in dieser Woche');
 const pages=doc.getPages();for(let i=0;i<pages.length;i++){page=pages[i];text('Stand '+stamp+' · Version '+(plan.number||1),left,28,7.5,muted);text((i+1)+' / '+pages.length,right-45,28,8,muted);}
 return doc.save();
}
root.LernplanPDF={create};
})(typeof globalThis!=='undefined'?globalThis:this);

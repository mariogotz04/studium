/* Wochen-PDF zum handschriftlichen Lösen (seit 11.11.2026): A4, je Aufgabe die Aufgabenstellung aus der
   Typst-Datei des Moduls (build.py setzt sie als „<Modul>_Blatt.pdf“, eine Seite je Aufgabe) und darunter
   ein karierter Schreibbereich. Läuft vollständig im Browser (pdf-lib), auch in der iPad-App. */
(function(root){
let loading;
const load=()=>loading||(loading=(async()=>{
 for(const [name,url] of [['PDFLib','vendor/pdf-lib-1.17.1.min.js'],['fontkit','vendor/fontkit-1.1.1.min.js']])if(!root[name])await new Promise((ok,no)=>{const s=document.createElement('script');s.src=url;s.onload=ok;s.onerror=()=>no(Error('PDF-Bibliothek konnte nicht geladen werden.'));document.head.appendChild(s);});
 const r=await fetch('vendor/NotoSans-Regular.ttf');if(!r.ok)throw Error('Die PDF-Schrift konnte nicht geladen werden.');return new Uint8Array(await r.arrayBuffer());
})().catch(e=>{loading=null;throw e;}));
const CM=28.3465;
// Schreibraum in cm: ausdrücklich gesetzt (platz:), sonst nach Art, Zeitansatz und Lösungsschritten.
function writingSpace(a){
 if(a.platz>0)return a.platz;
 if(a.art!=='rechnen')return Math.min(10,Math.max(5,3+a.schritte*1.5));
 return Math.min(24,Math.max(10,4+a.schritte*2.2,a.min*.7));
}
async function wochenblatt({week,kw,aufgaben,base}){
 const fontBytes=await load(),{PDFDocument,rgb,PDFString}=root.PDFLib,doc=await PDFDocument.create();
 doc.registerFontkit(root.fontkit);const font=await doc.embedFont(fontBytes,{subset:true});
 const fmt=d=>new Date(d+'T12:00:00Z').toLocaleDateString('de-DE',{timeZone:'Europe/Berlin',day:'2-digit',month:'2-digit',year:'numeric'});
 const sunday=new Date(Date.parse(week+'T12:00:00Z')+6*864e5).toISOString().slice(0,10);
 const title='Aufgaben KW '+kw;doc.setTitle(title+' ('+fmt(week)+' bis '+fmt(sunday)+')');doc.setLanguage('de-DE');doc.setCreator('Meine Lernplattform');
 const ink=rgb(.12,.16,.17),teal=rgb(.12,.44,.41),muted=rgb(.42,.45,.46),grid=rgb(.82,.86,.88),gridStrong=rgb(.72,.77,.79);
 const W=595.28,H=841.89,left=48.2,right=W-48.2,width=right-left,top=H-44,bottom=48;
 let page,y;
 const clean=s=>String(s??'').replace(/<[^>]*>/g,'').replace(/[‐-―]/g,'-').replace(/[\r\n]+/g,' ');
 const text=(s,x,yy,size=10,color=ink)=>page.drawText(clean(s),{x,y:yy,size,font,color});
 const fit=(s,size,max)=>{s=clean(s);if(font.widthOfTextAtSize(s,size)<=max)return s;while(s.length>3&&font.widthOfTextAtSize(s+'…',size)>max)s=s.slice(0,-1);return s+'…';};
 const wrap=(s,size,max)=>{const out=[];let cur='';for(const w of clean(s).split(/\s+/)){if(cur&&font.widthOfTextAtSize(cur+' '+w,size)>max){out.push(cur);cur=w;}else cur+=(cur?' ':'')+w;}if(cur)out.push(cur);return out;};
 const link=(url,x,yy,w,h=11)=>{const ref=doc.context.register(doc.context.obj({Type:'Annot',Subtype:'Link',Rect:[x,yy-3,x+w,yy+h-3],Border:[0,0,0],A:{Type:'Action',S:'URI',URI:PDFString.of(url)}}));page.node.addAnnot(ref);};
 const newPage=()=>{page=doc.addPage([W,H]);y=top;};
 const box=(x,yy,done)=>{page.drawRectangle({x,y:yy-1.5,width:9,height:9,borderColor:done?teal:muted,borderWidth:.7});if(done){page.drawLine({start:{x:x+1.8,y:yy+3},end:{x:x+3.8,y:yy+1},thickness:1.2,color:teal});page.drawLine({start:{x:x+3.8,y:yy+1},end:{x:x+7.5,y:yy+6.5},thickness:1.2,color:teal});}};
 // Kariertes Feld (5 mm), jede zweite Linie etwas kräftiger nicht nötig: ruhig und gleichmäßig.
 const gridArea=(y0,h)=>{const step=CM/2,rows=Math.floor(h/step),hh=rows*step;if(rows<1)return 0;
  page.drawRectangle({x:left,y:y0-hh,width,height:hh,borderColor:gridStrong,borderWidth:.6});
  for(let i=1;i<rows;i++)page.drawLine({start:{x:left,y:y0-i*step},end:{x:right,y:y0-i*step},thickness:.35,color:grid});
  const cols=Math.floor(width/step);for(let j=1;j<=cols;j++){const x=left+j*step;if(x<right-.5)page.drawLine({start:{x,y:y0},end:{x,y:y0-hh},thickness:.35,color:grid});}
  return hh;};
 // Aufgabenstellungen aus den Blatt-PDFs der Module übernehmen (Vektorgrafik, Formeln wie im Skript).
 const sources=new Map();
 for(const a of aufgaben){if(!a.blatt)throw Error('Für '+a.modul+' fehlen die Aufgabenblätter. Bitte die Seite neu laden.');if(!sources.has(a.blatt))sources.set(a.blatt,[]);sources.get(a.blatt).push(a);}
 const embedded=new Map();
 for(const [file,list] of sources){
  const r=await fetch(new URL(file,base).href);if(!r.ok)throw Error('Aufgabenblätter von '+list[0].modul+' konnten nicht geladen werden.');
  const src=await PDFDocument.load(await r.arrayBuffer()),n=src.getPageCount(),idx=[...new Set(list.map(a=>a.seite))].filter(i=>i<n);
  const pages=await doc.embedPdf(src,idx);idx.forEach((i,k)=>embedded.set(file+'#'+i,pages[k]));
 }
 // Deckblatt: Übersicht mit Kästchen
 newPage();text('AUFGABEN ZUM SELBSTLÖSEN',left,y,9,teal);y-=24;text(title,left,y,22);y-=20;text(fmt(week)+' bis '+fmt(sunday)+' · '+aufgaben.length+' Aufgaben · ca. '+duration(aufgaben.reduce((s,a)=>s+a.min,0)),left,y,10,muted);y-=16;
 for(const l of wrap('Erst selbst lösen, dann in der Plattform die Lösung Schritt für Schritt aufdecken und dich ehrlich bewerten. „Selbst gelöst“ hakt die Aufgabe im Wochenplan ab. Original = Aufgabe deines Professors; „Von Claude erstellt“ = Übungsaufgabe nach einer Vorlage oder zur Ergänzung.',9,width)){text(l,left,y,9,muted);y-=13;}
 y-=10;
 const mods=[...new Set(aufgaben.map(a=>a.modul))];
 for(const m of mods){
  if(y<bottom+40)newPage();text(m,left,y,13,teal);y-=18;
  for(const a of aufgaben.filter(a=>a.modul===m)){if(y<bottom+16)newPage();box(left,y,a.erledigt);text(fit('Aufgabe '+a.nr+' · '+a.titel,10,width-90),left+16,y,10);const t=duration(a.min);text(t,right-font.widthOfTextAtSize(t,9),y,9,muted);y-=15;}
  y-=8;
 }
 newPage();
 // Aufgaben: Kopfzeile, Aufgabenstellung, Schreibraum. Eine Aufgabe beginnt nie unten auf einer fast vollen Seite.
 const head=18+15,minGrid=4*CM;
 for(const a of aufgaben){
  const emb=embedded.get(a.blatt+'#'+a.seite);if(!emb)continue;
  let scale=Math.min(1,width/emb.width),sh=emb.height*scale;
  const full=top-bottom;if(head+sh+minGrid>full){scale*= (full-head-minGrid)/(head+sh);sh=emb.height*scale;}
  const want=writingSpace(a)*CM;
  if(y-(head+sh+Math.min(want,minGrid*1.5))<bottom)newPage();
  // Kopfzeile
  const meta=[a.modul,a.art==='rechnen'?'Rechenaufgabe':'Verständnisfrage',a.abschnitt,a.herkunft].filter(Boolean).join(' · ');
  text(fit(meta,8,width-95),left,y,8,a.original?teal:muted);const l='Lösung ansehen ›';const lw=font.widthOfTextAtSize(l,8);text(l,right-lw,y,8,teal);link(a.link,right-lw,y,lw);y-=16;
  box(left,y,a.erledigt);text(fit('Aufgabe '+a.nr+' · '+a.titel,12,width-20),left+16,y-1,12);y-=15;
  page.drawPage(emb,{x:left,y:y-sh,width:emb.width*scale,height:sh});y-=sh+8;
  // Schreibraum, bei Bedarf auf der nächsten Seite fortgesetzt
  let rest=want;
  while(rest>CM){
   const avail=y-bottom;
   if(avail<2*CM){newPage();text(fit('Aufgabe '+a.nr+' · Fortsetzung',8,width),left,y,8,muted);y-=12;continue;}
   if(rest>avail&&rest-avail<4*CM)rest=avail;   // kleiner Rest: lieber etwas weniger Platz als eine Mini-Fortsetzung
   const h=gridArea(y,Math.min(rest,avail));y-=h+18;rest-=h;
   if(rest>CM){newPage();text(fit('Aufgabe '+a.nr+' · '+a.titel+' · Fortsetzung',8,width),left,y,8,muted);y-=12;}
  }
  y-=6;
 }
 const pages=doc.getPages();for(let i=0;i<pages.length;i++){page=pages[i];text(title+' · '+fmt(week)+' bis '+fmt(sunday),left,26,7.5,muted);const p=(i+1)+' / '+pages.length;text(p,right-font.widthOfTextAtSize(p,8),26,8,muted);}
 return doc.save();
}
function duration(n){n=Math.max(0,Math.round(n||0));const h=Math.floor(n/60),r=n%60;return h?`${h} Std.${r?' '+r+' Min.':''}`:`${r} Min.`;}
root.LernplanPDF={wochenblatt,writingSpace};
})(typeof globalThis!=='undefined'?globalThis:this);

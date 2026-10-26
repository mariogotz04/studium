// Kopf des Feynman-Lernskripts (Layout + Bausteine). Bilder liegen in abbildungen/. Keine Pakete erforderlich.
#set document(title: "Technische Mechanik – Feynman-Lernskript", author: "Lernzusammenfassung")
#let navy = rgb("244f70")
#let teal = rgb("16746d")
#let ink = rgb("24323d")
#let muted = rgb("627380")
#let pale = rgb("eef4f8")
#let mint = rgb("eef7f2")
#let sand = rgb("fff6e5")
#let vartheta = sym.theta.alt
#let seitenfuss = context [
  #line(length: 100%, stroke: 0.45pt + rgb("d7e1e8"))
  #v(1.5mm)
  #text(size: 8pt, fill: muted)[Feynman-Lernskript · Stand 26.10.2026]
  #h(1fr)
  #text(size: 9pt, fill: navy)[Seite #counter(page).display("1") von #counter(page).final().first()]
]
#set page(paper: "a4", margin: (left: 20mm, right: 19mm, top: 19mm, bottom: 20mm),
 header: [#text(size: 8pt, fill: muted)[Technische Mechanik #h(1fr) Sehen · Verstehen · Erklären]], footer: seitenfuss)
#set text(font: "Libertinus Serif", size: 11pt, lang: "de", fill: ink, hyphenate: true)
#set par(justify: false, leading: 0.5em, spacing: 0.55em)
#set heading(numbering: none)
#set list(indent: 1.1em, body-indent: 0.5em, spacing: 0.35em)
#set enum(indent: 1.25em, body-indent: 0.5em, spacing: 0.55em)
#set math.equation(numbering: none)
#show heading.where(level: 1): it => block(above: 0.5em, below: 0.8em, sticky: true)[
 #text(size: 24pt, weight: "bold", fill: navy, it.body)
 #v(1.5mm) #line(length: 100%, stroke: 1pt + navy)
]
#show heading.where(level: 2): it => block(above: 1em, below: 0.6em, sticky: true)[
 #text(size: 15pt, weight: "bold", fill: navy, it.body)
]
#show heading.where(level: 3): it => block(above: 0.7em, below: 0.35em, sticky: true)[
 #text(size: 11.5pt, weight: "bold", fill: teal, it.body)
]
#show math.equation.where(block: true): it => block(above: 0.45em, below: 0.45em, breakable: false)[#it]
#let note(title, body, fill: mint) = block(width: 100%, fill: fill, inset: (x: 9pt, y: 7pt),
 above: 0.5em, below: 0.5em, breakable: false)[#text(fill: teal, weight: "bold", title) #parbreak() #body]
#let src(body) = block(above: 0.35em, below: 0.4em)[#text(size: 8pt, fill: muted)[*Grundlage:* #body]]
#let nachschlagen(body) = block(above: 0.25em, below: 0.3em, breakable: false)[#text(size: 8.5pt, fill: teal)[*Nachschlagen:* #body]]
// Verweis auf eine Stelle in DIESEM Lernskript mit automatischer Seitenzahl (für neue Lösungen).
// Überschrift mit Label versehen, z. B. === 2.12 Neues Thema <a-2-12>, dann #nachschlagen[Lernskript, #stelle(<a-2-12>)]
#let stelle(ziel) = context {
  let el = query(ziel).first()
  link(ziel)[Abschnitt #el.body, S. #counter(page).at(el.location()).first()]
}
#let form(body) = block(width: 100%, fill: pale, inset: (x: 7pt, y: 5pt), above: 0.5em, below: 0.5em, breakable: false)[#body]
#let tab(..args) = {
 set text(size: 9.6pt)
 set par(leading: 0.4em, spacing: 0.25em, justify: false)
 table(inset: 6pt, stroke: 0.35pt + rgb("cfdae2"), ..args)
}
#let th(..cells) = table.header(..cells.pos().map(c => table.cell(fill: pale)[#strong(c)]))

// ─── Überblick-Ebenen und Chunkmaps (in allen Modulen gleich) ─────────────────
// Ebene 0: Seite „Das Modul auf einen Blick“ nach dem Wegweiser (Label <ueberblick>).
// Ebene 1: unter jeder Kapitelüberschrift (Label <a-n>) #überblick mit #idee-Links und eine #karte oder ein #ablauf.
// Ebene 2: die Abschnitte; am Ende jedes Abschnitts #hoch(<a-n>, [Kapitelübersicht]).
// Die Kästen sind keine Überschriften: Inhaltsverzeichnis und PDF-Lesezeichen bleiben unverändert.
#let chunk(titel, begriffe, ziel: none, fill: pale, stroke: navy) = {
  let kasten = block(width: 100%, fill: fill, stroke: 0.6pt + stroke, radius: 4pt, inset: (x: 6pt, y: 5pt), breakable: false)[
    #set par(leading: 0.35em, spacing: 0.35em, justify: false)
    #set text(hyphenate: true)
    #text(size: 9pt, weight: "bold", fill: navy, titel)
    #if begriffe != none [#parbreak() #text(size: 7.8pt, fill: muted, begriffe)]
  ]
  if ziel == none { kasten } else { link(ziel, kasten) }
}
#let pfeil(beschriftung: none, zeichen: sym.arrow.r) = align(center + horizon, stack(dir: ttb, spacing: 2pt,
  ..(if beschriftung != none { (text(size: 6.8pt, fill: teal, beschriftung),) } else { () }),
  text(size: 13pt, fill: teal, zeichen)))
// Chunkmap als Raster: #karte((1fr, auto, 1fr), chunk(..), pfeil(..), chunk(..))
#let karte(spalten, ..zellen) = block(width: 100%, breakable: false, above: 0.7em, below: 0.7em,
  grid(columns: spalten, column-gutter: 3pt, row-gutter: 7pt, align: center + horizon, ..zellen))
// Flussdiagramm von oben nach unten: #ablauf(chunk(..), entscheidung(..), chunk(..))
#let ablauf(breite: 80%, ..schritte) = block(width: 100%, breakable: false, above: 0.7em, below: 0.7em, align(center,
  stack(dir: ttb, spacing: 2pt, ..schritte.pos().enumerate().map(((i, x)) =>
    (if i > 0 { (text(size: 12pt, fill: teal, sym.arrow.b),) } else { () }) + (block(width: breite, x),)).flatten())))
#let entscheidung(frage, ja, nein) = stack(dir: ttb, spacing: 3pt,
  chunk(frage, none, fill: sand, stroke: teal),
  grid(columns: (1fr, 1fr), column-gutter: 8pt,
    [#align(center, text(size: 8pt, fill: teal)[#sym.arrow.b *ja*]) #ja],
    [#align(center, text(size: 8pt, fill: teal)[#sym.arrow.b *nein*]) #nein]))
#let idee(ziel, kern, satz) = [#link(ziel)[#text(fill: teal, weight: "bold", kern)] #satz]
#let überblick(titel, ..ideen) = block(width: 100%, fill: pale, inset: (x: 9pt, y: 7pt), above: 0.6em, below: 0.6em, breakable: false)[
  #text(fill: navy, weight: "bold", titel)
  #set list(marker: text(fill: teal, sym.arrow.r), spacing: 0.45em)
  #list(..ideen.pos())
]
#let hoch(ziel, wort) = block(above: 0.4em, below: 0.4em, align(right, text(size: 8.5pt, fill: teal, link(ziel)[#sym.arrow.t #wort])))

#let abbildungen = (
  "map-klausur-torsion": "abbildungen/map-klausur-torsion.svg",
  "map-klausur-dms": "abbildungen/map-klausur-dms.svg",
  "map-klausur-stab": "abbildungen/map-klausur-stab.svg",
  "map-klausur-haftung": "abbildungen/map-klausur-haftung.svg",
  "map-klausur-schnitt": "abbildungen/map-klausur-schnitt.svg",
  "map-klausur-fachwerk": "abbildungen/map-klausur-fachwerk.svg",
  "map-klausur-lager": "abbildungen/map-klausur-lager.svg",
  "map-klausur-schwerpunkt": "abbildungen/map-klausur-schwerpunkt.svg",
  "map-klausur-tm2": "abbildungen/map-klausur-tm2.svg",
  "map-klausur-tm1": "abbildungen/map-klausur-tm1.svg",
  "ak24-waerme": "abbildungen/ak24-waerme.svg",
  "ak24-querschnitt": "abbildungen/ak24-querschnitt.svg",
  "ak24-fachwerk-schnitt": "abbildungen/ak24-fachwerk-schnitt.svg",
  "ak24-system": "abbildungen/ak24-system.svg",
  "ak_2018_dreifeld": "abbildungen/ak_2018_dreifeld.svg",
  "ak_2018_fachwerk": "abbildungen/ak_2018_fachwerk.svg",
  "ak_2018_ftm": "abbildungen/ak_2018_ftm.svg",
  "ak_2018_ftm_tab": "abbildungen/ak_2018_ftm_tab.svg",
  "ak_2018_ix": "abbildungen/ak_2018_ix.svg",
  "ak_2018_rahmen": "abbildungen/ak_2018_rahmen.svg",
  "ak_2018_torsion": "abbildungen/ak_2018_torsion.svg",
  "ak_p13_zweifeld": "abbildungen/ak_p13_zweifeld.svg",
  "ak_p25_profil": "abbildungen/ak_p25_profil.svg",
  "ak_ss16_fachwerk": "abbildungen/ak_ss16_fachwerk.svg",
  "ak_ss16_ftm": "abbildungen/ak_ss16_ftm.svg",
  "ak_ss16_klotz": "abbildungen/ak_ss16_klotz.svg",
  "ak_ss16_rahmen": "abbildungen/ak_ss16_rahmen.svg",
  "ak_stab_ax": "abbildungen/ak_stab_ax.svg",
  "ak_u_profile": "abbildungen/ak_u_profile.svg",
  "ak_unb_balken": "abbildungen/ak_unb_balken.svg",
  "ak_unb_ftm": "abbildungen/ak_unb_ftm.svg",
  "ak_unb_torsion": "abbildungen/ak_unb_torsion.svg",
  "cover": "abbildungen/cover.svg",
  "map-t1k0": "abbildungen/map-t1k0.svg",
  "map-t1k1a": "abbildungen/map-t1k1a.svg",
  "map-t1k1b": "abbildungen/map-t1k1b.svg",
  "map-t1k1c": "abbildungen/map-t1k1c.svg",
  "map-t1k2a": "abbildungen/map-t1k2a.svg",
  "map-t1k2b": "abbildungen/map-t1k2b.svg",
  "map-t1k3a": "abbildungen/map-t1k3a.svg",
  "map-t1k3b": "abbildungen/map-t1k3b.svg",
  "map-t1k4a": "abbildungen/map-t1k4a.svg",
  "map-t1k4b": "abbildungen/map-t1k4b.svg",
  "map-t1k5a": "abbildungen/map-t1k5a.svg",
  "map-t1k5b": "abbildungen/map-t1k5b.svg",
  "map-t1k6a": "abbildungen/map-t1k6a.svg",
  "map-t1k6b": "abbildungen/map-t1k6b.svg",
  "map-t1k7a": "abbildungen/map-t1k7a.svg",
  "map-t1k7b": "abbildungen/map-t1k7b.svg",
  "map-t1k9": "abbildungen/map-t1k9.svg",
  "map-t2k0": "abbildungen/map-t2k0.svg",
  "map-t2k1": "abbildungen/map-t2k1.svg",
  "map-t2k2": "abbildungen/map-t2k2.svg",
  "map-t2k3": "abbildungen/map-t2k3.svg",
  "map-t2k4": "abbildungen/map-t2k4.svg",
  "map-t2k5": "abbildungen/map-t2k5.svg",
  "tm1k01_aeussere": "abbildungen/tm1k01_aeussere.svg",
  "tm1k01_aufgabe": "abbildungen/tm1k01_aufgabe.svg",
  "tm1k01_bsp1": "abbildungen/tm1k01_bsp1.svg",
  "tm1k01_bsp1_mitschrift": "abbildungen/tm1k01_bsp1_mitschrift.svg",
  "tm1k01_bsp2": "abbildungen/tm1k01_bsp2.svg",
  "tm1k01_bsp2_mitschrift": "abbildungen/tm1k01_bsp2_mitschrift.svg",
  "tm1k01_bsp3": "abbildungen/tm1k01_bsp3.svg",
  "tm1k01_darstellung": "abbildungen/tm1k01_darstellung.svg",
  "tm1k01_eigenschaften": "abbildungen/tm1k01_eigenschaften.svg",
  "tm1k01_einheiten": "abbildungen/tm1k01_einheiten.svg",
  "tm1k01_einteilung": "abbildungen/tm1k01_einteilung.svg",
  "tm1k01_falle": "abbildungen/tm1k01_falle.svg",
  "tm1k01_gerber_frei": "abbildungen/tm1k01_gerber_frei.svg",
  "tm1k01_herkunft": "abbildungen/tm1k01_herkunft.svg",
  "tm1k01_innere": "abbildungen/tm1k01_innere.svg",
  "tm1k01_kreuz_komp": "abbildungen/tm1k01_kreuz_komp.svg",
  "tm1k01_kreuz_moment": "abbildungen/tm1k01_kreuz_moment.svg",
  "tm1k01_lager": "abbildungen/tm1k01_lager.svg",
  "tm1k01_linienkraft": "abbildungen/tm1k01_linienkraft.svg",
  "tm1k01_mitschrift_freischnitt": "abbildungen/tm1k01_mitschrift_freischnitt.svg",
  "tm1k01_mitschrift_schnitt": "abbildungen/tm1k01_mitschrift_schnitt.svg",
  "tm1k01_modellguete": "abbildungen/tm1k01_modellguete.svg",
  "tm1k01_momentdarst": "abbildungen/tm1k01_momentdarst.svg",
  "tm1k01_projektion_fs": "abbildungen/tm1k01_projektion_fs.svg",
  "tm1k01_punktlast": "abbildungen/tm1k01_punktlast.svg",
  "tm1k01_rechtsschraube": "abbildungen/tm1k01_rechtsschraube.svg",
  "tm1k01_richtung2": "abbildungen/tm1k01_richtung2.svg",
  "tm1k01_skalarprodukt": "abbildungen/tm1k01_skalarprodukt.svg",
  "tm1k01_starr": "abbildungen/tm1k01_starr.svg",
  "tm1k01_statik_ggw": "abbildungen/tm1k01_statik_ggw.svg",
  "tm1k01_stein": "abbildungen/tm1k01_stein.svg",
  "tm1k01_ueb_beispiel": "abbildungen/tm1k01_ueb_beispiel.svg",
  "tm1k01_vek_add": "abbildungen/tm1k01_vek_add.svg",
  "tm1k01_vek_betrag": "abbildungen/tm1k01_vek_betrag.svg",
  "tm1k01_vek_darst": "abbildungen/tm1k01_vek_darst.svg",
  "tm1k01_vek_sub": "abbildungen/tm1k01_vek_sub.svg",
  "tm1k01_vorgehen_c": "abbildungen/tm1k01_vorgehen_c.svg",
  "tm1k01_winkel_faelle": "abbildungen/tm1k01_winkel_faelle.svg",
  "tm1k01_wirkung": "abbildungen/tm1k01_wirkung.svg",
  "tm1k01_ww_gesetz": "abbildungen/tm1k01_ww_gesetz.svg",
  "tm1k01_wzf_lesenkraft": "abbildungen/tm1k01_wzf_lesenkraft.svg",
  "tm1k01_wzf_winkel": "abbildungen/tm1k01_wzf_winkel.svg",
  "tm1k01_zuordnung": "abbildungen/tm1k01_zuordnung.svg",
  "tm1k2_balken": "abbildungen/tm1k2_balken.svg",
  "tm1k2_bsp1_oese": "abbildungen/tm1k2_bsp1_oese.svg",
  "tm1k2_bsp1_vektoriell": "abbildungen/tm1k2_bsp1_vektoriell.svg",
  "tm1k2_bsp2_rechnung": "abbildungen/tm1k2_bsp2_rechnung.svg",
  "tm1k2_bsp2_walze": "abbildungen/tm1k2_bsp2_walze.svg",
  "tm1k2_bsp3_gewichte": "abbildungen/tm1k2_bsp3_gewichte.svg",
  "tm1k2_bsp4_vektoriell": "abbildungen/tm1k2_bsp4_vektoriell.svg",
  "tm1k2_bsp4_zweischlag": "abbildungen/tm1k2_bsp4_zweischlag.svg",
  "tm1k2_bsp5_seile": "abbildungen/tm1k2_bsp5_seile.svg",
  "tm1k2_bsp6_foto": "abbildungen/tm1k2_bsp6_foto.svg",
  "tm1k2_bsp6_tafel": "abbildungen/tm1k2_bsp6_tafel.svg",
  "tm1k2_bsp6_windkanal": "abbildungen/tm1k2_bsp6_windkanal.svg",
  "tm1k2_bsp_cosinussatz": "abbildungen/tm1k2_bsp_cosinussatz.svg",
  "tm1k2_definition": "abbildungen/tm1k2_definition.svg",
  "tm1k2_dreieckssaetze": "abbildungen/tm1k2_dreieckssaetze.svg",
  "tm1k2_dreikraft": "abbildungen/tm1k2_dreikraft.svg",
  "tm1k2_fachwerkknoten": "abbildungen/tm1k2_fachwerkknoten.svg",
  "tm1k2_gebogener_stab": "abbildungen/tm1k2_gebogener_stab.svg",
  "tm1k2_gerberbalken": "abbildungen/tm1k2_gerberbalken.svg",
  "tm1k2_ggw_mehrere": "abbildungen/tm1k2_ggw_mehrere.svg",
  "tm1k2_ggw_zwei": "abbildungen/tm1k2_ggw_zwei.svg",
  "tm1k2_komponenten": "abbildungen/tm1k2_komponenten.svg",
  "tm1k2_krafteck": "abbildungen/tm1k2_krafteck.svg",
  "tm1k2_lager1": "abbildungen/tm1k2_lager1.svg",
  "tm1k2_lager2": "abbildungen/tm1k2_lager2.svg",
  "tm1k2_lager3": "abbildungen/tm1k2_lager3.svg",
  "tm1k2_mitschrift_zerlegung": "abbildungen/tm1k2_mitschrift_zerlegung.svg",
  "tm1k2_parallelogramm": "abbildungen/tm1k2_parallelogramm.svg",
  "tm1k2_resultierende": "abbildungen/tm1k2_resultierende.svg",
  "tm1k2_rolle": "abbildungen/tm1k2_rolle.svg",
  "tm1k2_seil": "abbildungen/tm1k2_seil.svg",
  "tm1k2_skolaut2": "abbildungen/tm1k2_skolaut2.svg",
  "tm1k2_stab": "abbildungen/tm1k2_stab.svg",
  "tm1k2_sys_seil_walze": "abbildungen/tm1k2_sys_seil_walze.svg",
  "tm1k2_sys_zweischlag_rolle": "abbildungen/tm1k2_sys_zweischlag_rolle.svg",
  "tm1k2_ue21": "abbildungen/tm1k2_ue21.svg",
  "tm1k2_ue22": "abbildungen/tm1k2_ue22.svg",
  "tm1k2_ue23": "abbildungen/tm1k2_ue23.svg",
  "tm1k2_ue24": "abbildungen/tm1k2_ue24.svg",
  "tm1k2_ue31": "abbildungen/tm1k2_ue31.svg",
  "tm1k2_ue32": "abbildungen/tm1k2_ue32.svg",
  "tm1k2_ue33": "abbildungen/tm1k2_ue33.svg",
  "tm1k2_ue34": "abbildungen/tm1k2_ue34.svg",
  "tm1k2_ue41": "abbildungen/tm1k2_ue41.svg",
  "tm1k2_ue42": "abbildungen/tm1k2_ue42.svg",
  "tm1k2_ue43": "abbildungen/tm1k2_ue43.svg",
  "tm1k2_ue45": "abbildungen/tm1k2_ue45.svg",
  "tm1k2_zerlegung_grafisch": "abbildungen/tm1k2_zerlegung_grafisch.svg",
  "tm1k2_zerlegung_herleitung2": "abbildungen/tm1k2_zerlegung_herleitung2.svg",
  "tm1k2_zerlegung_senkrecht": "abbildungen/tm1k2_zerlegung_senkrecht.svg",
  "tm1k2_zerlegung_trigo": "abbildungen/tm1k2_zerlegung_trigo.svg",
  "tm1k3_actio": "abbildungen/tm1k3_actio.svg",
  "tm1k3_alternativen": "abbildungen/tm1k3_alternativen.svg",
  "tm1k3_bsp_alt2": "abbildungen/tm1k3_bsp_alt2.svg",
  "tm1k3_bsp_alt3": "abbildungen/tm1k3_bsp_alt3.svg",
  "tm1k3_bsp_balken": "abbildungen/tm1k3_bsp_balken.svg",
  "tm1k3_einheit": "abbildungen/tm1k3_einheit.svg",
  "tm1k3_ggw": "abbildungen/tm1k3_ggw.svg",
  "tm1k3_greifer": "abbildungen/tm1k3_greifer.svg",
  "tm1k3_greifer_arm": "abbildungen/tm1k3_greifer_arm.svg",
  "tm1k3_greifer_ges": "abbildungen/tm1k3_greifer_ges.svg",
  "tm1k3_kp_bsp": "abbildungen/tm1k3_kp_bsp.svg",
  "tm1k3_kp_eigensch": "abbildungen/tm1k3_kp_eigensch.svg",
  "tm1k3_m0_komp": "abbildungen/tm1k3_m0_komp.svg",
  "tm1k3_m0_summe": "abbildungen/tm1k3_m0_summe.svg",
  "tm1k3_mauer": "abbildungen/tm1k3_mauer.svg",
  "tm1k3_parallelf": "abbildungen/tm1k3_parallelf.svg",
  "tm1k3_resultierende1": "abbildungen/tm1k3_resultierende1.svg",
  "tm1k3_resultierende2": "abbildungen/tm1k3_resultierende2.svg",
  "tm1k3_scheibe": "abbildungen/tm1k3_scheibe.svg",
  "tm1k3_trick": "abbildungen/tm1k3_trick.svg",
  "tm1k3_ue51": "abbildungen/tm1k3_ue51.svg",
  "tm1k3_ue52": "abbildungen/tm1k3_ue52.svg",
  "tm1k3_ue53": "abbildungen/tm1k3_ue53.svg",
  "tm1k3_ue54": "abbildungen/tm1k3_ue54.svg",
  "tm1k3_uebersicht": "abbildungen/tm1k3_uebersicht.svg",
  "tm1k3_versatz": "abbildungen/tm1k3_versatz.svg",
  "tm1k3_vorzeichen": "abbildungen/tm1k3_vorzeichen.svg",
  "tm1k4_aussparung": "abbildungen/tm1k4_aussparung.svg",
  "tm1k4_bereichsweise": "abbildungen/tm1k4_bereichsweise.svg",
  "tm1k4_bsp1a": "abbildungen/tm1k4_bsp1a.svg",
  "tm1k4_bsp1b": "abbildungen/tm1k4_bsp1b.svg",
  "tm1k4_bsp2_aufg": "abbildungen/tm1k4_bsp2_aufg.svg",
  "tm1k4_bsp2a": "abbildungen/tm1k4_bsp2a.svg",
  "tm1k4_bsp2b": "abbildungen/tm1k4_bsp2b.svg",
  "tm1k4_bsp2c": "abbildungen/tm1k4_bsp2c.svg",
  "tm1k4_bsp3": "abbildungen/tm1k4_bsp3.svg",
  "tm1k4_bsp4": "abbildungen/tm1k4_bsp4.svg",
  "tm1k4_bsp4b": "abbildungen/tm1k4_bsp4b.svg",
  "tm1k4_draht": "abbildungen/tm1k4_draht.svg",
  "tm1k4_dreieck1": "abbildungen/tm1k4_dreieck1.svg",
  "tm1k4_dreieck2": "abbildungen/tm1k4_dreieck2.svg",
  "tm1k4_einzel": "abbildungen/tm1k4_einzel.svg",
  "tm1k4_einzel_ggw": "abbildungen/tm1k4_einzel_ggw.svg",
  "tm1k4_flaeche_einzel": "abbildungen/tm1k4_flaeche_einzel.svg",
  "tm1k4_flaechenlast": "abbildungen/tm1k4_flaechenlast.svg",
  "tm1k4_fs_tabelle": "abbildungen/tm1k4_fs_tabelle.svg",
  "tm1k4_fsp": "abbildungen/tm1k4_fsp.svg",
  "tm1k4_inhalt": "abbildungen/tm1k4_inhalt.svg",
  "tm1k4_konst": "abbildungen/tm1k4_konst.svg",
  "tm1k4_ksabh": "abbildungen/tm1k4_ksabh.svg",
  "tm1k4_linie1": "abbildungen/tm1k4_linie1.svg",
  "tm1k4_linie2": "abbildungen/tm1k4_linie2.svg",
  "tm1k4_rahmen": "abbildungen/tm1k4_rahmen.svg",
  "tm1k4_schraeg": "abbildungen/tm1k4_schraeg.svg",
  "tm1k4_statmom": "abbildungen/tm1k4_statmom.svg",
  "tm1k4_strecke": "abbildungen/tm1k4_strecke.svg",
  "tm1k4_strecke_ggw": "abbildungen/tm1k4_strecke_ggw.svg",
  "tm1k4_symm": "abbildungen/tm1k4_symm.svg",
  "tm1k4_teilstuecke": "abbildungen/tm1k4_teilstuecke.svg",
  "tm1k4_ue61": "abbildungen/tm1k4_ue61.svg",
  "tm1k4_ue62": "abbildungen/tm1k4_ue62.svg",
  "tm1k4_ue63": "abbildungen/tm1k4_ue63.svg",
  "tm1k4_ue64": "abbildungen/tm1k4_ue64.svg",
  "tm1k4_vol1": "abbildungen/tm1k4_vol1.svg",
  "tm1k4_vol2": "abbildungen/tm1k4_vol2.svg",
  "tm1k4_vol3": "abbildungen/tm1k4_vol3.svg",
  "tm1k4_vol4": "abbildungen/tm1k4_vol4.svg",
  "tm1k4_wzf_dreieck_int": "abbildungen/tm1k4_wzf_dreieck_int.svg",
  "tm1k4_wzf_dreiecke": "abbildungen/tm1k4_wzf_dreiecke.svg",
  "tm1k4_wzf_fallend": "abbildungen/tm1k4_wzf_fallend.svg",
  "tm1k4_wzf_flaeche": "abbildungen/tm1k4_wzf_flaeche.svg",
  "tm1k4_wzf_steigend": "abbildungen/tm1k4_wzf_steigend.svg",
  "tm1k4_wzf_trapez": "abbildungen/tm1k4_wzf_trapez.svg",
  "tm1k4_zusammen1": "abbildungen/tm1k4_zusammen1.svg",
  "tm1k4_zusammen2": "abbildungen/tm1k4_zusammen2.svg",
  "tm1k5_bauteile": "abbildungen/tm1k5_bauteile.svg",
  "tm1k5_bsp12": "abbildungen/tm1k5_bsp12.svg",
  "tm1k5_bsp3": "abbildungen/tm1k5_bsp3.svg",
  "tm1k5_bsp51": "abbildungen/tm1k5_bsp51.svg",
  "tm1k5_bsp52": "abbildungen/tm1k5_bsp52.svg",
  "tm1k5_bsp53a": "abbildungen/tm1k5_bsp53a.svg",
  "tm1k5_bsp53b": "abbildungen/tm1k5_bsp53b.svg",
  "tm1k5_bsp53b_fkb": "abbildungen/tm1k5_bsp53b_fkb.svg",
  "tm1k5_bsp54": "abbildungen/tm1k5_bsp54.svg",
  "tm1k5_bsp54_fs": "abbildungen/tm1k5_bsp54_fs.svg",
  "tm1k5_bsp57": "abbildungen/tm1k5_bsp57.svg",
  "tm1k5_bsp57_fs": "abbildungen/tm1k5_bsp57_fs.svg",
  "tm1k5_dgb1": "abbildungen/tm1k5_dgb1.svg",
  "tm1k5_dgb2": "abbildungen/tm1k5_dgb2.svg",
  "tm1k5_dreiwertig": "abbildungen/tm1k5_dreiwertig.svg",
  "tm1k5_einfrier1": "abbildungen/tm1k5_einfrier1.svg",
  "tm1k5_einfrier2": "abbildungen/tm1k5_einfrier2.svg",
  "tm1k5_einfrier3": "abbildungen/tm1k5_einfrier3.svg",
  "tm1k5_einfrier4": "abbildungen/tm1k5_einfrier4.svg",
  "tm1k5_einfrier5": "abbildungen/tm1k5_einfrier5.svg",
  "tm1k5_einwertig": "abbildungen/tm1k5_einwertig.svg",
  "tm1k5_freischnitt": "abbildungen/tm1k5_freischnitt.svg",
  "tm1k5_gerber1": "abbildungen/tm1k5_gerber1.svg",
  "tm1k5_gerber2": "abbildungen/tm1k5_gerber2.svg",
  "tm1k5_ggw": "abbildungen/tm1k5_ggw.svg",
  "tm1k5_lager": "abbildungen/tm1k5_lager.svg",
  "tm1k5_mbest_bsp": "abbildungen/tm1k5_mbest_bsp.svg",
  "tm1k5_mbest_sonder": "abbildungen/tm1k5_mbest_sonder.svg",
  "tm1k5_mfreischnitt": "abbildungen/tm1k5_mfreischnitt.svg",
  "tm1k5_nichtzulaessig": "abbildungen/tm1k5_nichtzulaessig.svg",
  "tm1k5_pkw": "abbildungen/tm1k5_pkw.svg",
  "tm1k5_pkw_fs": "abbildungen/tm1k5_pkw_fs.svg",
  "tm1k5_rahmen": "abbildungen/tm1k5_rahmen.svg",
  "tm1k5_rahmen_mit": "abbildungen/tm1k5_rahmen_mit.svg",
  "tm1k5_regel": "abbildungen/tm1k5_regel.svg",
  "tm1k5_sonderfall1": "abbildungen/tm1k5_sonderfall1.svg",
  "tm1k5_sonderfall2": "abbildungen/tm1k5_sonderfall2.svg",
  "tm1k5_ue71": "abbildungen/tm1k5_ue71.svg",
  "tm1k5_ue72": "abbildungen/tm1k5_ue72.svg",
  "tm1k5_ue73": "abbildungen/tm1k5_ue73.svg",
  "tm1k5_ue74": "abbildungen/tm1k5_ue74.svg",
  "tm1k5_ue75": "abbildungen/tm1k5_ue75.svg",
  "tm1k5_ue76": "abbildungen/tm1k5_ue76.svg",
  "tm1k5_ue81": "abbildungen/tm1k5_ue81.svg",
  "tm1k5_ue82": "abbildungen/tm1k5_ue82.svg",
  "tm1k5_unbestimmt": "abbildungen/tm1k5_unbestimmt.svg",
  "tm1k5_verb1": "abbildungen/tm1k5_verb1.svg",
  "tm1k5_verb2": "abbildungen/tm1k5_verb2.svg",
  "tm1k5_verb3": "abbildungen/tm1k5_verb3.svg",
  "tm1k5_vorgehen": "abbildungen/tm1k5_vorgehen.svg",
  "tm1k5_zweiwertig": "abbildungen/tm1k5_zweiwertig.svg",
  "tm1k5_zweiwertig2": "abbildungen/tm1k5_zweiwertig2.svg",
  "tm1k6_bedingung": "abbildungen/tm1k6_bedingung.svg",
  "tm1k6_bg1": "abbildungen/tm1k6_bg1.svg",
  "tm1k6_bg2": "abbildungen/tm1k6_bg2.svg",
  "tm1k6_bg2b": "abbildungen/tm1k6_bg2b.svg",
  "tm1k6_bg2c": "abbildungen/tm1k6_bg2c.svg",
  "tm1k6_bg3": "abbildungen/tm1k6_bg3.svg",
  "tm1k6_bsp2": "abbildungen/tm1k6_bsp2.svg",
  "tm1k6_bsp2_ggw1": "abbildungen/tm1k6_bsp2_ggw1.svg",
  "tm1k6_bsp2_ggw2": "abbildungen/tm1k6_bsp2_ggw2.svg",
  "tm1k6_bsp2_lager": "abbildungen/tm1k6_bsp2_lager.svg",
  "tm1k6_bsp2_loesung": "abbildungen/tm1k6_bsp2_loesung.svg",
  "tm1k6_bsp2_null": "abbildungen/tm1k6_bsp2_null.svg",
  "tm1k6_bsp2_tabelle": "abbildungen/tm1k6_bsp2_tabelle.svg",
  "tm1k6_def": "abbildungen/tm1k6_def.svg",
  "tm1k6_mit_bemerkung": "abbildungen/tm1k6_mit_bemerkung.svg",
  "tm1k6_mit_bsp": "abbildungen/tm1k6_mit_bsp.svg",
  "tm1k6_mit_ggw": "abbildungen/tm1k6_mit_ggw.svg",
  "tm1k6_mit_ggw_knoten": "abbildungen/tm1k6_mit_ggw_knoten.svg",
  "tm1k6_mit_knoten": "abbildungen/tm1k6_mit_knoten.svg",
  "tm1k6_mit_lager": "abbildungen/tm1k6_mit_lager.svg",
  "tm1k6_mit_nullregeln": "abbildungen/tm1k6_mit_nullregeln.svg",
  "tm1k6_mit_nulltab": "abbildungen/tm1k6_mit_nulltab.svg",
  "tm1k6_mit_rest": "abbildungen/tm1k6_mit_rest.svg",
  "tm1k6_mit_stab": "abbildungen/tm1k6_mit_stab.svg",
  "tm1k6_mit_tabelle": "abbildungen/tm1k6_mit_tabelle.svg",
  "tm1k6_mit_vorgehen": "abbildungen/tm1k6_mit_vorgehen.svg",
  "tm1k6_nichtfw": "abbildungen/tm1k6_nichtfw.svg",
  "tm1k6_ritter1": "abbildungen/tm1k6_ritter1.svg",
  "tm1k6_ritter1_rech": "abbildungen/tm1k6_ritter1_rech.svg",
  "tm1k6_ritter2": "abbildungen/tm1k6_ritter2.svg",
  "tm1k6_ritter3": "abbildungen/tm1k6_ritter3.svg",
  "tm1k6_ue83": "abbildungen/tm1k6_ue83.svg",
  "tm1k6_ue84": "abbildungen/tm1k6_ue84.svg",
  "tm1k6_ue91": "abbildungen/tm1k6_ue91.svg",
  "tm1k6_unbestimmt": "abbildungen/tm1k6_unbestimmt.svg",
  "tm1k7_balkenstueck": "abbildungen/tm1k7_balkenstueck.svg",
  "tm1k7_bsp1": "abbildungen/tm1k7_bsp1.svg",
  "tm1k7_bsp1_verlauf": "abbildungen/tm1k7_bsp1_verlauf.svg",
  "tm1k7_bsp2": "abbildungen/tm1k7_bsp2.svg",
  "tm1k7_bsp2_verlauf": "abbildungen/tm1k7_bsp2_verlauf.svg",
  "tm1k7_bsp3_lager": "abbildungen/tm1k7_bsp3_lager.svg",
  "tm1k7_bsp3_verlauf": "abbildungen/tm1k7_bsp3_verlauf.svg",
  "tm1k7_bsp4": "abbildungen/tm1k7_bsp4.svg",
  "tm1k7_bsp4_verlauf": "abbildungen/tm1k7_bsp4_verlauf.svg",
  "tm1k7_einfuehrung": "abbildungen/tm1k7_einfuehrung.svg",
  "tm1k7_einzelkraefte": "abbildungen/tm1k7_einzelkraefte.svg",
  "tm1k7_element": "abbildungen/tm1k7_element.svg",
  "tm1k7_faser": "abbildungen/tm1k7_faser.svg",
  "tm1k7_foeppl_bsp": "abbildungen/tm1k7_foeppl_bsp.svg",
  "tm1k7_foeppl_def": "abbildungen/tm1k7_foeppl_def.svg",
  "tm1k7_freischnitte": "abbildungen/tm1k7_freischnitte.svg",
  "tm1k7_fs_rb": "abbildungen/tm1k7_fs_rb.svg",
  "tm1k7_gb1": "abbildungen/tm1k7_gb1.svg",
  "tm1k7_gb1_gelenk": "abbildungen/tm1k7_gb1_gelenk.svg",
  "tm1k7_gb1_lager": "abbildungen/tm1k7_gb1_lager.svg",
  "tm1k7_gb1_rbueb": "abbildungen/tm1k7_gb1_rbueb.svg",
  "tm1k7_gb1_verlauf": "abbildungen/tm1k7_gb1_verlauf.svg",
  "tm1k7_gb1_werte": "abbildungen/tm1k7_gb1_werte.svg",
  "tm1k7_gb2": "abbildungen/tm1k7_gb2.svg",
  "tm1k7_gb2_verlauf": "abbildungen/tm1k7_gb2_verlauf.svg",
  "tm1k7_inhalt": "abbildungen/tm1k7_inhalt.svg",
  "tm1k7_lager_lokal": "abbildungen/tm1k7_lager_lokal.svg",
  "tm1k7_mit_mmax": "abbildungen/tm1k7_mit_mmax.svg",
  "tm1k7_mit_punkt1": "abbildungen/tm1k7_mit_punkt1.svg",
  "tm1k7_mit_punkt2": "abbildungen/tm1k7_mit_punkt2.svg",
  "tm1k7_mit_ueb_c": "abbildungen/tm1k7_mit_ueb_c.svg",
  "tm1k7_mit_ueb_int": "abbildungen/tm1k7_mit_ueb_int.svg",
  "tm1k7_mit_ueb_lager": "abbildungen/tm1k7_mit_ueb_lager.svg",
  "tm1k7_mit_ueb_rb": "abbildungen/tm1k7_mit_ueb_rb.svg",
  "tm1k7_mit_ueb_skizze": "abbildungen/tm1k7_mit_ueb_skizze.svg",
  "tm1k7_mitschrift_bsp3": "abbildungen/tm1k7_mitschrift_bsp3.svg",
  "tm1k7_punkt_23": "abbildungen/tm1k7_punkt_23.svg",
  "tm1k7_punkt_bsp": "abbildungen/tm1k7_punkt_bsp.svg",
  "tm1k7_punkt_skizze": "abbildungen/tm1k7_punkt_skizze.svg",
  "tm1k7_punkt_tabelle": "abbildungen/tm1k7_punkt_tabelle.svg",
  "tm1k7_punkt_vorgehen": "abbildungen/tm1k7_punkt_vorgehen.svg",
  "tm1k7_qkp_fallend": "abbildungen/tm1k7_qkp_fallend.svg",
  "tm1k7_qkp_konst": "abbildungen/tm1k7_qkp_konst.svg",
  "tm1k7_qkp_steigend": "abbildungen/tm1k7_qkp_steigend.svg",
  "tm1k7_qkp_verlaeufe": "abbildungen/tm1k7_qkp_verlaeufe.svg",
  "tm1k7_qkp_voll": "abbildungen/tm1k7_qkp_voll.svg",
  "tm1k7_rahmen_bereich2": "abbildungen/tm1k7_rahmen_bereich2.svg",
  "tm1k7_rahmen_bogen": "abbildungen/tm1k7_rahmen_bogen.svg",
  "tm1k7_rahmen_c": "abbildungen/tm1k7_rahmen_c.svg",
  "tm1k7_rahmen_ecke": "abbildungen/tm1k7_rahmen_ecke.svg",
  "tm1k7_rahmen_g2": "abbildungen/tm1k7_rahmen_g2.svg",
  "tm1k7_rahmen_g3": "abbildungen/tm1k7_rahmen_g3.svg",
  "tm1k7_rahmen_lager": "abbildungen/tm1k7_rahmen_lager.svg",
  "tm1k7_rahmen_n": "abbildungen/tm1k7_rahmen_n.svg",
  "tm1k7_rahmen_qm": "abbildungen/tm1k7_rahmen_qm.svg",
  "tm1k7_rahmen_vorgehen": "abbildungen/tm1k7_rahmen_vorgehen.svg",
  "tm1k7_streckenlast": "abbildungen/tm1k7_streckenlast.svg",
  "tm1k7_teilres": "abbildungen/tm1k7_teilres.svg",
  "tm1k7_ue101": "abbildungen/tm1k7_ue101.svg",
  "tm1k7_ue102": "abbildungen/tm1k7_ue102.svg",
  "tm1k7_ue103": "abbildungen/tm1k7_ue103.svg",
  "tm1k7_ue104": "abbildungen/tm1k7_ue104.svg",
  "tm1k7_ue111": "abbildungen/tm1k7_ue111.svg",
  "tm1k7_ue112": "abbildungen/tm1k7_ue112.svg",
  "tm1k7_ue113": "abbildungen/tm1k7_ue113.svg",
  "tm1k7_ue121": "abbildungen/tm1k7_ue121.svg",
  "tm1k7_ue122": "abbildungen/tm1k7_ue122.svg",
  "tm1k7_ue123": "abbildungen/tm1k7_ue123.svg",
  "tm1k7_ue92": "abbildungen/tm1k7_ue92.svg",
  "tm1k7_ue93": "abbildungen/tm1k7_ue93.svg",
  "tm1k7_ue94": "abbildungen/tm1k7_ue94.svg",
  "tm1k7_ueb_fall_a": "abbildungen/tm1k7_ueb_fall_a.svg",
  "tm1k7_ueb_fall_b": "abbildungen/tm1k7_ueb_fall_b.svg",
  "tm1k7_ueb_fall_b2": "abbildungen/tm1k7_ueb_fall_b2.svg",
  "tm1k7_ueb_fall_c": "abbildungen/tm1k7_ueb_fall_c.svg",
  "tm1k7_ueb_felder": "abbildungen/tm1k7_ueb_felder.svg",
  "tm1k7_ueb_kombi": "abbildungen/tm1k7_ueb_kombi.svg",
  "tm1k7_ueb_kombi2": "abbildungen/tm1k7_ueb_kombi2.svg",
  "tm1k7_ueb_mehrteilig": "abbildungen/tm1k7_ueb_mehrteilig.svg",
  "tm1k7_verlauf_einzel": "abbildungen/tm1k7_verlauf_einzel.svg",
  "tm1k7_vielefelder": "abbildungen/tm1k7_vielefelder.svg",
  "tm1k7_vorzeichen": "abbildungen/tm1k7_vorzeichen.svg",
  "tm1k7_wzf_71": "abbildungen/tm1k7_wzf_71.svg",
  "tm1k7_wzf_93": "abbildungen/tm1k7_wzf_93.svg",
  "tm1k9_fs_seil": "abbildungen/tm1k9_fs_seil.svg",
  "tm1k9_ue03": "abbildungen/tm1k9_ue03.svg",
  "tm1k9_ue131": "abbildungen/tm1k9_ue131.svg",
  "tm1k9_ue131c": "abbildungen/tm1k9_ue131c.svg",
  "tm1k9_ue132": "abbildungen/tm1k9_ue132.svg",
  "tm1k9_ue133": "abbildungen/tm1k9_ue133.svg",
  "tm2k0_balken": "abbildungen/tm2k0_balken.svg",
  "tm2k0_balken_plot": "abbildungen/tm2k0_balken_plot.svg",
  "tm2k0_dgl_m": "abbildungen/tm2k0_dgl_m.svg",
  "tm2k0_dgl_n": "abbildungen/tm2k0_dgl_n.svg",
  "tm2k0_dgl_q": "abbildungen/tm2k0_dgl_q.svg",
  "tm2k0_foeppl": "abbildungen/tm2k0_foeppl.svg",
  "tm2k0_rahmen": "abbildungen/tm2k0_rahmen.svg",
  "tm2k0_rahmen_ecke": "abbildungen/tm2k0_rahmen_ecke.svg",
  "tm2k0_rahmen_fkb": "abbildungen/tm2k0_rahmen_fkb.svg",
  "tm2k0_rahmen_verlauf": "abbildungen/tm2k0_rahmen_verlauf.svg",
  "tm2k0_tm1wdh": "abbildungen/tm2k0_tm1wdh.svg",
  "tm2k1_biege": "abbildungen/tm2k1_biege.svg",
  "tm2k1_dehnung": "abbildungen/tm2k1_dehnung.svg",
  "tm2k1_dgl_n": "abbildungen/tm2k1_dgl_n.svg",
  "tm2k1_fs_schraube": "abbildungen/tm2k1_fs_schraube.svg",
  "tm2k1_fs_stabsystem": "abbildungen/tm2k1_fs_stabsystem.svg",
  "tm2k1_haengend": "abbildungen/tm2k1_haengend.svg",
  "tm2k1_konisch": "abbildungen/tm2k1_konisch.svg",
  "tm2k1_normal": "abbildungen/tm2k1_normal.svg",
  "tm2k1_pyramide": "abbildungen/tm2k1_pyramide.svg",
  "tm2k1_pyramide_lsg": "abbildungen/tm2k1_pyramide_lsg.svg",
  "tm2k1_scher": "abbildungen/tm2k1_scher.svg",
  "tm2k1_schnittufer": "abbildungen/tm2k1_schnittufer.svg",
  "tm2k1_schraeg": "abbildungen/tm2k1_schraeg.svg",
  "tm2k1_superpos": "abbildungen/tm2k1_superpos.svg",
  "tm2k1_torsion": "abbildungen/tm2k1_torsion.svg",
  "tm2k1_trafo_kreis": "abbildungen/tm2k1_trafo_kreis.svg",
  "tm2k1_ue11": "abbildungen/tm2k1_ue11.svg",
  "tm2k1_ue12": "abbildungen/tm2k1_ue12.svg",
  "tm2k1_ue13": "abbildungen/tm2k1_ue13.svg",
  "tm2k1_ue21": "abbildungen/tm2k1_ue21.svg",
  "tm2k1_ue23": "abbildungen/tm2k1_ue23.svg",
  "tm2k1_ue31": "abbildungen/tm2k1_ue31.svg",
  "tm2k1_ue32": "abbildungen/tm2k1_ue32.svg",
  "tm2k1_ue33": "abbildungen/tm2k1_ue33.svg",
  "tm2k1_ue41": "abbildungen/tm2k1_ue41.svg",
  "tm2k1_ue42": "abbildungen/tm2k1_ue42.svg",
  "tm2k1_ue43": "abbildungen/tm2k1_ue43.svg",
  "tm2k1_unbestimmt": "abbildungen/tm2k1_unbestimmt.svg",
  "tm2k1_w134_2": "abbildungen/tm2k1_w134_2.svg",
  "tm2k1_w134_3": "abbildungen/tm2k1_w134_3.svg",
  "tm2k1_w134_5": "abbildungen/tm2k1_w134_5.svg",
  "tm2k1_w134_6": "abbildungen/tm2k1_w134_6.svg",
  "tm2k1_w204_1": "abbildungen/tm2k1_w204_1.svg",
  "tm2k1_w204_2": "abbildungen/tm2k1_w204_2.svg",
  "tm2k1_w204_3": "abbildungen/tm2k1_w204_3.svg",
  "tm2k1_w204_4": "abbildungen/tm2k1_w204_4.svg",
  "tm2k1_w233_1": "abbildungen/tm2k1_w233_1.svg",
  "tm2k1_w233_2": "abbildungen/tm2k1_w233_2.svg",
  "tm2k1_w233_3": "abbildungen/tm2k1_w233_3.svg",
  "tm2k1_w233_4": "abbildungen/tm2k1_w233_4.svg",
  "tm2k1_w303_1": "abbildungen/tm2k1_w303_1.svg",
  "tm2k1_w303_3": "abbildungen/tm2k1_w303_3.svg",
  "tm2k1_w303_4": "abbildungen/tm2k1_w303_4.svg",
  "tm2k1_w303_5": "abbildungen/tm2k1_w303_5.svg",
  "tm2k1_wasserturm": "abbildungen/tm2k1_wasserturm.svg",
  "tm2k1_wasserturm_lsg": "abbildungen/tm2k1_wasserturm_lsg.svg",
  "tm2k1_werkstoff": "abbildungen/tm2k1_werkstoff.svg",
  "tm2k1_zugversuch": "abbildungen/tm2k1_zugversuch.svg",
  "tm2k2_dreieck": "abbildungen/tm2k2_dreieck.svg",
  "tm2k2_element3d": "abbildungen/tm2k2_element3d.svg",
  "tm2k2_folie_hns": "abbildungen/tm2k2_folie_hns.svg",
  "tm2k2_fs_kreis": "abbildungen/tm2k2_fs_kreis.svg",
  "tm2k2_invarianten": "abbildungen/tm2k2_invarianten.svg",
  "tm2k2_kartoffel": "abbildungen/tm2k2_kartoffel.svg",
  "tm2k2_mohr_a01": "abbildungen/tm2k2_mohr_a01.svg",
  "tm2k2_mohr_a01_zust": "abbildungen/tm2k2_mohr_a01_zust.svg",
  "tm2k2_mohr_bongmba": "abbildungen/tm2k2_mohr_bongmba.svg",
  "tm2k2_mohr_herleitung": "abbildungen/tm2k2_mohr_herleitung.svg",
  "tm2k2_mohr_tabelle": "abbildungen/tm2k2_mohr_tabelle.svg",
  "tm2k2_transformation": "abbildungen/tm2k2_transformation.svg",
  "tm2k2_ue51": "abbildungen/tm2k2_ue51.svg",
  "tm2k2_ue52": "abbildungen/tm2k2_ue52.svg",
  "tm2k2_ue71": "abbildungen/tm2k2_ue71.svg",
  "tm2k2_w115_1": "abbildungen/tm2k2_w115_1.svg",
  "tm2k2_w115_2": "abbildungen/tm2k2_w115_2.svg",
  "tm2k2_w115_3": "abbildungen/tm2k2_w115_3.svg",
  "tm2k2_w115_4": "abbildungen/tm2k2_w115_4.svg",
  "tm2k2_w45_5": "abbildungen/tm2k2_w45_5.svg",
  "tm2k2_w45_6": "abbildungen/tm2k2_w45_6.svg",
  "tm2k2_wzf_bsp1": "abbildungen/tm2k2_wzf_bsp1.svg",
  "tm2k2_wzf_bsp6": "abbildungen/tm2k2_wzf_bsp6.svg",
  "tm2k2_wzf_trafo45": "abbildungen/tm2k2_wzf_trafo45.svg",
  "tm2k2_zugeordnet": "abbildungen/tm2k2_zugeordnet.svg",
  "tm2k3_dms_anordnung": "abbildungen/tm2k3_dms_anordnung.svg",
  "tm2k3_dms_aufgabe": "abbildungen/tm2k3_dms_aufgabe.svg",
  "tm2k3_dms_richtung": "abbildungen/tm2k3_dms_richtung.svg",
  "tm2k3_dms_sigma": "abbildungen/tm2k3_dms_sigma.svg",
  "tm2k3_dms_winkel": "abbildungen/tm2k3_dms_winkel.svg",
  "tm2k3_reine": "abbildungen/tm2k3_reine.svg",
  "tm2k3_ue81": "abbildungen/tm2k3_ue81.svg",
  "tm2k3_ue83": "abbildungen/tm2k3_ue83.svg",
  "tm2k3_ue93": "abbildungen/tm2k3_ue93.svg",
  "tm2k3_verformung": "abbildungen/tm2k3_verformung.svg",
  "tm2k3_w185_1": "abbildungen/tm2k3_w185_1.svg",
  "tm2k3_w185_2": "abbildungen/tm2k3_w185_2.svg",
  "tm2k3_w185_3": "abbildungen/tm2k3_w185_3.svg",
  "tm2k3_w185_4": "abbildungen/tm2k3_w185_4.svg",
  "tm2k3_w185_5": "abbildungen/tm2k3_w185_5.svg",
  "tm2k3_w185_6": "abbildungen/tm2k3_w185_6.svg",
  "tm2k4_allg_dgl": "abbildungen/tm2k4_allg_dgl.svg",
  "tm2k4_bernoulli": "abbildungen/tm2k4_bernoulli.svg",
  "tm2k4_biegung_m0": "abbildungen/tm2k4_biegung_m0.svg",
  "tm2k4_dgl": "abbildungen/tm2k4_dgl.svg",
  "tm2k4_drehung": "abbildungen/tm2k4_drehung.svg",
  "tm2k4_dreieck1": "abbildungen/tm2k4_dreieck1.svg",
  "tm2k4_dreieck3": "abbildungen/tm2k4_dreieck3.svg",
  "tm2k4_faelle_abc": "abbildungen/tm2k4_faelle_abc.svg",
  "tm2k4_fall_a": "abbildungen/tm2k4_fall_a.svg",
  "tm2k4_fall_c": "abbildungen/tm2k4_fall_c.svg",
  "tm2k4_foeppl_def": "abbildungen/tm2k4_foeppl_def.svg",
  "tm2k4_foeppl_teil": "abbildungen/tm2k4_foeppl_teil.svg",
  "tm2k4_fs_tabelle": "abbildungen/tm2k4_fs_tabelle.svg",
  "tm2k4_ftm1_symm": "abbildungen/tm2k4_ftm1_symm.svg",
  "tm2k4_ftm_ansatz": "abbildungen/tm2k4_ftm_ansatz.svg",
  "tm2k4_ftm_herleitung": "abbildungen/tm2k4_ftm_herleitung.svg",
  "tm2k4_gg_element": "abbildungen/tm2k4_gg_element.svg",
  "tm2k4_hauptachsen": "abbildungen/tm2k4_hauptachsen.svg",
  "tm2k4_herleitung": "abbildungen/tm2k4_herleitung.svg",
  "tm2k4_iprofil": "abbildungen/tm2k4_iprofil.svg",
  "tm2k4_iprofil_disk": "abbildungen/tm2k4_iprofil_disk.svg",
  "tm2k4_kinematik": "abbildungen/tm2k4_kinematik.svg",
  "tm2k4_lastfall1": "abbildungen/tm2k4_lastfall1.svg",
  "tm2k4_lastfall4": "abbildungen/tm2k4_lastfall4.svg",
  "tm2k4_matrix": "abbildungen/tm2k4_matrix.svg",
  "tm2k4_maximalansatz": "abbildungen/tm2k4_maximalansatz.svg",
  "tm2k4_mehrbereich": "abbildungen/tm2k4_mehrbereich.svg",
  "tm2k4_platte_loecher": "abbildungen/tm2k4_platte_loecher.svg",
  "tm2k4_rb_tabelle": "abbildungen/tm2k4_rb_tabelle.svg",
  "tm2k4_rechteck_iy": "abbildungen/tm2k4_rechteck_iy.svg",
  "tm2k4_spannungsverlauf": "abbildungen/tm2k4_spannungsverlauf.svg",
  "tm2k4_ss_loesung": "abbildungen/tm2k4_ss_loesung.svg",
  "tm2k4_steiner": "abbildungen/tm2k4_steiner.svg",
  "tm2k4_steiner_box": "abbildungen/tm2k4_steiner_box.svg",
  "tm2k4_transformation": "abbildungen/tm2k4_transformation.svg",
  "tm2k4_ue10": "abbildungen/tm2k4_ue10.svg",
  "tm2k4_ue102": "abbildungen/tm2k4_ue102.svg",
  "tm2k4_ue103": "abbildungen/tm2k4_ue103.svg",
  "tm2k4_ue104": "abbildungen/tm2k4_ue104.svg",
  "tm2k4_ue11": "abbildungen/tm2k4_ue11.svg",
  "tm2k4_ue11_4": "abbildungen/tm2k4_ue11_4.svg",
  "tm2k4_ue91": "abbildungen/tm2k4_ue91.svg",
  "tm2k4_ue92": "abbildungen/tm2k4_ue92.svg",
  "tm2k4_ueberg_einzellast": "abbildungen/tm2k4_ueberg_einzellast.svg",
  "tm2k4_ueberg_streckenlast": "abbildungen/tm2k4_ueberg_streckenlast.svg",
  "tm2k4_ueberlagerung": "abbildungen/tm2k4_ueberlagerung.svg",
  "tm2k4_ursache": "abbildungen/tm2k4_ursache.svg",
  "tm2k4_w0106_duenn": "abbildungen/tm2k4_w0106_duenn.svg",
  "tm2k4_w0106_qm": "abbildungen/tm2k4_w0106_qm.svg",
  "tm2k4_w1506_bsp1": "abbildungen/tm2k4_w1506_bsp1.svg",
  "tm2k4_widerstand": "abbildungen/tm2k4_widerstand.svg",
  "tm2k4_wzf0106_aufgabe": "abbildungen/tm2k4_wzf0106_aufgabe.svg",
  "tm2k4_wzf0806_bsp": "abbildungen/tm2k4_wzf0806_bsp.svg",
  "tm2k4_wzf0806_ue10": "abbildungen/tm2k4_wzf0806_ue10.svg",
  "tm2k4_wzf1506_gelenk": "abbildungen/tm2k4_wzf1506_gelenk.svg",
  "tm2k4_wzf1506_rb": "abbildungen/tm2k4_wzf1506_rb.svg",
  "tm2k5_beispiele_duenn": "abbildungen/tm2k5_beispiele_duenn.svg",
  "tm2k5_bredt1": "abbildungen/tm2k5_bredt1.svg",
  "tm2k5_bredt2": "abbildungen/tm2k5_bredt2.svg",
  "tm2k5_bsp_vollkreis": "abbildungen/tm2k5_bsp_vollkreis.svg",
  "tm2k5_dgl": "abbildungen/tm2k5_dgl.svg",
  "tm2k5_formeln_kreis": "abbildungen/tm2k5_formeln_kreis.svg",
  "tm2k5_fs_offen": "abbildungen/tm2k5_fs_offen.svg",
  "tm2k5_fs_tab1": "abbildungen/tm2k5_fs_tab1.svg",
  "tm2k5_fs_tab2": "abbildungen/tm2k5_fs_tab2.svg",
  "tm2k5_gg_element": "abbildungen/tm2k5_gg_element.svg",
  "tm2k5_inkreis": "abbildungen/tm2k5_inkreis.svg",
  "tm2k5_kinematik": "abbildungen/tm2k5_kinematik.svg",
  "tm2k5_lkw_rahmen": "abbildungen/tm2k5_lkw_rahmen.svg",
  "tm2k5_offen_herl": "abbildungen/tm2k5_offen_herl.svg",
  "tm2k5_offen_wt": "abbildungen/tm2k5_offen_wt.svg",
  "tm2k5_polares_ftm": "abbildungen/tm2k5_polares_ftm.svg",
  "tm2k5_schubfluss": "abbildungen/tm2k5_schubfluss.svg",
  "tm2k5_stat_unbest": "abbildungen/tm2k5_stat_unbest.svg",
  "tm2k5_tau_linear": "abbildungen/tm2k5_tau_linear.svg",
  "tm2k5_vergleich_og": "abbildungen/tm2k5_vergleich_og.svg",
  "tm2k5_vergleich_qs": "abbildungen/tm2k5_vergleich_qs.svg",
  "tm2k5_w2206_it": "abbildungen/tm2k5_w2206_it.svg",
  "tm2k5_w2206_loes": "abbildungen/tm2k5_w2206_loes.svg",
  "tm2k5_wzf_bsp_quer": "abbildungen/tm2k5_wzf_bsp_quer.svg",
  "tm2k5_wzf_rohr": "abbildungen/tm2k5_wzf_rohr.svg",
  "tm2k5_wzf_schubfluss": "abbildungen/tm2k5_wzf_schubfluss.svg",
)

#let bilddeutungen = (
  "map-klausur-torsion": (titel: "Die Mindmap lesen", body: [Die vier hellblauen Äste verbinden die Schritte aus diesem Kapitel. Beginne mit dem Modell bzw. den gegebenen Größen und erkläre dann, welches Werkzeug zum gesuchten Ergebnis führt.]),
  "map-klausur-dms": (titel: "Die Mindmap lesen", body: [Die vier hellblauen Äste verbinden die Schritte aus diesem Kapitel. Beginne mit dem Modell bzw. den gegebenen Größen und erkläre dann, welches Werkzeug zum gesuchten Ergebnis führt.]),
  "map-klausur-stab": (titel: "Die Mindmap lesen", body: [Die vier hellblauen Äste verbinden die Schritte aus diesem Kapitel. Beginne mit dem Modell bzw. den gegebenen Größen und erkläre dann, welches Werkzeug zum gesuchten Ergebnis führt.]),
  "map-klausur-haftung": (titel: "Die Mindmap lesen", body: [Die vier hellblauen Äste verbinden die Schritte aus diesem Kapitel. Beginne mit dem Modell bzw. den gegebenen Größen und erkläre dann, welches Werkzeug zum gesuchten Ergebnis führt.]),
  "map-klausur-schnitt": (titel: "Die Mindmap lesen", body: [Die vier hellblauen Äste verbinden die Schritte aus diesem Kapitel. Beginne mit dem Modell bzw. den gegebenen Größen und erkläre dann, welches Werkzeug zum gesuchten Ergebnis führt.]),
  "map-klausur-fachwerk": (titel: "Die Mindmap lesen", body: [Die vier hellblauen Äste verbinden die Schritte aus diesem Kapitel. Beginne mit dem Modell bzw. den gegebenen Größen und erkläre dann, welches Werkzeug zum gesuchten Ergebnis führt.]),
  "map-klausur-lager": (titel: "Die Mindmap lesen", body: [Die vier hellblauen Äste verbinden die Schritte aus diesem Kapitel. Beginne mit dem Modell bzw. den gegebenen Größen und erkläre dann, welches Werkzeug zum gesuchten Ergebnis führt.]),
  "map-klausur-schwerpunkt": (titel: "Die Mindmap lesen", body: [Die vier hellblauen Äste verbinden die Schritte aus diesem Kapitel. Beginne mit dem Modell bzw. den gegebenen Größen und erkläre dann, welches Werkzeug zum gesuchten Ergebnis führt.]),
  "map-klausur-tm2": (titel: "Bild lesen", body: [Vier Äste zeigen die zusammengehörigen Rechenschritte. Die Kästen nennen das Ziel und das passende Werkzeug; die Verbindungslinien machen deutlich, dass die Aufgaben auf denselben Grundlagen aufbauen.]),
  "map-klausur-tm1": (titel: "Bild lesen", body: [Vier Äste zeigen die zusammengehörigen Rechenschritte. Die Kästen nennen das Ziel und das passende Werkzeug; die Verbindungslinien machen deutlich, dass die Aufgaben auf denselben Grundlagen aufbauen.]),
  "ak24-waerme": (titel: "Bild lesen", body: [Die Erwärmung möchte den senkrechten Stab verlängern und das Balkenende nach oben schieben. Die Druckkraft X verkürzt den Stab und biegt den Balken nach oben. Beide Bauteile müssen am gemeinsamen Gelenk dieselbe Verschiebung haben. Daher wird die Balkendurchbiegung mit freier Wärmedehnung minus elastischer Stauchung gleichgesetzt.]),
  "ak24-querschnitt": (titel: "Bild lesen", body: [Der Querschnitt besteht aus einem Rechteck mit aufgesetztem Halbkreis und einer passenden Aussparung. Die Hilfsachse y′ liegt durch den Kreismittelpunkt, z′ zeigt nach unten. Deshalb haben die Halbkreis-Schwerpunkte negative z′-Koordinaten, die Rechtecke positive. Erst nach der Schwerpunktrechnung wird die endgültige y-Achse durch S gelegt. Für Steiner sind die Abstände zu dieser Achse maßgeblich.]),
  "ak24-fachwerk-schnitt": (titel: "Bild lesen", body: [Die Streckenlasten des ersten Systems sind entfernt. Das Seil hat überall die Zugkraft 5F: An A wirken daher ein senkrechter und ein schräger Seilzug. Wegen der Abstände 4a und 3a hat der schräge Zug die Komponenten 4F und 3F. Rechts sind die 17 Fachwerkstäbe nummeriert. Die gestrichelte Bezugsfaser legt die lokalen Vorzeichen fest. Die angegebenen Reaktionen gehören nur zu diesem geänderten System.]),
  "ak24-system": (titel: "Bild lesen", body: [Links liegt der T-Träger A–E–B–G, rechts die als starr betrachtete Scheibe C–D–L–M. Das Gelenk G verbindet beide. Die Last q₀ wirkt senkrecht auf A–E, die dreieckige Seitenlast wächst von G nach M. B und D liefern jeweils nur eine horizontale Reaktion; C liefert zwei Komponenten. Die Abstände bestimmen die Hebelarme.]),
  "map-t1k0": (titel: "Die Mindmap lesen", body: [Im Zentrum steht das ganze Fach. Links oben und rechts oben stehen die beiden Grundfragen: Wie läuft eine Bewegung ab, und welche Kräfte stecken dahinter? Unten links steht der Sonderfall Ruhe, der Gegenstand der Statik. Unten rechts siehst du, welches Fach welchen Teil übernimmt.]),
  "map-t1k1a": (titel: "Die Mindmap lesen", body: [Jeder Ast ist ein Werkzeug mit einer typischen Frage. Betrag: Wie groß? Addition: Was ergibt sich zusammen? Skalarprodukt: Wie viel wirkt in eine bestimmte Richtung? Kreuzprodukt: Wie stark dreht es? In der Statik brauchst du vor allem die Addition und das Kreuzprodukt.]),
  "map-t1k1b": (titel: "Die Mindmap lesen", body: [Dieselbe Kraft kann in alle drei Sortierungen gleichzeitig passen: Das Gewicht eines Balkens ist eine Volumenkraft, eingeprägt und eine äußere Kraft. Der vierte Ast erinnert daran, dass „innen“ und „außen“ erst feststehen, wenn du das System gewählt hast.]),
  "map-t1k1c": (titel: "Die Mindmap lesen", body: [Die Äste laufen im Uhrzeigersinn wie der Rechenweg: Modell vereinfachen, Lager lösen und durch Kräfte ersetzen, bei mehreren Körpern actio = reactio beachten, zum Schluss die Gleichgewichtsbedingungen aufstellen.]),
  "tm1k01_aufgabe": (titel: "Bild lesen", body: [Gelb sind die Kernsätze der Folie markiert: Mechanik als Lehre der Bewegungen unter Kräften. Im Kasten rechts unten steht dein Tafelanschrieb mit den drei Gleichgewichtsbedingungen. Daraus folgt: Statik ist der Fall, in dem diese drei Summen null sind.]),
  "tm1k01_einteilung": (titel: "Bild lesen", body: [Der Baum liest sich von oben nach unten: Mechanik teilt sich in Kinematik und Dynamik; unter der Dynamik stehen Statik und Kinetik, jeweils für starre und verformbare Körper. Deine handschriftlichen Notizen ordnen die Kästen den Fächern zu: TM I = Statik starrer Körper, TM II = Elastostatik.]),
  "tm1k01_herkunft": (titel: "Bild lesen", body: [Links stehen Beispiele für die Herkunft von Kräften, rechts die Skizzen dazu. In deiner Federskizze zieht das Gewicht $m g$ die Feder um $Delta L$ länger. Man sieht also nicht die Kraft, sondern ihre Wirkung, die Verlängerung.]),
  "tm1k01_wirkung": (titel: "Bild lesen", body: [Oben zeigt der Radschlüssel zwei gleich große, entgegengesetzte Kräfte $F_1$ und $F_2$: ein Kräftepaar, das die Schraube dreht. Unten sind die drei Wirkungen markiert. Deine Skizze rechts zeigt die Schubverformung: Das Rechteck wird bei gleicher Höhe zum Parallelogramm.]),
  "tm1k01_statik_ggw": (titel: "Bild lesen", body: [Die Folie begründet, warum man in TM1 keine Kräfte sieht, und leitet daraus die Gleichgewichtsbedingungen ab: drei in 2D (gelb), sechs in 3D. Im Kasten rechts steht deine Vorzeichenregel: gegen den Uhrzeigersinn positiv.]),
  "tm1k01_eigenschaften": (titel: "Bild lesen", body: [Am Seil über der Rolle siehst du alle drei Eigenschaften: Der Pfeil hat eine Länge (Betrag), einen Winkel und eine Spitze (Richtung) und sitzt an einem Punkt (Angriffspunkt). Die gestrichelte Linie durch den Pfeil ist die Wirkungslinie.]),
  "tm1k01_darstellung": (titel: "Bild lesen", body: [Der Ortsvektor $arrow(s)$ führt vom Ursprung zum Angriffspunkt A, der Kraftvektor $arrow(F)_A$ beginnt dort. Unten: Kräfte senkrecht zur Zeichenebene stellt man als Punkt (heraus) oder Kreuz (hinein) dar, wie die Spitze oder die Federn eines Pfeils.]),
  "tm1k01_momentdarst": (titel: "Bild lesen", body: [Oben ein Würfel mit räumlichen Kräften, die man nur qualitativ zeichnen kann. Unten ein Balken mit Festlager A, Loslager B, Einzelkräften, einem Moment $M_0$ als gekrümmtem Pfeil und einer Linienlast $q(x)$. Deine Notizen benennen die Lager und Lasten.]),
  "tm1k01_rechtsschraube": (titel: "Bild lesen", body: [Unten siehst du zwei Schrauben: Dreht man gegen den Uhrzeigersinn, kommt die Schraube heraus, der Momentvektor zeigt aus der Ebene (Punkt). Dreht man im Uhrzeigersinn, geht sie hinein (Kreuz). So legt die Rechte-Hand-Regel den Richtungssinn fest.]),
  "tm1k01_vek_darst": (titel: "Bild lesen", body: [Links ein ebener Vektor mit seinen Komponenten $F_x$ und $F_y$ an den Achsen, rechts ein räumlicher mit drei Komponenten. Unten die Spaltenschreibweise. Gelb markiert: In der Ebene darf man maßstäblich zeichnen, im Raum nur qualitativ.]),
  "tm1k01_vek_betrag": (titel: "Bild lesen", body: [Der Betrag ist die Länge des Pfeils. Im roten Kasten steht die Formel als Pythagoras: Wurzel aus der Summe der quadrierten Komponenten. Dein großes Ausrufezeichen zeigt, dass du sie in fast jeder Aufgabe brauchst.]),
  "tm1k01_vek_add": (titel: "Bild lesen", body: [Oben werden zwei Pfeile Spitze an Fuß gehängt; der Summenpfeil $F_G$ geht vom ersten Fuß zur letzten Spitze, egal in welcher Reihenfolge. Unten (gelb) dasselbe rechnerisch: Komponenten zeilenweise addieren.]),
  "tm1k01_vek_sub": (titel: "Bild lesen", body: [Für $arrow(F)_1 - arrow(F)_2$ wird $arrow(F)_2$ umgedreht ($-arrow(F)_2$) und angehängt. Rechnerisch subtrahiert man zeilenweise. Die Subtraktion ist also eine Addition mit dem Gegenvektor.]),
  "tm1k01_skalarprodukt": (titel: "Bild lesen", body: [Die kleine Skizze zeigt, wie $arrow(b)$ auf $arrow(a)$ projiziert wird; die Projektion heißt $b_a$. Gelb sind die Komponentenformeln markiert. Wichtig: Das Ergebnis ist eine Zahl, und bei 90° ist es null.]),
  "tm1k01_winkel_faelle": (titel: "Bild lesen", body: [Unten stehen drei Fälle nebeneinander: spitzer Winkel (positives Skalarprodukt), stumpfer Winkel (negativ) und rechter Winkel (null). Mit dem Vorzeichen erkennst du also sofort, ob zwei Kräfte eher in dieselbe oder in entgegengesetzte Richtung zeigen.]),
  "tm1k01_projektion_fs": (titel: "Bild lesen", body: [Oben die Länge der Projektion, darunter der Projektionsvektor und unten der Winkel 45°. Im ersten Nenner hast du den Exponenten geschwärzt; dort gehört nur $|arrow(s)|$ hin (siehe Fehlerkasten).]),
  "tm1k01_kreuz_komp": (titel: "Bild lesen", body: [Die Formel bildet jede Zeile aus den beiden anderen Zeilen über Kreuz. Rechts oben dein Merkschema mit den doppelt untereinander geschriebenen Komponenten. Unten der ebene Sonderfall: Nur die z-Komponente bleibt übrig.]),
  "tm1k01_kreuz_moment": (titel: "Bild lesen", body: [Der Monteur zieht mit 100 N in y-Richtung am Hebel $r = "0,5" "m"$ in x-Richtung. Das Kreuzprodukt ergibt nur eine z-Komponente von 50 Nm: Das Moment steht senkrecht auf Hebel und Kraft, also entlang der Schraubenachse.]),
  "tm1k01_richtung2": (titel: "Bild lesen", body: [Die Rechnung zeigt, dass die drei Richtungswinkel über $cos^2 alpha + cos^2 beta + cos^2 gamma = 1$ verbunden sind. Deshalb sind im Raum nur zwei Winkel frei. Gelb: Ein Vektor ist in 2D durch zwei, in 3D durch drei Größen festgelegt.]),
  "tm1k01_wzf_winkel": (titel: "Bild lesen", body: [Im rechtwinkligen Dreieck sind Hypotenuse, Gegen- und Ankathete farbig benannt. Der Merksatz in der Mitte liest sich spaltenweise. Rechts deine Zusammenfassung der drei Winkelfunktionen, die du gelb markiert hast.]),
  "tm1k01_wzf_lesenkraft": (titel: "Bild lesen", body: [Die Kraft $F$ liegt unter dem Winkel $alpha$ zur x-Achse. Das blaue Rechteck zerlegt sie in $F_x$ (Ankathete, also cos) und $F_y$ (Gegenkathete, also sin). Die gestrichelte rote Linie ist die Wirkungslinie.]),
  "tm1k01_ueb_beispiel": (titel: "Bild lesen", body: [Oben die Skizze mit $F_1$ im zweiten und $F_2$ im ersten Quadranten. Darunter die Zerlegung in Komponenten, das Quadrantenschema „Sin + / Alle + / Tan + / Cos +“ und unten die Summe mit dem gelb markierten Ergebnis 110,72 N.]),
  "tm1k01_starr": (titel: "Bild lesen", body: [Oben: Die Kraft $F$ wandert auf ihrer Wirkungslinie von links nach rechts, die Wirkung bleibt gleich. Mitte: Zwei Kräfte $F_1$, $F_2$ einmal auf einer Linie, einmal parallel versetzt; versetzt entsteht ein Moment, daher das Ungleichzeichen.]),
  "tm1k01_zuordnung": (titel: "Bild lesen", body: [Oben (O.K.) werden die Kräfte am Winkelstück verschoben und bleiben am selben Körper. Unten (nicht O.K.) wird $F_1$ vom Stab $K_1$ auf den Stab $K_2$ geschoben. Das ändert das System, deshalb das Ungleichzeichen.]),
  "tm1k01_linienkraft": (titel: "Bild lesen", body: [Viele gleich lange Pfeile auf dem Balken stellen eine konstante Streckenlast $q_0$ dar. Rechts stehen die Größen mit Einheiten. Das Gewicht des ganzen Balkens wird also gleichmäßig auf seine Länge verteilt.]),
  "tm1k01_punktlast": (titel: "Bild lesen", body: [Links der reale Quader, in der Mitte sein Gewicht als Volumenkraft $d G$ und die Bodenpressung $p$ als Flächenkraft, rechts das idealisierte Modell mit nur zwei Punktlasten $G$ und $N$. Für die Statik genügt das rechte Bild.]),
  "tm1k01_stein": (titel: "Bild lesen", body: [Frei fallend wirkt nur das Gewicht $G$. Liegt der Stein auf dem Boden, kommt die Reaktionskraft $N$ dazu. Rechts sind Stein und Boden auseinandergezogen: $N$ wirkt nach oben auf den Stein und nach unten auf den Boden.]),
  "tm1k01_aeussere": (titel: "Bild lesen", body: [Links ist der Balken in die Wand eingespannt. Nach dem Freischnitt (rechts) ersetzen eine Kraft $F_A$ und ein Moment $M_A$ die Wand. Beides sind äußere Reaktionen, die du in Kapitel 5 berechnest.]),
  "tm1k01_innere": (titel: "Bild lesen", body: [Der Balken wird an einer Stelle durchgeschnitten. An beiden Schnittufern erscheinen $N$, $Q$ und $M$, jeweils entgegengesetzt gerichtet. Das sind die inneren Kräfte, die Kapitel 7 berechnet.]),
  "tm1k01_mitschrift_freischnitt": (titel: "Bild lesen", body: [Oben links der eingespannte Balken, rechts das Freikörperbild: Die Wand ist durch $A_x$, $A_y$ und $M_A$ ersetzt. Darunter drei Gleichgewichtsgleichungen und ihre Lösung. Das ist der Ablauf jeder Lagerkraftberechnung.]),
  "tm1k01_mitschrift_schnitt": (titel: "Bild lesen", body: [Der Balken ist bei $x$ geschnitten; links das positive, rechts das negative Schnittufer. Die grünen Pfeile zeigen $N$, $Q$, $M$ an beiden Ufern entgegengesetzt. Unten folgen die Definitionen der drei Schnittgrößen.]),
  "tm1k01_ww_gesetz": (titel: "Bild lesen", body: [Die Kugel liegt auf dem Boden. Nach dem Freischnitt wirkt $N$ nach oben auf die Kugel und gleich groß nach unten auf den Boden, auf derselben Wirkungslinie. Gelb markiert ist das Merkwort actio = reactio.]),
  "tm1k01_lager": (titel: "Bild lesen", body: [Der Gerberbalken liegt auf A (Festlager), C und B (Loslager) und hat ein Gelenk G. Rechts unten zeigen die Symbole für jedes Bauteil, welche Bewegung gesperrt (×) und welche frei (✓) ist: senkrecht, waagerecht, Drehung.]),
  "tm1k01_gerber_frei": (titel: "Bild lesen", body: [Oben das System, darunter die beiden Balkenteile getrennt. Am Gelenk wirken $G_x$, $G_y$ auf beide Teile mit umgekehrter Richtung. Unten die Lagerkräfte auf die Erde, ebenfalls umgedreht: actio = reactio an jeder Schnittstelle.]),
  "tm1k01_einheiten": (titel: "Bild lesen", body: [Oben die drei SI-Grundgrößen, darunter die Kraft als abgeleitete Größe. Die Kugel rechts veranschaulicht 1 N: Eine Masse von 1 kg wird mit $1 "m/s"^2$ beschleunigt. Unten der Gewichtsvektor mit $-"9,81"$ in z-Richtung für 3D.]),
  "tm1k01_falle": (titel: "Bild lesen", body: [Eine Kiste von 10 t hängt am Seil, gezogen wird mit 100 kN. Unten steht der Vergleich: Grob gerundet bleibt nichts übrig, genau bleiben 1,9 kN. Kleine Rundungen bei großen Zahlen können also das Ergebnis völlig verändern.]),
  "tm1k01_modellguete": (titel: "Bild lesen", body: [Die drei Spalten zeigen dieselbe Brücke mit Lkw in drei Modellen. Grob: Lkw als eine Kraft, Brücke gewichtslos. Mittel: zwei Achslasten und Brückengewicht im Schwerpunkt. Genau: zusätzlich Streckenlast $q_0$. Je genauer, desto mehr Rechenaufwand.]),
  "tm1k01_vorgehen_c": (titel: "Bild lesen", body: [Schritt c) ist gelb markiert, darüber deine Notiz „Ab hier nur wichtig“. Die Skizze zeigt einen Balken mit Lkw, darunter die gelösten Lager mit $A_x$, $A_y$ und $B$. Die Klammer erinnert: Die Gegenkräfte auf die Lager kann man meist weglassen.]),
  "tm1k01_bsp1": (titel: "Bild lesen", body: [Die Rolle lehnt oben an der Wand, der Stiel stützt sich unten unter dem Winkel $alpha$ auf dem Boden ab. Gesucht sind die Kräfte an Wand und Stiel. Unten rechts auf der Folie steht die Lösung $N = G cot alpha$, $S = G\/sin alpha$.]),
  "tm1k01_bsp1_mitschrift": (titel: "Bild lesen", body: [a) zeigt das System Walze plus Stiel mit $N$, $G$, $A_x$, $A_y$. b) zeigt nur die Walze mit $N$, $G$ und der Stielkraft $S$ in Stielrichtung („Stab!“). c) und d) sind die beiden Gleichgewichtsgleichungen und ihre Auflösung.]),
  "tm1k01_bsp2": (titel: "Bild lesen", body: [Der Bolzen in der Mitte hängt am Seil (oben links), am Gelenkstab (rechts oben) und an der Feder (unten links). Die Winkel $alpha$, $beta$, $gamma$ geben die Richtungen. Unten auf der Folie stehen die Ergebnisse für $S$ und $K$.]),
  "tm1k01_bsp2_mitschrift": (titel: "Bild lesen", body: [Am freigeschnittenen Bolzen sind alle vier Kräfte mit ihren Winkeln eingezeichnet. Die rote Zeile ist das Gleichgewicht in x („bei x immer cos“), die grüne das in y („bei y immer sin“).]),
  "tm1k01_bsp3": (titel: "Bild lesen", body: [Die Rolle liegt an der Wand und hängt am gekrümmten Balken, der unten rechts gelagert ist. Die Feder zieht vom Bolzen zur Wand. Der Schnitt A-A durch den Balken fragt nach der inneren Kraft dort.]),
  "tm1k2_definition": (titel: "Bild lesen", body: [Drei Kräfte greifen an verschiedenen Stellen eines starren Körpers an, ihre Wirkungslinien (gestrichelt) treffen sich aber in einem Punkt. Genau das macht die Gruppe „zentral“. Gelb markiert hast du die beiden Namen und „treffen sich in einem Angriffspunkt“.]),
  "tm1k2_fachwerkknoten": (titel: "Bild lesen", body: [Links ein Fachwerk mit Knoten I bis VI und Stäben 1 bis 11. Rechts unten ist Knoten III freigeschnitten: Alle Stabkräfte $S_1, S_3, S_4, S_5$ zeigen vom Knoten weg und treffen sich im Knotenpunkt. Grün oben deine Skizze desselben Knotens mit $F_3$ und dem Hinweis „Druckstab“ bei $S_1$.]),
  "tm1k2_parallelogramm": (titel: "Bild lesen", body: [Links der Lageplan: $F_1$ und $F_2$ greifen am selben Punkt an. Rechts das Kräfteparallelogramm: Die Diagonale ist $F_R$. Jede Hälfte des Parallelogramms ist ein Kräftedreieck, du brauchst also nur eines zu zeichnen. Unten: Für die grafische Addition darfst du eine Kraft parallel als Hilfslinie zeichnen.]),
  "tm1k2_krafteck": (titel: "Bild lesen", body: [Links vier Kräfte an einem Punkt (Lageplan). Rechts werden sie Spitze an Schaft aneinandergehängt. Der Pfeil vom Anfang des ersten zur Spitze des letzten ist $F_R$. Die Reihenfolge ist beliebig.]),
  "tm1k2_komponenten": (titel: "Bild lesen", body: [Erst das Koordinatensystem wählen (rot umrahmt), dann jede Kraft in $F_x = F cos phi$ und $F_y = F sin phi$ zerlegen. Der Winkel $phi$ wird von der positiven x-Achse gemessen. Rechts dein Merkkreis S-A-C-T: In welchem Quadranten ist welche Winkelfunktion positiv.]),
  "tm1k2_resultierende": (titel: "Bild lesen", body: [Oben werden alle x-Anteile und alle y-Anteile addiert. Unten das rechtwinklige Dreieck aus $F_"Rx"$, $F_"Ry"$ und $F_R$: Pythagoras liefert den Betrag, der Tangens den Winkel $phi_R$. Gelb markiert sind beide Formeln.]),
  "tm1k2_dreieckssaetze": (titel: "Bild lesen", body: [Ein beliebiges Dreieck mit Seiten $a, b, c$ und Gegenwinkeln $alpha, beta, gamma$. Cosinussatz und Sinussatz sind gelb markiert. Darunter die Umrechnungen wie $sin(pi - phi) = sin phi$, die du im Krafteck ständig brauchst.]),
  "tm1k2_bsp_cosinussatz": (titel: "Bild lesen", body: [$F_1$ und $F_2$ schließen den Winkel $alpha$ ein. Im Kräftedreieck rechts liegt zwischen ihnen der Winkel $pi - alpha$. Darum steht im Cosinussatz $cos(pi - alpha)$, was zu $+2 F_1 F_2 cos alpha$ wird. Der Sinussatz liefert dann den Winkel $beta$ von $F_R$.]),
  "tm1k2_zerlegung_grafisch": (titel: "Bild lesen", body: [Gegeben ist $F$ und die beiden Wirkungslinien $W L_(F_1)$ und $W L_(F_2)$. Parallelen zu den Wirkungslinien durch die Spitze von $F$ schneiden die Linien und begrenzen $F_1$ und $F_2$. Text links: Mit zwei Richtungen ist die Zerlegung eindeutig, mit mehr nicht.]),
  "tm1k2_mitschrift_zerlegung": (titel: "Bild lesen", body: [Deine Zeichnung auf Karopapier: Zwei gestrichelte Wirkungslinien, $F$ in der Mitte. Durch die Spitze von $F$ ziehst du Parallelen; dort, wo sie die Wirkungslinien schneiden, enden $F_A$ und $F_B$.]),
  "tm1k2_zerlegung_trigo": (titel: "Bild lesen", body: [Kräftedreieck aus $F$, $F_1$ und $F_2$ mit den Winkeln $alpha$ und $beta$ zu $F$. Der dritte Winkel ist $pi - (alpha + beta)$. Rechts der Sinussatz Schritt für Schritt bis $F_2 = F sin alpha \/ sin(alpha + beta)$ und $F_1 = F sin beta \/ sin(alpha + beta)$.]),
  "tm1k2_zerlegung_senkrecht": (titel: "Bild lesen", body: [Sonderfall: Die beiden Richtungen stehen senkrecht aufeinander, also $alpha + beta = 90°$. Dann wird der Sinussatz zu $F_1 = F cos alpha$ und $F_2 = F sin alpha$. Rechts der Alltagsfall x-y-Komponenten mit $arcsin$, $arccos$ und $arctan$ für den Winkel.]),
  "tm1k2_zerlegung_herleitung2": (titel: "Bild lesen", body: [Herleitung von $F_2$ aus der vektoriellen Zerlegung, Zeile für Zeile. Das Ergebnis unten ist $F_2 = F sin(phi - phi_1) \/ sin(phi_2 - phi_1)$, analog $F_1$. In der 2. und 3. Zeile sind Tippfehler, siehe Kasten im Text.]),
  "tm1k2_ggw_zwei": (titel: "Bild lesen", body: [Zwei Kräfte auf derselben Wirkungslinie, gleich groß, entgegengesetzt. Rechts das Krafteck: Die zweite Kraft führt genau zum Anfang zurück, es ist „geschlossen“. Vektoriell: $F_1 + F_2 = 0$.]),
  "tm1k2_ggw_mehrere": (titel: "Bild lesen", body: [Vier Kräfte an einem Punkt. Im Krafteck endet die letzte Kraft wieder am Anfang: Die Resultierende ist der Nullvektor. Grün hast du eine andere Reihenfolge gezeichnet, das Krafteck bleibt geschlossen.]),
  "tm1k2_seil": (titel: "Bild lesen", body: [Ein Seilstück mit Zugkräften $F_S$ an beiden Enden, gleich groß, entgegengesetzt, in Seilrichtung. Links die Idealisierungen: biegeschlaff, masselos, keine Last innerhalb des Seilstücks.]),
  "tm1k2_rolle": (titel: "Bild lesen", body: [Ein Seil läuft über eine reibungsfreie Rolle mit Lager A. Links und rechts wirkt dieselbe Seilkraft $F_S$, nur die Richtung ändert sich mit dem Seil.]),
  "tm1k2_stab": (titel: "Bild lesen", body: [Zwei gerade Stäbe. Oben zeigen die Kräfte $S$ nach außen: Zugstab. Unten zeigen sie nach innen: Druckstab. Links die Idealisierungen: masselos, beidseitig gelenkig, keine Last zwischen den Enden.]),
  "tm1k2_balken": (titel: "Bild lesen", body: [Links ein Balken mit schräger Last: Die Wirkungslinien von $F$, $F_A$ und $F_B$ treffen sich in einem Punkt (zentral). Rechts drei parallele Kräfte, die sich nicht schneiden (nicht zentral). Unten der Hinweis, dass „Balken“ und „Stab“ in Aufgaben manchmal vertauscht werden.]),
  "tm1k2_gebogener_stab": (titel: "Bild lesen", body: [Ein gekrümmter Stab mit Gelenken an beiden Enden. Die Kräfte $S$ zeigen nicht entlang des Bogens, sondern entlang der gestrichelten Verbindungslinie der beiden Gelenke.]),
  "tm1k2_lager1": (titel: "Bild lesen", body: [Tabelle mit vier Spalten: Name und Symbol, Bewegungsmöglichkeiten (grüner Haken = möglich, rotes Kreuz = verhindert), Freischnitt, Bemerkung. Festlager und Gelenk: beide Verschiebungen verhindert, Drehung frei, also zwei Kräfte. Kontakt mit Reibung: Normalkraft $N$ und Tangentialkraft $T$.]),
  "tm1k2_lager2": (titel: "Bild lesen", body: [Loslager und Schiebegelenk: Nur die Bewegung senkrecht zur Bahn ist verhindert, darum eine Kraft. Kontakt ohne Reibung: nur $N$ senkrecht zur Berührtangente; bei einer Walze zeigt $N$ zum Mittelpunkt.]),
  "tm1k2_lager3": (titel: "Bild lesen", body: [Schiebehülse: eine Kraft senkrecht zur Bewegungsrichtung und ein Moment. Starre Einspannung und starre Verbindung: alles verhindert, darum zwei Kräfte und ein Moment.]),
  "tm1k2_skolaut2": (titel: "Bild lesen", body: [Alltagsbeispiele nach Skolaut. Festlager (Wertigkeit 2): Drehpunkt eines Schlagbaums. Verschiebbare Hülse (Wertigkeit 2). Feste Einspannung (Wertigkeit 3): der einbetonierte Fuß einer Ampel. Rechts jeweils Symbol und Reaktionen als rote Pfeile.]),
  "tm1k2_gerberbalken": (titel: "Bild lesen", body: [Deine Notizseite: Lager verbinden mit der Umgebung, Gelenke verbinden Körper untereinander. Darunter ein Gerberbalken mit Festlager A, Loslagern B und C und Gelenk G. Unten für jedes Lager: welche Bewegungen gesperrt (rotes Kreuz) und welche frei (grüner Haken) sind. Rot umrahmt „Prüfung: Mehrteiliges Fachwerk mit Gelenk“.]),
  "tm1k2_sys_zweischlag_rolle": (titel: "Bild lesen", body: [Oben ein Zweischlag: zwei gelenkig verbundene Stäbe mit Last $F$ am Gelenk G. Freigeschnitten werden die Stäbe zu Stabkräften $S_1$, $S_2$. Unten eine Rolle mit Seil auf glatter schiefer Ebene: $F$, $G$ und $N$ (senkrecht zur Ebene).]),
  "tm1k2_sys_seil_walze": (titel: "Bild lesen", body: [Oben ein Seilknoten mit drei Kräften. Unten eine Walze zwischen zwei glatten schiefen Ebenen (Winkel $alpha$, $beta$). Beide Normalkräfte zeigen zum Mittelpunkt. Rechts die Winkelbetrachtung: $N_1$ steht unter $alpha$ zur Senkrechten.]),
  "tm1k2_dreikraft": (titel: "Bild lesen", body: [Balken mit Festlager A und schrägem Loslager B, Last $F$. Die Wirkungslinien von $F$ und $F_B$ schneiden sich oben. Rot notiert: „gemeinsamer Schnittpunkt“; die Wirkungslinie von $F_A$ muss durch diesen Punkt.]),
  "tm1k2_bsp1_oese": (titel: "Bild lesen", body: [Eine Öse an einer Wand mit zwei Kräften $F_1$, $F_2$ unter den Winkeln $alpha$, $beta$. Die Wandkraft $H$ hält beiden das Gleichgewicht. Rechts unten das geschlossene Krafteck; du hast „2× Z-Winkel“ notiert, weil sich die Winkel über Wechselwinkel übertragen.]),
  "tm1k2_bsp1_vektoriell": (titel: "Bild lesen", body: [Oben der Cosinussatz für $H$. Unten der empfohlene Weg: statt $H$ und Winkel $gamma$ die Komponenten $H_x$ und $H_y$ als Unbekannte. Zwei Gleichungen, zwei Unbekannte, fertig.]),
  "tm1k2_bsp2_walze": (titel: "Bild lesen", body: [Walze auf glatter schiefer Ebene (Winkel $alpha$), gehalten von einem Seil unter $beta$. Freischnitt: $G$ senkrecht, $N$ senkrecht zur Ebene, $F_S$ in Seilrichtung. Unten das Kräftedreieck mit den Winkeln $90° - beta$ und $90° - alpha + beta$.]),
  "tm1k2_bsp2_rechnung": (titel: "Bild lesen", body: [Oben der Sinussatz für $N$ und $F_S$. Unten der vektorielle Ansatz mit $sum F_x$ und $sum F_y$. Im Nenner der ersten Zeile steht nur „$90 - beta$“; es muss $sin(90° - beta)$ heißen.]),
  "tm1k2_bsp3_gewichte": (titel: "Bild lesen", body: [Drei Gewichte an einem Seil über zwei reibungsfreie Rollen. Am Knoten wirken $G_1$, $G_2$ (in Seilrichtung) und $G_3$ (senkrecht). Unten die grafische Lösung: zwei Kreise mit Radius $G_1$ und $G_2$, ihr Schnittpunkt legt die Winkel fest.]),
  "tm1k2_bsp4_zweischlag": (titel: "Bild lesen", body: [Zwei Stäbe an einer Wand halten ein Gewicht $G$. Freischnitt des Knotens mit $S_1$, $S_2$, $G$. Rechts unten das Krafteck: $S_1$ zieht (Zug), $S_2$ drückt (Druck).]),
  "tm1k2_bsp4_vektoriell": (titel: "Bild lesen", body: [Beide Stabkräfte werden als Zug angesetzt. Aus den Gleichgewichtsbedingungen folgt $S_1 > 0$ (Zug) und $S_2 < 0$ (Druck). Das Vorzeichen zeigt die Richtung automatisch.]),
  "tm1k2_bsp5_seile": (titel: "Bild lesen", body: [Sieben Seile an einem Punkt A, Winkel zwischen 30° und 60°. $S_1$ bis $S_5$ sind gegeben, $S_6$ und $S_7$ gesucht. Es bleibt eine zentrale Kräftegruppe mit zwei Unbekannten.]),
  "tm1k2_bsp6_windkanal": (titel: "Bild lesen", body: [Eine Kugel ($G = 50 "N"$) hängt an einem Draht (Winkel $alpha$) und einer Feder (Winkel $beta$). Von links bläst der Wind mit $W = 30 "N"$. Gesucht sind die Winkel bei $D = 45 "N"$ und $F = 30 "N"$.]),
  "tm1k2_bsp6_tafel": (titel: "Bild lesen", body: [Deine Mitschrift vom 30.10.25: oben die Anordnung, unten der Freischnitt der Kugel mit $D$ (grün, unter $alpha$), $F$ (grün, unter $beta$), $W$ (rot nach rechts) und $G$ (rot nach unten) im x-y-System.]),
  "tm1k2_bsp6_foto": (titel: "Bild lesen", body: [Foto der Tafel: grafische Lösung mit Geodreieck. Aus dem Krafteck abgelesen $alpha approx 29°$, $beta approx 71°$. Eine zweite Lösung ist als „physikalisch nicht sinnvoll“ markiert.]),
  "map-t1k2a": (titel: "Die Mindmap lesen", body: [Drei Wege führen zur Resultierenden: zeichnen, in Komponenten rechnen oder mit Cosinus- und Sinussatz. Der vierte Ast ist der umgekehrte Weg, die Zerlegung, und erinnert an ihre Grenze: nur zwei Richtungen.]),
  "map-t1k2b": (titel: "Die Mindmap lesen", body: [Links oben die Bedingung, rechts oben was sie leistet. Unten die zwei Werkzeuge, mit denen du Richtungen festlegst: die Idealisierung der Bauteile und das Dreikraftsystem.]),
  "tm1k2_ue21": (titel: "Bild lesen", body: [Ein Waggon von oben. Vorne zieht $F$ in Fahrtrichtung, die Seile $F_1$ und $F_2$ gehen unter 40° nach oben und 25° nach unten von der Zugrichtung ab.]),
  "tm1k2_ue22": (titel: "Bild lesen", body: [Draufsicht auf einen Mast mit vier Drähten. $F_3$ zeigt nach rechts, $F_4$ nach unten (90° zu $F_3$). $F_2$ liegt 45° über $F_3$, $F_1$ noch einmal 75° weiter.]),
  "tm1k2_ue23": (titel: "Bild lesen", body: [$F$ zeigt senkrecht nach oben. $F_1$ zeigt nach links unten, unter $alpha_1$ zur Waagerechten; $F_2$ nach rechts unten, unter $alpha_2$.]),
  "tm1k2_ue24": (titel: "Bild lesen", body: [Fünf Kräftesysteme. Bei 2.4.1, 2.4.3 und 2.4.4 sind Winkel zur x-Achse angegeben. Bei 2.4.2 und 2.4.5 stehen statt Winkeln Steigungsdreiecke (z. B. 3 und 4): daraus berechnest du sin und cos.]),
  "tm1k2_ue31": (titel: "Bild lesen", body: [Links die Frontansicht: Das Seil ist über eine Gabel im Kugelmittelpunkt befestigt. Rechts die Seitenansicht: Seil der Länge $a = 60 "cm"$ von der Wand zum Mittelpunkt, Kugel mit $r = 20 "cm"$ berührt die Wand. Grün und gelb sind deine Markierungen.]),
  "tm1k2_ue32": (titel: "Bild lesen", body: [Ein Gewicht $G$ hängt an einem Seil, das über eine Rolle läuft und unter dem Winkel $beta$ als $F_S$ weitergeführt wird. Die Rolle hängt an einer Pendelstange unter dem Winkel $alpha$ zur Decke.]),
  "tm1k2_ue33": (titel: "Bild lesen", body: [Zwei Rollen an der Decke. Körper 1 hängt am Knoten; das Seil nach links unter $alpha$ läuft über die linke Rolle zu Körper 2, das Seil nach rechts unter $beta$ über die rechte Rolle zu Körper 3.]),
  "tm1k2_ue34": (titel: "Bild lesen", body: [Ein Drehkran: senkrechte Säule mit A oben und B unten (Abstände $l_1$, $l_2$), Ausleger der Länge $l_3$. Zugstab Z von A zur Spitze, Druckstab D von B zur Spitze, dort hängt $F$.]),
  "tm1k2_ue41": (titel: "Bild lesen", body: [Zwei Stäbe an einer Wand: Stab 1 waagerecht, Stab 2 schräg darunter unter $beta$. Am gemeinsamen Knoten hängt die Masse $m$.]),
  "tm1k2_ue42": (titel: "Bild lesen", body: [Eine große Walze ($4G$, Radius $2r$) liegt auf zwei kleinen Walzen ($G$, Radius $r$). Die kleinen Walzen sind durch ein Seil $S$ verbunden, ihre Mittelpunkte haben den Abstand $3r$.]),
  "tm1k2_ue43": (titel: "Bild lesen", body: [Ein Bagger mit Ausleger bis B. Von B gehen Seil 1 zum Bagger und Seil 2 zu Punkt A, beide unter $alpha$. Von A geht Seil 3 waagerecht zurück, unten hängt $G$.]),
  "tm1k2_ue45": (titel: "Bild lesen", body: [Ein schräger Stab (Gewicht $G$) liegt bei A auf einer Ecke und lehnt bei B an einer senkrechten Wand. Zwischen Ecke und Wand liegt der Abstand $a$, der Stab steht unter $alpha$ zur Waagerechten.]),
  "tm1k3_uebersicht": (titel: "Bild lesen", body: [Die Gliederungsfolie von Kapitel 3: 3.1 Kraftgruppen in der Ebene mit 3.1.1 bis 3.1.4 und 3.2 Kraftgruppen im Raum. Daneben die Formelsammlungsseite mit der Gleichgewichtsbedingung am starren Körper: Kraftsumme null und Momentensumme null.]),
  "tm1k3_trick": (titel: "Bild lesen", body: [Zwei parallele Kräfte $F_1$, $F_2$ auf einem Balken schneiden sich nie. Der Trick: Auf einer gemeinsamen Wirkungslinie werden $-K$ und $+K$ ergänzt (blau). $R_1$ und $R_2$ (rot) schneiden sich oben; durch diesen Punkt geht die Resultierende $R = F_1 + F_2$.]),
  "tm1k3_kp_bsp": (titel: "Bild lesen", body: [Oben zwei gleich große, entgegengesetzte Kräfte im Abstand $h_s$: Ihre Summe ist null, sie drehen nur. Unten Alltagsbeispiele: ein Lenkrad mit zwei Händen und eine Schraubenzieherklinge im Schlitz.]),
  "tm1k3_vorzeichen": (titel: "Bild lesen", body: [Ein Kräftepaar dreht links herum: $M = +h_s F$; rechts herum: $M = -h_s F$. Unten rot umrandet die Vorzeichenfestlegung: Links herum ist positiv, das ist die positive Drehung um die z-Achse.]),
  "tm1k3_einheit": (titel: "Bild lesen", body: [Im Raum ist das Moment ein Vektor: $arrow(M) = arrow(h) times arrow(F)$, wobei $arrow(h)$ vom Bezugspunkt zum Angriffspunkt zeigt. Betrag $M = h_s F$, Einheit Länge mal Kraft, also Nm (rot umrandet).]),
  "tm1k3_kp_eigensch": (titel: "Bild lesen", body: [Oben: Verschiedene Kräftepaare sind gleichwertig, wenn $h_s F$ gleich ist (Foto des Tafelbildes rechts). Unten der Beweis der Verschiebbarkeit: Mit Hilfskräften, die sich gegenseitig aufheben, wandert das Paar an eine andere Stelle des starren Körpers.]),
  "tm1k3_actio": (titel: "Bild lesen", body: [Ein Balken wird geschnitten. An der Schnittstelle wirkt auf das linke Teil ein Moment und auf das rechte Teil das gleich große Moment mit entgegengesetztem Drehsinn, dazu die Schnittkräfte. actio = reactio gilt also auch für Momente.]),
  "tm1k3_versatz": (titel: "Bild lesen", body: [Ein Schraubenschlüssel mit Kraft $F$ am Griff. Im Punkt 0 (Schraube) werden $+F$ und $-F$ ergänzt. $F$ am Griff und $-F$ in 0 bilden ein Kräftepaar mit $M_((0)) = h_s F$. Übrig bleibt: $F$ in 0 plus Moment. Unten rot umrandet das Ergebnis.]),
  "tm1k3_m0_komp": (titel: "Bild lesen", body: [Oben: Das Moment einer Kraft hängt vom Bezugspunkt ab, $|M_((0))| = h_s F$. Unten wird $F$ in $F_x$ und $F_y$ zerlegt; mit den Abständen $h_x$, $h_y$ des Angriffspunkts gilt (rot umrandet) $M_((0)) = h_x F_y - h_y F_x$.]),
  "tm1k3_m0_summe": (titel: "Bild lesen", body: [Die Formel für $M_((0))$ ist die z-Komponente des Kreuzprodukts $arrow(h) times arrow(F)$. Rot umrandet: Greifen mehrere Kräfte an einem Punkt an, ist die Summe ihrer Momente gleich dem Moment der Resultierenden.]),
  "tm1k3_resultierende1": (titel: "Bild lesen", body: [Ein starrer Körper mit beliebigen Kräften $F_i$ und Momenten $M_j$. Alle Kräfte werden nach A verschoben; jede bekommt ihr Versetzmoment $M_(F_i (A)) = h_x F_"iy" - h_y F_"ix"$. Übrig bleiben zentrale Kräfte, Momente und Versetzmomente in A.]),
  "tm1k3_resultierende2": (titel: "Bild lesen", body: [In A ergibt sich eine resultierende Kraft $F_R$ und ein resultierendes Moment $M_(R(A))$ (rot umrandet). Ist $F_R != 0$, verschiebt man $F_R$ um $h_s = M_(R(A)) \/ F_R$ nach B; dort ist das Moment null.]),
  "tm1k3_ggw": (titel: "Bild lesen", body: [Folie: Gleichgewicht am starren Körper heißt $F_R = 0$ und $M_(R(A)) = 0$. Der Bezugspunkt A ist frei wählbar. Ausgeschrieben: drei Gleichungen $sum F_x$, $sum F_y$, $sum M$ für drei Unbekannte.]),
  "tm1k3_alternativen": (titel: "Bild lesen", body: [Statt zwei Kraft- und einer Momentensumme darf man auch eine Kraft- und zwei Momentensummen (Alternative A) oder drei Momentensummen (Alternative B) nehmen. Rechts die Bedingungen an die Lage der Punkte A, B, C.]),
  "tm1k3_bsp_balken": (titel: "Bild lesen", body: [Balken mit Festlager A und Loslager B. $F_1$ wirkt waagerecht auf einem Hebel der Höhe $a$, $F_2$ senkrecht in der Mitte, dazu das Moment $M$. Rechts das Freikörperbild mit $A_x$, $A_y$, $B$ und die drei Gleichungen.]),
  "tm1k3_bsp_alt2": (titel: "Bild lesen", body: [Dasselbe Beispiel mit einer Kraftsumme und zwei Momentensummen um A und B. Jede Gleichung enthält nur eine Unbekannte, das Lösen geht Zeile für Zeile.]),
  "tm1k3_bsp_alt3": (titel: "Bild lesen", body: [Dasselbe Beispiel mit drei Momentensummen um A, B und C. A, B, C liegen nicht auf einer Geraden. Wieder erscheint in jeder Gleichung nur eine Unbekannte.]),
  "tm1k3_mauer": (titel: "Bild lesen", body: [Deine Mitschrift: ein Balken steckt in einer Mauer (Einspannung A) und liegt bei B auf; am Ende wirkt $F$. Unten das Freikörperbild mit $A$, $M_A$, $B$ und die drei Gleichgewichtsbedingungen.]),
  "tm1k3_parallelf": (titel: "Bild lesen", body: [Ein Balken mit Parallelführung bei A (keine Drehung, keine senkrechte Verschiebung) und Loslager B, Last $F$. Im Freikörperbild hat A eine Kraft und ein Moment $M_A$, B eine Kraft.]),
  "tm1k3_scheibe": (titel: "Bild lesen", body: [Eine Scheibe, gehalten von drei Stäben, belastet durch ein Moment. Statt Kraftsummen bildest du Momentensummen um die Schnittpunkte von je zwei Stäben. Dann bleibt in jeder Gleichung nur eine Stabkraft.]),
  "tm1k3_greifer": (titel: "Bild lesen", body: [Ein Greifer hängt an einem Seil und hält eine Last $G$ durch Reibung. Er besteht aus zwei gelenkig verbundenen Armen. Gegeben sind die Maße $a$ bis $h$ und $G = 460 "N"$, gesucht die Kräfte in A und B.]),
  "tm1k3_greifer_ges": (titel: "Bild lesen", body: [Erst das Gesamtsystem: Seilkraft $S = G$. Dann Knoten C freigeschnitten mit den Stabkräften und ihren Komponenten über die Winkel.]),
  "tm1k3_greifer_arm": (titel: "Bild lesen", body: [Ein Arm freigeschnitten mit den Kräften an A, im Gelenk und vom Stab. Rechts das Gleichgewicht mit Momentensumme um das Gelenk; unten das Ergebnis für $S_3$.]),
  "map-t1k3a": (titel: "Die Mindmap lesen", body: [Oben die beiden Arten, ein Moment zu erzeugen: als Kräftepaar oder als Kraft mit Hebelarm. Unten, was daraus folgt: Wer eine Kraft parallel verschiebt, braucht ein Versetzmoment, und so wird jedes System zu Kraft plus Moment in einem Punkt.]),
  "map-t1k3b": (titel: "Die Mindmap lesen", body: [Oben die Grundform in der Ebene und der Hinweis, den Bezugspunkt geschickt zu wählen. Unten links die gleichwertigen Alternativen, unten rechts der Ausblick auf den Raum.]),
  "tm1k3_ue51": (titel: "Bild lesen", body: [Ein waagerechter Stab der Länge $l$ liegt mit seinen Enden auf zwei glatten schiefen Ebenen (A links unter $alpha$, B rechts unter $beta$). Das Gewicht $G$ liegt im Abstand $x$ vom linken Ende.]),
  "tm1k3_ue52": (titel: "Bild lesen", body: [Eine Scheibe mit Radius $r$ und Gewicht $G$, belastet durch $M_0$. Stab 1 greift unten waagerecht an, Stab 2 schräg unter 45° und Stab 3 waagerecht auf Höhe des Mittelpunkts, beide zur rechten Wand.]),
  "tm1k3_ue53": (titel: "Bild lesen", body: [Zwei Walzen in einer Vertiefung, Mittelpunktabstand $a$. Ein Hebel der Länge $l$ steht schräg zwischen ihnen auf dem Boden und lehnt an beiden Walzen; oben drückt $F$ senkrecht nach unten.]),
  "tm1k3_ue54": (titel: "Bild lesen", body: [Zwei Hebel mit Lagern übersetzen die Kraft $F$ (links, Hebelarm $2b$) über Zwischenstangen auf die Probe. Die Maße $b/2$, $b/3$, $b/4$, $b/6$ geben die Hebelarme an. Oben rechts das Gegengewicht $Q$.]),
  "tm1k4_inhalt": (titel: "Bild lesen", body: [Die Gliederung: 0 Einführung, 1 Balken (Einzelkräfte, Streckenlast), 2 Flächen und Linien (Einzelkräfte, Flächenlast, Flächen-, Linienschwerpunkt), 3 Volumen. Unten ein Balken mit abschnittsweise veränderlicher Streckenlast $q(x)$ als Titelbild.]),
  "tm1k4_einzel": (titel: "Bild lesen", body: [Ein gewichtsloser Balken mit senkrechten Kräften $F_1$ bis $F_n$ an den Stellen $x_1$ bis $x_n$. Gestrichelt die Resultierende $F_R$ im Abstand $x_s$; die Haltekraft $H$ zeigt auf derselben Linie nach oben.]),
  "tm1k4_einzel_ggw": (titel: "Bild lesen", body: [Aus $sum F_y = 0$ folgt $H = sum F_i$, aus $sum M_((0)) = 0$ folgt $x_s = sum x_i F_i \/ sum F_i$. Beide Ergebnisse sind umrahmt.]),
  "tm1k4_schraeg": (titel: "Bild lesen", body: [Alle Kräfte zeigen schräg unter demselben Winkel $alpha$. $H$ und $F_R$ haben die gleiche Richtung $alpha$. In der Momentengleichung steht überall $sin alpha$, das sich kürzt.]),
  "tm1k4_bsp1a": (titel: "Bild lesen", body: [Oben der Balken mit Festlager A, Loslager B, $3F$ bei $L$ und $F$ bei $2L$. Darunter dein Freikörperbild mit $A_x$, $A_y$ (grün) und $B_y$ und die drei Gleichungen. Ergebnis: $A_x = 0$, $B = 5\/3 F$, $A_y = 7\/3 F$.]),
  "tm1k4_bsp1b": (titel: "Bild lesen", body: [Zweiter Weg: Erst $F_R = 4F$ und $x_s = 5\/4 L$ berechnen, dann den Balken mit nur einer Kraft $F_R$ freischneiden. Die Gleichungen (4)–(6) liefern dieselben Lagerkräfte. Unten rechts das Datum 17.11.25.]),
  "tm1k4_strecke": (titel: "Bild lesen", body: [Eine stetige Streckenlast $q(x)$ über die Länge $l$. Ein schmaler Streifen der Breite $dif x$ ist schraffiert: Er wirkt wie die Einzelkraft $q(x) dif x$. Die Ersatzkraft $F_R$ (gestrichelt) und die Haltekraft $H$ liegen im Schwerpunkt bei $x_s$.]),
  "tm1k4_strecke_ggw": (titel: "Bild lesen", body: [Statt Summe jetzt Integral. Umrahmt die beiden Ergebnisse: $F_R = integral q dif x$ und $x_s = integral x q dif x \/ integral q dif x$. Unten der Satz, dass die Streckenlast durch $F_R$ am Ort $x_s$ ersetzt wird.]),
  "tm1k4_konst": (titel: "Bild lesen", body: [Konstante Last $q_0$ auf einem Balken mit zwei Lagern. Die Integrale liefern $F_R = q_0 l$ und $x_s = l\/2$: die Ersatzkraft sitzt in der Mitte.]),
  "tm1k4_dreieck1": (titel: "Bild lesen", body: [Die Last fällt linear von $q_0$ links auf 0 rechts. Bevor man integrieren kann, braucht man $q(x)$: Geradengleichung $q = a + b x$ mit $q(0) = q_0$ und $q(l) = 0$ ergibt $q(x) = q_0 (1 - x\/l)$.]),
  "tm1k4_dreieck2": (titel: "Bild lesen", body: [Die Integrale ergeben $F_R = q_0 l\/2$ und $x_s = l\/3$. Unten rechts deine zwei Skizzen: Beim rechtwinkligen Dreieck liegt der Schwerpunkt bei $1\/3$ von der hohen Seite und $2\/3$ von der Spitze.]),
  "tm1k4_teilstuecke": (titel: "Bild lesen", body: [Eine Last aus Rechtecken und Dreiecken (Teile 1 bis $n$). Jedes Teil bekommt seine Ersatzkraft $F_"Ri"$ in seinem Schwerpunkt $x_"si"$. Unten die Formeln für $F_R$ und $x_s$ als Summe.]),
  "tm1k4_bereichsweise": (titel: "Bild lesen", body: [Dieselbe Last in drei Bereiche I, II, III geteilt, jeder mit eigener Funktion $q_i(x)$ von $x_"Ai"$ bis $x_"Ei"$. Über jeden Bereich wird einzeln integriert und dann summiert.]),
  "tm1k4_wzf_steigend": (titel: "Bild lesen", body: [Steigende Dreieckslast von 0 auf $q_0$ über $L$. Mit $q = q_0 x\/l$ ergibt das Verhältnis der Integrale $x_"Res" = 2l\/3$: der Schwerpunkt liegt näher an der hohen Seite.]),
  "tm1k4_wzf_fallend": (titel: "Bild lesen", body: [Spiegelbild: fallende Last von $q_0$ auf 0. Mit $q = q_0 - q_0 x\/l$ ergibt sich $x_"Res" = l\/3$.]),
  "tm1k4_wzf_flaeche": (titel: "Bild lesen", body: [Die Last als Gerade $y = m x + b$ mit $b = 0$ und Steigung $Delta y \/ Delta x = q_0 \/ L$. Blau eingetragen die Ersatzkraft $F_"Res" = 1\/2 q_0 L$ bei $x = 2\/3 L$.]),
  "tm1k4_wzf_trapez": (titel: "Bild lesen", body: [Unten ein Rechteck (1) mit Höhe $q_0$, darauf ein Dreieck (2) von 0 auf $q_0$. Rechts die Tabelle: $x_1 = 0","5 L$, $x_2 = 2\/3 L$, Flächen $q_0 L$ und $0","5 q_0 L$; Ergebnis $x_s = 0","56 L$.]),
  "tm1k4_wzf_dreiecke": (titel: "Bild lesen", body: [Eine Dachlast mit Spitze $q_0$ bei $x = L\/4$, zerlegt in Dreieck 1 (links) und Dreieck 2 (rechts). Rechts zwei Tabellen: oben allgemein (mit falschem Endwert 0,48), unten mit Zahlen (richtig 0,4167).]),
  "tm1k4_wzf_dreieck_int": (titel: "Bild lesen", body: [Zwei Geradengleichungen: $q_I = q_0 x \/ (L\/4)$ links und $q_"II" = -q_0 (x - L\/4)\/(3L\/4) + q_0$ rechts. Der Text erklärt, warum im rechten Teil $(x - L\/4)$ steht.]),
  "tm1k4_flaeche_einzel": (titel: "Bild lesen", body: [Für Kräfte auf einer Fläche gibt es drei Gleichungen: $sum F_z$ liefert $F_R$, $sum M_y$ liefert $x_s$, $sum M_x$ liefert $y_s$. Die Vorzeichen folgen der Rechtsschraubenregel.]),
  "tm1k4_flaechenlast": (titel: "Bild lesen", body: [Eine Platte in der x-y-Ebene mit Flächenlast $p(x, y)$ (rote Pfeile nach unten). Ein Flächenelement $dif A$ trägt $d F = p dif A$. Die Ersatzkraft $F_R$ und die Haltekraft $H$ greifen im Punkt $(x_s, y_s)$ an.]),
  "tm1k4_fsp": (titel: "Bild lesen", body: [Bei konstantem $p$ steht $p$ in Zähler und Nenner und kürzt sich. Übrig bleiben die umrahmten Formeln $x_s = integral x dif A \/ A$ und $y_s = integral y dif A \/ A$; blau der Hinweis $z_s = 0$.]),
  "tm1k4_statmom": (titel: "Bild lesen", body: [Definition der statischen Momente $S_x = integral y dif A$ und $S_y = integral x dif A$. Darunter die Regeln: Tabelle der Formelsammlung nutzen; im Schwerpunktsystem sind die statischen Momente null.]),
  "tm1k4_symm": (titel: "Bild lesen", body: [Eine Fläche, symmetrisch zur y-Achse. Zu jedem Element $dif A$ bei $+x$ gibt es eines bei $-x$. Deshalb ist $S_y = 0$, $x_s = 0$, und die y-Achse ist Schwerachse.]),
  "tm1k4_ksabh": (titel: "Bild lesen", body: [Dasselbe Rechteck ($b times h$) in zwei Koordinatensystemen. Mit Ursprung im Schwerpunkt: $x_s = y_s = 0$ und $S_x = S_y = 0$. Mit Ursprung in der Ecke: $overline(x)_s = b\/2$, $overline(y)_s = h\/2$ und statische Momente ungleich null.]),
  "tm1k4_zusammen1": (titel: "Bild lesen", body: [Eine Fläche aus einem Rechteck $A_i$, einem Rechteck $A_l$ und einem Dreieck $A_2$, jeweils mit eigenem Schwerpunkt. Alle Teilschwerpunkte werden im gemeinsamen x-y-System gemessen.]),
  "tm1k4_zusammen2": (titel: "Bild lesen", body: [Das Integral über die ganze Fläche wird in Integrale über die Teilflächen aufgeteilt. Jedes ergibt $x_"si" A_i$. Umrahmt die Summenformeln für $x_s$ und $y_s$.]),
  "tm1k4_aussparung": (titel: "Bild lesen", body: [Ein Rechteck mit quadratischem Loch wird gerechnet als volles Rechteck ($A_1$, Schwerpunkt $S_1$) minus Quadrat ($A_2$, Schwerpunkt $S_2$). Unten die Formel mit Minuszeichen für die „fehlenden“ Flächen.]),
  "tm1k4_fs_tabelle": (titel: "Bild lesen", body: [Die Tabelle nennt für Standardflächen Flächeninhalt und Schwerpunktlage: rechtwinkliges und beliebiges Dreieck, Parallelogramm, Trapez, Kreisausschnitt, Halbkreis, Kreisabschnitt, quadratische Parabel. Unten deine handschriftliche Ergänzung zum Kreisbogen.]),
  "tm1k4_bsp2_aufg": (titel: "Bild lesen", body: [Drei schraffierte Flächen: a) Stufenform mit Breiten $2L$, $2L$, $L$ und Höhen $L$, $L$, $2L$; b) L-Winkel $4L times 4L$ mit Dicke $L$; c) Quadrat mit Seite $c$, oben rechts um ein Dreieck mit Katheten $c\/2$ gekürzt.]),
  "tm1k4_bsp2a": (titel: "Bild lesen", body: [Teil a) mit Koordinatensystem (grün) unten links und den Teilflächen 1, 2, 3 (blau). Darunter die Tabelle mit $x_s$, $y_s$, $A_i$ und den Produkten, oben die Ergebnisse.]),
  "tm1k4_bsp2b": (titel: "Bild lesen", body: [L-Profil in zwei Teile zerlegt: 1 waagerechter Steg unten, 2 senkrechter Schenkel. Tabelle mit Summe $7L^2$ und $9","5 L^3$; Ergebnis $x_s = y_s = 1","36 L$.]),
  "tm1k4_bsp2c": (titel: "Bild lesen", body: [Teil c) in drei Teile zerlegt: 1 linke Hälfte, 2 Quadrat unten rechts, 3 Dreieck oben rechts. In der Tabelle sind beim Dreieck die Schwerpunktkoordinaten wie beim Rechteck eingesetzt (siehe Kasten im Text).]),
  "tm1k4_linie1": (titel: "Bild lesen", body: [Ein gebogener Draht im Raum mit konstanter Streckenlast $q$ nach unten. Ein Stück $dif s$ trägt $q dif s$. Die Resultierende $F_R$ greift im Linienschwerpunkt $S$ an.]),
  "tm1k4_linie2": (titel: "Bild lesen", body: [Umrahmt: $F_R = q l$ und die Integrale für $x_s$, $y_s$ über die Bogenlänge. Unten die Summenformel für Linien aus Teilstücken $l_i$.]),
  "tm1k4_draht": (titel: "Bild lesen", body: [Ein Draht: links und rechts je ein waagerechtes Stück $a$, dazwischen eine Kröpfung aus zwei senkrechten Stücken $c$ und dem oberen Stück $b$. Die y-Achse ist Symmetrieachse. Unten die Formel für $y_s$.]),
  "tm1k4_bsp3": (titel: "Bild lesen", body: [Deine Skizze mit den Schwerpunkten $S_1$ bis $S_5$ der fünf Drahtstücke und der y-Achse (grün) in der Mitte. Darunter die Lösung: $x_s = 0$ wegen Symmetrie und $y_s = (c^2 + c b)\/(2a + 2c + b)$.]),
  "tm1k4_rahmen": (titel: "Bild lesen", body: [Ein dünner Rahmen: unten gerade 5 cm, links gerade 3 cm, rechts unten ein Viertelkreis mit 3 cm Radius, oben ein Halbkreis mit 4 cm Radius. Gestrichelt die Mittellinie. Unten das Ergebnis.]),
  "tm1k4_bsp4": (titel: "Bild lesen", body: [Links die Rahmenskizze mit den Teilen 1 bis 4. Rechts die Tabelle mit Länge und Schwerpunkt jedes Teils. Darunter die Rechnung für die Kreisbögen: Bogenlänge, Abstand $a = R sin alpha \/ alpha$ und die Projektion auf x und y.]),
  "tm1k4_bsp4b": (titel: "Bild lesen", body: [Oben die Ergebnisse $x_s$ und $y_s$. Unten eingerahmt dein Merksatz: schraffiert heißt Flächenschwerpunkt, nicht schraffiert heißt Linien- oder Streckenschwerpunkt.]),
  "tm1k4_vol1": (titel: "Bild lesen", body: [Ein Körper im Raum mit einer Volumenkraft $f(x, y, z)$, die nur in eine Richtung zeigt, aber unterschiedlich stark ist. Der Schwerpunkt S hat die Koordinaten $x_s$, $y_s$, $z_s$; die Formeln unten sind ohne Beweis angegeben.]),
  "tm1k4_vol2": (titel: "Bild lesen", body: [Für die Schwerkraft ist $f = rho g$. Bei konstantem $g$ kürzt es sich, und es bleibt $integral x rho dif V \/ m$. Das ist der Massenmittelpunkt.]),
  "tm1k4_vol3": (titel: "Bild lesen", body: [Bei konstanter Dichte kürzt sich auch $rho$: $x_s = integral x dif V \/ V$. Dieser Volumenmittelpunkt ist dann zugleich der Schwerpunkt.]),
  "tm1k4_vol4": (titel: "Bild lesen", body: [Für Körper aus Teilen: Summen mit $rho_i V_i$ als Gewicht. Bei gleicher Dichte fällt $rho$ heraus. Fehlende Volumina zählen negativ.]),
  "map-t1k4a": (titel: "Die Mindmap lesen", body: [Die oberen Äste sagen, was die Ersatzkraft ist: Fläche und deren Schwerpunkt. Unten links die Abkürzungen für die zwei häufigsten Formen, unten rechts die zwei Wege für zusammengesetzte Lasten.]),
  "map-t1k4b": (titel: "Die Mindmap lesen", body: [Drei Äste zeigen dieselbe Formel mit verschiedenem Gewicht: Fläche, Länge, Masse. Der vierte Ast ist die Abkürzung, die dir oft eine Koordinate schenkt.]),
  "tm1k4_ue61": (titel: "Bild lesen", body: [Drei Profile in mm: a) T-förmig mit Fuß $45 times 4$, Steg $5 times 20$, Kopf $15 times 8$; b) wie a), aber Steg und Kopf am linken Rand; c) U-förmig aus Rechtecken mit Halbkreis rechts (Radien 30 und 20 bezogen auf die Mittelachse).]),
  "tm1k4_ue62": (titel: "Bild lesen", body: [Eine Fünfeckfläche: unten 7 breit, links 2 hoch, rechts 2 hoch, Spitze oben bei 4 über der rechten Kante. Innen ein Rechteckausschnitt $1 times 2$, 1 über dem Boden, zwischen $x = 3$ und $x = 4$.]),
  "tm1k4_ue63": (titel: "Bild lesen", body: [Eine Platte: Fuß 40 cm breit und 10 cm hoch, darauf ein Steg 20 cm breit und 50 cm hoch. Im Steg ein Kreisloch mit Durchmesser 15 cm im gesuchten Abstand $y$. Der Schwerpunkt S soll bei $y_s = 25 "cm"$ liegen.]),
  "tm1k4_ue64": (titel: "Bild lesen", body: [Drei Lasten über die Länge $L$: a) Trapez von $q_0\/2$ links auf $q_0$ rechts, b) Dach mit Spitze $q_0$ bei $L\/3$, c) Viertelsinus von 0 auf $q_0$.]),
  "tm1k5_bauteile": (titel: "Bild lesen", body: [Links die Liste der Bauteile: Stab, Balken, Bogen (gekrümmter Balken) und Rahmen (starr verbundene Balken). Rechts Beispiele: ein Bogen mit $F_1$ und $F_2$, darunter ein Rahmen aus Wand, Knick und Kragarm mit Streckenlast $q$, $F_1$, Moment $M$ und $F_2$. Alles liegt in einer Ebene, in $z$-Richtung ist der Körper unverschiebbar.]),
  "tm1k5_lager": (titel: "Bild lesen", body: [Ein Balken mit dem gelenkigen Festlager A an der Wand und einer Stütze (Stab) bei B, die als Loslager wirkt. Oben greift die Kraft $F_1$ schräg an. Die Lager halten den Balken in der Ebene fest und leiten die Kräfte in Wand und Boden.]),
  "tm1k5_freischnitt": (titel: "Bild lesen", body: [Derselbe Balken freigeschnitten: Lager A wird durch $A_x$ und $A_y$ ersetzt, der Stab B durch eine Kraft $B$ in Stabrichtung. Rechts der Stab allein mit zwei gleich großen, entgegengesetzten Kräften $B$. Grün markiert: Diese Kräfte heißen Lagerreaktionen oder Reaktionskräfte.]),
  "tm1k5_einwertig": (titel: "Bild lesen", body: [Einwertige Lager ($r = 1$, $f = 2$): Rollenlager, Pendelstab, Kontakt ohne Reibung. Gesperrt ist nur die Bewegung senkrecht zur Auflagefläche (rotes Kreuz), Verschieben längs und Drehen bleiben frei (grüne Haken). Im Freischnitt bleibt eine Kraft $A_y$.]),
  "tm1k5_zweiwertig": (titel: "Bild lesen", body: [Zweiwertige Lager ($r = 2$, $f = 1$): gelenkiges Lager, Doppelstütze, Kontakt mit Reibung $mu_0$. Beide Verschiebungen sind gesperrt, nur die Drehung ist frei. Im Freischnitt erscheinen zwei Kräfte $A_x$ und $A_y$.]),
  "tm1k5_zweiwertig2": (titel: "Bild lesen", body: [Weitere zweiwertige Lager: Parallelführung und Schiebehülse. Hier ist eine Verschiebung frei, die andere Verschiebung und die Drehung sind gesperrt. Im Freischnitt stehen deshalb eine Kraft und ein Moment ($A_x$ und $M_A$ bzw. $A_y$ und $M_A$).]),
  "tm1k5_dreiwertig": (titel: "Bild lesen", body: [Dreiwertige Lager ($r = 3$, $f = 0$): feste Einspannung oder Doppelstütze plus Pendelstab. Nichts kann sich mehr bewegen. Im Freischnitt stehen $A_x$, $A_y$ und das Einspannmoment $M_A$.]),
  "tm1k5_ggw": (titel: "Bild lesen", body: [Ein einteiliges ebenes Tragwerk ist statisch bestimmt, wenn die drei Gleichgewichtsbedingungen alle Lagerreaktionen liefern. Daneben deine Notiz mit gleichwertigen Sätzen (z. B. zwei Kräftesummen und ein Moment oder drei Momentensummen um verschiedene Punkte). Unten die Rechnung $f = 3 - sum r = 3 - 3 = 0$.]),
  "tm1k5_bsp12": (titel: "Bild lesen", body: [Beispiel 1 (Normalfall): Balken auf Festlager ($r = 2$) und Loslager ($r = 1$) mit $F$ und $q_0$; $f = 3 - (2+1) = 0$. Beispiel 2 (Flugzeugtragflügel, deine Notiz): eingespannter Balken mit Dreieckslast; im Freischnitt $A_x$, $A_y$, $M_A$ und die Ersatzkraft $F_R = q_0 l \/ 2$. Auch hier $f = 0$.]),
  "tm1k5_bsp3": (titel: "Bild lesen", body: [Beispiel 3: eine Platte mit Gewicht $G$, gehalten von drei Pendelstützen A, B, C (je $r = 1$, gelb markiert). Rechts der Freischnitt mit den drei Stabkräften. Die Rechnung $f = 3 - (1+1+1) = 0$ ist am Bildrand abgeschnitten.]),
  "tm1k5_sonderfall1": (titel: "Bild lesen", body: [Sonderfall 1: Balken auf drei Rollenlagern A, B, C, alle Kräfte senkrecht. Formal $f = 0$ (rot markiert), aber alle Lagerkräfte sind parallel. Der Balken kann sich waagerecht verschieben. Deine Notiz: Durch die waagerechte Kraft $F_3$ ist das System nicht im Gleichgewicht.]),
  "tm1k5_sonderfall2": (titel: "Bild lesen", body: [Sonderfall 2: eine Scheibe mit drei Pendelstäben A, B, C, deren Wirkungslinien sich in einem Punkt D schneiden. Formal $f = 0$, aber die Scheibe kann sich um D drehen („Schlackern“). Das System ist vorspannbar.]),
  "tm1k5_regel": (titel: "Bild lesen", body: [Gelb markiert: $f = 0$ ist notwendig, aber nicht hinreichend. Im roten Kasten die gültige Regel: statisch bestimmt bei 1) drei Reaktionskräften, die nicht alle parallel oder zentral sind, oder 2) zwei nicht parallelen Reaktionskräften und einem Moment.]),
  "tm1k5_unbestimmt": (titel: "Bild lesen", body: [Oben ein überbestimmter Balken mit Einspannung und drei Rollenlagern: $sum r = 5$, $n = 5 - 3 = 2$, also zweifach statisch überbestimmt (Berechnung in TM II). Unten ein Balken nur mit Festlager: $sum r = 2$, $n = 1$, einfach unterbestimmt, also beweglich.]),
  "tm1k5_vorgehen": (titel: "Bild lesen", body: [Das allgemeine Vorgehen: oben ein Balken mit Festlager A, Rollenlager B, Pendelstab C, Kräften $F_i$ und Momenten $M_j$. Darunter Schritt a), der Freischnitt mit den Reaktionen $A$, $B$ und $C$.]),
  "tm1k5_bsp51": (titel: "Bild lesen", body: [Beispiel 5.1: ein eingespannter Balken der Länge $l$. Auf einem Ständer im Abstand $a$ greift $F_1$ in Höhe $b$ waagerecht an, am Ende $F_2$ unter dem Winkel $alpha$. Darunter der Freischnitt mit $A_x$, $A_y$ und $M_A$.]),
  "tm1k5_bsp52": (titel: "Bild lesen", body: [Beispiel 5.2: Balken auf Festlager A und Loslager B mit vier Kräften $K_1$ bis $K_4$ (zwei davon schräg unter 75° und 60°), Abstände 1, 2, 3, 4, 1 m. Unten die Ergebnisse: $A_x = -227,65$ kN, $A_y = 507,09$ kN, $B = 442,49$ kN.]),
  "tm1k5_bsp53a": (titel: "Bild lesen", body: [Beispiel 5.3a: Balken mit Kraft $K_1$ nach unten an einem Hebel, $K_2$ schräg unter 60° und $K_3$ am Kragarm, Abstände $l$, $l$, $l$, $l\/2$ mit $l = 3$ m. Unten die Ergebnisse: $A_x = 0$, $A_y = 44,94$ kN, $B = 314,87$ kN.]),
  "tm1k5_bsp53b": (titel: "Bild lesen", body: [Beispiel 5.3b: die Tragfläche eines Sportflugzeugs als gewichtsloser Balken mit konstanter Streckenlast $q_0$, gelagert im Festlager A und gestützt durch eine schräge Pendelstütze. Gesucht sind Lagerreaktionen und später die Schnittgrößen.]),
  "tm1k5_bsp53b_fkb": (titel: "Bild lesen", body: [Deine Lösung: Gegeben $q_0$ und $L$. Im Freikörperbild ersetzt du die Streckenlast durch $q_0 L$ in der Mitte, das Festlager durch $A_x$, $A_y$ und die Stütze durch $S_1$ unter 45° mit den Komponenten $cos 45° dot S_1$ und $sin 45° dot S_1$. Unter b) prüfst du: $f = 3 - (2+1) = 0$, drei Kräfte nicht parallel und nicht zentral, also statisch bestimmt.]),
  "tm1k5_verb1": (titel: "Bild lesen", body: [Einwertige Verbindungselemente ($v = 1$): Pendelstab, Schiebegelenk, Kontakt ohne Reibung zwischen den Körpern 1 und 2. Übertragen wird nur eine Kraft: die Stabkraft $S$ bzw. die Normalkraft $N$, gegengleich an beiden Körpern.]),
  "tm1k5_verb2": (titel: "Bild lesen", body: [Zweiwertige Verbindungselemente ($v = 2$): Gelenk und Kontakt mit Reibung. Das Gelenk überträgt $G_x$ und $G_y$, der Reibkontakt $N$ und $T$, jeweils gegengleich an Körper 1 und 2. Die Drehung bleibt frei.]),
  "tm1k5_verb3": (titel: "Bild lesen", body: [Weitere zweiwertige Verbindungen: Parallelführung und Schiebehülse. Sie übertragen eine Kraft quer zur Führung und ein Moment $M_G$, eine Verschiebung bleibt frei.]),
  "tm1k5_nichtzulaessig": (titel: "Bild lesen", body: [Nicht zulässig: a) mehr als zwei Körper an einem Verbindungselement, b) zwei Körper an einem Lager. Im Beispiel: $n = 4$, $sum r = 4$, $v = 4 dot 2 = 8$. Abhilfe: das Gelenk gedanklich in mehrere Gelenke am gleichen Ort aufteilen.]),
  "tm1k5_mbest_bsp": (titel: "Bild lesen", body: [Beispiel 1: drei Körper mit Gelenken: $n = 3$, $v = 4$, $r = 5$, also $3n = 9 = v + r$. Beispiel 2: Zweigelenkbogen und gerader Balken mit Mittelgelenk: $n = 2$, $v = 2$, $r = 4$, also $6 = 6$. Grüne Haken: Bedingung erfüllt.]),
  "tm1k5_mbest_sonder": (titel: "Bild lesen", body: [Beide Fälle erfüllen die Zählbedingung. Der Dreigelenkbogen ist der Normalfall: bestimmt, nicht vorspannbar, nicht beweglich. Der gerade Balken mit Mittelgelenk ist der Sonderfall: unbestimmt, waagerecht vorspannbar („klemmt“) und senkrecht infinitesimal beweglich („wackelt“).]),
  "tm1k5_mfreischnitt": (titel: "Bild lesen", body: [Alle Teile freigeschnitten: die Gelenkkräfte $G_x$, $G_y$ und die Kräfte $C_x$, $C_y$ erscheinen an beiden Nachbarteilen gegengleich. Achtung: Jede äußere Kraft $F_i$ und jedes Moment $M_j$ gehört zu genau einem Bauteil.]),
  "tm1k5_bsp54": (titel: "Bild lesen", body: [Beispiel 5.4: Balken 1 mit Kraft $F$ am linken Ende, Loslager B und Gelenk G, daran der Winkel 2 mit der Einspannung A unten. Abstände $a$, $b$, $c$, Höhe $h$.]),
  "tm1k5_bsp54_fs": (titel: "Bild lesen", body: [a) Freischnitt: Balken 1 mit $F$, $B$ und den Gelenkkräften $G_x$, $G_y$; Winkel 2 mit den gegengleichen $G_x$, $G_y$ und $A_x$, $A_y$, $M_A$. b) Prüfung: $n = 2$, $v = 2$, $r = 1 + 3 = 4$, also $3n = 6 = v + r$.]),
  "tm1k5_pkw": (titel: "Bild lesen", body: [Beispiel 5.5: Auto mit Anhänger. Anhänger 5 kN, Auto 15 kN. Rot die Achslasten: A = 4 kN, H = 8,9 kN, V = 7,1 kN. Abstände 0,25 m, 1 m, 1 m, 1,4 m, 1,4 m.]),
  "tm1k5_pkw_fs": (titel: "Bild lesen", body: [a) Freischnitt: Anhänger mit 5 kN, $A_y$ und den Kupplungskräften $G_x$, $G_y$; Auto mit 15 kN, gegengleichen $G_x$, $G_y$, Hinterachse $H_x$, $H_y$ und Vorderachse $V_y$.]),
  "tm1k5_rahmen": (titel: "Bild lesen", body: [Beispiel 5.6: Rahmen aus den Teilen 1 (Stütze und Riegel, Festlager A) und 3 (Schrägstab zum Festlager B), verbunden im Gelenk G. Belastung: Streckenlast $q_0 = F\/a$ auf dem Riegel, Kraft $F$ bei C, Höhe $b = 3\/4 a$. Ergebnisse: $A_x = 2\/7 F$, $A_y = 2\/7 F$, $B_x = 5\/7 F$, $B_y = 5\/7 F$, $G_x = -5\/7 F$, $G_y = 5\/7 F$.]),
  "tm1k5_rahmen_mit": (titel: "Bild lesen", body: [Deine Mitschrift dazu: Teil 1 mit $F_1$, der Ersatzkraft $F_t$ in der Mitte des Riegels, $A_x$, $A_y$ und den Gelenkkräften $G_x$, $G_y$ ($v = 2$). Teil 2 als Schrägstab mit gegengleichen $G_x$, $G_y$ und $B_x$, $B_y$ ($r = 2$). Maße $3\/4 a$ und $a$.]),
  "tm1k5_einfrier1": (titel: "Bild lesen", body: [Ausgangspunkt des Einfrierprinzips: ein Rahmen aus fünf Teilen mit vielen Gelenken: $n = 5$, $v = 12$, $r = 4$. Es gilt $3n = 15 != v + r = 16$, das System ist statisch überbestimmt.]),
  "tm1k5_einfrier2": (titel: "Bild lesen", body: [a) Das Dreieck aus vier Teilen (links: $n = 4$, $v = 10$, $r = 3$, $12 != 13$) wird als eine starre Scheibe betrachtet (rechts: $n = 1$, $v = 0$, $r = 3$, $3 = 3$). Ein starres Teilsystem darf man wie einen Körper behandeln.]),
  "tm1k5_einfrier3": (titel: "Bild lesen", body: [Das Gesamtsystem mit eingefrorener Scheibe: Scheibe plus Stütze, $n = 2$, $v = 2$, $r = 4$, $3n = 6 = v + r$. Damit sind alle äußeren Lager- und Verbindungsreaktionen bestimmbar.]),
  "tm1k5_einfrier4": (titel: "Bild lesen", body: [b) Gleichgewicht am ganzen System: Mit $sum F_x$, $sum F_y$ und $sum M_((A))$ folgen $B_y = F\/2$ und $A_y = F\/2$. $A_x$, $B_x$, $G_x$, $G_y$ bleiben noch offen (Fragezeichen).]),
  "tm1k5_einfrier5": (titel: "Bild lesen", body: [Vollständige Lösung: Scheibe und Stütze getrennt freigeschnitten, an jedem Teil drei Gleichungen. Insgesamt 6 Gleichungen für 6 Unbekannte; die 3 Gleichungen am Gesamtsystem sind zusätzlich und dienen als Kontrolle.]),
  "tm1k5_dgb1": (titel: "Bild lesen", body: [Ausgangspunkt: ein Rahmen mit einem Festlager und einem Loslager ist statisch bestimmt ($n = 1$, $r = 3$) und gibt nach (gestrichelt). Mit zwei Festlagern ist er überbestimmt ($n = 1$, $r = 4$, rotes Kreuz).]),
  "tm1k5_dgb2": (titel: "Bild lesen", body: [Dreigelenkbogen: Ein zusätzliches Gelenk G im Riegel macht den Rahmen mit zwei Festlagern wieder bestimmt: $n = 2$, $r = 4$, $v = 2$, $3n = 6 = r + v$. Unten der Freischnitt beider Hälften mit $A$, $B$ und den gegengleichen Gelenkkräften $G_x$, $G_y$.]),
  "tm1k5_gerber1": (titel: "Bild lesen", body: [Ausgangspunkt: Ein langer Balken auf zwei Lagern ist bestimmt, biegt sich aber stark durch ($n = 1$, $r = 3$). Mit zusätzlichen Lagern wird er überbestimmt ($n = 1$, $r = 5$, rotes Kreuz).]),
  "tm1k5_gerber2": (titel: "Bild lesen", body: [Gerberträger (Gelenkbalken): Zwei zusätzliche Gelenke $G_1$, $G_2$ machen ihn wieder bestimmt: $n = 3$, $r = 5$, $v = 4$, $3n = 9 = r + v$. Rechts unten der Freischnitt der drei Teile mit den gegengleichen Gelenkkräften.]),
  "tm1k5_bsp57": (titel: "Bild lesen", body: [Beispiel 5.7: Gerberträger aus dem gewichtslosen Teil I (Lager A, Kraft $F = 500$ kN) und dem schweren Teil II ($G_(I I) = 1000$ kN, Lager B und C), verbunden im Gelenk. Abstände $l$, $l$, $l$, $3l$ mit $l = 2$ m. Ergebnisse: A = 250 kN, B = 1000 kN, C = 250 kN, G = 250 kN.]),
  "tm1k5_bsp57_fs": (titel: "Bild lesen", body: [Dein Freischnitt: Teil I mit 500 kN in der Mitte, $A_y$ ($r = 1$) und den Gelenkkräften $G_x$, $G_y$ ($v = 2$). Teil II mit 1000 kN, gegengleichen Gelenkkräften, $B_y$ ($r = 1$) und $C_x$, $C_y$ ($r = 2$). Unten die Maße 2, 6 bzw. 4, 4, 8 m.]),
  "tm1k5_ue71": (titel: "Bild lesen", body: [Balken auf Festlager A und Loslager B, Länge $3a$. Belastung: $F_1$ senkrecht über A, $F_2$ schräg unter dem Winkel $alpha$ bei $a$, Streckenlast $q_0$ von $a$ bis $2a$, $F_3$ bei $2a$ und das Moment $M_0$ am Ende B.]),
  "tm1k5_ue72": (titel: "Bild lesen", body: [a) Winkel mit Festlager A, Loslager B (Abstand $a$) und senkrechtem Arm der Höhe $c$ im Abstand $b$, oben greift $F$ waagerecht an. b) Ein Körper mit zwei Pendelstäben links und Loslager B rechts; $F$ wirkt oben links waagerecht und rechts senkrecht. Maße $a$, $2a$, $a$.]),
  "tm1k5_ue73": (titel: "Bild lesen", body: [Ein Rahmen aus Riegel ($2a$) und zwei Stützen. Lager A (Festlager) sitzt links in Höhe $2a$ unter dem Riegel, Lager B (Loslager) rechts $a$ tiefer. $F_1$ greift waagerecht oben links an, $F_2$ schräg unter $alpha$ oben rechts.]),
  "tm1k5_ue74": (titel: "Bild lesen", body: [Eingespannter Winkel A: senkrechte Stütze der Höhe $a$ mit waagerechter Streckenlast $q_1$, waagerechter Kragarm der Länge $b$ mit $q_2$. $F_1$ wirkt im Abstand $c$, $F_2$ am Ende des Kragarms.]),
  "tm1k5_ue75": (titel: "Bild lesen", body: [Ein Träger mit Festlager A unten links, schrägem Stab nach oben rechts, waagerechtem Teil mit Streckenlast $q$ über $2a$ und einem senkrechten Arm bis zum Loslager B (waagerecht verschieblich gehalten) oben rechts. $F_1$ wirkt waagerecht am Knick, $F_2$ senkrecht am Ende. Höhen $a$, $a$, Längen $a$, $2a$.]),
  "tm1k5_ue76": (titel: "Bild lesen", body: [Ein Stufentragwerk: links Teil AB–C mit Streckenlast $q_0$ (Gelenk C), daran die Stufe C–D, oben Riegel D–E mit $q_0$ bis zum Lager E, rechts die Stütze E–F. Lager A, B, E, F sind seitlich gehalten. Maße $a$, $a$, Höhen $a$ und $2a$.]),
  "tm1k5_ue81": (titel: "Bild lesen", body: [Die Musterlösung schneidet beide Rahmenhälften frei. Teil 1: Resultierende $R$, Lagerkräfte $A_H$, $A_V$, Gelenkkräfte $C_H$, $C_V$. Teil 2: $R$, $B_H$, $B_V$ und die gegengleichen $C_H$, $C_V$.]),
  "tm1k5_ue82": (titel: "Bild lesen", body: [Teil 1: senkrechter Stab mit Resultierender $R$ in der Höhe $s$, oben $B_H$, $B_V$, unten $C_H$, $C_V$. Teil 2: Schrägbalken mit Moment $M_0$, links die gegengleichen $B_H$, $B_V$, rechts die Einspannung mit $A_H$ und $M_A$.]),
  "map-t1k5a": (titel: "Die Mindmap lesen", body: [In der Mitte das einteilige Tragwerk (ein Bauteil). Die vier Äste: Die Wertigkeit eines Lagers zählt die gesperrten Bewegungen; mit $f = 3 - sum r$ prüfst du, ob $f = 0$ ist; Sonderfälle mit parallelen oder zentralen Reaktionen sind trotzdem unbestimmt; das Rezept lautet freischneiden, zählen, Gleichgewicht, lösen.]),
  "map-t1k5b": (titel: "Die Mindmap lesen", body: [In der Mitte das mehrteilige Tragwerk (mehrere Bauteile). Die Äste: Gelenke übertragen zwei Kräfte, Pendelstäbe eine; $3n = v + r$ ist notwendig; mit dem Einfrierprinzip behandelst du starre Teilsysteme wie einen Körper; Dreigelenkbogen und Gerberträger sind die typischen Beispiele.]),
  "tm1k6_def": (titel: "Bild lesen", body: [Links die Definition, rechts das Beispiel: ein Brückenfachwerk aus 11 Stäben (arabische Zahlen) und 7 Knoten (römische Zahlen) mit Festlager in I, Loslager in VII und den Kräften $F_1$ (an IV), $F_2$ (an VI), $F_3$ (an III). Deine Notizen: an jedem Knoten die Gelenkzahl $v$ (2, 4 oder 6), unten links die Zählung $3n = 33 = v + r$, oben rechts eine Skizze, wie ein Knoten mit drei Stäben in zwei Gelenke zerfällt.]),
  "tm1k6_nichtfw": (titel: "Bild lesen", body: [Oben links ein Dreieck, bei dem die Kraft $F$ mitten auf einem Stab angreift – das ist kein Fachwerk. Rechts ein freigeschnittener Knoten III mit vier Stabkräften $S_1$, $S_3$, $S_4$, $S_5$ (grün) und der äußeren Kraft $F_3$ (rot). Alle Pfeile gehen durch einen Punkt.]),
  "tm1k6_bedingung": (titel: "Bild lesen", body: [Die Herleitung von $2k = s + r$ (gelb umrandet) und das Zählbeispiel $k = 7$, $s = 11$, $r = 3$: 14 Gleichungen, 14 Unbekannte. Deine Notiz darüber: Bei Fachwerken wird das verwendet, nicht mehr $3n = v + r$.]),
  "tm1k6_unbestimmt": (titel: "Bild lesen", body: [Oben Beispiel 1: links ein Rechteck mit zwei gekreuzten Diagonalen 3 und 4 (gelb markiert, ohne Verbindung), rechts ein Feld ohne Diagonale (gestrichelt die mögliche Bewegung). Unten Beispiel 2: Knoten VI liegt genau zwischen den Stäben 5 und 6 auf einer Linie (gestrichelt verschoben). Beide Male $2k = 12 = s + r$, trotzdem nicht statisch bestimmt.]),
  "tm1k6_bg1": (titel: "Bild lesen", body: [Ein Parallelogramm aus zwei Dreiecken: unten Stab ① (schwarz), dann die Zweischläge ② und ③ (blau), dazu die Lager ④ (grün): Festlager unten links, waagerecht verschiebliches Lager oben rechts.]),
  "tm1k6_bg2": (titel: "Bild lesen", body: [Zwei Fachwerke FW1 (links) und FW2 (rechts), verbunden durch drei blaue Stäbe ②, die weder parallel sind noch sich in einem Punkt schneiden. Grün die Lager ③: ein Festlager unter FW1, ein Loslager unter FW2.]),
  "tm1k6_bg2b": (titel: "Bild lesen", body: [FW1 und FW2 hängen nur an einem gemeinsamen Knoten ② (blau). Dafür bekommen beide ein Festlager ③ – zusammen $r = 4$.]),
  "tm1k6_bg2c": (titel: "Bild lesen", body: [FW1 und FW2 sind durch einen gemeinsamen Knoten ② oben und einen zusätzlichen blauen Stab ② unten verbunden. Lager ③: Festlager links, Loslager rechts, $r = 3$.]),
  "tm1k6_bg3": (titel: "Bild lesen", body: [Ein Fachwerk aus einem großen Trapez ① und einem kleinen Dreieck. Der rot durchgestrichene Stab ② wird entfernt, der grün gestrichelte Stab ③ an anderer Stelle eingefügt. Das Fachwerk bleibt starr.]),
  "tm1k6_mit_vorgehen": (titel: "Bild lesen", body: [Deine Überschrift „6.3 Bestimmung der Stabkräfte“, dann a) Fachwerk einfrieren und Lagerreaktionen bestimmen (kleine Lagersymbole), b) Nullstäbe bestimmen mit dem gelben Hinweis auf die Formelsammlung, darunter deine Bemerkung zu a) und b).]),
  "tm1k6_mit_stab": (titel: "Bild lesen", body: [Oben zwei Knoten, verbunden durch Stab 3, an jedem hängen zwei weitere Stäbe (1, 2 bzw. 4, 5). Darunter die zwei Knoten mit den grünen Stabkräften und der Stab 3 allein mit $S_3$ an beiden Enden. In der Klammer: $Sigma F_x = 0$: $S_3 = S_3$, $Sigma F_y = 0$: $0 = 0$, $Sigma M = 0$: $0 = 0$. Rechts: Stab kann man weglassen, nur Knoten rechnen. Unten die Vorzeichenregel Zug/Druck.]),
  "tm1k6_mit_ggw": (titel: "Bild lesen", body: [d) 2 GGW-Bedingungen an jedem Knoten: $Sigma F_x = 0$ und $Sigma F_y = 0$; $Sigma M = 0$ ist nicht sinnvoll und nötig; GGW am Stab nicht nötig. Ergebnis: $2 dot k$ Gleichungen (Anzahl Knoten) für $r + s$ Unbekannte (Lagerreaktionen und Stäbe). Unten e) Gleichungssystem lösen.]),
  "tm1k6_mit_nullregeln": (titel: "Bild lesen", body: [Drei Regeln mit je einer kleinen Skizze (Stäbe als Rechtecke, rote Kraftpfeile): ① unbelasteter Knoten mit 2 Stäben im Winkel → $S_1 = S_2 = 0$. ② Knoten mit 2 Stäben und Kraft $F$ in Richtung von Stab 1 → $S_2 = 0$, $S_1 = F$ („genau“ gelb markiert). ③ Knoten mit 3 Stäben, 1 und 2 auf einer Linie → $S_3 = 0$, $S_1 = S_2$.]),
  "tm1k6_mit_bemerkung": (titel: "Bild lesen", body: [Oben zu Regel 1: Ein Fachwerk mit Lagern A, B und Last $F$ an Knoten II; die Stäbe 6 und 7 am Knoten VI sind rot als Nullstäbe durchgestrichen. Daneben dasselbe Fachwerk ohne diese Stäbe. Darunter zu Regel 2 und 3: dasselbe Fachwerk mit einer Kraft $F$ waagerecht an VI – jetzt sind die Stäbe 6 und 7 nötig.]),
  "tm1k6_mit_bsp": (titel: "Bild lesen", body: [Das Beispiel: Knoten I oben rechts mit Kraft $F$ nach unten, II oben, IV und III in der Mitte, V (Festlager A) und VI (Loslager B) unten. Stäbe ① bis ⑨ eingekreist, Maße $a$, $a$ waagerecht und senkrecht. Darunter deine Lösung: Aufbau nach dem 1. Bildungsgesetz, $s = 9$, $k = 6$, $r = 3$, $2 dot 6 = 12 = 9 + 3$ ✓.]),
  "tm1k6_mit_lager": (titel: "Bild lesen", body: [Das Fachwerk ist blau schraffiert, also eingefroren. Rot die Lagerkräfte $A_x$, $A_y$, $B_y$ und die Last $F$, daneben das x-y-System. Darunter die drei Gleichungen mit den Ergebnissen $A_x = 0$, $B = 2F$ und $A_y = -F$ (doppelt unterstrichen).]),
  "tm1k6_mit_nulltab": (titel: "Bild lesen", body: [Eine kleine Tabelle „Nullstäbe“: Regel 1 – keiner (Strich), Regel 2 – Stäbe 9 und 7, Regel 3 – keiner (Strich).]),
  "tm1k6_mit_knoten": (titel: "Bild lesen", body: [Ein Foto von der Tafel bzw. dem Tablet: alle sechs Knoten einzeln mit ihren Stabkräften $S_1$ bis $S_8$, alle vom Knoten weg gezeichnet. Unten links Knoten „VI“ mit $A_y = A$, unten rechts Knoten „V“ mit $B$; die Last $F$ (rot) an Knoten I.]),
  "tm1k6_mit_ggw_knoten": (titel: "Bild lesen", body: [Für die Knoten I bis VI je $Sigma F_x = 0$ und $Sigma F_y = 0$ mit den Komponenten $S_i dot 1\/sqrt(2)$ der schrägen Stäbe. Bei V und VI ist die x-Gleichung leer (Strich), weil dort nur senkrechte Kräfte wirken.]),
  "tm1k6_mit_tabelle": (titel: "Bild lesen", body: [Oben die Stabkrafttabelle $S_1$ bis $S_9$: $F$, $-sqrt(2) F$, $-F$, $sqrt(2) F$, $-F$, $F$, 0 (rot eingekreist), $-2F$, 0 (rot eingekreist). Darunter die Auflösung Knoten für Knoten: I liefert $S_2$ und $S_1$, II liefert $S_4$ und $S_3$, III liefert $S_5$.]),
  "tm1k6_mit_rest": (titel: "Bild lesen", body: [Die letzten zwei Gleichungen: $S_6 = -A_y = F$ und $S_8 = -B = -2F$. Dann: + bedeutet Zugstäbe, − Druckstäbe. Unten: Nicht alle Knoten-GGW verwendet, da Nullstäbe und Lagerreaktionen vorab bestimmt.]),
  "tm1k6_bsp1": (titel: "Bild lesen", body: [Beispiel 1 der Folie: das gleiche Fachwerk wie in deiner Mitschrift mit $F = 3$ MN und 3 m Kantenlänge. Unten die Ergebnistabelle in MN: 3,00 / −4,24 / −3,00 / 4,24 / −3,00 / 3,00 / 0,00 / −6,00 / 0,00.]),
  "tm1k6_bsp2": (titel: "Bild lesen", body: [Ein liegendes Fachwerk der Höhe $l$ aus drei Feldern der Breite $2l$: oben die Knoten I, III, V, VII, unten II, IV, VI, VIII. Festlager in II, Loslager in VIII, Kraft $F$ an V. Darunter die Zählung $k = 8$, $s = 13$, $r = 3$ → $16 = 16$.]),
  "tm1k6_bsp2_lager": (titel: "Bild lesen", body: [Das Fachwerk als eingefrorenes Rechteck mit den grünen Lagerkräften $A$, $B_x$, $B_y$ und der Last $F$. Die drei Gleichungen liefern $B_x = 0$, $B_y = 2\/3 F$ und $A = 1\/3 F$.]),
  "tm1k6_bsp2_null": (titel: "Bild lesen", body: [Oben die Nullstäbe nach Regel 1 ($S_10$, $S_13$), Regel 2 ($S_4$) und Regel 3 ($S_5$, $S_9$). Darunter alle acht Knoten freigeschnitten, grün die Stabkräfte, an II die Lagerkraft $1\/3 F$, an VIII $2\/3 F$, an V die Last $F$.]),
  "tm1k6_bsp2_ggw1": (titel: "Bild lesen", body: [Die Gleichungen an den Knoten I bis IV mit $cos alpha$ und $sin alpha$ für die schrägen Stäbe; daneben die Knotenskizzen. An II folgt $S_4 = 0$ (Nullstab), an III $S_5 = 0$.]),
  "tm1k6_bsp2_ggw2": (titel: "Bild lesen", body: [Die Gleichungen an den Knoten V bis VIII. In eckigen Klammern die schon bekannten Nullstäbe $S_10 = 0$, $S_9 = 0$, $S_13 = 0$. An VIII wirkt $2\/3 F$ nach oben.]),
  "tm1k6_bsp2_loesung": (titel: "Bild lesen", body: [Die Auflösung in der Reihenfolge II, I, I, III, IV, IV, V, VI mit den Ergebnissen für $S_1$, $S_3$, $S_2$, $S_6$, $S_7$, $S_8$, $S_11$, $S_12$. Rechts ein Dreieck mit den Seiten $2l$, $l$ und $sqrt(5) l$ für $cos alpha = 2\/sqrt(5)$ und $sin alpha = 1\/sqrt(5)$.]),
  "tm1k6_bsp2_tabelle": (titel: "Bild lesen", body: [Die Stabkrafttabelle für die Stäbe 1 bis 13 als Vielfache von $F$, darunter: + Zugstäbe, − Druckstäbe. Nicht alle Knoten-GGW wurden benutzt.]),
  "tm1k6_ritter1": (titel: "Bild lesen", body: [Links ein Fachwerk mit Lagern A und B oben, Höhe $b$, drei Felder $a$, Last $F$ an D. Rote Schnittmarken an den Stäben 1, 2, 3. Rechts die beiden Teile „links“ (mit $A_x$, $A_y$) und „rechts“ (mit $F$, $B$), an beiden die grünen Stabkräfte $S_1$, $S_2$, $S_3$ entgegengesetzt. C ist der untere Knoten links vom Schnitt.]),
  "tm1k6_ritter1_rech": (titel: "Bild lesen", body: [Rechts das rechte Teilfachwerk mit $S_1$, $S_2$, $S_3$, $F$ und $B$; der Punkt C liegt links außerhalb (gestrichelt verlängert). Links die Gleichungen $Sigma M_((C))$, $Sigma M_((D))$ und $Sigma F_y$ mit den Ergebnissen für $S_1$, $S_3$, $S_2$ und $tan alpha = b\/a$.]),
  "tm1k6_ritter2": (titel: "Bild lesen", body: [Ein Kragfachwerk an der Wand (Lager A und B links), Last $F$ an der Spitze rechts, rote Schnittmarken an drei Stäben. Rechts das abgeschnittene Spitzenstück mit $S_1$, $S_2$, $S_3$ und $F$ – ohne Lagerkräfte.]),
  "tm1k6_ritter3": (titel: "Bild lesen", body: [Ein Dachbinder mit Lagern A und B und Last $F$ an der Spitze P. Der Schnitt geht durch den Knoten P und den Untergurt 1. Rechts das rechte Teil mit $S_a$, $S_b$ (beide durch P), $S_1$ und $B$.]),
  "tm1k6_ue83": (titel: "Bild lesen", body: [Ein auf die Spitze gestelltes Quadrat mit den Ecken I (oben), II (rechts), III (unten), IV (links) und einer waagerechten Diagonale IV–II. Bei IV die Lagerkräfte $A_H$ und $A_V$ (grün), bei III eine Lagerkraft nach oben. Rot: $2F$ waagerecht an I, $F$ nach unten an II. Bei IV ist der Winkel 45° eingetragen.]),
  "tm1k6_ue84": (titel: "Bild lesen", body: [Ein Quadrat III–II–IV–V mit der Diagonale 5 (III–IV), darüber ein spitzes Dreieck zum Knoten I oben rechts (Stäbe 1 und 2). $F_1$ wirkt an I nach unten, $F_2$ an II nach rechts. Unten links bei V die Lagerkraft (grün).]),
  "tm1k6_ue91": (titel: "Bild lesen", body: [Ein Fachwerk über drei Felder $2a$ und Höhe $a$: unten I (Festlager A), III, V, VI (Loslager B); oben II und IV. $2F$ wirkt an III nach unten, $F$ an IV nach rechts. Stäbe 1 bis 9.]),
  "map-t1k6a": (titel: "Die Mindmap lesen", body: [In der Mitte das Fachwerk. Die Äste: gerade Stäbe mit gelenkigen Knoten; Lasten nur in den Knoten; $2k = s + r$ ist nur notwendig; nach den drei Bildungsgesetzen gebaut ist es starr und statisch bestimmt.]),
  "map-t1k6b": (titel: "Die Mindmap lesen", body: [In der Mitte die Stabkräfte. Die Äste: Knotenpunktverfahren mit 2 Gleichungen je Knoten; Nullstäbe nach 3 Regeln; Ritter-Schnitt durch 3 Stäbe; Vorzeichen: vom Knoten weg gezeichnet ist Zug positiv, Druck negativ.]),
  "tm1k7_einfuehrung": (titel: "Bild lesen", body: [Oben ein Balken mit $F_1$, $M_0$, $F_2$ und $q(x)$, an der Stelle $S$ (Abstand $x$) geschnitten. Am linken Teil zeigen $N$ nach rechts, $Q$ nach unten, $M$ gegen den Uhrzeigersinn; am rechten Teil jeweils umgekehrt. Darunter die Liste $N$, $Q$, $M$ als Funktionen von $x$. Im roten Kasten deine Notiz „$d Q\/d x = q$“ (Vorzeichen fehlt, richtig $-q$) und „$d M\/d x = Q$“.]),
  "tm1k7_vorzeichen": (titel: "Bild lesen", body: [Oben rechts das neue System: $x$ nach rechts, $z$ nach unten, $y$ aus der Ebene, $+M$ als Pfeil. In der Mitte deine Tafelskizze der zwei Schnittufer: links das positive Ufer (+) mit $N$ nach rechts und $Q$ nach unten, rechts das negative Ufer (−) mit $N$ nach links und $Q$ nach oben. Unten im Kasten die Vorzeichenregel.]),
  "tm1k7_einzelkraefte": (titel: "Bild lesen", body: [Oben der Balken $A$–$B$ (Länge $l$) mit Kräften $F_i$ bei $a_i$ und Momenten $M_j$ bei $b_j$. Unten das Freikörperbild mit $A_x$, $A_z$, $B_z$ und den Feldern I–V (rote Kreise); deine Notiz rechts: $A_x = 0$, $A_z = A$.]),
  "tm1k7_freischnitte": (titel: "Bild lesen", body: [Drei Zeilen 3I, 3II, 3V: Jede zeigt denselben Balken, an einer anderen Stelle $x$ geschnitten. Links steht der linke Teil mit dem positiven Ufer (+), rechts der rechte Teil mit dem negativen Ufer (−). Die Schnittgrößen (grün) zeigen an beiden Ufern entgegengesetzt.]),
  "tm1k7_verlauf_einzel": (titel: "Bild lesen", body: [Oben der Balken mit Feldern I–V. In der Mitte $Q(x)$: Treppe, die bei $A$ hochspringt, an jedem $F$ nach unten springt und bei $B$ auf null zurückgeht. Unten $M(x)$: Geradenstücke mit Knick an jeder Kraft und senkrechten Sprüngen an $M_1$ und $M_j$; $M = 0$ an beiden Enden.]),
  "tm1k7_bsp1": (titel: "Bild lesen", body: [Balken $A$–$B$ mit schräger Kraft $sqrt(2) F$ unter 45° bei $x = a$. Darunter die Zerlegung in $F$ senkrecht und $F$ waagerecht (nach links). Rechts die Gleichgewichte: $A_x = F$, $B = F a\/l$, $A_z = F(1 - a\/l)$; unten die zwei Abschnitte I und II.]),
  "tm1k7_bsp1_verlauf": (titel: "Bild lesen", body: [Drei Verläufe untereinander. $N$: im Feld I negativ ($-F$), danach null. $Q$: positiv $A_z$ bis $x = a$, dann Sprung um $F$ auf $-B$. $M$: Dreieck mit Spitze $M_(max) = F(1 - a\/l) a$ unter der Kraft, null an den Lagern.]),
  "tm1k7_bsp2": (titel: "Bild lesen", body: [Balken mit Lager $A$ am linken Ende (überträgt waagerechte Kraft und Moment, keine Vertikalkraft), Loslager $B$ bei $x = a$ und Kraft $F$ am Kragende $x = l$. Darunter das Freikörperbild mit $A$, $M_A$, $B$ und rechts die Gleichgewichte: $A = 0$, $M_A = -F(l - a)$, $B = F$.]),
  "tm1k7_bsp2_verlauf": (titel: "Bild lesen", body: [$N$ ist überall null. $Q$ ist im Feld I null und springt bei $B$ auf $+F$. $M$ ist im Feld I konstant $-F(l - a)$ (negativ, unter der Achse) und steigt im Feld II linear auf null am Kragende.]),
  "tm1k7_streckenlast": (titel: "Bild lesen", body: [Balken $3a$ mit einer Dreieckslast von $x = a$ (null) bis $x = 2a$ ($q_0$). Die Felder I, II, III sind markiert. Die Gesamtresultierende $F_R$ sitzt bei $x_R = frac(5, 3) a$. Unten: $F_R$ nur für Lagerreaktionen und für Felder I, III verwenden.]),
  "tm1k7_teilres": (titel: "Bild lesen", body: [Schnitt im Feld II: Links bleibt nur ein Teil der Dreieckslast mit Höhe $q'$. Dessen Teilresultierende $F_R '$ greift bei $x_R '$ an. Rechts die Formeln für $q'$, $F_R '$ und $x_R '$; unten die Gleichgewichte für $Q(x)$ und $M(x)$ im Feld II.]),
  "tm1k7_bsp3_verlauf": (titel: "Bild lesen", body: [Einfeldbalken mit $q_0$ über die ganze Länge. $Q$ fällt als Gerade von $A = frac(1, 2) q_0 l$ auf $-B$, Nullstelle in der Mitte. $M$ ist eine nach unten offene Parabel mit $M_(max) = q_0 l^2\/8$ in der Mitte; RB1 und RB2: $M = 0$ an den Lagern.]),
  "tm1k7_mitschrift_bsp3": (titel: "Bild lesen", body: [Deine Handskizze: oben der Balken mit $q$, $A_x$, $A_z$, $B_z$. Darunter $Q$ als fallende Gerade von $+q L\/2$ auf $-q L\/2 = Q_min$, dann $M$ als Bogen („Parabel 2. Ordnung“) mit $M_max = q L^2\/8$. Unten eingeklebt die Rechnung $Q = 0 => x = l\/2$.]),
  "tm1k7_bsp4": (titel: "Bild lesen", body: [Balken $A$–$B$ mit Feldlängen $l$, $l$, $l$, $l\/2$. $K_1$ wirkt waagerecht nach links an einem Hebel unter dem Balken bei $x = l$, $K_2$ schräg unter 60° bei $2l$, $K_3$ senkrecht am Kragende.]),
  "tm1k7_bsp4_verlauf": (titel: "Bild lesen", body: [Drei schraffierte Verläufe. $N$: $+150$ kN zwischen $l$ und $2l$, sonst null. $Q$: $+"44,94"$ kN, dann $-"214,87"$ kN, auf dem Kragarm $+100$ kN. $M$: Anstieg auf $"134,82"$ kNm, Sprung auf $"359,82"$ kNm (Moment aus dem Hebel von $K_1$), Spitze $"494,64"$ kNm bei $2l$, Abfall auf $-150$ kNm über $B$ und zurück auf null.]),
  "tm1k7_balkenstueck": (titel: "Bild lesen", body: [Links der Text, rechts deine Tafelskizze: ein Balkenstück von $A$ bis $B$ mit beliebiger Streckenlast $q(x)$ (rot), an den Enden $Q_A$, $M_A$, $Q_B$, $M_B$. Schraffiert ein kleines Element $d x$, das auf der nächsten Folie freigeschnitten wird.]),
  "tm1k7_element": (titel: "Bild lesen", body: [Das Element $d x$ mit Last $q(x)$: links $Q(x)$, $M(x)$ am negativen Ufer (−), rechts $Q + d Q$, $M + d M$ am positiven Ufer (+). Darunter die zwei Gleichgewichte mit den umrahmten Ergebnissen $d Q\/d x = -q(x)$ und $d M\/d x = Q(x)$.]),
  "tm1k7_fs_rb": (titel: "Bild lesen", body: [Tabelle aus der Formelsammlung: fünf Lagerarten in Zeilen (Parallelführung, Fest-/Loslager, Schiebehülse, feste Einspannung, freies Ende), daneben $Q(x_(R B))$ und $M(x_(R B))$. Rot und „= 0“ sind nur die verwertbaren RB.]),
  "tm1k7_lager_lokal": (titel: "Bild lesen", body: [Kragarm mit Einspannung $A$ und Streckenlast. Rechts ein winziges Stück direkt an der Einspannung (Länge „0“) mit $A_x$, $M_A$, $Q(x = 0)$ und $M(x = 0)$. Unten: $A_x = 0$ und $M_A = -M_0 - M(x = 0)$.]),
  "tm1k7_bsp3_lager": (titel: "Bild lesen", body: [Zwei winzige Randstücke von Beispiel 3: links mit $A$ und $Q(x = 0)$, rechts mit $B$ und $Q(x = l)$. Daraus $A = Q(0) = q_0 l\/2$ und $B = -Q(l) = q_0 l\/2$.]),
  "tm1k7_ueb_felder": (titel: "Bild lesen", body: [Zwei Beispielbalken. Oben a): $q_0$ nur auf dem linken Teil → Felder I und II. Unten b): Einzelkraft $F_1$, ein Lager in der Mitte und $F$ am Kragende → Felder I, II, III. Die Feldgrenzen sind als senkrechte Striche markiert.]),
  "tm1k7_ueb_mehrteilig": (titel: "Bild lesen", body: [Oben c): Balken mit Einspannung, Kraft $F$, Lager, Gelenk und $q_0$ → vier Felder I–IV. Darunter die Integrale für $Q(x)$ und $M(x)$ im Kasten und die Regel: Anzahl der Konstanten = Anzahl der Felder mal 2.]),
  "tm1k7_ueb_fall_a": (titel: "Bild lesen", body: [Oben: Auch $q = 0$ ist ein Bereich. Im Kasten die Zählregel $sum "ÜB" + sum "RB" = 2 dot$Felder und „Ende Feld $i$ = Anfang Feld $i + 1$“. Unten die Tabelle Fall a): Schnitt rechts und links eines Lastwechsels ($Delta x$ = „0“), Ergebnis $Q_"II" = Q_I$ (Knick) und $M_"II" = M_I$.]),
  "tm1k7_ueb_fall_b": (titel: "Bild lesen", body: [Tabelle Fall b) mit zwei Zeilen. Einzelkraft $F$: $Q_"II" = Q_I - F$ (Sprung), $M_"II" = M_I$ (Knick). Einzelmoment $M_0$: $Q_"II" = Q_I$, $M_"II" = M_I - M_0$ (Sprung). In der Skizze jeweils das winzige Stück mit $Q_I$, $M_I$ links und $Q_"II"$, $M_"II"$ rechts.]),
  "tm1k7_ueb_fall_b2": (titel: "Bild lesen", body: [Fall b) mit Lagerreaktionen. Fest-/Loslager: $Q_"II" = Q_I - ?$ (Lagerkraft unbekannt), $M_"II" = M_I$. Momentstütze: $Q_"II" = Q_I$, $M_"II" = M_I - ?$. Oben der Hinweis: Wurden die Lager vorab berechnet, sind zusätzliche, überzählige ÜB möglich.]),
  "tm1k7_ueb_fall_c": (titel: "Bild lesen", body: [Fall c) mehrteiliger Balken. Gelenk: $Q_"II" = Q_I$ und $M_"II" = M_I = 0$ ⇒ 2 ÜB beim Moment; $M$ hat dort eine Nullstelle. Parallelführung (Querkraftgelenk): $Q_"II" = Q_I = 0$ ⇒ 2 ÜB, $M_"II" = M_I$; $M$ hat dort einen Extremwert.]),
  "tm1k7_ueb_kombi": (titel: "Bild lesen", body: [Text: Bei Kombination der Fälle unmittelbar vor und nach der Übergangsstelle schneiden und lokales GGW. Darunter ein Balken $2l$ mit $q_0$ auf dem ersten Feld und $F$ bei $x = l$; RB ① $M(0) = 0$, ② $M(2l) = 0$ mit Verweis auf FS S. 38.]),
  "tm1k7_ueb_kombi2": (titel: "Bild lesen", body: [Oben deine grüne Skizze der ÜB-Stelle mit $F$: $Q_"II" = Q_I - F$ ③ und $M_"II" = M_I$ ④. Unten Fall a)+b)+c): Einspannung links, Gelenk mit $F$ bei $l$, $q_0$ im Feld II, Loslager rechts. RB ① $M(2l) = 0$; ÜB ② $M_I (l) = 0$, ③ $M_"II"(l) = 0$, ④ $Q_"II"(l) = Q_I (l) - F$.]),
  "tm1k7_mit_ueb_lager": (titel: "Bild lesen", body: [Deine Mitschrift: Überschrift „Übergangsbedingungen (ÜB) bei mehreren Feldern“. Skizze: Balken $2L$, $q_0$ auf der linken Hälfte, $F$ bei $L$, Festlager links, Loslager rechts. Darunter „geg.: $q_0$, $L$, $F$; ges.: $Q$, $M$“ und das Freikörperbild mit $A_x$, $A_z$, $B_z$, Resultierende $q L$ bei $L\/2$, Felder I und II.]),
  "tm1k7_mit_ueb_int": (titel: "Bild lesen", body: [Deine Rechnung: Integration in Feld I ($q_I = q_0$) und Feld II ($q_"II" = 0$) mit den Konstanten $C_1$ bis $C_4$. Darunter die RB $M_I (0) = 0$ und $M_"II"(2L) = 0$ mit Hinweis „Formelsammlung S. 38“ und eine grüne Skizze des Schnitts an der ÜB-Stelle.]),
  "tm1k7_mit_ueb_rb": (titel: "Bild lesen", body: [Lokales GGW an der ÜB-Stelle: $sum F_z$ liefert $Q_"II"(L) = Q_I (L) - F$, $sum M$ liefert $M_"II"(L) = M_I (L)$. Darunter „d) Bestimmung von $C_1$–$C_4$“ mit den vier nummerierten Gleichungen ①–④.]),
  "tm1k7_mit_ueb_c": (titel: "Bild lesen", body: [Auflösen nach $C_4 = F L + q L^2\/2$ und $C_3 = -(F\/2 + q L\/4)$; Teil e): die eingesetzten Funktionen $Q_I$, $M_I$, $Q_"II"$, $M_"II"$ (links eingerahmt). Unten f) Lagerreaktionen aus lokalem GGW: $A_x = 0$, $A_z = F\/2 + 3\/4 q L$; rechts der Ansatz für $B$.]),
  "tm1k7_mit_ueb_skizze": (titel: "Bild lesen", body: [Teil g) Skizze. Oben die Werte $Q_I (0)$, $Q_I (L)$, $Q_"II"$, $M_I (L)$. $Q$ fällt im Feld I linear (positiv), springt bei $F$ ins Negative und bleibt konstant bis $B$. $M$ steigt als Parabel bis $M(L) = q L^2\/4 + F L\/2$ und fällt dann linear auf null.]),
  "tm1k7_gb1": (titel: "Bild lesen", body: [Gelenkbalken: Festlager $A$, $q_0$ über Feld I (Länge $l$) bis zum Gelenk $G$, dort $F$ nach unten; Loslager $B$ bei $l + l\/2$, Loslager $C$ am Ende. Felder I, II, III; die Nummern ①–⑥ markieren die Stellen der RB und ÜB.]),
  "tm1k7_gb1_rbueb": (titel: "Bild lesen", body: [Links die RB ① $M_I (0) = 0$, ② $M_"II"(x = "2,5" l) = 0$ und die ÜB ③–⑥. Rechts zwei winzige Stücke: am Gelenk mit $q_0$, $F$, $Q_I$, $Q_"II"$; am Lager $B$ mit $M_"II"$, $M_"III"$ und $B = ?$. Unten: Die letzte Gleichung ist keine ÜB, da $B$ unbekannt.]),
  "tm1k7_gb1_lager": (titel: "Bild lesen", body: [Drei winzige Randstücke: bei $A$ ($A = Q(0) = q_0 l\/2$), über $B$ ($B = Q_"III" - Q_"II" = 3\/4 q_0 l + 3\/2 F$) und bei $C$ ($C = -Q_"III"(5l\/2) = -1\/4 q_0 l - 1\/2 F$).]),
  "tm1k7_gb1_gelenk": (titel: "Bild lesen", body: [Gelenk freigeschnitten, $F$ wird links von $G$ angesetzt. Links das linke Stück mit $Q_I (l)$, $G_x$, $G_y$; rechts das rechte Stück mit $Q_"II"(l)$. Ergebnis: $G_x = 0$, $G_y = G = Q_"II"(l) = -1\/2 q_0 l - F$; in der Klammer dasselbe über $Q_I$.]),
  "tm1k7_gb1_werte": (titel: "Bild lesen", body: [Teil g): Werte an markanten Stellen. $Q_I (0) = q_0 l\/2$, $Q_I (l) = -q_0 l\/2$; $M_(I,max)$ bei $x = l\/2$ mit $q_0 l^2\/8$; $M = 0$ bei $0$, $l$ und $5l\/2$; $M(3l\/2) = -1\/4 q_0 l^2 - 1\/2 F l$ (gleich von links und rechts).]),
  "tm1k7_gb1_verlauf": (titel: "Bild lesen", body: [Oben der Gelenkbalken. Mitte $Q(x)$: fallende Gerade im Feld I, Sprung um $F$ nach unten am Gelenk, konstant negativ bis $B$, Sprung um $B$ nach oben, konstant positiv bis $C$. Unten $M(x)$: Parabelbogen $q_0 l^2\/8$ im Feld I, dann Gerade ins Negative bis über $B$ und zurück auf null bei $C$. Die Kreise ①–⑥ zeigen die Kontrollpunkte.]),
  "tm1k7_gb2": (titel: "Bild lesen", body: [Gleicher Gelenkbalken wie Beispiel 1, aber $q_0$ läuft ohne Unterbrechung von $A$ über das Gelenk $G$ bis $B$; keine Einzelkraft. Lokale Koordinaten: $x_1$ ab $A$ (Feld I bis $B$), $x_2$ ab $B$ (Feld II bis $C$). Am Gelenk gibt es keine Feldgrenze.]),
  "tm1k7_gb2_verlauf": (titel: "Bild lesen", body: [$Q$: Gerade von $A = q_0 l\/2$ durch null bis über $B$, Sprung um $B = 11\/8 q_0 l$ auf $3\/8 q_0 l$, dann konstant bis $C$. $M$: kleiner Bogen mit $M_max = q_0 l^2\/8$, null am Gelenk (④ ✓), tiefster Punkt $-3\/8 q_0 l^2$ über $B$, linear zurück auf null bei $C$.]),
  "tm1k7_vielefelder": (titel: "Bild lesen", body: [Ein Balken mit $F$, einer Streckenlast $q_0$ und einem Moment $M_0$ hat fünf Felder I–V. Darunter: Integration sehr aufwendig (viele ÜB, viele $C_i$); Vereinfachung durch das Föppl-Symbol (7.2.5); meist einfacher: abschnittsweise schneiden (7.2.1) oder punktweise (7.2.6).]),
  "tm1k7_foeppl_def": (titel: "Bild lesen", body: [Definition: $chevron.l x - a chevron.r^n$ ist 0 für $x < a$ und $(x - a)^n$ für $x > a$; für $n = 0$ ist es 0 bzw. 1. Darunter die Rechenregeln für Ableitung und Integral – sie sehen aus wie bei einer normalen Klammer.]),
  "tm1k7_foeppl_bsp": (titel: "Bild lesen", body: [Oben ein Balken (Länge $3a$) mit $q_0$ nur im mittleren Drittel. Darunter als „Rechnung mit Bildern“: Last $q_0$ ab $x = a$ bis zum Ende ($q_0 chevron.l x - a chevron.r^0$) minus Last $q_0$ ab $x = 2a$ ($q_0 chevron.l x - 2a chevron.r^0$). Unten die Formel für $q(x)$.]),
  "tm1k7_punkt_vorgehen": (titel: "Bild lesen", body: [Folientext a)–c) der punktweisen Ermittlung mit der Liste der markanten Stellen. Oben in Rot deine Notizen: „Für Prüfung wichtig!“ und „In der Prüfung Lager + Gelenkreaktionen bereits bestimmt. Schnittgrößen nur an markanten Stellen bestimmen.“ Die Wörter „markanten Stellen“ hast du unterstrichen.]),
  "tm1k7_punkt_tabelle": (titel: "Bild lesen", body: [Oben $d Q\/d x = -q$ und $d M\/d x = Q$. Die Tabelle hat drei Zeilen (Einzelkraft, Einzelmoment, Streckenlast von $A$ bis $E$) und sagt jeweils, wie $Q$ und $M$ links, an der Stelle und rechts aussehen. Oben rechts dein Hinweis „Formelsammlung S. 43“.]),
  "tm1k7_mit_punkt1": (titel: "Bild lesen", body: [Deine Mitschrift „Punktweise Bestimmung der Schnittgrößen“, rot daneben „Sowie Prüfungsaufgabe“. Balken $3a$, $q_0$ im mittleren Drittel. Lager $A_z = B_z = q_0 a\/2$. Dann zwei Schnitte mit Skizzen: bei $x = a$ (vor $q_0$, linker Teil) $Q = q_0 a\/2$, $M = q_0 a^2\/2$; bei $x = 2a$ (nach $q_0$, rechter Teil) $Q = -q_0 a\/2$, $M = q_0 a^2\/2$.]),
  "tm1k7_mit_punkt2": (titel: "Bild lesen", body: [Teil c): $Q$ ist konstant $+q_0 a\/2$, fällt im Lastbereich linear und bleibt dann bei $-q_0 a\/2$. $M$ steigt linear auf $q_0 a^2\/2$, wölbt sich als Bogen ($M_max$) und fällt linear auf null. Teil d): Schnitt mit $x_2$ im Lastbereich, $Q(x_2) = q_0 a\/2 - q_0 x_2$ und $M(x_2)$.]),
  "tm1k7_mit_mmax": (titel: "Bild lesen", body: [„Bestimmung von $M_max$“: $d M\/d x = Q = 0$ ergibt $x_2 = a\/2$. Eingesetzt in $M(x_2)$ folgt $M_max = q_0 a^2 dot 5\/8$ (doppelt unterstrichen).]),
  "tm1k7_punkt_bsp": (titel: "Bild lesen", body: [Oben das Momentengleichgewicht um $A$ und daraus $B = 1\/6 (F + 6 q_0 a - M_0\/a)$. Darunter Schnitt ① bei $x = a$ vor $F$: kleines linkes Stück mit $A_x$, $A_z$, $N$, $Q$, $M$; Ergebnis $Q = A_z$ und $M = a A_z$.]),
  "tm1k7_punkt_23": (titel: "Bild lesen", body: [Schnitt ② bei $x = 2a$ vor $q_0$: $Q = A_z - F$, $M = 2a A_z - a F$. Schnitt ③ bei $x = 4a$ nach $q_0$, mit Resultierender $F_R$: $Q = A_z - F - F_R$, $M = 4a A_z - 3a F - 2 q_0 a^2$. Schnitt ④ am rechten Teil mit $M_0$ und $B$: $Q = -B$, $M = M_0 + 2 B a$.]),
  "tm1k7_punkt_skizze": (titel: "Bild lesen", body: [Teil c) Skizze. Balken mit $F$, $q_0$ (Resultierende $F_R$), $M_0$ und Feldern I–V. $Q$: Stufe $A$, Sprung um $F$, linear fallend im Lastbereich, konstant $-B$. $M$: linear bis $A a$, Knick, quadratisch mit $M_max$ bei $x_max$, linear bis $M_0 + 2 B a$, Sprung um $M_0$ und linear auf null.]),
  "tm1k7_qkp_voll": (titel: "Bild lesen", body: [Links ein Balken mit zwei gelenkigen Lagern und einer schrägen Kraft $F$ (Winkel $alpha$) in der Mitte. Rechts der vollständige Querkraftplan: $Q = A_V$ konstant (+), bei der Kraft Sprung um $F_V$ nach unten, dann konstant negativ bis $-Q = B$.]),
  "tm1k7_qkp_konst": (titel: "Bild lesen", body: [Oben ein $Q$-Verlauf, der konstant und positiv ist. Darunter der passende $M$-Verlauf: eine steigende Gerade („linear steigend“). Rechts der Satz mit dem Fehler „$M = d Q\/d x$“; richtig ist $Q = d M\/d x$.]),
  "tm1k7_qkp_steigend": (titel: "Bild lesen", body: [$Q$ steigt linear von negativ nach positiv. $M$ ist eine nach oben offene Parabel: Solange $Q < 0$ ist, fällt $M$; beim Nulldurchgang von $Q$ ist die Tangente waagerecht (Minimum); danach steigt $M$.]),
  "tm1k7_qkp_fallend": (titel: "Bild lesen", body: [Die Überschrift sagt „Q positiv linear steigend“, der Kurzlabel am $Q$-Verlauf aber „linear fallend“ – gezeigt ist der fallende Fall. $M$ ist eine nach unten offene Parabel, also entgegengesetzt zum Bild davor.]),
  "tm1k7_qkp_verlaeufe": (titel: "Bild lesen", body: [Oben der Querkraftplan aus S. 9 ($Q = A_V$, Sprung $F_V$, $-Q = B$), Feldlängen $a$, $a$. Darunter der Momentenverlauf: ein Dreieck, das linear (proportional zu $x$) bis zur Mitte steigt und dann linear auf null fällt; $M = 0$ an beiden Lagern.]),
  "tm1k7_wzf_93": (titel: "Bild lesen", body: [Deine WZF-Notizen: „Aufgabe 9.3 etwas abgeändert aus Vorlesung“. Links Balken mit Festlager $A$, $2F$ bei $a$, Loslager $B$, $F$ am Kragende ($c$), darunter das Freikörperbild. In der Mitte die drei Gleichgewichte (mit vertauschter Beschriftung $F_x$/$F_y$) und die Lösungen für $B$, $A_x$, $A_y$. Rechts qualitativ der Querkraft- und der Momentenplan.]),
  "tm1k7_wzf_71": (titel: "Bild lesen", body: [Deine WZF-Mitschrift vom 18.12.25, „Einschub Querkraftplan zu 7.1“. Oben die Angaben ($F_1$, $F_2$, $F_3$, $M_0$, $q_0$, $a$, $alpha$) und der Balken. Darunter viele kleine Freischnitte an ausgezeichneten Stellen mit den Gleichungen 1–21. Unten rechts ein kleiner Querkraftplan als Treppe.]),
  "tm1k7_inhalt": (titel: "Bild lesen", body: [Das Inhaltsverzeichnis der Schnittgrößen-Folien mit Seitenzahlen. Neben „2.6 Punktweise Ermittlung der Schnittgrößen“ steht in Rot „→ Klausur“. Punkt 4 „Schnittgrößen bei räumlichen Tragwerken“ ist durchgestrichen (nicht behandelt).]),
  "tm1k7_rahmen_bogen": (titel: "Bild lesen", body: [Links ein Rahmen (Stütze, Riegel, Schräge), rechts ein Bogen, jeweils auf zwei Lagern. Darunter: Bisher war das KS eindeutig ($x$ rechts, $z$ unten). Jetzt wird an jedem Schnitt ein örtliches KS festgelegt, und zwar durch die gestrichelte Faser = „unten“ (freie Wahl).]),
  "tm1k7_faser": (titel: "Bild lesen", body: [In der Mitte ein Rahmen mit blau gestrichelter Faser innen. Links an der Stütze und rechts am Riegel je ein Schnitt mit örtlichem $x$-$y$-$z$-System und den Schnittgrößen $N$, $Q$, $M$ am Ufer (+) und (−). Unten die Regeln: $z$ zur Faser hin, $x$ parallel zur Faser, Normalkraft immer betrachten ($N <=> Q$).]),
  "tm1k7_rahmen_vorgehen": (titel: "Bild lesen", body: [Der Beispielrahmen: Stütze 1 von $A$ nach $C$ (Höhe $b = 3\/4 a$), Riegel 2 von $C$ nach $G$ (Länge $a$, Last $q_0 = F\/a$), Schräge 3 von $G$ nach $B$ (je $a$ waagerecht und senkrecht). $F$ wirkt waagerecht bei $C$; $G$ ist ein Gelenk. Gestrichelte Faser innen. Unten die Schritte a)–d).]),
  "tm1k7_rahmen_lager": (titel: "Bild lesen", body: [Oben die zwei Teilkörper: links Stütze + Riegel mit $F$, $q_0$, $A_V$, $A_H$, $G_V$, $G_H$; rechts die Schräge mit $G_H$, $G_V$, $B_H$, $B_V$; daneben das globale H–V-System. Unten das „eingefrorene“ Gesamtsystem und die Ergebnisliste $A_H$, $A_V$, $G_H$, $G_V$, $B_H$, $B_V$.]),
  "tm1k7_rahmen_c": (titel: "Bild lesen", body: [Zwei Schnitte an Ecke $C$, jeweils am linken Teil. Oben „vor $C$“ (C,1): Schnitt in der Stütze, $N_(C,1) = -"0,286" F$, $Q_(C,1) = "0,286" F$, $M_(C,1) = "0,214" a F$. Unten „nach $C$“ (C,2): Schnitt im Riegel mit $F$, $N_(C,2) = -"0,714" F$, $Q_(C,2) = "0,286" F$, $M_(C,2) = "0,214" a F$.]),
  "tm1k7_rahmen_g2": (titel: "Bild lesen", body: [Schnitt „vor $G$“ im Riegel, betrachtet wird der rechte Teil (Schräge mit $B_H$, $B_V$). Die Gleichgewichte liefern $N_(G,2) = -"0,714" F$, $Q_(G,2) = -"0,714" F$ und $M_(G,2) = 0$ (Gelenk!).]),
  "tm1k7_rahmen_g3": (titel: "Bild lesen", body: [Schnitt „nach $G$“ in der Schräge unter $alpha = 45°$ mit gedrehtem örtlichem KS. Mit $cos alpha = sin alpha = sqrt(2)\/2$: $N_(G,3) = -"1,01" F$, $Q_(G,3) = 0$, $M_(G,3) = 0$.]),
  "tm1k7_rahmen_ecke": (titel: "Bild lesen", body: [Links die Eckregeln: $|M_"vor"| = |M_"nach"|$; an 90°-Ecken $|N_"vor"| = |Q_"nach"|$ und $|Q_"vor"| = |N_"nach"|$. Rechts: Mit äußerer Last örtliches GGW an der Ecke im globalen KS. Unten Ecke $C$ mit $F$ freigeschnitten: $N_(C,2) = Q_(C,1) - F$, $Q_(C,2) = -N_(C,1)$, $M_(C,2) = M_(C,1)$; alle Hebelarme null.]),
  "tm1k7_rahmen_n": (titel: "Bild lesen", body: [Normalkraftverlauf am Rahmen, maßstäblich (5 mm = 0,2 F). Stütze: $|A_V| = "0,286" F$, Riegel: $|-F + A_H| = "0,714" F$ bzw. $|B_H|$, Schräge: $"1,01" F$. Alle Flächen tragen ein Minus: überall Druck.]),
  "tm1k7_rahmen_qm": (titel: "Bild lesen", body: [Oben $Q$: Stütze konstant $|A_H| = "0,286" F$ (+), Riegel linear von $+"0,286" F$ auf $-"0,714" F$ mit Nullstelle, Schräge $Q = 0$ („Stab!“). Unten $M$ (10 mm = 0,2 Fa): Stütze linear auf $"0,214" a F$, Riegel Parabel mit $M_max$ und $M = 0$ am Gelenk, Schräge $M = 0$.]),
  "tm1k7_rahmen_bereich2": (titel: "Bild lesen", body: [Links: Im Riegel (Bereich 2) gilt $q_2 = F\/a$; Integration ergibt $Q_2$ und $M_2$ mit $C_1$, $C_2$. RB (2 von 4 möglichen) aus der punktweisen Rechnung an $C$: $C_1 = "0,286" F$, $C_2 = "0,214" a F$. Rechts der Rahmen mit lokaler Koordinate $x_2$ im Abschnitt 2.]),
  "tm1k7_ue92": (titel: "Bild lesen", body: [Balken $A$–$B$ mit vier gleichen Feldern $a$ und drei senkrechten Kräften $F_1$, $F_2$, $F_3$ an den Feldgrenzen. Laut Text ist $F_3 = -F$, wirkt also nach oben.]),
  "tm1k7_ue93": (titel: "Bild lesen", body: [Träger mit Festlager links, 30 kN nach 6 m, Loslager nach weiteren 5 m und 20 kN am Kragende nach weiteren 3 m. Oben links die $x$-Richtung.]),
  "tm1k7_ue94": (titel: "Bild lesen", body: [Einfeldbalken (Länge $l$) mit einer Dreieckslast, die links bei null beginnt und rechts auf $q_0$ anwächst.]),
  "tm1k7_ue101": (titel: "Bild lesen", body: [Einfeldbalken (Länge $l$) mit Trapezlast: links $q_0$, rechts $q_1$ (laut Text $q_1 = 2 q_0$).]),
  "tm1k7_ue102": (titel: "Bild lesen", body: [Balken der Länge $l$: links gelenkiges Lager $A$ mit Einzelmoment $M_0$, rechts eine Parallelführung $B$ an einer Wand mit Einzelkraft $F$; dazwischen die Gleichstreckenlast $q_0$.]),
  "tm1k7_ue103": (titel: "Bild lesen", body: [Mehrfeldträger $A$–$B$ (Länge $10a$): $F$ nach $2a$, $q_0$ von $3a$ bis $6a$, $2F$ bei $8a$; Feldlängen $2a$, $a$, $3a$, $2a$, $2a$.]),
  "tm1k7_ue104": (titel: "Bild lesen", body: [Oben der Balken mit Festlager $A$ und Lager $B$ (Rasterung 2 m). Darunter die gegebene Momentenlinie (nach unten positiv aufgetragen) mit den Werten 12, 6, 18, 10, 10 kNm, einer quadratischen Parabel symmetrisch zur Mitte und dem Hinweis „Gleiche Steigung!“ am Übergang.]),
  "tm1k7_ue111": (titel: "Bild lesen", body: [Balken mit Einspannung $A$ links, Gelenk $G$ bei $a$ und Loslager $B$ rechts (Länge $l$). Die Dreieckslast wächst von null bei $A$ linear auf $q_0$ bei $B$ und läuft über das Gelenk hinweg.]),
  "tm1k7_ue112": (titel: "Bild lesen", body: [Balken mit Einspannung $A$, Kraft $F$ nach $a = 8$ m, Gelenk $G$ nach weiteren $b = 4$ m, dann $q_0$ auf $c = 6$ m bis zum Loslager $B$ mit Moment $M_0$. Lokale Koordinaten $x_1$, $x_2$, $x_3$; die Kreise ①–⑥ zeigen RB- und ÜB-Stellen.]),
  "tm1k7_ue113": (titel: "Bild lesen", body: [Oben ein Kran auf einer Brücke (Einfeldbalken $A$–$B$, Länge $l$), Radstand $b$, Abstand $x$. Unten das Ersatzsystem: zwei Radkräfte $H$ und $V$ nach unten und die Lagerkräfte $A$ und $B$ (grün).]),
  "tm1k7_ue121": (titel: "Bild lesen", body: [Gerberträger: Festlager $A$, Loslager $B$ nach $a$, $q_0$ von $B$ bis zum Gelenk $G$ (nach weiteren $a$), Kraft $F$ unter 30° nach $b$, Loslager $C$ nach weiteren $b$.]),
  "tm1k7_ue122": (titel: "Bild lesen", body: [Rahmen mit gestrichelter Faser innen: Stütze 1 (Höhe $b$) über Lager $A$, Riegel 2 von $C$ nach $D$ (Länge $a$) mit $q_0$, Stütze 3 (Höhe $a$) bis zum Festlager $B$ mit $B_H$, $B_V$. $F$ wirkt waagerecht bei $C$; das H–V-System ist eingezeichnet.]),
  "tm1k7_ue123": (titel: "Bild lesen", body: [Gleicher Rahmen wie in 12.2, aber mit Gelenk $G$ an der rechten oberen Ecke. Festlager $A$ ($A_H$, $A_V$) und $B$ ($B_H$, $B$); $F$ waagerecht bei $C$, $q_0$ auf dem Riegel.]),
  "map-t1k7a": (titel: "Die Mindmap lesen", body: [In der Mitte „Balken“. Die vier Äste: Schnittgrößen am Schnitt immer positiv ansetzen; die Grundbeziehungen $Q' = -q$ und $M' = Q$; Integration mit Konstanten aus den RB; $M_max$ bei $Q = 0$. Lies im Uhrzeigersinn: vom Schnitt zur Formel zur Rechnung zum Ergebnis.]),
  "map-t1k7b": (titel: "Die Mindmap lesen", body: [In der Mitte „Viele Felder“. Die vier Äste: Zählregel ÜB + RB = 2 · Felder; Gelenk heißt $M = 0$; punktweise nur an markanten Stellen rechnen (klausurrelevant); beim Rahmen über die gestrichelte Faser wie beim Balken vorgehen.]),
  "tm1k9_ue131": (titel: "Bild lesen", body: [Zweimal derselbe Klotz auf einer schiefen Ebene (Winkel $alpha$, rau mit $mu_0$). $G$ zeigt senkrecht nach unten, $F$ waagerecht von links. Das blaue $x$-$y$-System liegt parallel und senkrecht zur Ebene. Links zeigt $H$ hangabwärts (der Klotz soll nicht hochrutschen), rechts hangaufwärts (er soll nicht runterrutschen). $N$ steht jeweils senkrecht zur Ebene.]),
  "tm1k9_ue131c": (titel: "Bild lesen", body: [Kraftecke im Grenzfall: $G$ senkrecht nach unten, $F_I$ bzw. $F_"II"$ waagerecht (rot), die Kontaktkräfte $R_I$ und $R_"II"$ (grün) schließen das Dreieck. Die schwarzen Linien zeigen die Normale der Ebene und die zwei Grenzen des Haftungskeils, jeweils um $phi_0$ gedreht. Daraus folgt $F = G tan(alpha plus.minus phi_0)$.]),
  "tm1k9_ue132": (titel: "Bild lesen", body: [Eine graue Walze (Mittelpunkt $M$) in einer Ecke. Links an der Wand wirken $N_1$ waagerecht und $H_1$ nach oben, unten am Boden $N_2$ nach oben und $H_2$ nach links. $G$ zeigt nach unten, $F$ greift rechts am Rand senkrecht nach oben an.]),
  "tm1k9_ue133": (titel: "Bild lesen", body: [Eine Leiter (Länge $L = 5$ m) lehnt unter dem Winkel $alpha$ zur senkrechten Wand. Oben drückt nur die Wand waagerecht ($N_W$, glatt). Unten am Boden wirken $N_B$ nach oben und $H_B$ nach links (rau). Die Person $G$ steht in der Höhe $h$ auf der Leiter.]),
  "tm1k9_ue03": (titel: "Bild lesen", body: [Ein Klotz $m_1$ liegt auf einer waagerechten Fläche. Ein Seil läuft von ihm waagerecht zu einer Rolle an der Kante und hängt dort senkrecht mit der Masse $m_2$ herunter.]),
  "tm1k9_fs_seil": (titel: "Bild lesen", body: [Drei Skizzen: ein Seil über einer Walze mit Umschlingungswinkel $alpha$ und den Kräften $S_1$, $S_2$; ein Seil mehrfach um einen Pfosten gewickelt; eine volle Windung plus Restwinkel $alpha_1$ ($alpha = alpha_1 + n dot 2 pi$). Darunter die Euler-Eytelwein-Formel für Grenzhaftung ($mu_0$) und Reibung ($mu$).]),
  "map-t1k9": (titel: "Die Mindmap lesen", body: [In der Mitte „Raue Fläche“. Die vier Äste: Haftung mit $|H| < mu_0 N$; Grenzhaftung mit $H = mu_0 N$; Reibung mit $R = mu N$; Seil mit $S_2 = S_1 e^(mu_0 alpha)$. Von Ruhe über Grenzfall zu Bewegung.]),
  "tm2k0_tm1wdh": (titel: "Bild lesen", body: [Eine Textfolie zum Einstieg: Schnittgrößen lassen sich lokal an ausgezeichneten Stellen oder bereichsweise mit der DGL berechnen. Oben rechts hast du rot „TM1 wiederholen“ hinterlegt. Unten der Ausblick: Die Schnittgrößen werden aus der Belastung hergeleitet.]),
  "tm2k1_schnittufer": (titel: "Bild lesen", body: [Links ein Balken $A$–$B$ (Länge $L$) unter Streckenlast $q_0$. Rechts zwei Ausschnitte nach dem Schnitt: am positiven Schnittufer (+) zeigen $N$ nach rechts, $Q$ nach unten und $M$ gegen den Uhrzeigersinn; am negativen Ufer (−) alles umgekehrt. Grün das lokale, blau das globale Koordinatensystem.]),
  "tm2k0_rahmen": (titel: "Bild lesen", body: [Ein Rahmen: links Festlager $A$, daneben das Moment $M_0$, dann das Gelenk $G$. Über dem Riegel $G$–$B$ (Länge $3l$) steigt eine Dreieckslast bis $q_0$ an. An der Ecke $B$ knickt der Rahmen nach unten; an der Stütze greift $F$ waagerecht in halber Höhe an, unten steht das Festlager $C$. Rechts die gegebenen Größen.]),
  "tm2k0_rahmen_fkb": (titel: "Bild lesen", body: [Oben das Freikörperbild: der Rahmen am Gelenk getrennt, $G_H$ und $G_V$ an beiden Teilen entgegengesetzt, die Dreieckslast durch $F_"res"$ ersetzt. Unten links die drei Gleichgewichte für Teilsystem I ($A$–$G$), rechts die drei für Teilsystem II ($G$–$B$–$C$) mit der Momentengleichung um $G$.]),
  "tm2k0_rahmen_ecke": (titel: "Bild lesen", body: [Schnitt direkt nach der Rahmenecke $B$ in der Stütze. Links die Gleichgewichte am positiven Ufer (oberer Teil mit $A$, $M_0$ und Last), rechts zur Kontrolle am negativen Ufer (nur $F$ und Lager $C$). In der Stütze zeigt $N$ jetzt senkrecht und $Q$ waagerecht.]),
  "tm2k0_rahmen_verlauf": (titel: "Bild lesen", body: [Ein Tabellenkalkulations-Diagramm: Die Verläufe von $N$ (rot), $Q$ (grün) und $M$ (dunkelgrün) über der „abgewickelten“ Länge des Rahmens. Man sieht den Sprung bei $M_0$, die Parabelform unter der Dreieckslast und $M = 0$ am Gelenk. Unten zur Orientierung der Rahmen.]),
  "tm2k0_balken": (titel: "Bild lesen", body: [Freikörperbild des Balkens: $q_0$ auf dem ersten Feld (Resultierende $F_"res" = q_0 l$ bei $l\/2$, blau), Lager $A$ links, Lager $B$ ($B_H$, $B_V$) bei $2l$, Einzelkraft $F$ am freien Ende bei $3l$. Unten die Feldlängen $l$, $l$, $l$.]),
  "tm2k0_foeppl": (titel: "Bild lesen", body: [Die allgemeinen Gleichungen für $q(x)$, $Q(x)$ und $M(x)$ mit Föppl-Klammern. Deine handschriftliche Korrektur ändert $q(x)$ auf $q_0 x^0 - q_0 chevron.l x - l chevron.r^0$. Gelb markiert hast du die Terme $+B_V$ und $-F$ und daneben notiert, woher die Vorzeichen der Sprünge kommen.]),
  "tm2k0_balken_plot": (titel: "Bild lesen", body: [Links eine Wertetabelle (x, N, Q, M) in Schritten von 0,1 m, rechts das Diagramm: $N = 0$ (gelb), $Q$ (blau) fällt im ersten Feld, ist bis $B$ konstant negativ und springt dann auf $+4$ kN; $M$ (grün) hat einen kleinen Buckel, fällt bis $-4$ kNm über $B$ und geht am Ende auf null.]),
  "tm2k0_dgl_q": (titel: "Bild lesen", body: [Ein Balkenelement der Länge $d x$ unter konstanter Last $q_0$. Links wirken $N$, $Q$, $M$, rechts $N$, $Q + d Q$, $M + d M$. Darunter die Gleichung für die senkrechten Kräfte und das Ergebnis (1), auf der Folie mit dem überzähligen Faktor „$dot d x$“.]),
  "tm2k0_dgl_m": (titel: "Bild lesen", body: [Dasselbe Element, jetzt mit dem Momentengleichgewicht. Die Folie schreibt $+(Q + d Q) d x$ und als Ergebnis (2) wieder mit überzähligem „$dot d x$“. Beides ist im Text als Folienfehler erklärt.]),
  "tm2k0_dgl_n": (titel: "Bild lesen", body: [Das Element unter einer Längslast $n(x) = n_0$: links $N$, rechts $N + d N$. Das Gleichgewicht in Längsrichtung liefert (3) $d N\/d x = -n(x)$ (auf der Folie wieder mit „$dot d x$“ und $q_0$ statt $n_0$).]),
  "map-t2k0": (titel: "Die Mindmap lesen", body: [In der Mitte „Schnittgrößen“. Die vier Äste: schneiden und Gleichgewicht; Vorzeichen über das Schnittufer; zwei Wege (punktweise oder mit Föppl/DGL); die Ableitungen $Q' = -q$, $M' = Q$, $N' = -n$ als Brücke zu Kapitel 1.]),
  "tm2k1_normal": (titel: "Bild lesen", body: [Links ein grauer Stab, oben und unten zieht je eine rote Kraft $F$ nach außen. Die Schere zeigt den Schnitt quer zur Achse. Rechts der untere Teil: Auf der Schnittfläche wirken viele gleich lange rote Pfeile nach oben, das ist die gleichmäßig verteilte Spannung $sigma_(Z\/D)$. Darunter die Formel $sigma = F\/A = N\/A$.]),
  "tm2k1_scher": (titel: "Bild lesen", body: [Ein Balken auf zwei Lagern, in der Mitte drückt $F$ nach unten, die Schere schneidet daneben senkrecht. Rechts das abgeschnittene Stück: Die Pfeile $tau_S$ liegen #strong[in] der Schnittfläche (senkrecht nach unten), nicht senkrecht zu ihr. Formel $tau_S = F\/A_S = Q\/A_S$.]),
  "tm2k1_biege": (titel: "Bild lesen", body: [Ein eingespannter Balken mit Moment $M_0$ am Ende. Rechts der Schnitt: Die Pfeile sind oben nach links (Druck $sigma_D$) und unten nach rechts (Zug $sigma_Z$) gerichtet und außen am längsten. In der Mitte ist die Spannung null.]),
  "tm2k1_torsion": (titel: "Bild lesen", body: [Eine eingespannte blaue Welle mit Torsionsmoment $M_0$ (roter Pfeil längs der Achse). Rechts der Kreisquerschnitt: Die Schubspannungen $tau$ laufen im Kreis um die Mitte und sind am Rand am größten ($tau_(T max)$).]),
  "tm2k1_schraeg": (titel: "Bild lesen", body: [Ein Stabstück wird links mit $F$ gezogen. Rechts ist es schräg unter dem Winkel $phi$ geschnitten (blaue Linie, Fläche $A^*$). Auf der Schnittfläche wirken rote Pfeile, die man in $sigma$ (senkrecht zur Fläche) und $tau$ (in der Fläche) zerlegt. Darunter die zwei Gleichgewichtsbedingungen (1) waagerecht und (2) senkrecht.]),
  "tm2k1_trafo_kreis": (titel: "Bild lesen", body: [Oben die Formeln $sigma = frac(1, 2) sigma_0 + frac(1, 2) sigma_0 cos 2 phi$ und $tau = frac(1, 2) sigma_0 sin 2 phi$. Darunter ein Kreis im $sigma$-$tau$-Diagramm mit Mittelpunkt bei $frac(1, 2) sigma_0$ und Radius $frac(1, 2) sigma_0$. Ein Radius unter dem Winkel $2 phi$ zeigt auf den Punkt ($sigma$, $tau$): grün der waagerechte Anteil $frac(1, 2) sigma_0 cos 2 phi$, blau der senkrechte $frac(1, 2) sigma_0 sin 2 phi$.]),
  "tm2k1_konisch": (titel: "Bild lesen", body: [Handschriftlich: oben ein Kegelstumpf, links Radius $r_0$, rechts $2 r_0$, an beiden Enden zieht $F$. Darunter der Radius als Gerade: $r(x) = r_0 (1 + x\/L)$ (Steigung über das Steigungsdreieck). Unten die Fläche $A = pi r^2$ und die Spannung $sigma(x) = F\/(pi r_0^2 (1 + x\/L)^2)$.]),
  "tm2k1_wasserturm": (titel: "Bild lesen", body: [Links ein Wasserturm: oben der Behälter mit Gewicht $G_0$, darunter eine Stütze, die nach unten breiter wird (Höhe $H$, innen hohl mit Radius $r_i$). Rechts die Koordinate $x$ von oben nach unten und ein Scheibchen $d x$. Text: Die Außenkontur $r(x)$ soll so sein, dass überall $sigma = sigma_0$ gilt.]),
  "tm2k1_wasserturm_lsg": (titel: "Bild lesen", body: [Lösungsschritte: aus dem Gleichgewicht $sigma_0\/(rho g) d A\/A = d x$; beidseitig integrieren, $integral d A\/A = ln A$; Ergebnis $A = A_0 e^(rho g x\/sigma_0)$ und daraus $r(x)$ mit einer Wurzel.]),
  "tm2k1_pyramide": (titel: "Bild lesen", body: [Ein Pyramidenstumpf von der Seite: oben schmal (Seite $a$), unten breit (Seite $b$), Höhe $h$. Oben drückt $F$. Die Koordinate $x$ läuft von oben nach unten, $y$ ist die halbe bzw. ganze Breite an der Stelle $x$.]),
  "tm2k1_pyramide_lsg": (titel: "Bild lesen", body: [Nur eine Formelzeile: $sigma(x) = N(x)\/A(x) = (rho dot A(x) dot x dot g - F)\/A(x)$. Sie benutzt $V = A(x) dot x$, was beim Stumpf nicht stimmt (siehe Kasten „Fehler auf der Folie“).]),
  "tm2k1_dgl_n": (titel: "Bild lesen", body: [Links oben ein Körper unter verteilter Längslast $n(x)$. Darunter ein herausgeschnittenes Element der Länge $d x$: links $N$ nach links, rechts $N + d N$ nach rechts, dazwischen $n d x$. Rechts die Gleichung $-N + n(x) d x + (N + Delta N) = 0$ und eingerahmt $d N\/d x = -n(x)$.]),
  "tm2k1_dehnung": (titel: "Bild lesen", body: [Oben ein eingespanntes Band mit einem kleinen Rechteck darauf, rechts zieht $F$. Unten das vergrößerte Element: Grau die alte Länge $d x$, gelblich der Zuwachs $d u$. Rechts der Text und eingerahmt $epsilon = d u\/d x$.]),
  "tm2k1_werkstoff": (titel: "Bild lesen", body: [Links oben zwei Spannungs-Dehnungs-Kurven (mechanische Einwirkung), darunter ein Block, der von einer Flamme erwärmt wird (thermische Einwirkung). Rechts eingerahmt $epsilon = sigma\/E + alpha_T Delta T$, unter dem ersten Term „mechanisch“, unter dem zweiten „thermisch“.]),
  "tm2k1_zugversuch": (titel: "Bild lesen", body: [Handschriftlich: links ein Probestab mit dickeren Köpfen. Mitte das Diagramm eines duktilen Werkstoffs ($sigma$ über $epsilon$): gerader Anstieg, dann die Streckgrenze $R_e$, ein Plateau und das Maximum $R_m$. Rechts ein spröder Werkstoff: keine ausgeprägte Streckgrenze, statt $R_e$ gilt $R_(p 0","2)$ bei 0,2 % bleibender Dehnung.]),
  "tm2k1_haengend": (titel: "Bild lesen", body: [Ein Balken hängt an der Decke, die roten Pfeile im Inneren zeigen die Eigengewichtslast $n = m g\/L$ nach unten. Rechts die DGL $E A u''(x) = -n(x) = -G\/L$ und zweimal integriert $E A u' = -G\/L x + C_1$, $E A u = -G\/(2L) x^2 + C_1 x + C_2$.]),
  "tm2k1_unbestimmt": (titel: "Bild lesen", body: [Zwischen zwei festen Wänden liegen zwei Balken hintereinander: links $E_1 A_1$ (Länge $L_1$, grau), rechts $E_2 A_2$ mit $alpha_T$ (Länge $L_2$, rosa, erwärmt um $Delta T$). Unten die Punkte A, B, C und die Koordinate $x$. Rechts der Aufgabentext.]),
  "tm2k1_superpos": (titel: "Bild lesen", body: [Drei Skizzen nebeneinander: das System = System 0 + System 1. In System 0 ist das rechte Lager entfernt, der rosa Balken dehnt sich frei aus. In System 1 drückt die Kraft $X$ am rechten Ende zurück. Zusammen ergibt sich wieder die Gesamtlänge null.]),
  "tm2k1_w233_1": (titel: "Bild lesen", body: [Mitschrift: oben die Formeln $sigma = N\/A$ und $tau = T\/A$ (T = Tangentialkraft). Darunter Beispiel 1: Eine Masse $G$ hängt an zwei Seilen $S_1$ (60°) und $S_2$ (30°), die mit Klebestellen 3 und 4 an der Decke hängen. Gegeben $G = 10$ N und vier Flächen. Unten das Freikörperbild am Knoten mit den zwei Gleichgewichtsbedingungen.]),
  "tm2k1_w233_2": (titel: "Bild lesen", body: [Mitschrift: Auflösen nach $S_2 = 5$ N und $S_1 = "8,66"$ N, dann $sigma_1 = 433$ und $sigma_2 = 500 thin "N/cm"^2$. Darunter je eine kleine Skizze der Klebestellen: Die Seilkraft wird in eine Normalkraft $N$ (senkrecht zur Klebefläche) und eine Tangentialkraft $T$ zerlegt; daraus $sigma_3$, $tau_3$, $sigma_4$, $tau_4$.]),
  "tm2k1_w233_3": (titel: "Bild lesen", body: [Mitschrift Beispiel 2: Ein Stab mit Gewicht $G$ am Ende hängt an der Decke, Punkt C oben, Schnitte unter den Winkeln $alpha$. Gleichgewicht liefert $L = G_S + G = 10000$ N. Unten ein schräger Schnitt mit Zerlegung von $L$ in $N_i = L sin alpha_i$ und $T_i = L cos alpha_i$, Fläche $A_i = A\/sin alpha_i$.]),
  "tm2k1_w233_4": (titel: "Bild lesen", body: [Mitschrift: drei Spalten Zahlenwerte für $sigma_i$ und $tau_i$ (erste Spalte mit dem Fehler 10.000 statt 1000). Darunter Teil 2: $A_(min)$ aus $sigma = (G + gamma L A_(min))\/A_(min) <= sigma_("zul")$, Ergebnis $A_(min) >= "4,16" thin "cm"^2$.]),
  "tm2k1_w303_1": (titel: "Bild lesen", body: [Mitschrift-Kopf „Aufgaben zu Übungsblatt Nr. 2: Dehnung und Verschiebung – statisch bestimmter Einzelstab“. Darunter die Formeln für $sigma(x)$, $epsilon(x)$, $u(x)$, $Delta L$ und der Sonderfall $A$, $N$ konstant. Unten gelb markiert „$E dot A$ ≙ Dehnsteifigkeit“ und die Bedeutung von $E$, $alpha_T$, $Delta T$.]),
  "tm2k1_w303_3": (titel: "Bild lesen", body: [Mitschrift Beispiel 2: hängender Stab (Länge $L$, $x$ nach unten). Rechts ein freigeschnittenes Stück der Länge $L - x$ mit $N(x)$ oben und dem Gewicht $G(x)$. Darunter $N(x) = rho A (L-x) g$, $sigma(x) = rho (L-x) g$ und die Dehnung $epsilon(x) = rho (L-x) g\/E$.]),
  "tm2k1_w303_4": (titel: "Bild lesen", body: [Mitschrift: c) Verschiebung durch Integrieren von $epsilon$, Konstante aus $u(0) = 0$, Ergebnis doppelt unterstrichen. d) Längenänderung $Delta L = u(L) - u(0) = rho g L^2\/(2E)$. Rechts zwei Skizzen: der Stab vorher (schwarz) und nachher (blau), rot dazwischen $Delta L$.]),
  "tm2k1_w303_5": (titel: "Bild lesen", body: [Mitschrift „Alternativ“: $Delta L = integral_0^L epsilon d x$ direkt ausgerechnet, gleiches Ergebnis $rho g L^2\/(2E)$.]),
  "tm2k1_w134_2": (titel: "Bild lesen", body: [Mitschrift Beispiel 1: In einer Hülse 3 (schraffiert, Länge $2L$) liegen Stab 1 und Stab 2 (je Länge $L$) hintereinander. Rechts eine starre Platte, an der $F$ zieht. Darunter das freigeschnittene System: $X$ in den Stäben, $F_H$ in der Hülse. Gelb markiert: $N_1 = X$, $N_2 = X$, $N_3 = F_H = F - X$.]),
  "tm2k1_w134_3": (titel: "Bild lesen", body: [Mitschrift: Schritt 3 die Längenänderungen $Delta l_3$, $Delta l_1$, $Delta l_2$ (mit Wärme in Stab 2). Schritt 4 die Kompatibilitätsbedingung $Delta l_(12) = Delta l_3$, auflösen nach $X$. Schritt 5 einsetzen: $Delta L = (F - X) dot 2L\/(E A_3)$.]),
  "tm2k1_w134_5": (titel: "Bild lesen", body: [Mitschrift Beispiel 2: starrer Balken, links Festlager 0, bei $a$ Stab 1, bei $2a$ Stab 2 und die Kraft $F$ nach unten. Abzählkriterium $3n = r + v$ zeigt: einfach statisch unbestimmt. Freischneiden mit $X$ in Stab 2. Gelb markiert $N_2 = S_2 = X$, $S_1 = 2F - 2X$ und die Spannungen.]),
  "tm2k1_w134_6": (titel: "Bild lesen", body: [Mitschrift: Längenänderungen der Stäbe, dann eine Skizze des sich drehenden starren Balkens (blau die verformte Lage, Winkel $gamma$). Aus $tan gamma = Delta l_1\/a = Delta l_2\/(2a)$ folgt $X = frac(4, 5) F$. Gelb markiert $X$, $sigma_2 = 4F\/(5A)$ und $sigma_1 = 2F\/(5A)$.]),
  "tm2k1_w204_1": (titel: "Bild lesen", body: [Mitschrift „4. Übung, Aufgabe 4.1“: Schraube (1) in Hülse (2) als statisch unbestimmte Parallelschaltung. Drei Skizzen: der Zusammenbau, die Hülse mit $Delta l_2$ und die Schraube mit $Delta l_1$ und dem Weg $n dot h$. Darunter die Längenänderungen mit Wärme; rot „Stauchung wird hier positiv!“.]),
  "tm2k1_w204_2": (titel: "Bild lesen", body: [Mitschrift: Kompatibilität $Delta l_1 + Delta l_2 = n h$, Auflösen nach $X$, Vereinfachung $l_1 approx l_2 = l$. Unten die Betriebskraft $F_B$ an Mutter und Schraubenkopf mit Skizze und den geänderten Längen $Delta l_1'$, $Delta l_2'$.]),
  "tm2k1_w204_3": (titel: "Bild lesen", body: [Mitschrift: $Delta l_2' = (X' - F_B) l\/(E_2 A_2)$, Kompatibilität $Delta l_1' + Delta l_2' = n h$, Ergebnis $X' = F_("Schraube")$. Darunter die vier Schritte zum Verspannungsschaubild: $n h$ auf der x-Achse, $F_V$ mit $Delta l_1$, $Delta l_2$ antragen, zeichnen, $F_B$ grafisch einpassen.]),
  "tm2k1_w204_4": (titel: "Bild lesen", body: [Mitschrift „Beispiel Verschiebungsplan“: die Seilaufhängung (Seile 1 und 2 unter 60° und 30°, Gewicht $G$, Knoten C). Darunter der vergrößerte Plan: rot die beiden Seilrichtungen mit $Delta l_1$ und $Delta l_2$, die Senkrechten schneiden sich im neuen Punkt C. Blau die Verschiebungen $u$ (waagerecht) und $v$ (senkrecht) mit den Formeln.]),
  "tm2k1_fs_stabsystem": (titel: "Bild lesen", body: [FS-Abschnitt 1.5 mit den drei Schritten a)–c) und Gl. (1.27). Unten links ein Zweistab (Stab 1 senkrecht, Stab 2 schräg unter 45°) mit Kraft $F$ am Knoten C. In der Mitte der Verschiebungsplan mit $Delta l_1$, $Delta l_2$ und den Hilfslängen $Delta l\/sqrt(2)$, rechts das Ergebnis $u$ und $v$.]),
  "tm2k1_fs_schraube": (titel: "Bild lesen", body: [Oben drei Schnittbilder von Schraube und Hülse mit den Kräften $X$ und den Längen $l_1$, $l_2$, $n h$. Rechts die Formeln für die Vorspannkraft. Unten das Verspannungsschaubild: Kraft $F$ über Längenänderung $Delta l$. Die steile Gerade ist die Schraube, die fallende die Hülse; ihr Schnittpunkt V ist die Vorspannung, B der Betriebspunkt, K der kritische Punkt (Klaffen).]),
  "tm2k1_ue11": (titel: "Bild lesen", body: [Drei Querschnitte nebeneinander: a) Vollkreis $D = 20$ mm, b) Kreisring $D_a = 20$ mm, $D_i = 10$ mm, c) Quadrat mit Seite 20 mm.]),
  "tm2k1_ue12": (titel: "Bild lesen", body: [Ein senkrechter Mast der Höhe $L$ steht auf dem Boden. Die Koordinate $x$ zeigt vom Boden nach oben.]),
  "tm2k1_ue13": (titel: "Bild lesen", body: [Ein trapezförmiges Maschinenteil: oben Breite $a$, unten $2a$, Höhe $h$, Dicke $t$. Oben drückt $F$, $x$ läuft von oben nach unten. Ein Schnitt R–S zeigt den rechteckigen Querschnitt $b(x) dot t$; das Eigengewicht oberhalb ist $gamma A(x)$.]),
  "tm2k1_ue21": (titel: "Bild lesen", body: [Ein Förderturm über einem Schacht. Das Seil läuft über eine Rolle oben und hängt im Schacht senkrecht nach unten (Länge $l$). Am Seilende zieht die Last $F$.]),
  "tm2k1_ue23": (titel: "Bild lesen", body: [Ein Probestab mit zwei dicken Einspannköpfen und einem schlanken zylindrischen Mittelteil, $l = 100$ mm, $d = 10$ mm.]),
  "tm2k1_ue31": (titel: "Bild lesen", body: [Ein abgesetzter Zylinder zwischen zwei festen Lagern A (links) und B (rechts): links das dünne Stück 1 (Länge $l_1$), rechts das dicke Stück 2 (Länge $l_2$), an der Absatzstelle der Punkt C.]),
  "tm2k1_ue32": (titel: "Bild lesen", body: [Oben eine Säule der Höhe $l$ mit einer Platte, auf die $F$ drückt; gestrichelt die Stahlstäbe im Inneren. Unten der Schnitt R–S: ein Quadrat aus Beton mit vier runden Stahlstäben in den Ecken.]),
  "tm2k1_ue33": (titel: "Bild lesen", body: [Ein liegender Kegelstumpf (links Durchmesser $D$ an der Wand, rechts $d$ an einer Platte A), Länge $l$. Oben und unten verbinden zwei Federn die Wand mit der Platte.]),
  "tm2k1_ue41": (titel: "Bild lesen", body: [Links ein Kolben im Schnitt (oben Stahl, unten Aluminium) mit zwei Stiftschrauben. Rechts eine Schraube vergrößert: Durchmesser $d_k$ (Gewindekern), $d_s$ (Dehnschaft), $d_i$, $d_a$ (Hülse), Länge $l = 100$ mm.]),
  "tm2k1_ue42": (titel: "Bild lesen", body: [Ein waagerechter starrer Balken (Länge $3a$, Gewicht $G$). Er ruht bei $a$ auf zwei schrägen Stäben 1 und 2 (zusammen ein V auf zwei Bodenlagern) und bei $2a$ auf dem senkrechten Stab 3 der Länge $l$. Alle Stäbe haben $E A$.]),
  "tm2k1_ue43": (titel: "Bild lesen", body: [Bild a: Knoten C wird von Stab 1 (schräg) und Stab 2 (senkrecht) gehalten; Stab 3 waagerecht zur Wand ist um $delta$ zu kurz. Bild b: dieselbe Anordnung mit einer Kraft $F$ nach rechts am Knoten C.]),
  "map-t2k1": (titel: "Die Mindmap lesen", body: [In der Mitte „Zug und Druck“. Die vier Äste: Spannung ($sigma = N\/A$), Dehnung ($epsilon = d u\/d x$), Stoffgesetz ($epsilon = sigma\/E + alpha_T Delta T$) und Statisch unbestimmt (Gleichgewicht plus Kompatibilität). Von der Kraft über die Verformung zurück zur fehlenden Kraft.]),
  "tm2k2_kartoffel": (titel: "Bild lesen", body: [Links ein beliebiger Körper („Kartoffel“) mit äußeren Kräften $F_1$, $F_2$ und einer Streckenlast $q$; gestrichelt der Schnitt s–s. Rechts der abgeschnittene Teil: Auf ein kleines Flächenstück $d A$ im Punkt P wirkt $d F$. Der Spannungsvektor $arrow(t)$ wird zerlegt in $sigma$ (in Richtung der Normale $n$) und $tau$ (in der Schnittfläche). Unten die Definition $arrow(t) = lim Delta F\/Delta A = d F\/d A$.]),
  "tm2k2_element3d": (titel: "Bild lesen", body: [Ein kleiner Quader im $x$-$y$-$z$-System. Auf jeder sichtbaren Fläche stehen eine Normalspannung ($sigma_x$, $sigma_y$, $sigma_z$) und zwei Schubspannungen (z. B. $tau_("xy")$, $tau_("xz")$). Rot: Spannungen am positiven Schnittufer, gestrichelt: am negativen. Links die Erklärung der Indizes bei $tau_("xy")$: erster Index = Flächennormale, zweiter = Richtung.]),
  "tm2k2_zugeordnet": (titel: "Bild lesen", body: [Links ein Rechteck-Element ($d y$ breit, $d z$ hoch) mit $sigma_y$, $sigma_z$ und den Schubspannungen $tau_("yz")$, $tau_("zy")$ an allen vier Seiten, Mittelpunkt M. Rechts drei Gleichgewichtsbedingungen; aus dem Momentengleichgewicht um M folgt eingerahmt $tau_("yz") = tau_("zy")$.]),
  "tm2k2_invarianten": (titel: "Bild lesen", body: [Links der symmetrische Spannungstensor (3 × 3). Rechts handschriftlich die zwei Invarianten: 1) $sigma_(xi) + sigma_(eta) = sigma_x + sigma_y$; 2) die Determinante $sigma_x sigma_y - tau_("xy")^2$ bleibt beim Drehen gleich. Dazwischen ein Element im $x$-$y$-System und dasselbe gedreht.]),
  "tm2k2_wzf_bsp1": (titel: "Bild lesen", body: [Mitschrift Beispiel 1: Ein Quader ($2a$ lang, $a$ hoch, Dicke $t$) wird links und rechts mit $2F$ gezogen und oben und unten mit $F$ gedrückt. Blau gestrichelt ein Schnitt unter $phi = 45°$. Unten der gesuchte Tensor $S$ und rechts ein Element mit positiven Spannungen.]),
  "tm2k2_dreieck": (titel: "Bild lesen", body: [Ein kleines Dreieck: links die senkrechte Fläche $d A cos phi$ mit $sigma_x$, $tau_("xy")$; unten die waagerechte Fläche $d A sin phi$ mit $sigma_y$, $tau_("yx")$; die schräge Fläche $d A$ mit $sigma_(xi)$ und $tau_(xi eta)$ im gedrehten $xi$-$eta$-System. Rechts die zwei Gleichgewichtsbedingungen in $xi$- und $eta$-Richtung.]),
  "tm2k2_transformation": (titel: "Bild lesen", body: [Rot umrahmt die drei Transformationsgleichungen für $sigma_(xi)$, $sigma_(eta)$ und $tau_(xi eta)$ mit $cos 2 phi$ und $sin 2 phi$, handschriftlich auf der Folie.]),
  "tm2k2_wzf_trafo45": (titel: "Bild lesen", body: [Mitschrift: links das bekannte Element mit $sigma_x$, $sigma_y$, $tau_("xy")$, rechts das gesuchte Dreieck mit 45°-Schnitt. In der Mitte das um 45° gedrehte Element ($xi$, $eta$ blau). Unten $cos 2 phi = 0$, $sin 2 phi = 1$ und die Rechnung für $sigma_(xi)$.]),
  "tm2k2_wzf_bsp6": (titel: "Bild lesen", body: [Mitschrift „6. Übung“: ein Element mit $sigma_x$ (Druck, Pfeile nach innen), $sigma_y$ (Zug) und $tau_("xy")$. Rechts die Werte $sigma_x = -100$, $sigma_y = 100$, $tau_("xy") = -100$ N/mm², unten der Tensor $S$. Oben rot deine Notiz „Mögliche Klausuraufgabe → auch Aufgabe 6.2“.]),
  "tm2k2_folie_hns": (titel: "Bild lesen", body: [Folientext: Aus der Extremwertaufgabe folgt $tan(2 phi^*) = 2 tau_("xy")\/(sigma_y - sigma_x)$ und daraus $sigma_(1\/2)$ mit $-tau_("xy")^2$ unter der Wurzel. Beide Stellen sind Vorzeichenfehler (siehe Kasten).]),
  "tm2k2_mohr_herleitung": (titel: "Bild lesen", body: [Handschriftlich: Aus den Transformationsgleichungen folgt $[sigma_(xi) - frac(1, 2)(sigma_x + sigma_y)]^2 + tau_(xi eta)^2 = ((sigma_x - sigma_y)\/2)^2 + tau_("xy")^2$, grün darunter als $(sigma - sigma_M)^2 + tau^2 = r^2$. Unten ein $sigma$-$tau$-Diagramm mit dem Mittelpunkt $sigma_M$, dem Abstand $frac(1, 2)(sigma_x - sigma_y)$ und dem Radius $r$ als Hypotenuse mit $tau_("xy")$.]),
  "tm2k2_fs_kreis": (titel: "Bild lesen", body: [Ein Kreis im $sigma$-$tau$-Diagramm. Durch den Mittelpunkt $sigma_M$ läuft die Linie von $P = (sigma_x, tau_("xy"))$ nach $P' = (sigma_y, -tau_("xy"))$. Blau eine um $2 phi$ gedrehte Linie zu $Q = (sigma_(xi), tau_(xi eta))$ und $Q'$. Rechts und links auf der $sigma$-Achse $sigma_1$ und $sigma_2$, oben und unten $plus.minus tau_(max)$. Links oben in Rot ein kleines Element mit den Spannungen.]),
  "tm2k2_w45_5": (titel: "Bild lesen", body: [Mitschrift „Mohr'scher Kreis“ (rot: „kommt i. d. Prüfung dran!“): Regeln $P = (sigma_x; tau_("xy"))$, $P' = (sigma_y; -tau_("xy"))$, Maßstab 20 N/mm² ≙ 1 cm, Winkel von $overline(sigma_M P)$ aus messen, $2 phi$ in entgegengesetzter Richtung. Darunter ein blauer Kreis um den Ursprung, rot die Linie $P P'$, grün die Winkel $2 phi^*$ und $2 phi^(**)$; unten die Rechenergebnisse.]),
  "tm2k2_w45_6": (titel: "Bild lesen", body: [Mitschrift „Abgelesen bzw. Mohr'scher Kreis“: $2 phi^* = 45°$ → $phi^* = "22,5"°$, $sigma_1 = "141,0"$, $sigma_2 = -"141,0"$ N/mm², $phi^(**) = "67,5"°$, $sigma_M = 0$.]),
  "tm2k2_mohr_bongmba": (titel: "Bild lesen", body: [Bildschirmfoto der Bongmba-Folie „2.2 Ebener Spannungszustand – Spannungskreis“. Sie zeigt denselben Kreis wie FS TM2 S. 15: $P$, $P'$, $Q$, $Q'$, $sigma_1$, $sigma_2$, $sigma_M$, $plus.minus tau_(max)$ und die Winkel $2 phi$ und $2 phi^(**)$.]),
  "tm2k2_mohr_tabelle": (titel: "Bild lesen", body: [Eine Tabelle mit acht Zeilen (A01–A08): $sigma_x = plus.minus 50$ oder $plus.minus 10$, $sigma_y = plus.minus 20$, $tau_("xy") = plus.minus 30$ N/mm². Die Zeilen unterscheiden sich nur in den Vorzeichen.]),
  "tm2k2_mohr_a01": (titel: "Bild lesen", body: [Karopapier mit $sigma$- und $tau$-Achse. Ein roter Kreis rechts vom Ursprung, blau die Linie durch $P$ und $P'$ und durch den Mittelpunkt; markiert $sigma_x$, $sigma_y$, $sigma_1$, $sigma_2$, $sigma_M$, $tau_(max)$ und grün der Winkel $2 phi$.]),
  "tm2k2_mohr_a01_zust": (titel: "Bild lesen", body: [Drei Elemente nebeneinander: Ausgangslage ($phi = 0$) mit $sigma_x$, $sigma_y$, $tau_("xy")$; um $phi^*$ gedreht mit nur $sigma_1$ und $sigma_2$ (Hauptnormalspannungszustand); um $phi^(**)$ gedreht mit $tau_(max)$ und $sigma_M$ auf allen Seiten (Hauptschubspannungszustand).]),
  "tm2k2_w115_1": (titel: "Bild lesen", body: [Mitschrift „7. Übung: Zweiachsiger Spannungszustand, Anwendungen, Vergleichsspannungen“: ein eingespannter Behälter mit Innendruck $p$ und Torsionsmoment $M_t$ am Deckel. Gegeben $r = 10$ mm, $t = 1$ mm, $p = 10$, $M_t = 31420$. Gesucht vier Teile. Unten das Element mit $sigma_x$, $sigma_y$, $tau_("xy")$; blau der Verweis „Formelsammlung Formel 2.20“.]),
  "tm2k2_w115_2": (titel: "Bild lesen", body: [Mitschrift: $sigma_x = p r\/(2t) = 50$, $sigma_y = p r\/t = 100$, $tau_("xy") = -M_t\/(2 pi r^2 t) = -50$ N/mm², dazu eine Skizze der Torsion am Rohr. Der Tensor $S$ ist doppelt unterstrichen. Unten Teil 2 mit $tan 2 phi^*$, $phi^* = "31,71"°$ und dem Ansatz für $sigma_(xi)^*$.]),
  "tm2k2_w115_3": (titel: "Bild lesen", body: [Mitschrift: $sigma_(xi)^* = "19,1" = sigma_2$, $sigma_(eta)^* = "130,9" = sigma_1$, Kontrolle mit der Summe 150 N/mm². Darunter $phi^(**) = "76,71"°$, $tau_(xi eta)^(**) = "55,90" = tau_(max)$ und $sigma_M = 75$ N/mm².]),
  "tm2k2_w115_4": (titel: "Bild lesen", body: [Mitschrift: Teil 3 Schweißpunktrichtung mit einer Skizze des gedrehten Elements ($phi^* approx 30°$, $alpha = 60°$). Teil 4 die drei Vergleichsspannungen: Normalspannungshypothese 130, Schubspannungshypothese 130 (gleiche Vorzeichen), von Mises 122,50 N/mm².]),
  "tm2k2_ue51": (titel: "Bild lesen", body: [Ein Blechstreifen (Länge $l$, Breite $b$, Dicke $t$), rechts zieht $F$. Gestrichelt ein Schnitt unter 45° durch den Streifen.]),
  "tm2k2_ue52": (titel: "Bild lesen", body: [Ein Blechstreifen, an beiden Enden gezogen mit $sigma_x$. In der Mitte eine schräge Schweißnaht, die um $phi$ gegen die Senkrechte geneigt ist.]),
  "tm2k2_ue71": (titel: "Bild lesen", body: [Ein senkrechtes Rohr (Bohrkrone). Oben drückt $F_x$ nach unten, ein Drehpfeil zeigt das Torsionsmoment $M_t$. Unten ein kleines Wandstück mit den Achsen $x$ (nach unten) und $y$ (nach rechts).]),
  "map-t2k2": (titel: "Die Mindmap lesen", body: [In der Mitte „Spannungszustand“. Die vier Äste: Tensor ($sigma_x$, $sigma_y$, $tau_("xy")$), Transformation (Winkel $2 phi$), Hauptspannungen ($sigma_1$, $sigma_2$, $tau_(max)$) mit dem Mohrschen Kreis, Vergleichsspannung ($sigma_V <= sigma_("zul")$).]),
  "tm2k3_verformung": (titel: "Bild lesen", body: [Folie „Komplexes Verformungsbild“ (Bild aus Gross/Hauger/Schnell). Ein kleines Rechteck PQRS ($d x$ mal $d y$) wird zum grauen Parallelogramm P'Q'R'S'. P verschiebt sich um $u$ und $v$. Q verschiebt sich zusätzlich um $(partial u\/partial x) d x$ nach rechts und $(partial v\/partial x) d x$ nach oben, S um $(partial u\/partial y) d y$ und $(partial v\/partial y) d y$. Der rechte Winkel bei P' wird zu $pi\/2 - gamma_("xy")$, die Kippwinkel heißen $alpha$ und $beta$.]),
  "tm2k3_reine": (titel: "Bild lesen", body: [Folie „Mehrdimensionale Dehnung: reine Verzerrung“. Ein Element mit Ecke P im Ursprung. Die Kante PQ ($d x$) kippt um $beta$ nach oben bis Q' (Höhe $(partial v\/partial x) d x$), die Kante PS ($d y$) kippt um $alpha$ nach rechts bis S' (Versatz $(partial u\/partial y) d y$). Grün die Flächen, die beim Kippen dazukommen. Der Winkel bei P ist jetzt $90° - gamma$.]),
  "tm2k3_w185_1": (titel: "Bild lesen", body: [Mitschrift „8. Übung TM2: Spannung, Verzerrung, Stoffgesetz“, Beispiel 1 (identisch zu Aufgabe 8.1). Ein Blechstreifen (Länge $L$) mit $F_x$ links und rechts nach außen, $F_(t 1)$ an den kurzen Seiten und $F_(t 2)$ an den langen Seiten (Schub). Gegeben $L = 1$ m, $B = 100$ mm, $t = 1$ mm, $F_x = "10,5"$ kN, $F_(t 1) = "8,08"$ kN, $F_(t 2) = "80,8"$ kN, $E = "2,1" dot 10^5$ N/mm², $nu = "0,3"$, $G = "0,808" dot 10^5$ N/mm². Gesucht: a) Spannungstensor $S$, b) Verzerrungstensor $V$, c) Hauptdehnungen.]),
  "tm2k3_w185_2": (titel: "Bild lesen", body: [Mitschrift Lösung a): $sigma_x = F_x\/(b t) = 105$ N/mm², $tau_("xy") = F_(t 1)\/(b t) = "80,8"$ N/mm², $sigma_y = 0$, zur Kontrolle $tau_("xy") = F_(t 2)\/(L t) = "80,80"$ N/mm². Darunter der Tensor $S$. Teil b) mit dem Hookeschen Gesetz (FS 3.20, 3.21): $epsilon_x = "0,5" dot 10^(-3)$, $epsilon_y = -"0,15" dot 10^(-3)$; die Einheiten N/mm² sind rot weggekürzt.]),
  "tm2k3_w185_3": (titel: "Bild lesen", body: [Mitschrift: $gamma_("xy") = tau_("xy")\/G = "1,0" dot 10^(-3)$ rad (FS 3.22) und der Verzerrungstensor $V$ mit $"0,5"$, $frac(1, 2) dot "1,0"$ und $-"0,15"$ (mal $10^(-3)$). Darunter eine Skizze: schwarz das unverformte Rechteck, blau das verformte, schräg gezogene Parallelogramm; rot der Winkel unten links.]),
  "tm2k3_w185_4": (titel: "Bild lesen", body: [Mitschrift c): $epsilon_(xi)^*$ mit FS 3.7 und $phi^* = "28,15"°$ ergibt $"0,77" dot 10^(-3) = epsilon_1$; $epsilon_(eta)^*$ mit FS 3.8 ergibt $-"0,42" dot 10^(-3) = epsilon_2$. Kontrolle (FS 3.10): $epsilon_x + epsilon_y = epsilon_1 + epsilon_2 = "0,35" dot 10^(-3)$, abgehakt.]),
  "tm2k3_w185_5": (titel: "Bild lesen", body: [Mitschrift „Mohr'scher Dehnungskreis“ (1 cm ≙ $"0,1" dot 10^(-3)$). Waagerecht die $epsilon$-Achse, senkrecht $frac(1, 2) gamma$. Ein roter Kreis; schwarz die Linie von $P = (epsilon_x; frac(1, 2) gamma_("xy"))$ nach $P' = (epsilon_y; -frac(1, 2) gamma_("xy"))$, am Mittelpunkt der Winkel $2 phi^*$. Unten eine Tabelle: Rechnung $phi^* = "28,15"°$, $epsilon_1 = "0,77"$, $epsilon_2 = -"0,42"$; Zeichnung $28°$, $"0,78"$, $-"0,42"$ (je $10^(-3)$).]),
  "tm2k3_w185_6": (titel: "Bild lesen", body: [Mitschrift Beispiel 2, rot daneben deine Notiz „pot. Klausuraufgabe“. Eine DMS-Rosette mit drei Streifen a (in $x$), b (unter 45°) und c (in $y$). Messwerte $epsilon_a = "0,5"$ ‰, $epsilon_b = "0,1675"$ ‰, $epsilon_c = -"0,15"$ ‰. Gesucht der Verzerrungstensor. Lösung: $epsilon_x = epsilon_a$, $epsilon_y = epsilon_c$, $epsilon_(xi) = epsilon_b$ bei $phi = 45°$ (Skizze rechts), daraus $gamma_("xy") = 2 epsilon_b - (epsilon_a + epsilon_c) = "1,0" dot 10^(-3)$ und derselbe Tensor $V$ wie in Beispiel 1.]),
  "tm2k3_dms_aufgabe": (titel: "Bild lesen", body: [Folie „Aufgabenstellung Dehnmeßstreifen (DMS)“. Tabelle der Messwerte: $epsilon_a = 12$, $epsilon_b = 2$, $epsilon_c = -2$ (je $10^(-4)$). Werkstoff: $E = "2,1" dot 10^5$ N/mm², $nu = "0,3"$. Gesucht: Hauptdehnungen, Winkel $phi^*$ und die zugehörigen Hauptspannungen.]),
  "tm2k3_dms_anordnung": (titel: "Bild lesen", body: [Folie „Anordnung der DMS“. Im $x$-$y$-System liegt Streifen b auf der $x$-Achse, Streifen c unter $+45°$ (Richtung $eta$) und Streifen a unter $-45°$ (Richtung $xi$). Grün die zwei Achsen $xi$ und $eta$, die senkrecht aufeinander stehen.]),
  "tm2k3_dms_winkel": (titel: "Bild lesen", body: [Folie „Einsetzen der Winkel“: Für a ($-45°$) gilt $cos(-90°) = 0$ und $sin(-90°) = -1$, also $epsilon_a = frac(1, 2)(epsilon_x + epsilon_y) - frac(1, 2) gamma_("xy")$. Für c ($+45°$) gilt $epsilon_c = frac(1, 2)(epsilon_x + epsilon_y) + frac(1, 2) gamma_("xy")$.]),
  "tm2k3_dms_sigma": (titel: "Bild lesen", body: [Folie „Spannungsberechnung“: $sigma_1 = E\/(1 - nu^2) (epsilon_1 + nu epsilon_2) = 273$ N/mm² und $sigma_2 = E\/(1 - nu^2)(epsilon_2 + nu epsilon_1) = 27$ N/mm². Auf der Folie steht vor $nu$ jeweils ein Minus; das ist ein Folienfehler (siehe Kasten), die Zahlen passen zum Plus.]),
  "tm2k3_dms_richtung": (titel: "Bild lesen", body: [Folie „Darstellung der Hauptspannungsrichtungen“: dieselbe DMS-Anordnung wie vorher. Orange die Richtung von $sigma_1$ und $sigma_2$ (oben rechts als Pfeile), lila die Richtungen der größten Schubspannung $tau_(max)$, die um 45° dazu gedreht sind.]),
  "tm2k3_ue81": (titel: "Bild lesen", body: [Ein Blechstreifen (Länge $l$, Breite $b$, Dicke $t$), rechts zieht $F$ in $x$-Richtung. Gestrichelt eine schräge Linie durch den Streifen, mit einem kleinen Pfeil senkrecht dazu (die Messrichtung).]),
  "tm2k3_ue83": (titel: "Bild lesen", body: [Eine DMS-Rosette als Skizze: Richtung a waagerecht nach rechts, b unter 45° und c senkrecht nach oben (90° zu a).]),
  "tm2k3_ue93": (titel: "Bild lesen", body: [Aufgabentext oben (Quader wird um 100 °C erwärmt, gesucht $F$, damit er sich in $z$-Richtung nicht ausdehnt). Bild a: ein Quader (Breite $a$, Höhe $h$) steht in einer starren Form, oben drückt $F$ über eine Platte. Bild b: das Element mit Druckspannungen $sigma_z$ oben und unten und $sigma_x$ links und rechts.]),
  "map-t2k3": (titel: "Die Mindmap lesen", body: [In der Mitte „Verzerrung“. Die vier Äste: Dehnung ($epsilon = partial u\/partial x$), Gleitung ($gamma = tau\/G$), Hooke ($E$, $nu$, $G$ verknüpfen Spannung und Verzerrung), DMS (drei Messungen ergeben $sigma_1$ und $sigma_2$).]),
  "tm2k4_biegung_m0": (titel: "Bild lesen", body: [Links ein grauer Kragarm, an der Wand eingespannt. Am freien Ende dreht ein rotes Moment $M_0$. Eine Schere zeigt den Schnitt. Rechts das abgeschnittene Stück: Am Schnittufer zeigen rote Pfeile die Spannung, oben Druck ($sigma_(D max)$), unten Zug ($sigma_(Z max)$), dazwischen linear.]),
  "tm2k4_ursache": (titel: "Bild lesen", body: [Ein Balken auf zwei Lagern A und B. Eine Kraft $F$ drückt von oben, rechts davon dreht ein Moment $M_0$. Grün die Maße $a$, $b$ und $l$ von A aus, eine Schere markiert eine Schnittstelle zwischen A und $F$.]),
  "tm2k4_gg_element": (titel: "Bild lesen", body: [Handschrift „Gerade Biegung, benötigte Formeln: Gleichgewicht, Kinematik, Werkstoffgesetz (vgl. Berechnung statisch unbestimmter Systeme)“. Darunter ein Balken mit $F$, $M_0$ und $q_0$, ein herausgeschnittenes Element $d x$ mit $N$, $Q$, $M$ links und $N$, $Q + d Q$, $M + d M$ rechts, und ein Element mit Spannungen $sigma$ und $tau$ an der Fläche $d A$.]),
  "tm2k4_kinematik": (titel: "Bild lesen", body: [Oben $d Q\/d x = -q$, $d M\/d x = Q$ und $M = integral z sigma d A$, $Q = integral tau d A$, $N = integral sigma d A$. Mitte „2) Kinematik“: ein Rechteck $d x times d z$ wird länger ($d u = epsilon d x$) und schief ($partial w\/partial x$, $partial u\/partial z$), daraus $epsilon = partial u\/partial x$ und $gamma = partial w\/partial x + partial u\/partial z$. Unten „3) Werkstoffgesetz“: $sigma = E epsilon$, $tau = G gamma$, Querkontraktion vernachlässigt ($sigma_x >> sigma_y, sigma_z$).]),
  "tm2k4_bernoulli": (titel: "Bild lesen", body: [Grün ein gebogener Balken (verformte Struktur) über dem geraden (unverformte Struktur). Ein Querschnitt mit Punkt P wandert nach P' und dreht sich, bleibt aber eben; markiert die Absenkung $w$, die Drehung $psi$ und die Verschiebung $u = z psi$. Unten der Text: Gleichgewicht, Kinematik und Werkstoffgesetz reichen nicht, deshalb a) $w = w(x)$ und b) Ebenbleiben der Querschnitte (Bernoulli) $u(x, z) = psi z$.]),
  "tm2k4_herleitung": (titel: "Bild lesen", body: [Oben drei Spalten: Annahmen ($w = w(x)$, $u = psi z$), Kinematik ($epsilon$, $gamma$), Werkstoffgesetz ($sigma = E epsilon$, $tau = G gamma$). Daraus $sigma = E psi' z$ und $tau = G(w' + psi)$, $Q = kappa G A_s (w' + psi)$, $N = E psi' S_y$ (grün: bei Symmetrie 0) und $M = E psi' I_y$. Unten die „Nebenbemerkung“ mit vier Steifigkeiten: $E A$ Dehn-, $E A_s$ Schub-, $G I$ Biege-, $G I_T$ Torsionssteifigkeit.]),
  "tm2k4_ueberlagerung": (titel: "Bild lesen", body: [Vier Kästchen nebeneinander: Zug (konstante Spannung), Biegung durch $M_B$ (lineare Spannung, oben und unten entgegengesetzt), Schub durch $F$ (Schubspannung) und Torsion durch $M_T$. Darunter „Addition gleichgerichteter Spannungen“.]),
  "tm2k4_ftm_ansatz": (titel: "Bild lesen", body: [Ein Kragarm mit Rechteckquerschnitt (Breite $b$, Höhe $h$), links auf einem Lager A. Grün das lokale Koordinatensystem im Schwerpunkt: $x$ in Längsrichtung, $y$ nach links, $z$ nach unten.]),
  "tm2k4_ftm_herleitung": (titel: "Bild lesen", body: [Derselbe Kragarm, jetzt mit roter Spannungsverteilung: oben Druck bis $sigma_(d max)$, unten Zug bis $sigma_(z max)$, in der Mitte (S) $sigma = 0$. Ein orangener Streifen $b dot d z = d A$ im Abstand $z$. Unten links: lineare Spannung $sigma(z) = c z$ ($c$ = Steigung der Geraden). Rechts: Schnittmoment $d M = z dot sigma d A$, aufsummiert $M = c integral z^2 d A = c I$, daraus $sigma = M\/I dot z$ und mit $z = z_(max)$: $sigma_b = M_b\/W_b$.]),
  "tm2k4_widerstand": (titel: "Bild lesen", body: [Handschrift „Widerstandsmoment“: aus $d M = z sigma d A$ folgt $sigma = M\/I dot z$ (blau umrahmt). Für $z = z_(max)$ gilt $I\/z_(max) = W$. Darunter rot: $z_(max)$ ist der Abstand vom Flächenschwerpunkt zur äußersten Faser. Beispiele: Rechteck (beide Ränder gleich weit, $e_1 = e_2 = h\/2$) und Dreieck ($e_1 != e_2$, der größere zählt).]),
  "tm2k4_spannungsverlauf": (titel: "Bild lesen", body: [Drei Querschnitte links (Rechteck, Dreieck, Achteck), rechts jeweils der Balken mit dem roten Spannungsverlauf über die Höhe: eine schräge Gerade von $sigma_(d max)$ oben bis $sigma_(z max)$ unten. Beim Dreieck liegt die Nulllinie nicht in der Mitte. Beim Achteck sind Hilfslinien „$tilde z^2$“ eingezeichnet.]),
  "tm2k4_wzf0106_aufgabe": (titel: "Bild lesen", body: [Mitschrift „9. Übung TM2: Biegespannungen“, Beispiel Balken mit Einzellast. Einfeldträger A–B (Länge $L$), $F$ von oben im Abstand $L\/3$ vor B, Schnitt C–C. Daten: $F = 200$ kN, $c = 333$ mm, $t = 15$ mm, $L = 10$ m, $sigma_("zul")$. Unten der Schnitt: ein quadratischer Kasten mit Wanddicke $t$, Teilflächen ① außen und ② innen. Rot daneben „2. Aufgabe in Klausur!“.]),
  "tm2k4_w0106_qm": (titel: "Bild lesen", body: [Mitschrift: Balken mit $A_x$, $A_y$, $B_y$, $F$ bei $frac(2, 3) L$. $F_A = F\/3$, $F_B = frac(2, 3) F$. Q-Verlauf: positiv bis $frac(2, 3) L$, dann Sprung nach $-frac(2, 3) F$. M-Verlauf: Dreieck mit Spitze $M_(max)$ bei $frac(2, 3) L$. Unten $Q_(max) = -frac(2, 3) F$, $M_(max) = frac(2, 9) F L$ und ein Freikörperbild; rechts deine Notiz „Kap. 7 TM I ist das wichtigste, da alles vernetzt“.]),
  "tm2k4_w0106_duenn": (titel: "Bild lesen", body: [Mitschrift „Satz von Steiner (FS 4.19)“: $I_y$ aus vier Teilen, zwei Gurte mit Eigenanteil $c t^3\/12$ und Steiner-Anteil $(c\/2)^2 c t$, zwei Stege mit $t c^3\/12$ ohne Steiner-Anteil. Zusammengefasst $I_y = frac(2, 3) c^3 t$ (Zahlenwert als „369,26 · 10#super[3] mm#super[4]“ beschriftet). Unten „Widerstandsmoment $W_y = I_y\/|z_(max)|$“ mit Skizze: rot ist $z_(max)$ bis zur Außenkante markiert.]),
  "tm2k4_ftm1_symm": (titel: "Bild lesen", body: [Handschrift „Flächenträgheitsmomente I. und II. Ordnung“: I. Ordnung (statische Momente) $S_y = integral z d A$, $S_z = integral y d A$, Anwendung Schwerpunkt $y_s = integral y d A\/integral d A$. Eigenschaft: Statische Momente um die Schwerpunktachsen sind null. Unten ein symmetrisches Dreieck mit zwei Flächenstücken $d A$ links und rechts: $S_z = S_(z l i) + S_(z r e) = 0$, aber $S_y != 0$.]),
  "tm2k4_rechteck_iy": (titel: "Bild lesen", body: [Folie „Berechnung des Flächenträgheitsmomentes $I_y$“: gelbes Rechteck ($b$ breit, $h$ hoch), rot ein waagerechter Streifen der Höhe $Delta z$. Rechts $I_y = integral z^2 d A = integral_(-h\/2)^(h\/2) z^2 b d z = b h^3\/12$.]),
  "tm2k4_fs_tabelle": (titel: "Bild lesen", body: [Formelsammlung: oben „Parallelverschiebung – Satz von Steiner“ mit einer Fläche, Schwerpunkt S und den Gleichungen 4.19–4.21. Darunter zwei Tabellen aus Gross/Hauger/Schröder/Wall mit $I_y$, $I_z$, $I_("yz")$, $I_p$ und $I_T$ für Rechteck, Quadrat, Dreieck, Kreis, dünnen Kreisring, Halbkreis und Ellipse.]),
  "tm2k4_steiner": (titel: "Bild lesen", body: [Handschrift „Parallelverschiebung der Bezugsachsen“: eine Fläche mit Schwerpunkt S, schwarz das $y$-$z$-System durch S, rot das parallele $overline(y)$-$overline(z)$-System, Abstände $overline(y)_s$ und $overline(z)_s$. Unten die Rechnung $I_(overline(y)) = integral (z + overline(z)_s)^2 d A = I_y + 2 overline(z)_s integral z d A + overline(z)_s^2 A$; grün: das statische Moment ist im Schwerpunkt 0, also $I_(overline(y)) = I_y + overline(z)_s^2 A$.]),
  "tm2k4_steiner_box": (titel: "Bild lesen", body: [Rot umrahmt die drei Steiner-Formeln: $I_(overline(y)) = I_y + overline(z)_s^2 A$, $I_(overline(z)) = I_z + overline(y)_s^2 A$, $I_(overline(y) overline(z)) = I_("yz") - overline(y)_s overline(z)_s A$.]),
  "tm2k4_platte_loecher": (titel: "Bild lesen", body: [Ein graues Rechteck (Breite $b$, Höhe $h$) mit zwei gelben Rechteck-Aussparungen links und rechts der Mitte (Schwerpunkte $S_2$, $S_3$, Abstände $e_1$, $e_2$). Der Gesamtschwerpunkt $S_1$ liegt in der Mitte, Achsen $overline(y)$ nach links und $overline(z)$ nach unten. Rechts und unten eine Tabellenrechnung; die Löcher stehen mit „(−)“ in der Tabelle, Ergebnis rot $I_1$, $I_2$.]),
  "tm2k4_iprofil": (titel: "Bild lesen", body: [Folie „I-Profil stehend“: links das Profil, rot die Gurte ($b = 75$, $s = 7$ mm), blau der Steg ($h = 90$, $t = 4$ mm). Rechts die Schwerpunkttabelle (Flächen 525, 360, 525 mm², Abstände ±48,5 mm, Schwerpunkt in der Mitte). Unten die FTM-Tabelle mit Eigenanteilen und Steiner-Anteilen: $I_y = 2717150$, $I_z = "492667,5" thin "mm"^4$, $I_("yz") = 0$. Ganz unten $y_(max) = "37,5"$ mm, $z_(max) = 52$ mm und $W_("by") = 72457$, $W_("bz") = 9474$ (vertauscht, siehe Kasten).]),
  "tm2k4_iprofil_disk": (titel: "Bild lesen", body: [Folientext „Zwischenbetrachtung“: Bei Biegung um die $overline(y)$-Achse bietet das stehende I-Profil einen viel höheren Widerstand als das liegende ($I_(y, "ges")$). Wo die Belastung die größte Spannung macht, sitzt auch das meiste Material („wo viel Spannung, da viel Material“).]),
  "tm2k4_drehung": (titel: "Bild lesen", body: [Handzeichnung: das $y$-$z$-System (schwarz) und das um $phi$ gedrehte $eta$-$zeta$-System (blau) mit einem Flächenstück $d A$ (rot). Viele Hilfsdreiecke zeigen die Anteile $y cos phi$, $z sin phi$, $y sin phi$, $z cos phi$. Oben blau $eta = y cos phi + z sin phi$, unten braun $zeta = -y sin phi + z cos phi$.]),
  "tm2k4_transformation": (titel: "Bild lesen", body: [Handschrift „Herleitung der FTM im gedrehten Koordinatensystem“: $I_(eta) = integral zeta^2 d A$ ausmultipliziert gibt $I_z sin^2 phi - 2 I_("yz") sin phi cos phi + I_y cos^2 phi$; mit den Doppelwinkel-Formeln wird daraus rot umrahmt die Transformationsregel für $I_(eta)$, $I_(zeta)$ und $I_(eta zeta)$.]),
  "tm2k4_hauptachsen": (titel: "Bild lesen", body: [Handschrift: Deviationstensor $I_("yz") = mat(I_y, I_("yz"); I_("yz"), I_z)$ mit den Invarianten $I_y + I_z = I_(eta) + I_(zeta) = I_p$ und $det$. Darunter die Extremwertaufgabe $tan 2 phi^* = 2 I_("yz")\/(I_y - I_z)$ und $I_(1,2) = (I_y + I_z)\/2 plus.minus sqrt(...)$ (grün: $I_M$ und $I_("yz" max)$), dann $tan 2 phi^(**) = -(I_y - I_z)\/(2 I_("yz"))$. Unten: „→ Tabelle FHS“, „→ Schwerpunktberechnung!“.]),
  "tm2k4_wzf0806_ue10": (titel: "Bild lesen", body: [Aufgabenblatt Übung 10, Aufgabe 10.1: ein graues Rechteck ($4a$ breit, $6a$ hoch) mit weißem Rechteckloch ($2a times 3a$, Abstand $a$ von oben), Hilfsachse $y'$ an der Oberkante, $z = z'$ in der Mitte. Ganz oben rot deine Notiz „Prüfung: Flächenträgheitsmomente mit versch. Ausschnitten!“.]),
  "tm2k4_wzf0806_bsp": (titel: "Bild lesen", body: [Mitschrift „Beispiel“: Quadrat $c times c$, schraffiert, oben rechts ein Dreieck ($c\/2 times c\/2$) abgeschnitten. Darunter orange markierte Schritte: 1) Schwerpunkt-Tabelle ($y'_s = z'_s = "0,548" c$), 2) $y$-$z$-KS durch S, 3) FTM der Einzelflächen mit Steiner, das Dreieck aus der FS gedreht. Rechts 4) Summe FTM, 5) Haupt-FTM mit $phi^* = 45°$ und unten eine Kontrollskizze mit den Hauptachsen $eta^*$ (1) und $zeta^*$ (2).]),
  "tm2k4_dgl": (titel: "Bild lesen", body: [Handschrift „Biegelinie“: $d Q\/d x = -q$, $d M\/d x = Q$, $psi' = M\/(E I)$, für schubstarre Balken $w' + psi = 0$. Nach Elimination von $psi$: $w'' = -M\/(E I)$ (umrahmt), daneben die Krümmung $kappa = w''\/(1 + w'^2)^(3\/2) approx w''$. Unten „Integration führt zu“ die Kette $E I w^("IV") = q$, $E I w''' = -Q$, $E I w'' = -M$, $E I w' = -psi$, $E I w$ → Biegelinie.]),
  "tm2k4_allg_dgl": (titel: "Bild lesen", body: [Folie: „Die Biegelinie kann aus der Streckenlast in allgemeiner Form der Lösung über den Satz der allgemeinen DGLn berechnet werden“. Für $E I w^("IV") = q_0 x^n$ folgen durch Integrieren $E I w'''$, $E I w''$, $E I w'$ und $E I w$ mit den Konstanten $C_1$ bis $C_4$. Unten klein ein Balken mit Streckenlast.]),
  "tm2k4_rb_tabelle": (titel: "Bild lesen", body: [Tabelle „Rand“ mit den Spalten $Q$, $M$, $w'$, $w$: gelenkiges Lager $Q != 0$, $M = 0$, $w' != 0$, $w = 0$; Einspannung $Q != 0$, $M != 0$, $w' = 0$, $w = 0$; Parallelführung (zweites Symbol) $Q = 0$, $M != 0$, $w' = 0$, $w != 0$; freies Ende $Q = 0$, $M = 0$, $w' != 0$, $w != 0$.]),
  "tm2k4_faelle_abc": (titel: "Bild lesen", body: [Mitschrift „Berechnung der DGL der Biegung“: drei Balken mit gleicher Last $q_0$: a) links eingespannt, rechts frei; b) beidseitig gelenkig; c) links eingespannt, rechts gelenkig. Darunter die gemeinsame DGL bis $E I w = q_0 x^4\/24 + ...$ und für jeden Fall die vier Randbedingungen, z. B. a) $Q(L) = 0$, $M(L) = 0$, $w'(0) = 0$, $w(0) = 0$.]),
  "tm2k4_ss_loesung": (titel: "Bild lesen", body: [Folie: Einarbeiten der Konstanten führt zur speziellen Lösung für den beidseitig gelenkigen Balken unter $q_0$: $E I w''' = q_0 x - q_0 l\/2$ bis $E I w = frac(1, 24) q_0 x^4 + ... + q_0 l^2\/24 dot x$ (Exponent falsch, siehe Kasten). Unten der Balken auf zwei Lagern mit roter Streckenlast.]),
  "tm2k4_fall_a": (titel: "Bild lesen", body: [Mitschrift „DGL für Fall a)“: aus $w(0) = 0$ folgt $C_4 = 0$, aus $w'(0) = 0$ folgt $C_3 = 0$, aus $M(L) = 0$ und $Q(L) = 0$ folgen $C_1 = -q_0 L$ und $C_2 = frac(1, 2) q_0 L^2$. Rechts eingerahmt die fertige Biegelinie des Kragarms mit Belastung und Reaktion.]),
  "tm2k4_fall_c": (titel: "Bild lesen", body: [Mitschrift „Fall c) statisch unbestimmt“: $C_4 = 0$, $C_3 = 0$, dann zwei Gleichungen (1) $M(L) = 0$ und (2) $w(L) = 0$ für $C_1$, $C_2$. Mit dem Additionsverfahren folgt $C_1 = -frac(5, 8) q_0 L$ und $C_2 = frac(1, 8) q_0 L^2$ (doppelt unterstrichen).]),
  "tm2k4_dreieck1": (titel: "Bild lesen", body: [Mitschrift „Aufgabe: Einfeldproblem statisch unbestimmt“: Balken links bei A eingespannt, rechts bei B gelenkig, rote Dreieckslast mit $q_0$ bei A, null bei B. Rechts die Geradengleichung der Last $q(x) = -q_0 x\/L + q_0$ mit Steigungsdreieck (orange). Darunter der Satz der allgemeinen DGLn und die Randbedingungen bei A ($C_3 = C_4 = 0$) und B.]),
  "tm2k4_dreieck3": (titel: "Bild lesen", body: [Mitschrift: Satz der speziellen DGLn mit den Konstanten. Unten die Lagerreaktionen: Freikörperbild an A (rot $M_A$, $A_H$, $A_v$), aus $Q(0)$ folgt $A_v = frac(2, 5) q_0 L$, aus $M(0)$ folgt $M_A = frac(1, 15) q_0 L^2$.]),
  "tm2k4_w1506_bsp1": (titel: "Bild lesen", body: [Mitschrift „Einfeldbalken, Beispiel 1“: blauer Kragarm, links eingespannt, Länge $L$, am rechten Ende rot $F$ nach unten und ein Moment $M_0$. Rechts: gegeben $E I_y$ ($I_z$ nicht nötig, $I_("yz") = 0$: symmetrischer Querschnitt, Belastung in Hauptachsenrichtung, gerade Biegung), gesucht die Durchbiegung $w(x)$.]),
  "tm2k4_wzf1506_rb": (titel: "Bild lesen", body: [Mitschrift: $w(0) = C_4 = 0$, $w'(0) = C_3 = 0$, $Q(L) = C_1 = F$, $M(L) = C_1 L + C_2 = M_0$ → $C_2 = M_0 - F L$. Rot deine Notiz „Integrieren in d. Klausur nicht so wichtig, eher Randbedingungen aufstellen!“. Darunter das Ergebnis $w(x) = -1\/(E I)[F x^3\/6 + (M_0 - F L) x^2\/2]$ und „c) 4-fache Integration für $E I$ = konst.“.]),
  "tm2k4_mehrbereich": (titel: "Bild lesen", body: [Folie „Streckenlast – Aufwand zur Berechnung der Integrationsvariablen“: ein Balken auf zwei Lagern A, B mit $q_0$ nur auf der Länge $a$. Grün „Aufteilen der Struktur in (zwei) Bereiche“, rechts die zwei Teile mit Übergang ($x_1 = a$, $x_2 = 0$). Unten die allgemeinen DGLn: ① mit $q_0$ und $C_1$–$C_4$, ② ohne Last mit $C_5$–$C_8$.]),
  "tm2k4_ueberg_streckenlast": (titel: "Bild lesen", body: [Mitschrift „Berechnung der Integrationskonstanten aus Rand- und Übergangsbedingungen“: Lager A ($x_1 = 0$): $M = 0$ → $C_2 = 0$, $w = 0$ → $C_4 = 0$. Lager B ($x_2 = b$): $M = 0$ und $w = 0$. Übergang bei $x_1 = a$ / $x_2 = 0$: $E I w'''$, $E I w''$, $E I w'$ und $E I w$ beider Bereiche sind gleich.]),
  "tm2k4_matrix": (titel: "Bild lesen", body: [Handgeschriebenes Gleichungssystem $A dot arrow(x) = arrow(b)$: eine $8 times 8$-Matrix (Spalten $C_1$ bis $C_8$) mit vielen Nullen, rot die Hauptdiagonale. Rechts der Lastvektor mit $q_0$-Termen. Blau „Schwach besetzt! Bandbreite“.]),
  "tm2k4_ueberg_einzellast": (titel: "Bild lesen", body: [Mitschrift „Übergangsbedingungen ($x_1 = a$, $x_2 = 0$)“: Freikörperbild an der Stelle von $F$ mit $Q$ links und rechts. Aus dem Gleichgewicht $Q_1 + F - Q_2 = 0$ folgt der Sprung in $Q$ (rot eingekreist). Für $M$, $w'$ und $w$ gilt Gleichheit beider Bereiche; unten „Berechnung fortsetzen …“.]),
  "tm2k4_foeppl_def": (titel: "Bild lesen", body: [Mitschrift „Föppl-Symbol in der Balkenbiegung“: $chevron.l x - a chevron.r^n$ ist 0 für $x < a$ und $(x - a)^n$ für $x > a$; Integrieren wie gewohnt. Anwendung auf Biegelinientafel Lastfall 1 (Einfeldträger, $F$ bei $a$): allgemeine DGL mit $F chevron.l x - a chevron.r^0$. Orange: Vorzeichenwahl von $F$ nach Definition der Achse. Unten die Randbedingungen bei A.]),
  "tm2k4_foeppl_teil": (titel: "Bild lesen", body: [Mitschrift „Bereichsoperator als An-/Aus-Schalter“: Streckenlast $q_0$ nur auf Länge $a$ eines Einfeldträgers. $E I w^("IV") = q_0 chevron.l x - 0 chevron.r^0 - q_0 chevron.l x - a chevron.r^0$ (rosa und orange eingekreist), dann viermal integriert. Unten Lager A: $C_2 = C_4 = 0$; Lager B liefert $C_1$.]),
  "tm2k4_maximalansatz": (titel: "Bild lesen", body: [Mitschrift „Aufgabe“: ein langer Balken von A (eingespannt) bis C mit Moment $M_0$, Gelenk G1, Lager B, Parallelführung G2 und Dreieckslast $q_0$ am Ende. Die DGL enthält Föppl-Terme für jede Größe, grün eingekreist die Sprungterme $E I Delta phi chevron.l x - L chevron.r$ und $E I Delta w chevron.l x - 2L chevron.r^0$. Unten die Randbedingungen bei A und C.]),
  "tm2k4_lastfall1": (titel: "Bild lesen", body: [Mitschrift „Biegelinientafel Lastfall 1“: Einfeldträger A–B, $F$ bei $a$. Allgemeine DGL mit Föppl-Symbol, Randbedingungen ($C_2 = C_4 = 0$, $C_1 = -F b\/L$, $C_3$ aus $w(L) = 0$). Unten die Biegelinie in dimensionsloser Form $E I w = F L^3\/6 [beta xi (1 - beta^2 - xi^2) + chevron.l xi - alpha chevron.r^3]$.]),
  "tm2k4_lastfall4": (titel: "Bild lesen", body: [Mitschrift „Biegelinientafel Lastfall 4“: Einfeldträger A–B, Moment $M_0$ bei $a$. Links die Umformung bis $E I w = M_0 L^2\/6 [xi (3 beta^2 - 1) + xi^3 - 3 chevron.l xi - alpha chevron.r^2]$, rechts die allgemeine DGL und die Konstanten aus den Lagern A und B.]),
  "tm2k4_wzf1506_gelenk": (titel: "Bild lesen", body: [Mitschrift „Mehrfeldbalken: Superposition (+ „X“ falls System statisch unbestimmt)“, Beispiel 2: links und rechts eingespannte Balken ($L$ und $L$), dazwischen ein Gelenk. $F$ von oben am Gelenk, rot $q_0$ auf dem rechten Feld (Pfeile von unten). Lösung: Teil I links mit $F$ und $X$ (Fall [6]), Teil II rechts mit $X$ (Fall [6]) minus $q_0$ (Fall [7]). Darunter die Verträglichkeit bis $X = F\/2 + q_0 L dot 3\/16$, rechts oben $w_G = F L^3\/(6 E I) - q_0 L^4\/(16 E I)$.]),
  "map-t2k4": (titel: "Die Mindmap lesen", body: [In der Mitte „Biegung“. Die vier Äste: Spannung ($sigma = M\/I dot z$, $sigma_(max) = M\/W$), Flächenträgheitsmoment ($I = integral z^2 d A$, Steiner), Hauptachsen ($tan 2 phi^*$, $I_1$, $I_2$), Biegelinie ($E I w'' = -M$, Rand- und Übergangsbedingungen).]),
  "tm2k4_ue91": (titel: "Bild lesen", body: [Ein Kragarm (Länge $40 a$), links eingespannt, rechts $F$ nach unten, Schnitt A–A. Rechts der Querschnitt „A–A“: ein Hutprofil, oben ein Steg der Breite $2a$, zwei senkrechte Wände der Höhe $2a$ und unten zwei Füße der Breite $a$; Wanddicke $t$.]),
  "tm2k4_ue92": (titel: "Bild lesen", body: [Eine Stange auf Lager A (links) und B. Von A aus nach 1,8 m greift 5 kN an, nach weiteren 1,2 m liegt Lager B, dann 0,8 m Kragende mit 3 kN am Ende.]),
  "tm2k4_ue10": (titel: "Bild lesen", body: [Aufgabe 10.1: graues Rechteck ($4a$ breit, $6a$ hoch) mit weißem Loch ($2a$ breit, $3a$ hoch), das Loch beginnt $a$ unter der Oberkante. Hilfsachse $y'$ an der Oberkante, $y$ durch den Schwerpunkt, $z = z'$ senkrecht in der Mitte.]),
  "tm2k4_ue102": (titel: "Bild lesen", body: [Aufgabe 10.2: schraffiertes Quadrat (Seite $a$) mit einem rechteckigen Schlitz ($b$ breit, $c$ lang), der um 45° gedreht durch die Mitte läuft. Achsen $y$ und $z$ durch die Mitte, unten 45° markiert. Rechts die Hinweise (FTM subtrahieren, Hauptachsen durch Anschauung, Transformationsgleichung) und $b = a\/4$, $c = a$.]),
  "tm2k4_ue103": (titel: "Bild lesen", body: [Aufgabe 10.3: links ein Z-Profil (Gesamthöhe 200, oben Gurt 70 nach links, unten Gurt 70 nach rechts, Steg 10, Gurtdicke 13 mm) mit $y$, $z$ durch S. Rechts dasselbe dünnwandig als Mittellinie: Gurte 75 mm, Steghöhe 187 mm, Wanddicken 13, 10, 13.]),
  "tm2k4_ue104": (titel: "Bild lesen", body: [Aufgabe 10.4: links ein C-förmiger Querschnitt (Stegbreite 10 mm, oberer Gurt 30 mm, unterer Gurt 60 mm breit, Gurtdicken 10 mm, Stegmitte 50 mm), Hilfsachsen $y'$, $z'$ und Schwerpunkt S. Rechts ein Kragarm der Länge $l$ unter Streckenlast $q$.]),
  "tm2k4_ue11": (titel: "Bild lesen", body: [Aufgabenblatt Übung 11, S. 1: 11.1 Balken auf zwei gelenkigen Lagern mit Endmoment $M_0$ bei B (a: System, b: Freikörperbild); 11.2 beidseitig eingespannter Balken unter $q_0$; 11.3 rechts eingespannter Träger unter $q_0$ mit Rechteckquerschnitt (Breite $b$, Höhe $h(x)$).]),
  "tm2k4_ue11_4": (titel: "Bild lesen", body: [Aufgabe 11.4: Balken von A (eingespannt) über das Gelenk G bis B (eingespannt), Felder je $a$. $F$ greift am Gelenk an, $q_0$ liegt auf dem letzten Feld vor B.]),
  "tm2k5_kinematik": (titel: "Bild lesen", body: [Handschriftliche Folie „Torsion (kreisrunde Welle)“. Links eine eingespannte Welle der Länge $L$ mit $M_T$ am Ende; eine Mantellinie wird um $gamma$ schräg, der Querschnitt dreht sich um $d theta$. Darunter die Kette: $r thin d theta = gamma thin d x$ → $gamma = r theta'$ → $tau = G gamma = G r theta'$ → $M_T = integral r tau thin d A = G theta' I_p$. Rot umrahmt: $G I_T theta' = M_T$ und $theta_L = M_T L\/(G I_T)$.]),
  "tm2k5_formeln_kreis": (titel: "Bild lesen", body: [Oben rot umrahmt $tau_("max") = M_T\/W_T$ und $tau = M_T\/I_T dot r$, grün daneben „vgl. Biegung“. Darunter die Anwendung: Kreiswelle mit $I_T = I_p = frac(pi, 2) R^4$, $W_T = frac(pi, 2) R^3$; dickwandiges Rohr und dünnwandiges Rohr (Skizze: Ring abgewickelt zu einem Streifen der Länge $U = 2 pi R_m$). Die Rohrformeln auf der Folie sind fehlerhaft (siehe Kasten).]),
  "tm2k5_tau_linear": (titel: "Bild lesen", body: [Ein roter Kreis (Querschnitt) mit grünem Achsenkreuz. Eine schräge Linie durch den Mittelpunkt zeigt den Betrag von $tau$: null in der Mitte, größter Wert $tau_T$ oben und unten am Rand. Die Pfeile stehen senkrecht zum Radius.]),
  "tm2k5_polares_ftm": (titel: "Bild lesen", body: [Oben links ein Punkt im $x$-$y$-System mit Abstand $r$ vom Ursprung, $r^2 = x^2 + y^2$. Rechts die axialen FTM $I_x$, $I_y$ und das polare $I_p = integral r^2 d A = I_x + I_y$ (umrahmt), Text: „polares FTM ist die Summe der axialen FTM“. Unten ein Kreis mit einem orangen Ring der Breite $d r$, abgewickelt als Streifen $2 pi r$ mal $d r$; Integration ergibt $I_p = frac(pi, 2) R^4$.]),
  "tm2k5_inkreis": (titel: "Bild lesen", body: [Drei Querschnitte (grau) mit dem jeweils größten einbeschriebenen Kreis (blau): ein hohes Rechteck, eine liegende Ellipse und ein auf der Spitze stehendes Quadrat.]),
  "tm2k5_bsp_vollkreis": (titel: "Bild lesen", body: [Oben links eine Kurbel: Welle (Radius $r$, Länge $L$) mit zwei Kräften $F$ im Abstand $2R$. Daneben die gegebenen Werte $R = 200$ mm, $r = 20$ mm, $L = 5$ m, $tau_("zul") = 150$, $G = "0,8" dot 10^5 thin "N/mm"^2$. Darunter die Rechnung: a) $M_T = 2 R F$, $F <= 4710$ N; b) $Delta theta = "0,47" "rad" ≙ 27°$.]),
  "tm2k5_dgl": (titel: "Bild lesen", body: [Ein eingespannter Stab mit verteiltem Streckenmoment $m_T$. Rechts das Freikörperbild eines Stückes $d x$: links $M_T$, rechts $M_T + d M_T$, dazwischen $m_T d x$. Gleichgewicht: $d M_T\/d x = -m_T$; mit $M_T = G I_T theta'$ folgt $-m_T = (G I_T theta')'$. Unten „Beispiel: Streckenbelastung, Integration“.]),
  "tm2k5_fs_tab1": (titel: "Bild lesen", body: [Tabelle mit vier Spalten (Querschnitt, $W_T$, $I_T$, Bemerkungen). Zeilen: Vollkreis ($pi R^3\/2$, $pi R^4\/2$, $tau_("max")$ am Rand), Ellipse ($pi a b^2\/2$, $pi a^3 b^3\/(a^2 + b^2)$, Endpunkte der kleinen Achse), Quadrat ($"0,208" a^3$, $"0,141" a^4$, Mitte der Seiten), dickwandiges Kreisrohr ($frac(pi R_a^3, 2) (1 - alpha^4)$, $frac(pi R_a^4, 2) (1 - alpha^4)$ mit $alpha = R_i\/R_a$, äußerer Rand).]),
  "tm2k5_stat_unbest": (titel: "Bild lesen", body: [Links eine Welle zwischen zwei Einspannungen, auf dem rechten Stück ein grünes Streckenmoment $m_0$; darunter die DGL mit Föppl-Klammern und die Randbedingungen $theta(0) = 0$, $theta(L) = 0$. Rechts zwei Diagramme: der Momentenverlauf $M_T$ (links konstant, ab $a$ linear fallend) und der Verdrehwinkel $theta$ (erst linear, dann Parabel, mit „tangentialem Übergang“ bei $a$).]),
  "tm2k5_beispiele_duenn": (titel: "Bild lesen", body: [Fotos von dünnwandigen Profilen aus dem Handel: ein Vierkantrohr, ein gelochtes Blechprofil, eine C-Schiene mit Langlöchern, unten ein U-Profil und ein Z-Profil aus Edelstahl. Nur das Vierkantrohr ist geschlossen.]),
  "tm2k5_schubfluss": (titel: "Bild lesen", body: [Ein Stück eines dünnwandigen geschlossenen Profils (beliebige Form) mit Torsionsmoment $M_T$. Ein kleines Element $d s$ mal $d x$ (orange) zeigt die Schubspannung $tau$ entlang der Wand; die Koordinate $s$ läuft um den Umfang. Rechts der Text: Außen- und Innenfläche sind belastungsfrei, also verläuft $tau$ tangential und ist über die Dicke konstant. Umrahmt: Schubfluss $T = tau dot t$.]),
  "tm2k5_gg_element": (titel: "Bild lesen", body: [Ein rechteckiges Wandelement zwischen $s$ und $s + d s$ sowie $x$ und $x + d x$. An den Rändern $T$ und $T + frac(partial T, partial x) d x$ bzw. $T + frac(partial T, partial s) d s$. Aus dem Gleichgewicht folgt $partial T\/partial x = 0$ und $partial T\/partial s = 0$: „Schubfluss rund um das Profil ist konstant“, $T = tau dot t = "konst"$. Voraussetzung $N = 0$ (keine Verwölbung behindert).]),
  "tm2k5_bredt1": (titel: "Bild lesen", body: [Oben links ein Hohlprofil mit der Fläche $A_m$ (innerhalb der Mittellinie) und dem Hebelarm $r_perp$ zum Schubfluss $T d s$. Rechnung: $d M_T = r_perp T d s$, Integration über den Umlauf, $integral.cont r_perp d s = 2 A_m$ → $M_T = 2 A_m T$. Rot: „Achtung: im Allgemeinen gilt $A_m != A$!“ Umrahmt: $tau = frac(M_T, 2 A_m t)$ (1. Bredtsche Regel). Rechts: $tau_("max")$ bei $t_("min")$ und $W_T = 2 A_m t$.]),
  "tm2k5_bredt2": (titel: "Bild lesen", body: [Links zwei Skizzen der Verformung eines Wandpunktes: Er wandert um $d v = r_perp d theta$ entlang der Wand. Darunter die Schubverzerrung $gamma = partial u\/partial s + partial v\/partial x$ und die Bedingung, dass der Umlauf geschlossen ist ($integral.cont partial u\/partial s thin d s = 0$). Rechts umrahmt: $theta' = M_T\/(G I_T)$ (2. Bredtsche Regel) und $I_T = (2 A_m)^2 \/ integral.cont d s\/t$.]),
  "tm2k5_fs_tab2": (titel: "Bild lesen", body: [Fortsetzung der FS-Tabelle: dünnwandige geschlossene Hohlquerschnitte ($W_T = 2 A_m t_("min")$, $I_T = (2 A_m)^2\/integral.cont d s\/t$, Schubfluss konstant, $tau_("max")$ bei $t_("min")$); dünnwandiges Kreisrohr ($2 pi R_m^2 t$, $2 pi R_m^3 t$); schmales Rechteck ($frac(1, 3) h t^2$, $frac(1, 3) h t^3$); aus schmalen Rechtecken zusammengesetzte Profile ($approx frac(1, 3) sum h_i t_i^3\/t_("max")$, $approx frac(1, 3) sum h_i t_i^3$, $tau_("max")$ bei $t_("max")$), Skizzen eines C- und eines T-Profils.]),
  "tm2k5_wzf_rohr": (titel: "Bild lesen", body: [Mitschrift auf Karopapier: ein liegendes Rohr, links in eine Wand eingespannt, rechts mit Deckel. Innen roter Stern für den Innendruck $p$, am Deckel ein Drehpfeil $M_t$. Darunter „Geg.: mittlerer Radius $r = 10$ mm, Wanddicke $t = 1$ mm“.]),
  "tm2k5_offen_herl": (titel: "Bild lesen", body: [Links ein hohes, schmales Rechteck (Höhe $h$, Dicke $t$) im $y$-$z$-System und daneben dasselbe mit roten Pfeilen: Schub nach oben auf der einen, nach unten auf der anderen Seite. Darunter die lineare Verteilung $tau(y)$ von $-tau_0$ bis $+tau_0$ und die Geradengleichung $y = m x + b$. Rechts die Rechnung: $d T = tau(y) d y$, $d M_T = 2 A_m d T$ mit $A_m = 2 y h$, Integration von $0$ bis $t\/2$; rot umrahmt $M_T = frac(1, 3) tau_0 h t^2$.]),
  "tm2k5_offen_wt": (titel: "Bild lesen", body: [Folie „Torsion dünnwandiger offener Querschnitte“: $M_T = frac(1, 3) tau_0 h t^2$, $tau_("max")$ am Rand, aus dem Vergleich mit $tau_("max") = M_T\/W_T$ folgt umrahmt $W_T = frac(1, 3) h t^2$. Dann „Berechnung des Torsionsträgheitsmoments“: $d I_T = 8 h y^2 d y$, umrahmt $I_T = frac(1, 3) h t^3$. Unten rechts für zusammengesetzte Profile: $I_T = frac(1, 3) sum h_i t_i^3$ und $W_T = frac(1, 3) sum h_i t_i^3\/t_("max")$.]),
  "tm2k5_fs_offen": (titel: "Bild lesen", body: [FS-Ausschnitt mit zwei Karopapier-Skizzen. Links ein schmales Rechteck mit rot gestricheltem Schubfluss, der an einer Seite hoch- und an der anderen herunterläuft; rot die Frage „„Fluß“ von $tau$ (geschlossen?)“. Rechts ein U-förmiges Profil aus drei Teilen ($h_1$, $h_2$, $h_3$, Mittellinie $R_m$) mit demselben rot gestrichelten Fluss. Darunter „Einzelnes Rechteck“ (5.15) und „Zusammengesetzte offene Profile“ (5.16).]),
  "tm2k5_vergleich_og": (titel: "Bild lesen", body: [Oben ein Stab mit $M_T$ an beiden Enden und die gegebenen Werte. Links das geschlossene Kastenprofil (Seite $a$, Wanddicken $2t$ und $t$) mit $A = a^2$, $integral.cont d s\/t = 3a\/t$, $I_T = frac(4, 3) t a^3$, $W_T = 2 a^2 t$ → $M_(T "zul") = 6400$, $Delta theta = "0,0188" "rad" = "1,07"°$. Rechts das offene Profil mit Schlitz: $I_T = 6 t^3 a$, $W_T = 3 t^2 a$ → $M_(T "zul") = 96$, $Delta theta = "0,625" "rad" = "35,8"°$.]),
  "tm2k5_vergleich_qs": (titel: "Bild lesen", body: [Handgeschriebene Tabelle mit vier Zeilen. Spalten: Profil-Skizze, $W_T$, charakteristische Länge (aus $tau_("max") = tau_("zul")$ aufgelöst), Fläche. Vollkreis $a = "53,5"$ mm, $A = "89,9" thin "cm"^2$; Quadrat $2b$ mit $b = "52,4"$ mm, $A = "109,8" thin "cm"^2$; geschlossenes Rohr $c = "72,6"$ mm, $A = "33,1" thin "cm"^2$ (grüner Haken); geschlitztes Rohr $d = "225,4"$ mm, $A = "319,2" thin "cm"^2$.]),
  "tm2k5_wzf_bsp_quer": (titel: "Bild lesen", body: [Mitschrift „Beispiel“: oben ein eingespannter Kragarm (Länge $L$) mit rotem $M_T$ am Ende, rechts „Geg.: $M_T$, $G$, $L$; Ges.: $tau_("max")$, $Delta theta$ für“. Darunter drei Querschnitte: a) volles Quadrat $c times c$ (schraffiert); b) dünnwandiger geschlossener Kasten mit oben $2d$, sonst $d$, $d = "0,1" c$; c) derselbe Kasten mit einem Schlitz in der unteren Wand.]),
  "tm2k5_w2206_loes": (titel: "Bild lesen", body: [Mitschrift „Lösung“: a) $W_T = "0,208" c^3$, $I_T = "0,141" c^4$, $tau_("max")$ am Rand in der Mitte der Seite. b) Kasten mit blau schraffierter Fläche $A_m$ und markiertem $t_("min")$; $W_T = 2 A_m t_("min") = "0,2" c^3$ („≈ $"0,208" c^3 = W_T (a)$“); $integral.cont d s\/t = frac(c, 2d) + frac(c, d) + frac(c, d) + frac(c, d)$; $I_T = frac(2 dot "0,1" c dot 4 c^3, 7) = "0,114" c^4$ („gleiche Größenordnung wie $I_T (a)$“). Rechts eine kleine Skizze mit Umlaufrichtung $s$.]),
  "tm2k5_wzf_schubfluss": (titel: "Bild lesen", body: [Oben der geschlossene Kasten mit roten Pfeilen rundherum (Schubfluss), Text: „$tau_("max")$ ≙ größte Schubspannung an der Stelle der kleinsten Wanddicke $t_("min")$“. Mitte: Teil c), der Kasten mit Schlitz unten; $W_T = frac(1, 3) sum h_i t_i^3\/t_("max")$ mit $t_("max") = 2d$, Ergebnis $W_T = "0,0183" c^3$ („≈ 9,12 % von $W_T (a)$“). Unten der offene Kasten mit rot gestricheltem Fluss in jeder Wand und $tau_("max")$ in der Wand mit $t_("max")$.]),
  "tm2k5_w2206_it": (titel: "Bild lesen", body: [Eine Rechenzeile: $I_T = frac(1, 3) sum h_i t_i^3 = frac(1, 3) (frac(c, 2) d^3 + c d^3 + c (2d)^3 + c d^3 + frac(c, 2) d^3) = frac(11, 3) c d^3$, mit $d = "0,1" c$ unterstrichen „$I_T = "0,00367" c^3$ (≈ 3,22 % von $I_T (a)$)“. Die Einheit $c^3$ ist falsch (richtig $c^4$).]),
  "tm2k5_lkw_rahmen": (titel: "Bild lesen", body: [Schwarz-weißes Foto eines Lkw-Fahrgestells ohne Aufbau: zwei lange Längsträger mit mehreren Querträgern (Leiterrahmen), vorn Motor und Lenkrad, hinten Doppelachse mit Zwillingsreifen. Oben die Bildquelle als Link.]),
  "map-t2k5": (titel: "Die Mindmap lesen", body: [In der Mitte „Torsion“. Die vier Äste: Kreiswelle ($tau_("max") = M_T\/W_T$), Verdrehung ($theta' = M_T\/(G I_T)$), dünnwandig geschlossen (Bredt, $T = M_T\/(2 A_m)$) und dünnwandig offen ($I_T = frac(1, 3) sum h t^3$).]),
  "ak_2018_rahmen": (titel: "Bild lesen", body: [Foto der Klausur. Links ein Rahmen: senkrechter Stab $A$–$B$ (Höhe $a$, Moment $M_0$ in halber Höhe), waagrechter Riegel $B$–$G$–$C$ mit gleichmäßiger Streckenlast $q_0$, senkrechter Stab $C$–$D$, waagrechter Stab $D$–$E$ mit Kraft $F$ in der Mitte. Unten die Bemaßung in Schritten $a\/2$. Rechts die Tabelle: $a = 2$ m, $q_0 = 2$ kN/m, $F = 2$ kN, $M_0 = 2$ kNm, $A_H = 2$ kN, $A_V = 3$ kN, $E_H = 2$ kN, $E_V = 3$ kN.]),
  "ak_2018_fachwerk": (titel: "Bild lesen", body: [Handskizze auf Karopapier. Zwei waagrechte Gurte im Abstand $a$, drei Felder der Breite $a$. Unten links Knoten I, darüber II mit Kraft $F$ nach unten. Festlager $A$ = Knoten III, darüber IV; Knoten V unten in der Mitte, darüber VI mit $2F$; rechts unten Loslager $B$ = VII, darüber VIII. Stäbe 1 bis 13; die Diagonalen 3, 7 und 11 stehen unter dem Winkel $alpha$.]),
  "ak_2018_ftm": (titel: "Bild lesen", body: [Links ein Kreis (schraffiert) mit dem Hilfs-KS $y'$ (nach links) und $z'$ (nach unten) in der Ecke. Darin ausgespart: ein rechtwinkliges Dreieck ② und darunter ein Rechteck ③. Die Bemaßung läuft in Schritten $a\/2$. Rechts eine Skizze des Trägers, der in eine Wand eingespannt ist.]),
  "ak_2018_ftm_tab": (titel: "Bild lesen", body: [Tabelle mit vorgegebenen Werten für $a = 30$ mm. Zeile 1: $A = 2830$, $y' = 30$, $z' = 30$, $y = "0,5"$, $z = 1$. Zeile 2(−): $225$, $35$, $25$, $"5,5"$, $-4$. Zeile 3(−): $450$, $30$, $"37,5"$, $"0,5"$, $"8,5"$.]),
  "ak_2018_torsion": (titel: "Bild lesen", body: [Drei gleichseitige Dreiecksprofile nebeneinander. Links mit dicker Wand $t_1$ und dünnen Wänden $t_2$, dazu $y$- und $z$-Achse (Biegung um $y$). In der Mitte das gleiche Profil geschlossen, rechts mit einem Schlitz (offen), beide unter Torsion um die $x$-Achse. Darunter eine Tabelle zum Ausfüllen.]),
  "ak_2018_ix": (titel: "Bild lesen", body: [Links eingespannter Balken der Länge $l$, oben $I_0$ an der Einspannung, rechts dünner mit $I(x)$; $F$ wirkt am rechten Ende nach unten. Daneben die Formel $I(x) = I_0 l\/(l + x)$.]),
  "ak_2018_dreifeld": (titel: "Bild lesen", body: [Balken von $A$ (Einspannung) bis $C$. Über dem ersten Stück eine Dreieckslast von $2 q_0$ bei $A$ auf null; $F$ greift am Gelenk $G$ an. Loslager $B$ bei $a$, Loslager $C$ bei $2a$. Im dritten Feld steigt die Last von $q_0\/2$ bei $B$ auf $q_0$ bei $C$. Felder I, II, III; $x$ läuft ab $A$.]),
  "ak_p13_zweifeld": (titel: "Bild lesen", body: [Balken von $A$ (frei, Kraft $F$) über $B$ (Loslager, Abstand $a$) bis $C$ (Einspannung, nochmals $a$). Die Streckenlast steigt von $q_0$ bei $A$ auf $2 q_0$ bei $B$ und fällt dann auf null bei $C$. Bereiche I und II, $x$ ab $A$.]),
  "ak_u_profile": (titel: "Bild lesen", body: [Links zwei gleiche U-Profile. In der Mitte, rot eingezeichnet, die beiden Profile Rücken an Rücken als I-Form mit Pfeil auf $sigma_("max")$ (für Biegung). Rechts die Profile mit den Öffnungen zueinander zu einem geschlossenen Kasten verschweißt, Notiz „Torsion“ (für Torsion).]),
  "ak_stab_ax": (titel: "Bild lesen", body: [Stab der Länge $l$, links in eine Wand eingespannt und dort breiter, nach rechts schmaler bis $A_0$. Am rechten Ende drückt $F$ nach links. Daneben handschriftlich $A(x) = A_0 dot 2l\/(l + x)$, unten „Druck“.]),
  "ak_ss16_rahmen": (titel: "Bild lesen", body: [Rahmen: senkrechter Stab $A$–$B$ mit $M_0$ in der Mitte, Riegel $B$–$G$–$C$ mit $F$ zwischen $B$ und $G$ und dachförmiger Last (Spitze $q_0$) zwischen $G$ und $C$, Lager in $A$ und $C$. Rechts die Tabelle: $q_0 = 1$ kN/m, $F = 1$ kN, $M_0 = 1$ kNm, $a = 2$ m, $A_H = "0,5"$ kN, $A_V = 1$ kN, $C_H = "0,5"$ kN, $C_V = 1$ kN.]),
  "ak_ss16_fachwerk": (titel: "Bild lesen", body: [Fachwerk auf Karopapier. Links oben Lager $B$ (Knoten I), links unten Festlager $A$ (Knoten II). Oben die Knoten I, III, V, unten II, IV, VI. Stäbe 1 bis 9, zwei Diagonalen unter $alpha$. In Knoten VI wirkt $F$ schräg nach links oben in Richtung von Stab 7. Rote Kreise an den Nullstäben.]),
  "ak_ss16_klotz": (titel: "Bild lesen", body: [Links: Klotz $G_1$ auf rauer Unterlage ($mu_0$), $F$ zieht nach links; ein Seil läuft unter $alpha$ nach rechts oben zu einer Rolle, an der $G_2$ hängt. Rechts der freigeschnittene Klotz mit $F$, $G_1$, Seilkraft $G_2$ unter $alpha$, Normalkraft $N$ und Haftkraft $H_0$.]),
  "ak_p25_profil": (titel: "Bild lesen", body: [Links das abgewinkelte Profil: Einspannung oben links bei $A$, Länge $l_1$ und $l_2$, $F_1$ senkrecht nach unten, $F_2$ in Richtung $A$–$B$. In der Mitte der Querschnitt: Halbring mit Steg (schraffiert), $y$ waagrecht, $z$ nach unten. Rechts die Zahlenwerte $t = 5$ mm, $r_i = 15$ mm, $h = 40$ mm, $l_1 = "0,5"$ m, $l_2 = 1$ m, $E$, $G$, $nu = "0,3"$, $F_1 = "0,9"$ kN, $F_2 = 10$ kN.]),
  "ak_ss16_ftm": (titel: "Bild lesen", body: [Oben links ein eingespannter Träger mit Kraft. Rechts der Querschnitt (Höhe $h = 60$ mm) mit halbkreisförmiger und dreieckiger Aussparung; eingezeichnet der Schwerpunkt $S$, die Achsen $y$, $z$ und die gedrehten Hauptachsen 1 und 2 unter $phi^*$.]),
  "ak_unb_ftm": (titel: "Bild lesen", body: [Querschnitt: oben ein Halbkreis ①, darunter ein breites Rechteck ③, in das ein Rechteck ② (gestrichelt, Aussparung) eingeschrieben ist. Hilfs-KS $y'$, $z'$; Schwerpunkt $S$ mit Achsen $y$, $z$ und Hauptachse 1 unter $phi^*$. Rechts die Werte $t = 10$, $b = 20$, $h = 40$ mm.]),
  "ak_unb_torsion": (titel: "Bild lesen", body: [Links ein abgewinkeltes Profil mit $F_1$ und $F_2$. Rechts der Querschnitt: Kreisring mit dreieckigem Anbau, symmetrisch zu $y$ und $z$, Wanddicken $t_1$ und $t_2$. Daneben $r_i = 15$, $t_1 = 5$, $h_1 = 20$, $h_2 = 15$, $t_2 = "3,5"$, $Delta y_s = "3,5"$ mm, $l = 1$ m, $F_2 = 10$ kN, $F_1 = "0,05"$ kN.]),
  "ak_unb_balken": (titel: "Bild lesen", body: [Balken der Länge $L$ von $A$ (links, an der Wand geführt) bis $B$ (Festlager mit Moment $M_0$). Eine Dreieckslast fällt von $q_0$ bei $A$ auf null bei $B$. Von Hand eingezeichnet zwei mögliche Biegelinien ① und ②.]),
  "cover": (titel: "Bild lesen", body: [Drei Grundbilder des Moduls nebeneinander. Links ein Fachwerk auf Fest- und Loslager mit einer Kraft $F$ oben (TM1: freischneiden, Gleichgewicht). In der Mitte ein Balken auf zwei Lagern unter der Streckenlast $q_0$, darunter gestrichelt die Biegelinie $w(x)$ (TM2: Spannung, Dehnung, Biegelinie). Rechts eine eingespannte Welle mit Torsionsmoment $M_T$; die schräge Linie zeigt, wie sich die Mantellinie verdreht.]),

)


#let bild(name, caption, height: 55mm) = block(width: 100%, breakable: false, above: 0.6em, below: 0.6em)[
 #align(center)[#image(abbildungen.at(name), format: "svg", width: 100%, height: height, fit: "contain")]
 #v(1.2mm)
 #align(center)[#text(size: 8.4pt, fill: muted, caption)]
 #let deutung = bilddeutungen.at(name, default: none)
 #if deutung != none [
  #v(2mm)
  #text(weight: "bold", fill: teal)[#deutung.titel.] #deutung.body
 ]
]

#align(center)[
#v(8mm)
#text(size: 11pt, tracking: 1pt, fill: teal)[VERSTEHEN · ERKLÄREN · ANWENDEN]
#v(6mm)
#text(size: 29pt, weight: "bold", fill: navy)[Technische Mechanik]
#v(2mm)
#text(size: 14pt, fill: navy)[TM1 Statik · TM2 Elastostatik]
#v(4mm)
#text(size: 20pt, fill: navy)[Feynman-Lernskript]
#text(size: 13pt, fill: teal)[Klausurfassung · Stand 26.10.2026]
#v(4mm)
#bild("cover", [Schematische Illustration; eigens erzeugt, nicht maßstäblich.], height: 57mm)
#text(size: 12pt, fill: teal)[Freischneiden → Gleichgewicht → Schnittgrößen → Spannung und Verformung]
]
#note("Dein Feynman-Schritt", [Erkläre bei jeder Aufgabe: *Welchen Körper betrachte ich? Welche Bindung ersetzt welche Kraft? Warum gilt mein Ansatz?* Rechne erst danach und prüfe das Ergebnis mit Vorzeichen, Einheit und einem Grenzfall.])
Diese Fassung konzentriert sich auf deine Themenliste „Klausur TM“, die neu eingereichte Prüfung SS 2023/24 von Bongmba/Sosnowsky und die dazu passenden Übungsblätter. Die ältere Vollfassung ist gesichert. Schwerpunkt sind die Aufgaben aus TM1 ab Übungsblatt 6 sowie die genannten TM2-Themen. Wärme-Verträglichkeit und Tabellen-Superposition sind durch AK24 ausdrücklich belegt. Die Kapitelnummern der Vorlesung bleiben zur Orientierung erhalten; allgemeine Einführung und doppelte Herleitungen sind gekürzt. Seit dem 26.10.2026 stehen Aufgaben, ausführliche Lösungen und Quiz auf der Lernwebseite (Tab „Lernen“); dieses Skript enthält Erklärung und Formelsammlung.
#src[Prüfungshinweise „Klausur TM“, PDF-S. 1; Altklausur SS 24, PDF-S. 1–26. Auswahl und Lernwege: eigene Zusammenstellung.]
#pagebreak()
#heading(level: 1, outlined: false)[Wegweiser]
#block[
#set text(size: 9.2pt)
#set par(leading: 0.25em, spacing: 0.1em)
#outline(title: none, depth: 2, indent: auto)
]
#text(size: 8.3pt, fill: muted)[*Quellenkürzel:* KH = deine Themenliste „Klausur TM“; AK24 = „Altklausur SS 24.pdf“ (im Kopf SS 2023/24, Bongmba/Sosnowsky); P1/P2 = neu eingereichte „Übungsblätter TM1/TM2“ mit deinen Rechnungen; neue Lösungen = Lösungspaket vom 26.10.2026; FS TM1/TM2 = Formelsammlungen, auch als neue Kopien; Skript TM1 = Bongmba-Folien mit deinen Notizen; Skript TM2 = Sosnowsky; WZF = Mitschrift der Übung. Alte Klausuren = Scans 2013–2018. Seiten sind stets PDF-Seiten. Eigene Beispiele, Lösungen und Skizzen sind gekennzeichnet.]
Die älteren Klausuren bestätigen wiederkehrende Aufgabenmuster; einige stammen aus anderen Studiengängen und von anderen Prüfern. Deine undatierte Themenliste ist die Arbeitsgrundlage, keine verbindliche Zusage für den Zweitversuch. Dessen Termin, Dauer und erlaubte Hilfsmittel sind weiter offen.
#src[KH S. 1; P1 S. 1 und 50; AK24 S. 1, 18–26; ältere Klausurköpfe.]
#pagebreak()
#heading(level: 1, outlined: false, bookmarked: false)[Das Modul auf einen Blick] <ueberblick>

Jeder Kasten führt zu seinem Kapitel. Die Pfeiltexte zeigen, wie die Kapitel zusammenhängen.

#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([TM1 Kapitel 1 · Das Werkzeug für Klausuraufgaben], [Freischnitt · Komponenten · Hebelarm · Gleichgewicht], ziel: <k-tm1-1>),
  pfeil(beschriftung: [bereitet Lastmodelle vor für]),
  chunk([TM1 Kapitel 4 · Streckenlasten und Schwerpunkt], [Streckenlast · Resultierende · Angriffspunkt · Schwerpunkt], ziel: <k-tm1-4>),
  pfeil(beschriftung: [liefert Ersatzlasten für]),
  chunk([TM1 Kapitel 5 · Lagerreaktionen und statische Bestimmtheit], [Lagerwertigkeit · Teilkörper · Bestimmtheit · Gelenkkräfte], ziel: <k-tm1-5>),
)
#align(center)[#text(size: 8pt, fill: teal)[↓ liefert Lagerkräfte für]]
#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([TM1 Kapitel 6 · Fachwerke: Nullstäbe und Ritterschnitt], [Fachwerkmodell · Nullstäbe · Knotenverfahren · Ritterschnitt], ziel: <k-tm1-6>),
  pfeil(beschriftung: [verbindet innere Kräfte mit]),
  chunk([TM1 Kapitel 7 · Schnittgrößen punktweise bestimmen], [Schnittufer · Normalkraft · Querkraft · Moment · Sprünge], ziel: <k-tm1-7>),
  pfeil(beschriftung: [ergänzt um Kontaktgrenzen]),
  chunk([TM1 Kapitel 9 · Haftreibung als kurzer Klausurbaustein], [Kontakt · Normalkraft · Haftreibung · Grenzfall], ziel: <k-tm1-9>),
)
#align(center)[#text(size: 8pt, fill: teal)[↓ weiter mit Spannung und Verformung]]
#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([TM2 Kapitel 1 · Zug, Druck und Wärmedehnung], [Normalkraft · Spannung · Dehnung · Wärme · Verträglichkeit], ziel: <k-tm2-1>),
  pfeil(beschriftung: [erweitert auf mehrere Richtungen]),
  chunk([TM2 Kapitel 2 · Spannungszustand und Mohrscher Kreis], [Spannungstensor · Achsendrehung · Hauptspannung · Mohr], ziel: <k-tm2-2>),
  pfeil(beschriftung: [wird über Stoffgesetze verknüpft mit]),
  chunk([TM2 Kapitel 3 · Dehnungen, Elastizitätsgesetz und DMS], [DMS · Dehnung · halbe Gleitung · Hauptwerte · Stoffgesetz], ziel: <k-tm2-3>),
)
#align(center)[#text(size: 8pt, fill: teal)[↓ liefert Verformungsgrundlagen für]]
#karte((1fr, auto, 1fr),
  chunk([TM2 Kapitel 4 · Biegung, FTM und Biegelinie], [Schwerpunkt · Steiner · Flächenträgheitsmoment · Biegespannung · Biegelinie], ziel: <k-tm2-4>),
  pfeil(beschriftung: [ergänzt Biegung um Verdrehung]),
  chunk([TM2 Kapitel 5 · Torsion: Spannung und Verdrehung], [Torsionsmoment · Profilform · Schubspannung · Torsionssteifigkeit · Verdrehung], ziel: <k-tm2-5>),
)

Der Freischnitt macht äußere Lasten und unbekannte Reaktionen sichtbar. Gleichgewicht liefert Lagerkräfte, Stabkräfte und Schnittgrößen; Schwerpunkt und Reibung ergänzen die passenden Last- und Kontaktmodelle. TM2 übersetzt diese Kräfte in Spannungen und Verformungen. Stoffgesetze, Querschnittswerte und Verträglichkeit verbinden Zug, Biegung und Torsion zu einem prüfbaren Bauteilmodell.
#src[Eigene Darstellung; Zusammenführung des bereits enthaltenen Stoffs und der Denkkette auf der Titelseite.]

#pagebreak()

#pagebreak(weak: true)
= TM1 Kapitel 1 · Das Werkzeug für Klausuraufgaben <k-tm1-1>

#überblick([Kapitel TM1 1 auf einen Blick],
  idee(<a-tm1-1-6>, [Der Freischnitt kommt zuerst.], [Jede entfernte Bindung wird durch ihre Wirkung auf den betrachteten Körper ersetzt.]),
  idee(<a-tm1-1-3>, [Die Skizze legt Komponenten und Vorzeichen fest.], [Winkelbezug und einheitliche Einheiten gehören zum Ansatz.]),
  idee(<a-tm1-1-4>, [Gleichgewicht verhindert Verschieben und Drehen.], [Kraftsummen und Momentensumme liefern die drei ebenen Bedingungen.]),
)

#ablauf(
  chunk([Körper freischneiden], [Lasten und Bindungsreaktionen eintragen], ziel: <a-tm1-1-6>),
  chunk([Achsen und Hebelarme wählen], [Kräfte zerlegen · Vorzeichen festlegen], ziel: <a-tm1-1-3>),
  chunk([Gleichgewicht aufstellen], [zwei Kraftsummen · eine Momentensumme], ziel: <a-tm1-1-4>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])

Du brauchst einen sicheren Umgang mit Kraftkomponenten, Momenten und Freikörperbildern. Diese Grundlagen werden hier unmittelbar für Lager-, Fachwerk- und Schnittgrößenaufgaben eingesetzt.

== 1.3 Kräfte zerlegen und Einheiten wählen <a-tm1-1-3>
Eine schräge Kraft wirkt gleichzeitig horizontal und vertikal. Entscheidend ist, *von welcher Achse der Winkel gemessen wird*.
#form[$ F_x = F cos alpha, quad F_y = F sin alpha, quad F = sqrt(F_x^2 + F_y^2) $]
$alpha$ ist hier der Winkel zur positiven $x$-Achse. Die Vorzeichen folgen der Pfeilrichtung. Bei einem Dreieck mit den Seiten 3, 4 und 5 sind die Komponenten einer Kraft $5F$ genau $3F$ und $4F$.
#bild("tm1k2_mitschrift_zerlegung", [Zerlegung entlang zweier Wirkungslinien; deine Mitschrift, Skript TM1 PDF-S. 69 oben.], height: 45mm)
#note("Fehler vermeiden", [Schreibe nicht pauschal „horizontal immer Kosinus“. Liegt der Winkel zur Senkrechten, tauschen Sinus und Kosinus ihre Rollen. Rechne Statik z. B. mit kN und m, Festigkeitslehre mit N und mm: $1 "kNm" = 10^6 "Nmm"$.])
#src[FS TM1 S. 8, 14–15; Skript TM1 S. 69–71; AK24 S. 8–9. Eigene Erklärung.]
#hoch(<k-tm1-1>, [Kapitelübersicht])

== 1.4 Momente und Gleichgewicht <a-tm1-1-4>
Eine Tür öffnet sich durch den Hebelarm. Für das Moment zählt der *senkrechte Abstand* von der Wirkungslinie zum Bezugspunkt, nicht irgendeine eingezeichnete Länge.
#form[$ M_((P)) = F d, quad sum F_x = 0, quad sum F_y = 0, quad sum M_((P)) = 0 $]
$d$ in m bzw. mm, $M$ in Nm bzw. Nmm. In der Ebene stehen pro freiem starren Körper drei unabhängige Gleichgewichtsbedingungen zur Verfügung. Eine Kraft durch $P$ erzeugt um $P$ kein Moment. Ein eingeprägtes Kräftepaar $M_0$ geht unabhängig vom Bezugspunkt mit seinem Drehsinn ein.
#bild("tm1k01_momentdarst", [Kräfte und Momente am Ersatzmodell; Skript TM1 PDF-S. 20 unten.], height: 42mm)
#note("Selbst erklären", [Warum ist $sum F_y=0$ allein kein Gleichgewicht? Zwei entgegengesetzte, versetzte Kräfte können die Kraftsumme null haben und trotzdem ein Drehmoment erzeugen.])
#src[FS TM1 S. 21–24; Skript TM1 S. 20, 23–24, 99–109.]
#hoch(<k-tm1-1>, [Kapitelübersicht])

== 1.6 Freischneiden <a-tm1-1-6>
Beim *Freischneiden* entfernst du eine Verbindung und zeichnest ihre Wirkung als Kraft oder Moment ein. Das Freikörperbild enthält nur Kräfte, die auf den betrachteten Körper wirken.
#bild("tm1k01_gerber_frei", [Freischnitt eines mehrteiligen Systems; Skript TM1 PDF-S. 34.], height: 48mm)
+ Körper bzw. Teilkörper festlegen und deutlich getrennt zeichnen.
+ Eingeprägte Kräfte, Momente und Resultierende der Streckenlasten eintragen.
+ Jede gelöste Lagerung durch ihre zulässigen Reaktionen ersetzen.
+ An beiden Seiten eines gelösten Gelenks dieselben Unbekannten entgegengesetzt ansetzen.
+ Achsen und angenommene positive Pfeile festhalten; ein negatives Ergebnis kehrt den Pfeil um.
#note("Fehler vermeiden", [Actio und reactio wirken auf *verschiedene* Körper. Im Freikörperbild eines einzelnen Körpers darfst du nicht beide Gegenkräfte eintragen. Ein Seil zieht entlang des Seils; ein unbelasteter, beidseitig gelenkiger Stab wirkt entlang seiner Gelenkverbindung.])
#src[Skript TM1 S. 30–34; FS TM1 S. 10–11, 16–19; KH S. 1.]
#bild("map-klausur-tm1", [Mindmap: Werkzeuge der Statik. Eigene Darstellung.], height: 43mm)
*Der Zusammenhang in Kapitel 1.* Die Skizze bestimmt die Kraftkomponenten und Hebelarme. Der Freischnitt macht alle unbekannten Reaktionen sichtbar. Erst danach liefern die drei Gleichgewichtsbedingungen eine prüfbare Rechnung.
#hoch(<k-tm1-1>, [Kapitelübersicht])


#pagebreak()
#pagebreak(weak: true)
= TM1 Kapitel 4 · Streckenlasten und Schwerpunkt <k-tm1-4>

#überblick([Kapitel TM1 4 auf einen Blick],
  idee(<a-tm1-4-1-2>, [Die Lastfläche liefert die Resultierende.], [Ihr Schwerpunkt bestimmt den momentengleichen Angriffspunkt.]),
  idee(<a-tm1-4-2-3>, [Teilflächen werden gewichtet zusammengeführt.], [Aussparungen zählen mit negativem Vorzeichen.]),
  idee(<a-tm1-4-2-3>, [Der Gesamtschwerpunkt bestimmt die Bezugsachsen.], [Abstände der Teilflächen zu diesen Achsen werden später für Steiner gebraucht.]),
)

#karte((1fr, auto, 1fr, auto, 1fr),
  chunk([Verteilung zerlegen], [Lastdiagramm oder Teilflächen], ziel: <a-tm1-4-1-2>),
  pfeil(beschriftung: [liefert Beiträge für]),
  chunk([Gewichtete Summe], [Beträge · Schwerpunktlagen], ziel: <a-tm1-4-2-3>),
  pfeil(beschriftung: [bestimmt]),
  chunk([Resultierende Lage], [Lastangriff oder Flächenschwerpunkt], ziel: <a-tm1-4-2-3>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])

Eine verteilte Last lässt sich für das äußere Gleichgewicht durch eine Einzelkraft ersetzen. Dieselbe Schwerpunktidee wird später für Querschnitte und Flächenträgheitsmomente gebraucht.

== 4.1 Resultierende einer Streckenlast <a-tm1-4-1-2>
Die *Streckenlast* $q(x)$ gibt Kraft pro Länge an. Ihre Resultierende ist die Fläche unter dem Lastdiagramm; sie greift im Schwerpunkt dieser Fläche an.
#form[$ F_R = integral_0^L q(x) dif x, quad x_R = frac(integral_0^L x q(x) dif x, F_R) $]
$q$ in N/m, $F_R$ in N, $x_R$ in m. Die Resultierende ersetzt die Last für Kräfte und Momente des *gesamten belasteten Abschnitts*.
#tab(columns: (1fr, 1fr, 1.5fr), th([Lastbild], [$F_R$], [Angriffspunkt]),
 [Rechteck $q_0$ über $L$], [$q_0 L$], [$L/2$],
 [Dreieck, von $q_0$ auf 0], [$q_0 L/2$], [$L/3$ von der hohen Seite],
 [Dreieck, von 0 auf $q_0$], [$q_0 L/2$], [$2L/3$ von der Nullseite],
 [Trapez], [Rechteck + Dreieck], [Momentengleichwertig zusammensetzen],)
#bild("ak24-system", [Geometrie der Klausur SS 2023/24, AK24 PDF-S. 1. Eigene Darstellung, nicht maßstäblich.], height: 70mm)
#note("Anwendung auf AK24", [Oben: $F_(R 1)=q_0 dot 4a$, Angriff $2a$ rechts von A. Seitlich: $F_(R 2)=q_0 dot 6a/2=3q_0a$, Angriff $2a$ oberhalb von M. Die seitliche Last wirkt horizontal und erzeugt deshalb Momente mit *vertikalen* Hebelarmen.])
#note("Fehler vermeiden", [Beim Schnitt *innerhalb* einer Streckenlast ersetzt du nur den verbleibenden Lastabschnitt. Bei einer Dreieckslast ändern sich dabei sowohl die Breite als auch die lokale Lasthöhe.])
#src[FS TM1 S. 25–26; P1 S. 1, Aufgabe 6.4; AK24 S. 1, 3–4.]
#hoch(<k-tm1-4>, [Kapitelübersicht])

== 4.2 Flächenschwerpunkt <a-tm1-4-2-3>
Ein Querschnitt wird in einfache Teilflächen zerlegt. Aussparungen zählen als negative Fläche. Ein Hilfsachsensystem hält die Rechnung übersichtlich.
#form[$ y'_S = frac(sum A_i y'_(S i),sum A_i), quad z'_S = frac(sum A_i z'_(S i),sum A_i) $]
$A_i$ in mm², Koordinaten in mm. Die Summe der Teilflächen muss die tatsächlich vorhandene Materialfläche ergeben.
#bild("tm2k4_wzf0806_ue10", [Rechteck mit Aussparung, Aufgabe 10.1; WZF 08.06.26 PDF-S. 1. Deine Markierung „Prüfung: Flächenträgheitsmomente mit versch. Ausschnitten!“], height: 50mm)
+ Symmetrie prüfen: Auf einer Symmetrieachse liegt der Gesamtschwerpunkt.
+ Für jede Teilfläche Größe, Vorzeichen und Schwerpunkt im Hilfssystem eintragen.
+ Gesamtschwerpunkt berechnen; erst dann die endgültigen Achsen durch S legen.
+ Für Steiner die *Abstände zum Gesamtschwerpunkt* bilden: $y_(S i)=y'_(S i)-y'_S$ und $z_(S i)=z'_(S i)-z'_S$.
#note("Von dir markiert und präzisiert", [Deine neue FTM-Notiz betont die Verschiebung auf die gemeinsame Schwerpunktachse. Dabei muss *nicht jeder Teilflächenschwerpunkt auf dieser Achse liegen*. Sein senkrechter Abstand zur gemeinsamen Achse erzeugt gerade den Steiner-Anteil.])
#src[FS TM1 S. 27; P1 S. 1–5; neue Notiz „Flächenträgheitsmomente und Flächenschwerpunkt“, S. 1; FS TM2 S. 24–26.]
#bild("map-klausur-schwerpunkt", [Mindmap zum Kapitel; eigene Darstellung.], height: 35mm)
*Der Zusammenhang in Kapitel 4.* Für Lasten wird eine verteilte Kraft durch Fläche und Schwerpunkt zusammengefasst. Für Querschnitte liefert dieselbe gewichtete Mittelung den Gesamtschwerpunkt. Die Abstände zu diesem Punkt werden in TM2 zum entscheidenden Bestandteil der FTM-Rechnung.
#hoch(<k-tm1-4>, [Kapitelübersicht])


#pagebreak()
#pagebreak(weak: true)
= TM1 Kapitel 5 · Lagerreaktionen und statische Bestimmtheit <k-tm1-5>

#überblick([Kapitel TM1 5 auf einen Blick],
  idee(<a-tm1-5-1>, [Jede gesperrte Bewegung erzeugt eine Reaktion.], [Die Lagerart bestimmt Zahl und Richtung der Unbekannten.]),
  idee(<a-tm1-5-3-2>, [Abzählen ist erst die erste Prüfung.], [Zusätzlich muss die Geometrie eine freie Bewegung verhindern.]),
  idee(<a-tm1-5-3-3>, [Teilkörper machen Gelenkkräfte berechenbar.], [An beiden Gelenkseiten wirken sie gleich groß und entgegengesetzt.]),
  idee(<a-tm1-5-4>, [Das Gesamtsystem kontrolliert die Lösung.], [Innere Gelenkkräfte heben sich dort auf.]),
)

#ablauf(
  chunk([Lager und Teilkörper erfassen], [Unbekannte · Bindungen · Geometrie], ziel: <a-tm1-5-1>),
  entscheidung([Ist die Lagerung geometrisch wirksam und statisch bestimmt?],
    chunk([Teilkörper freischneiden], [Lager- und Gelenkreaktionen ansetzen], ziel: <a-tm1-5-3-3>),
    chunk([Modell erneut einordnen], [Beweglichkeit oder zusätzliche Verformungsbedingungen prüfen], ziel: <a-tm1-5-3-2>)),
  chunk([Gleichgewichte lösen und kontrollieren], [Momentenbezug wählen · Gesamtsystem prüfen], ziel: <a-tm1-5-4>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])

Hier beginnt die große Statikaufgabe: Bindungen erkennen, Körper zählen, Lasten ersetzen und Gleichgewicht aufstellen. Bei mehreren Körpern werden die Gelenkkräfte ausdrücklich mitgerechnet.

== 5.1 Lager und ihre Wertigkeit <a-tm1-5-1>
Die *Wertigkeit* sagt, wie viele unabhängige Bewegungen ein Lager verhindert und damit wie viele unbekannte Reaktionen entstehen.
#tab(columns: (1fr, 1.35fr, 1fr), th([Bindung], [Bewegung / Wirkung], [Unbekannte]),
 [Loslager / glatter Kontakt], [Verschiebung normal zur Auflage gesperrt], [1 Kraft normal zur Auflage],
 [Festlager], [Zwei Verschiebungen gesperrt, Drehung frei], [2 Kraftkomponenten],
 [Feste Einspannung], [Beide Verschiebungen und Drehung gesperrt], [2 Kräfte + 1 Moment],
 [Parallelführung], [Eine Verschiebung und Drehung gesperrt], [1 Kraft + 1 Moment],
 [Pendelstütze], [Kraft nur in Stabrichtung], [1 Stabkraft],
 [Inneres Drehgelenk], [Teile bleiben verbunden, relative Drehung frei], [2 Kräfte, kein Moment],
 [Querkraftgelenk], [Relative Querverschiebung frei], [Normalkraft und Moment, keine Querkraft],)
#bild("tm1k2_lager1", [Festlager, Gelenk und Kontakt mit Reibung; Skript TM1 PDF-S. 76 unten. Weitere Lager: FS TM1 PDF-S. 18–19.], height: 55mm)
#note("Fehler vermeiden", [Ein seitliches Loslager liefert eine *horizontale* Kraft. Die Pfeilrichtung richtet sich nach der Auflagefläche. „Festlager“ und „feste Einspannung“ sind verschiedene Bindungen.])
#src[FS TM1 S. 18–19, 30–32; Skript TM1 S. 76, 148–159, 174–177.]
#hoch(<k-tm1-5>, [Kapitelübersicht])

== 5.3 Mehrteilige Tragwerke <a-tm1-5-3>
=== 5.3.2 Statische Bestimmtheit <a-tm1-5-3-2>
Ein ebener starrer Körper besitzt drei Freiheitsgrade. Nach dem Trennen in $n$ Körper brauchst du entsprechend drei Gleichgewichtsbedingungen je Körper.
#form[$ r+v=3n $]
$r$ = Anzahl äußerer Lagerunbekannter, $v$ = Anzahl innerer Verbindungsunbekannter. Das ist eine *notwendige Abzählbedingung*. Zusätzlich muss die Lagerung geometrisch wirksam sein: keine freie Bewegung, keine abhängigen Bindungen.
#tab(columns: 2, th([Abzählung], [Erste Einordnung]),
 [$r+v<3n$], [Zu wenige Bindungen; im Allgemeinen beweglich],
 [$r+v=3n$], [Statisch bestimmt möglich; Beweglichkeit gesondert prüfen],
 [$r+v>3n$], [Überzählige Bindungen; bei stabiler Lagerung statisch unbestimmt],)
#note("Klausurformulierung", [Schreibe die Zahlen für $r$, $v$, $n$ hin und begründe anschließend die Geometrie. „Gleichung erfüllt“ allein ist kein vollständiger Nachweis.])
#src[FS TM1 S. 30–32; Skript TM1 S. 151–158, 178–181; AK24 S. 1–2.]
=== 5.3.3 Lager- und Gelenkreaktionen berechnen <a-tm1-5-3-3>
+ Alle Teilkörper freischneiden; am Gelenk Gegenkräfte eintragen.
+ Pro Teilkörper drei Gleichgewichte aufstellen.
+ Momentenbezug so wählen, dass möglichst viele unbekannte Kräfte durch den Bezugspunkt gehen.
+ In der geforderten Reihenfolge lösen und die Richtung negativer Ergebnisse deuten.
+ Mit dem Gesamtsystem kontrollieren: Innere Gelenkkräfte heben sich dort auf.
#note("Einfrieren des Fachwerks", [Für die *äußeren* Lager- und Gelenkkräfte darfst du das geometrisch stabile Fachwerk als starre Scheibe betrachten. Erst danach löst du es in einzelne Stäbe auf. Genau so ist AK24 Aufgabe 1 aufgebaut.])
#src[FS TM1 S. 32; AK24 S. 1, 3–7.]
#hoch(<k-tm1-5>, [Kapitelübersicht])

== 5.4 Ergänzung: Rechenweg aus SS 2023/24 <a-tm1-5-4>
#bild("ak24-system", [AK24 PDF-S. 1, 3–5; eigene Darstellung.], height: 67mm)
Das System hat zwei Teilkörper: den T-Träger und die Scheibe. B und D sind einwertig, C zweiwertig, G überträgt zwei Gelenkkräfte. *$r=4$, $v=2$, $n=2$*, also $4+2=3 dot 2$. Die horizontalen Lager B und D liegen auf verschiedenen Höhen; zusammen mit C ist das System unbeweglich.
#note("Ein Pfeilsystem für die Rechnung", [Am T-Träger: $G_H$ nach rechts, $G_V$ nach oben, $B_H$ nach links. An der Scheibe wirken die Gegenkräfte; $D_H$ und $C_H$ werden nach links, $C_V$ nach oben angesetzt. $F$ zählt positiv nach rechts; für Teil e) ist $F=-4q_0a$ vorgegeben.])
#bild("map-klausur-lager", [Mindmap zum Kapitel; eigene Darstellung.], height: 35mm)
*Der Zusammenhang in Kapitel 5.* Lager bestimmen die unbekannten Reaktionen, die Abzählung prüft den Ansatz und die Geometrie dessen Wirksamkeit. Teilkörpergleichgewichte liefern die Gelenkkräfte. Mit genau diesen Reaktionen beginnt die Schnittgrößenrechnung.
#src[AK24 S. 1–7; FS TM1 S. 30–32. Eigene, nachgerechnete Aufbereitung.]
#hoch(<k-tm1-5>, [Kapitelübersicht])


#pagebreak()
#pagebreak(weak: true)
= TM1 Kapitel 6 · Fachwerke: Nullstäbe und Ritterschnitt <k-tm1-6>

#überblick([Kapitel TM1 6 auf einen Blick],
  idee(<a-tm1-6-1>, [Das Idealmodell kennt nur Stabzug und Stabdruck.], [Lasten greifen an Knoten an und die Stäbe sind zwischen den Knoten unbelastet.]),
  idee(<a-tm1-6-3-1>, [Nullstabregeln vereinfachen den Lastfall.], [Ein kraftloser Stab kann trotzdem für andere Lasten oder die Stabilität gebraucht werden.]),
  idee(<a-tm1-6-3-3>, [Das Ziel bestimmt den Freischnitt.], [Knotenverfahren und Ritterschnitt verwenden dasselbe Gleichgewicht an verschiedenen Teilsystemen.]),
)

#ablauf(
  chunk([Modell und Lagerkräfte prüfen], [ideale Gelenkstäbe · geometrische Stabilität], ziel: <a-tm1-6-1>),
  chunk([Nullstäbe erkennen], [Knotensituation für diesen Lastfall beurteilen], ziel: <a-tm1-6-3-1>),
  entscheidung([Ist eine gezielte Stabkraft über einen geeigneten Schnitt erreichbar?],
    chunk([Ritterschnitt], [bis zu drei unabhängige unbekannte Stabkräfte], ziel: <a-tm1-6-3-3>),
    chunk([Knotenverfahren], [am Knoten mit höchstens zwei Unbekannten beginnen], ziel: <a-tm1-6-3-1>)),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])

Die Lagerkräfte stammen aus dem eingefrorenen Gesamtsystem. Im idealen Fachwerk übertragen gelenkig verbundene Stäbe nur Zug oder Druck; gesucht sind daher skalare Stabkräfte entlang der Stäbe.

== 6.1 Modell und statische Bestimmtheit <a-tm1-6-1>
Die idealen Stäbe sind gerade, an den Enden gelenkig verbunden und zwischen den Knoten unbelastet. Äußere Lasten greifen an Knoten an. Eine zunächst als Zug angesetzte Stabkraft zeigt am freigeschnittenen Knoten vom Knoten weg; ein negatives Ergebnis bedeutet Druck.
#form[$ s+r=2k $]
$s$ = Stäbe, $r$ = äußere Reaktionen, $k$ = Knoten. Auch diese Abzählbedingung ist notwendig, aber keine Garantie für geometrische Stabilität.
#src[FS TM1 S. 33–35; Skript TM1 S. 194–201.]
#hoch(<k-tm1-6>, [Kapitelübersicht])

== 6.3 Nullstäbe und Stabkräfte <a-tm1-6-3>
=== 6.3.1 Nullstabregeln und Knotenverfahren <a-tm1-6-3-1>
#tab(columns: (0.4fr, 2fr, 1.4fr), th([Regel], [Knotensituation], [Folgerung]),
 [1], [Unbelasteter Knoten mit zwei nicht kollinearen Stäben], [Beide sind Nullstäbe],
 [2], [Zwei nicht kollineare Stäbe, Last in Richtung eines Stabes], [Der andere Stab ist Nullstab],
 [3], [Unbelasteter Knoten mit drei Stäben, davon zwei kollinear], [Der dritte Stab ist Nullstab],)
Die Regeln gelten unter der betrachteten Belastung. Nach dem Erkennen eines Nullstabs kann ein Nachbarknoten auf eine einfachere Situation zurückfallen.
#note("Fehler vermeiden", [Ein Nullstab darf nicht automatisch baulich weggelassen werden. Er kann den Knoten geometrisch stabilisieren oder bei einer anderen Belastung Kräfte übertragen. AK24 fragt das ausdrücklich.])
Beim Knotenverfahren schneidest du einen Knoten frei und nutzt $sum F_H=0$, $sum F_V=0$. Beginne dort, wo höchstens zwei unbekannte Stabkräfte wirken.
#src[FS TM1 S. 34–35; AK24 S. 13, 15.]
=== 6.3.3 Rittersches Schnittverfahren <a-tm1-6-3-3>
Ein *Ritterschnitt* trennt das Fachwerk durch höchstens drei unbekannte Stäbe. Am freigeschnittenen Teil stehen wieder drei Gleichgewichte zur Verfügung. Für eine einzelne Zielkraft legst du den Momentenbezug durch den Schnittpunkt der anderen beiden Stabkräfte.
#bild("ak24-fachwerk-schnitt", [Geändertes System aus AK24 PDF-S. 8, 13; eigene Darstellung.], height: 73mm)
+ Zuerst Nullstäbe erkennen und die benötigten Lagerkräfte bereithalten.
+ Schnitt durch die gesuchten Stäbe wählen; ein Teilfachwerk freischneiden.
+ Alle durchschnittenen Stabkräfte zunächst als Zug ansetzen.
+ Geschickt gewählte Momentengleichgewichte verwenden, dann Kraftsummen ergänzen.
#note("Grenze des Verfahrens", [Drei unbekannte Stabkräfte dürfen nicht alle durch denselben Punkt gehen: Dann liefert das Moment um diesen Punkt keine Information über diese Kräfte. Bei drei parallelen Stäben fehlt ebenfalls eine unabhängige Bedingung.])
#src[FS TM1 S. 35; P1 S. 22–24, Aufgabe 9.1; AK24 S. 13, 15–16.]
#bild("map-klausur-fachwerk", [Mindmap zum Kapitel; eigene Darstellung.], height: 35mm)
*Der Zusammenhang in Kapitel 6.* Das Fachwerk wird für Lagerkräfte als Ganzes betrachtet, für Stabkräfte gezielt zerlegt. Nullstabregeln vereinfachen das System. Knotenverfahren und Ritterschnitt nutzen dasselbe Gleichgewicht in unterschiedlich großen Teilsystemen.
#hoch(<k-tm1-6>, [Kapitelübersicht])


#pagebreak()
#pagebreak(weak: true)
= TM1 Kapitel 7 · Schnittgrößen punktweise bestimmen <k-tm1-7>

#überblick([Kapitel TM1 7 auf einen Blick],
  idee(<a-tm1-7-1>, [Die Bezugsfaser legt die Vorzeichen fest.], [Normalkraft, Querkraft und Moment werden am gewählten Schnittufer eingetragen.]),
  idee(<a-tm1-7-2-6>, [Ein Schnitt macht innere Kräfte zu äußeren Kräften.], [Am einfacheren Teilkörper liefert Gleichgewicht die gesuchten Werte.]),
  idee(<a-tm1-7-3>, [Die Belastung bestimmt den Verlauf.], [Streckenlast, Einzelkraft und Einzelmoment erzeugen unterschiedliche Steigungen oder Sprünge.]),
)

#ablauf(
  chunk([Reaktionen und Bezugsfaser übernehmen], [richtigen Lastfall verwenden], ziel: <a-tm1-7-1>),
  chunk([Links oder rechts der Zielstelle schneiden], [einfacheren Teilkörper wählen · N, Q und M eintragen], ziel: <a-tm1-7-2-6>),
  chunk([Gleichgewicht und Verlauf prüfen], [Punktwerte · Sprünge · Randbedingungen], ziel: <a-tm1-7-3>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])

Die Klausur nennt markante Stellen statt einer einzigen langen Funktion. Du bestimmst dort Normalkraft, Querkraft und Moment und verbindest die Werte anschließend mit dem passenden Verlauf.

== 7.1 Schnittufer und Bezugsfaser <a-tm1-7-1>
Die *Normalkraft* $N$ wirkt entlang der Stabachse, die *Querkraft* $Q$ quer dazu und das *Biegemoment* $M$ dreht das Schnittufer. $N>0$ bedeutet Zug.
#bild("tm1k01_mitschrift_schnitt", [Deine Mitschrift zum Schnittufer; Skript TM1 PDF-S. 32.], height: 58mm)
Im geraden Balken zeigt $x$ entlang der Achse, $z$ zur vorgegebenen Bezugsfaser. Bei Rahmen drehst du dieses lokale System mit dem Stab. Die Pfeile an den beiden Schnittufern sind entgegengesetzt. Ein negativer Zahlenwert ändert die tatsächliche Richtung, nicht die festgelegte Konvention.
#src[Skript TM1 S. 32, 214–225, 266–274; FS TM1 S. 36–37, 44–45.]
#hoch(<k-tm1-7>, [Kapitelübersicht])

== 7.2.6 Die punktweise Methode ★ <a-tm1-7-2-6>
+ Lager- und Gelenkreaktionen übernehmen oder vorher berechnen.
+ Schnitt *unmittelbar links oder rechts* der genannten Stelle setzen.
+ Den einfacheren Teilkörper wählen und $N$, $Q$, $M$ eintragen.
+ Nur die tatsächlich vorhandenen äußeren Lasten am gewählten Teil berücksichtigen.
+ Drei Gleichgewichte aufstellen und Vorzeichen mit der Bezugsfaser prüfen.
#note("Von dir markiert", [In deinen Vorlesungsnotizen steht: „In der Prüfung Lager + Gelenkreaktionen bereits bestimmt. Schnittgrößen nur an markanten Stellen bestimmen.“ AK24 gibt für den geänderten Lastfall ebenfalls neue Reaktionen vor. Vermische diese nicht mit den zuvor selbst berechneten Reaktionen.])
#src[Skript TM1 S. 259–263; KH S. 1; AK24 S. 5, 8–14.]
#hoch(<k-tm1-7>, [Kapitelübersicht])

== 7.3 Verläufe und Sprünge lesen <a-tm1-7-3>
#form[$ Q'(x)=-q(x), quad M'(x)=Q(x) $]
Für den geraden Balken mit der Vorlesungskonvention. Damit lassen sich die punktweisen Ergebnisse verbinden und kontrollieren:
#tab(columns: 3, th([Belastung], [$Q$], [$M$]),
 [$q=0$], [konstant], [linear],
 [$q=$ konstant], [linear], [quadratisch],
 [$q$ linear], [quadratisch], [kubisch],
 [Einzelkraft quer], [Sprung], [stetig mit Knick],
 [Einzelmoment], [stetig], [Sprung],)
An einem unbelasteten inneren Drehgelenk gilt $M=0$. Am Querkraftgelenk gilt $Q=0$; ein Moment kann dort übertragen werden. An einer Rahmenecke ändern sich die lokalen Richtungen: Global dieselbe Kraft kann im neuen Stab Normalkraft statt Querkraft sein.
#note("Momentenextremum", [Im glatten Bereich liegen innere Extremstellen von $M$ dort, wo $Q=0$ und sein Vorzeichen wechselt. Prüfe zusätzlich Randstellen und Sprungstellen.])
#src[FS TM1 S. 37–45; neue Lösung TM1 Nr. 10 S. 1–11; P1 S. 25–49.]
#hoch(<k-tm1-7>, [Kapitelübersicht])

== 7.4 Ergänzung: Seilrolle und markante Stellen in AK24 <a-tm1-7-4>
#bild("ak24-fachwerk-schnitt", [AK24 PDF-S. 8, 10, 13; eigene Darstellung.], height: 72mm)
An der Rolle A wirken $4F$ nach rechts und $8F$ nach unten. Für einen Schnitt im unbelasteten Abschnitt A–E gilt bei $x$ ab A:
#form[$ N=-4F, quad Q=-8F, quad M=-8F x, quad 0<x<4a $]
Damit ist unmittelbar nach A $M=0$, unmittelbar vor E dagegen $M=-32F a$. Der Verlauf muss linear sein. Für den Abschnitt E–G lässt sich der rechte Teil mit den gegebenen Gelenkkräften verwenden.
#note("Fehler in der beigefügten Rechnung", [Auf AK24 PDF-S. 9 steht auch für den Schnitt vor E $M=0$. Dort wurde der Hebelarm vergessen: Der Lastangriff an A liegt $4a$ vom Schnitt entfernt. Richtig ist *$M(E^-)=-32F a$*, wie auf der fotografierten Klausurseite (PDF-S. 10).])
#src[AK24 S. 8–10, 13–14; eigene Nachrechnung.]
#bild("map-klausur-schnitt", [Mindmap zum Kapitel; eigene Darstellung.], height: 35mm)
*Der Zusammenhang in Kapitel 7.* Der Freischnitt liefert einzelne Werte, die lokale Faser liefert deren Vorzeichen. Die Beziehungen zwischen Last, Querkraft und Moment bestimmen, wie die Werte verbunden werden. Sprünge zeigen unmittelbar, welche Einzelkraft oder welches Einzelmoment eingeleitet wird.
#hoch(<k-tm1-7>, [Kapitelübersicht])


#pagebreak()
#pagebreak(weak: true)
= TM1 Kapitel 9 · Haftreibung als kurzer Klausurbaustein <k-tm1-9>

#überblick([Kapitel TM1 9 auf einen Blick],
  idee(<a-tm1-9-2>, [Haftreibung passt sich dem Bedarf an.], [Sie ist innerhalb der Haftgrenze keine fest vorgegebene Kraft.]),
  idee(<a-tm1-9-2>, [Die Normalkraft begrenzt die Haftkraft.], [Der Reibwert verknüpft beide über die Haftbedingung.]),
  idee(<a-tm1-9-2>, [Gleichheit gilt beim beginnenden Gleiten.], [Zuerst wird der nötige Reibkraftbetrag aus dem Gleichgewicht bestimmt.]),
)

#ablauf(
  chunk([Kontakt freischneiden], [Normalkraft und erforderliche Reibkraft aus Gleichgewicht], ziel: <a-tm1-9-2>),
  entscheidung([Liegt der erforderliche Betrag innerhalb der Haftgrenze?],
    chunk([Haften möglich], [Gleichheit kennzeichnet den Grenzfall], ziel: <a-tm1-9-2>),
    chunk([Haftmodell reicht nicht], [ruhendes Gleichgewicht unter diesen Annahmen nicht möglich], ziel: <a-tm1-9-2>)),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])

Die neue Sammlung enthält Übungsblatt 13; die älteren Klausuren fragen regelmäßig nach dem Grenzfall des Rutschens. Dafür genügen Freischnitt, Gleichgewicht und eine zusätzliche Haftbedingung.

== 9.2 Haftbedingung und Grenzfall <a-tm1-9-2>
Die Normalkraft $N$ drückt senkrecht auf die Kontaktfläche. Die Haftkraft $H$ wirkt tangential entgegen der drohenden Relativbewegung und passt sich bis zur Grenze an.
#form[$ abs(H)<=mu_0 N, quad N>=0, quad "im Grenzfall:" abs(H)=mu_0 N $]
$mu_0$ ist dimensionslos, N und H sind Kräfte. Die Gleichheit gilt nur beim gerade bevorstehenden Rutschen. Eine negative Normalkraft bedeutet Ablösen: Dann gilt das angenommene Kontaktmodell nicht mehr.
#bild("ak_ss16_klotz", [Haftreibungsaufgabe aus der älteren Klausursammlung, PrüfungenTM2 PDF-S. 23.], height: 40mm)
#note("Selbst erklären", [Warum ist $H=mu_0N$ nicht immer richtig? Solange der Körper haftet, ist nur die tatsächlich benötigte Haftkraft vorhanden. Der Grenzwert wird erst beim drohenden Rutschen erreicht.])
#src[FS TM1 S. 48–49; P1 S. 50, Übung 13; ältere Klausuren PrüfungenTM2 S. 3, 23, 26, 32/37 und TM_Prüfung_2018 S. 7.]
#bild("map-klausur-haftung", [Mindmap zum Kapitel; eigene Darstellung.], height: 35mm)
*Der Zusammenhang in Kapitel 9.* Das Gleichgewicht liefert die nötige Tangentialkraft. Die Haftgrenze entscheidet, ob der angenommene Ruhezustand möglich ist. Kontaktrichtung und drohende Bewegung müssen vor der Rechnung festgelegt werden.
#hoch(<k-tm1-9>, [Kapitelübersicht])


#pagebreak()
#pagebreak(weak: true)
= TM2 Kapitel 1 · Zug, Druck und Wärmedehnung <k-tm2-1>

#überblick([Kapitel TM2 1 auf einen Blick],
  idee(<a-tm2-1-1>, [Normalkraft wird über die Fläche zur Spannung.], [Das Stoffgesetz verbindet Spannung und elastische Dehnung.]),
  idee(<a-tm2-1-4>, [Dehnung führt zur Längenänderung.], [Mechanischer und thermischer Anteil werden entsprechend dem Modell zusammengeführt.]),
  idee(<a-tm2-1-6>, [Zusätzliche Bindungen brauchen Verträglichkeit.], [Die Verformungen müssen zu derselben geometrischen Lage passen.]),
  idee(<a-tm2-1-7>, [Wärmedehnung kann eine Reaktionskraft erzeugen.], [Ein behinderter Stab und der angeschlossene Balken verformen sich gemeinsam.]),
)

#ablauf(
  chunk([Normalkraft aus Gleichgewicht], [Fläche und Werkstoff erfassen], ziel: <a-tm2-1-1>),
  chunk([Längenänderung aufstellen], [elastische Dehnung + Wärmeanteil], ziel: <a-tm2-1-4>),
  chunk([Verträglichkeit schließen], [gemeinsame Anschlusslage von Stab und Umgebung], ziel: <a-tm2-1-6>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])

Aus der Normalkraft wird eine Spannung, aus Spannung und Temperaturänderung eine Dehnung. Bei zusätzlichen Bindungen reicht Gleichgewicht nicht: Die Bauteile müssen sich auch geometrisch miteinander vertragen.

== TM2 1.1 Spannung, Dehnung und Stoffgesetz <a-tm2-1-1>
Zug ist positiv, Druck negativ. Für einen ausreichend schlanken Stab mit zentrischer Belastung ist die Normalspannung über den Querschnitt näherungsweise gleichmäßig.
#form[$ sigma(x)=N(x)/A(x), quad epsilon(x)=u'(x), quad epsilon(x)=sigma(x)/E+alpha_T Delta T(x) $]
$N$ in N, $A$ in mm², $sigma,E$ in N/mm², $alpha_T$ in 1/K, $epsilon$ dimensionslos. Das Stoffgesetz gilt linear elastisch; Temperaturausdehnung und mechanische Dehnung werden überlagert.
#bild("ak_stab_ax", [Stab mit variablem Querschnitt; ältere Klausursammlung PrüfungenTM2 PDF-S. 12.], height: 40mm)
#src[FS TM2 S. 4–8; P2 S. 1–10; AK24 S. 24.]
#hoch(<k-tm2-1>, [Kapitelübersicht])

== TM2 1.4 Längenänderung berechnen <a-tm2-1-4>
#form[$ Delta l=integral_0^l (N(x)/(E(x) A(x))+alpha_T Delta T(x)) dif x $]
Für konstante Größen vereinfacht sich das zu $Delta l=N l/(E A)+alpha_T Delta T l$. Bei mehreren Abschnitten werden deren Längenänderungen vorzeichenrichtig addiert. *Dehnung ist nicht Verschiebung*: Eine vorgegebene Einspannung legt erst die Integrationskonstante von u fest.
#note("Fehler vermeiden", [Erwärmung erzeugt bei freier Ausdehnung zunächst keine Spannung. Wird die Ausdehnung behindert, muss die mechanische Dehnung die Bindung erfüllen; dadurch entsteht bei Erwärmung meist Druck.])
#src[FS TM2 S. 5–10; P2 S. 4–10.]
#hoch(<k-tm2-1>, [Kapitelübersicht])

== TM2 1.6 Verträglichkeit bei statischer Unbestimmtheit <a-tm2-1-6>
Die Zusatzgleichung stammt aus der *Verformung*. Beispiele: festgehaltene Gesamtlänge, gleiche Verschiebung zweier verbundener Teile oder ein ursprünglich vorhandener Spalt.
+ Überzählige Reaktion als unbekannte Kraft X einführen.
+ Normalkräfte aus Gleichgewicht als Funktion von X bestimmen.
+ Elastische und thermische Längenänderungen berechnen.
+ Geometrische Verträglichkeit aufstellen und X bestimmen.
#note("Knicken erkennen", [Eine zulässige Druckspannung allein garantiert keine Sicherheit eines schlanken Stabes: Er kann seitlich ausknicken. Die älteren Klausuren fragen danach als Begriff. Eine vollständige Euler-Knickberechnung ist in deiner Themenliste nicht genannt.])
#src[FS TM2 S. 8–10; P2 S. 7–10; ältere Klausuren PrüfungenTM2 S. 3, 12, 29 und TM_Prüfung_2018 S. 10.]
#hoch(<k-tm2-1>, [Kapitelübersicht])

== TM2 1.7 Ergänzung: Erwärmter Stab stützt einen Balken <a-tm2-1-7>
#bild("ak24-waerme", [Klausurmodell AK24 PDF-S. 18 und 24. Eigene Darstellung.], height: 64mm)
Der Stab will sich um $alpha_T Delta T a$ verlängern. Die positive Druckkraft X verkürzt ihn um $X a/(E A)$. Gleichzeitig biegt X das freie Balkenende nach oben um $X l^3/(3E I)$. Der gemeinsame Gelenkpunkt darf nur eine Lage haben:
#form[$ frac(X l^3,3E I)=alpha_T Delta T a-frac(X a,E A), quad X=frac(alpha_T Delta T a, a/(E A)+l^3/(3E I)) $]
Hier bezeichnet X den *positiven Betrag der Druckkraft*, die Stabnormalkraft lautet N=−X. Der Balken ist linear elastisch, schubstarr und hat konstantes EI.
#src[AK24 S. 18, 24; FS TM2 S. 8, 30, 46–47; eigene Herleitung und Nachrechnung.]
#bild("map-klausur-stab", [Mindmap zum Kapitel; eigene Darstellung.], height: 35mm)
*Der Zusammenhang in TM2 Kapitel 1.* Gleichgewicht liefert N, die Querschnittsfläche macht daraus Spannung. Das Stoffgesetz liefert die Dehnung und ihre Integration die Längenänderung. Zusätzliche Bindungen schließen die Rechnung durch Verträglichkeit.
#hoch(<k-tm2-1>, [Kapitelübersicht])


#pagebreak()
#pagebreak(weak: true)
= TM2 Kapitel 2 · Spannungszustand und Mohrscher Kreis <k-tm2-2>

#überblick([Kapitel TM2 2 auf einen Blick],
  idee(<a-tm2-2-1>, [Spannung gehört zu einer Schnittfläche.], [Normal- und Schubkomponenten beschreiben denselben örtlichen Zustand.]),
  idee(<a-tm2-2-2>, [Eine Drehung ändert die Komponenten.], [In den Hauptrichtungen verschwindet die Schubspannung.]),
  idee(<a-tm2-2-2-3>, [Der Mohrsche Kreis macht die Transformation sichtbar.], [Kreiswinkel und Bauteilwinkel sind mit der festgelegten Konvention zuzuordnen.]),
)

#ablauf(
  chunk([Spannungskomponenten erfassen], [Normalspannungen · Schubspannung · Vorzeichen], ziel: <a-tm2-2-1>),
  chunk([Kreis oder Transformation verwenden], [Mittelpunkt · Radius · doppelter Winkel], ziel: <a-tm2-2-2-3>),
  chunk([Hauptwerte und Richtungen prüfen], [Schubspannung null · räumliches Schubmaximum gesondert prüfen], ziel: <a-tm2-2-2>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])

Ein schräger Schnitt durch dasselbe Bauteil zeigt andere Normal- und Schubspannungen. Du suchst die größten Werte, ihre Richtungen und eine zeichnerische Kontrolle.

== TM2 2.1 Der ebene Spannungszustand <a-tm2-2-1>
Im dünnen Blech werden die Spannungen senkrecht zur Oberfläche näherungsweise null gesetzt. Im ebenen Zustand bleiben zwei Normalspannungen und eine unabhängige Schubspannung:
#form[$ S=mat(sigma_x,tau_(x y);tau_(x y),sigma_y) $]
Alle Einträge in N/mm². Normalspannungen wirken senkrecht auf die Schnittfläche, Schubspannungen tangential. Die beiden Nebendiagonaleinträge sind wegen des Momentengleichgewichts gleich.
#src[FS TM2 S. 11–12; neue Lösungen TM2 Nr. 5 S. 1–5.]
#hoch(<k-tm2-2>, [Kapitelübersicht])

== TM2 2.2 Transformation und Hauptspannungen <a-tm2-2-2>
Bei einer Drehung des Achsensystems um $phi$ gilt:
#form[$ sigma_xi=(sigma_x+sigma_y)/2+(sigma_x-sigma_y)/2 cos(2phi)+tau_(x y) sin(2phi) $
$ tau_(xi eta)=-(sigma_x-sigma_y)/2 sin(2phi)+tau_(x y) cos(2phi) $]
In den *Hauptrichtungen* ist die Schubspannung null. Die beiden Hauptspannungen sind:
#form[$ sigma_(1,2)=(sigma_x+sigma_y)/2 plus.minus sqrt(((sigma_x-sigma_y)/2)^2+tau_(x y)^2), quad tan(2phi^*)=frac(2tau_(x y),sigma_x-sigma_y) $]
$phi^*$ allein bestimmt noch nicht, welche Hauptspannung zu der Richtung gehört: in die Transformationsgleichung einsetzen. Die zweite Hauptrichtung liegt um 90° versetzt.
#note("Schubmaximum richtig benennen", [Der Radius des *ebenen* Kreises ist $tau_("max, Ebene")=(sigma_1-sigma_2)/2$. Für das absolute räumliche Maximum müssen alle drei Hauptspannungen betrachtet werden, im ebenen Spannungszustand also zusätzlich $sigma_3=0$: $tau_("max, räumlich")=(sigma_("größte")-sigma_("kleinste"))/2$.])
#src[FS TM2 S. 12–15; neue Lösung TM2 Nr. 6 S. 1–5.]
#hoch(<k-tm2-2>, [Kapitelübersicht])

== TM2 2.2.3 Mohrschen Spannungskreis zeichnen ★ <a-tm2-2-2-3>
#bild("tm2k2_fs_kreis", [Spannungskreis; FS TM2 PDF-S. 15.], height: 56mm)
+ $sigma$ waagerecht, $tau$ senkrecht mit *gleichem Maßstab* einzeichnen.
+ $P=(sigma_x,tau_(x y))$ und $P'=(sigma_y,-tau_(x y))$ eintragen.
+ Mittelpunkt $C=((sigma_x+sigma_y)/2,0)$ bilden und Kreis durch beide Punkte zeichnen. PP′ ist ein Durchmesser.
+ Schnittpunkte mit der horizontalen Achse liefern $sigma_1$, $sigma_2$; Radius ist das ebene Schubmaximum.
+ Winkel von CP zur gewählten Zielrichtung messen: Kreiswinkel = doppelter Bauteilwinkel, mit entgegengesetztem Drehsinn in dieser Konvention.
#note("Von dir markiert", [„Kommt i. d. Prüfung dran!“ steht neben dem Kreis in WZF 04.05.26. KH nennt ausdrücklich *Spannung oder Dehnung*. Deshalb beide Konstruktionen von Hand üben.])
#src[FS TM2 S. 13–15; WZF 04.05.26 S. 5–6; KH S. 1; AK24 S. 24–25.]
#bild("map-klausur-tm2", [Mindmap: die Aufgabenbausteine der Elastostatik. Eigene Darstellung.], height: 43mm)
*Der Zusammenhang in TM2 Kapitel 2.* Der Tensor beschreibt den örtlichen Zustand. Die Drehung verändert seine Komponenten, aber nicht seine Hauptwerte. Die Formeln und der Kreis sind zwei Wege zu denselben Spannungen und Richtungen.
#hoch(<k-tm2-2>, [Kapitelübersicht])


#pagebreak()
#pagebreak(weak: true)
= TM2 Kapitel 3 · Dehnungen, Elastizitätsgesetz und DMS <k-tm2-3>

#überblick([Kapitel TM2 3 auf einen Blick],
  idee(<a-tm2-3-3>, [Ein DMS misst eine Richtungsdehnung.], [Drei Messrichtungen liefern die Komponenten des ebenen Verzerrungszustands.]),
  idee(<a-tm2-3-1>, [Im Verzerrungskreis steht die halbe Gleitung.], [Einheiten und Skalierung aller Messwerte müssen zusammenpassen.]),
  idee(<a-tm2-3-2>, [Das Stoffgesetz führt von Dehnung zu Spannung.], [Materialannahmen und thermische Dehnung bestimmen die gültige Umrechnung.]),
)

#ablauf(
  chunk([Messrichtungen und Werte lesen], [Winkel · Einheiten · Temperaturanteil], ziel: <a-tm2-3-3>),
  chunk([Verzerrungszustand bestimmen], [Normaldehnungen und Gleitung · Kreis mit halber Gleitung], ziel: <a-tm2-3-1>),
  chunk([Spannungen berechnen], [Elastizitätsgesetz mit passenden Voraussetzungen], ziel: <a-tm2-3-2>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])

Dehnmessstreifen messen Längenänderungen in bestimmten Richtungen. Aus drei Messungen berechnest du den ebenen Verzerrungszustand und daraus mit dem Werkstoffgesetz die Spannungen.

== TM2 3.1 Dehnung und halbe Gleitung <a-tm2-3-1>
Die Dehnung $epsilon$ misst relative Längenänderung. Die Gleitung $gamma_(x y)$ misst die Änderung eines ursprünglich rechten Winkels im Bogenmaß.
#form[$ V=mat(epsilon_x,gamma_(x y)/2;gamma_(x y)/2,epsilon_y) $]
Im *Mohrschen Verzerrungskreis* wird $sigma$ durch $epsilon$ ersetzt, $tau$ aber durch *$gamma/2$*.
#form[$ epsilon_(1,2)=(epsilon_x+epsilon_y)/2 plus.minus sqrt(((epsilon_x-epsilon_y)/2)^2+(gamma_(x y)/2)^2), quad tan(2phi^*)=frac(gamma_(x y),epsilon_x-epsilon_y) $]
#bild("tm2k3_reine", [Gleitung als Winkeländerung; Skript TM2 PDF-S. 456.], height: 46mm)
Für den Kreis trägst du $P=(epsilon_x,gamma/2)$ und $P'=(epsilon_y,-gamma/2)$ ein. Auch hier gelten gleicher Maßstab, halber Bauteilwinkel und entgegengesetzter Drehsinn.
#note("Fehler vermeiden", [$1 "‰"=10^(-3)$, $1 "%"=10^(-2)$, $1 "µm/m"=10^(-6)$. Wenn du mit Promille rechnest, müssen *alle* Dehnungen und die Gleitung in derselben Skalierung stehen. Für das Hookesche Gesetz wieder die dimensionslosen Zahlen verwenden.])
#src[FS TM2 S. 17–18; neue Lösung TM2 Nr. 8 S. 1–7; KH S. 1.]
#hoch(<k-tm2-3>, [Kapitelübersicht])

== TM2 3.2 Von Dehnungen zu Spannungen <a-tm2-3-2>
Im linear elastischen, isotropen Material mit ebenem Spannungszustand und ohne Temperaturanteil gilt:
#form[$ epsilon_x=(sigma_x-nu sigma_y)/E, quad epsilon_y=(sigma_y-nu sigma_x)/E, quad gamma_(x y)=tau_(x y)/G, quad G=E/(2(1+nu)) $]
Umgekehrt:
#form[$ sigma_x=E/(1-nu^2)(epsilon_x+nu epsilon_y), quad sigma_y=E/(1-nu^2)(epsilon_y+nu epsilon_x), quad tau_(x y)=G gamma_(x y) $]
Dieselben Formeln gelten in Hauptachsen mit Indizes 1 und 2. Bei Temperaturänderung zunächst die freie thermische Dehnung $alpha_T Delta T$ aus beiden Normaldehnungen abziehen.
#note("Dritte Dehnung", [Auch bei $sigma_z=0$ ist $epsilon_z=-nu(sigma_x+sigma_y)/E$ im Allgemeinen nicht null. Das ist Querkontraktion. Ein *ebener Spannungszustand* ist deshalb kein ebener Verzerrungszustand.])
#src[FS TM2 S. 19–21; neue Lösungen TM2 Nr. 5 und 8; ältere Klausur TM_Prüfung_2018 S. 11.]
#hoch(<k-tm2-3>, [Kapitelübersicht])

== TM2 3.3 DMS-Rosetten auswerten ★ <a-tm2-3-3>
Ein DMS misst die Dehnung entlang seiner Messrichtung. Für einen Winkel $phi$ gegen die x-Achse gilt:
#form[$ epsilon_phi=(epsilon_x+epsilon_y)/2+(epsilon_x-epsilon_y)/2 cos(2phi)+gamma_(x y)/2 sin(2phi) $]
Drei unterschiedlich orientierte Messrichtungen liefern drei Gleichungen für $epsilon_x$, $epsilon_y$ und $gamma_(x y)$.
#bild("tm2k3_dms_anordnung", [Rosette mit b in x-Richtung und a/c bei −45°/+45°; Skript TM2 PDF-S. 467.], height: 48mm)
#tab(columns: 2, th([Rosette], [Auswertung]),
 [0° / 45° / 90°], [$epsilon_x=epsilon_0$, $epsilon_y=epsilon_90$, $gamma_(x y)=2epsilon_45-epsilon_0-epsilon_90$],
 [−45° / 0° / +45°], [$epsilon_x=epsilon_0$, $epsilon_y=epsilon_(-45)+epsilon_(+45)-epsilon_0$, $gamma_(x y)=epsilon_(+45)-epsilon_(-45)$],
 [Andere Winkel], [Für jede Richtung die allgemeine Gleichung einsetzen und das lineare Gleichungssystem lösen],)
Danach folgen Hauptdehnungen samt Richtungszuordnung und schließlich Hauptspannungen. Bei isotropem Material stimmen Hauptspannungs- und Hauptdehnungsrichtungen überein.
#note("Von dir markiert", [WZF 18.05.26 S. 6 nennt die Rosette „pot. Klausuraufgabe“. Deine neue Themenliste bestätigt DMS ausdrücklich.])
#src[Skript TM2 S. 464–480; WZF 18.05.26 S. 6; P2 S. 33–35, Aufgabe 8.3; neue Lösung TM2 Nr. 8 S. 5–7; KH S. 1.]
#bild("map-klausur-dms", [Mindmap zum Kapitel; eigene Darstellung.], height: 35mm)
*Der Zusammenhang in TM2 Kapitel 3.* Die Messrichtungen liefern Komponenten des Verzerrungstensors. Der Verzerrungskreis liefert dessen Hauptwerte. Das Elastizitätsgesetz verbindet diese messbaren Verformungen mit dem gesuchten Spannungszustand.
#hoch(<k-tm2-3>, [Kapitelübersicht])


#pagebreak()
#pagebreak(weak: true)
= TM2 Kapitel 4 · Biegung, FTM und Biegelinie <k-tm2-4>

#überblick([Kapitel TM2 4 auf einen Blick],
  idee(<a-tm2-4-3>, [Gemeinsame Schwerpunktachsen kommen zuerst.], [Steiner verschiebt die Teilmomente auf diese Achsen.]),
  idee(<a-tm2-4-2>, [Moment und Widerstandsmoment bestimmen die Randspannung.], [Achse, Randabstand und Querschnitt müssen zusammenpassen.]),
  idee(<a-tm2-4-4>, [Biegesteifigkeit bestimmt die Verformung.], [Randbedingungen, Integration oder passende Tafelfälle liefern die Biegelinie.]),
  idee(<a-tm2-4-7>, [Jede Rechnung braucht ihre eigene Geometriegröße.], [Materialfläche und Wandmittellinie dürfen nicht verwechselt werden.]),
)

#ablauf(
  chunk([Schwerpunkt und gemeinsame Achsen], [Teilflächen · Aussparungen · Abstände], ziel: <a-tm2-4-3>),
  chunk([FTM und Widerstandsmoment], [Steiner · zugehöriger Randabstand], ziel: <a-tm2-4-2>),
  chunk([Spannung und Verformung getrennt prüfen], [M/W · Biegesteifigkeit EI · Randbedingungen], ziel: <a-tm2-4-4>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])

Die Biegespannung hängt von Last und Querschnitt ab, die Durchbiegung zusätzlich von der Steifigkeit. Der zentrale Rechenweg lautet: Schwerpunkt → FTM → Widerstandsmoment → Spannung bzw. Verformung.

== TM2 4.2 Biegespannung und Widerstandsmoment <a-tm2-4-2>
Bei *gerader Biegung* um eine Schwerpunkt-Hauptachse verläuft die Normalspannung linear über den Querschnitt. In der neutralen Faser z=0 ist sie null; den größten Betrag erhältst du am am weitesten entfernten Rand.
#form[$ sigma_x(z)=M_y z/I_y, quad abs(sigma_("max"))=abs(M_y)/W_y, quad W_y=I_y/max(abs(z)) $]
$M$ in Nmm, $I$ in mm⁴, $W$ in mm³, $sigma$ in N/mm². Gültig für kleine Verformungen, linear elastisches Material und Bernoulli-Balken. Bei unsymmetrischen Querschnitten zuerst prüfen, ob die betrachtete Achse eine Hauptachse ist.
#bild("tm2k4_spannungsverlauf", [Linearer Spannungsverlauf bei verschiedenen Querschnitten; Skript TM2 PDF-S. 538.], height: 43mm)
#note("Fehler vermeiden", [Zu $I_y$ gehört der Randabstand in *z-Richtung*. Der Rand mit größtem Abstand zu S ist maßgebend, nicht automatisch die Hälfte der Gesamthöhe. Der Ort des größten Moments entlang des Balkens und der größte Randabstand im Querschnitt sind zwei getrennte Fragen.])
#note("Zug/Druck und Biegung gemeinsam", [Wirkt zusätzlich eine zentrische Normalkraft, werden im linear elastischen Fall die Normalspannungen addiert: $sigma_x(z)=N/A+M_y z/I_y$. Der Anteil N/A verschiebt den linearen Biegespannungsverlauf. Die Randwerte auf beiden Seiten prüfen; die neutrale Faser liegt dann im Allgemeinen nicht mehr bei z=0.])
#src[FS TM2 S. 22–23; Skript TM2 S. 538; neue Lösung TM2 Nr. 9 S. 1–5; AK24 S. 24.]
#hoch(<k-tm2-4>, [Kapitelübersicht])

== TM2 4.3 Flächenträgheitsmomente und Steiner <a-tm2-4-3>
Ein FTM beschreibt, wie weit die Fläche von einer Achse entfernt liegt. Material weit weg von der Biegeachse trägt wegen des quadratischen Abstands stark bei.
#form[$ I_y=integral z^2 dif A, quad I_z=integral y^2 dif A, quad I_(y z)=-integral y z dif A $]
Hier gilt ausdrücklich die Vorlesungskonvention mit *Minus* im Deviationsmoment.
#tab(columns: 3, th([Form], [Fläche], [Eigen-FTM um Schwerpunktachse]),
 [Rechteck b × h], [$b h$], [$I_y=b h^3/12$, $I_z=h b^3/12$],
 [Vollkreis Radius R], [$pi R^2$], [$I_y=I_z=pi R^4/4$],
 [Halbkreis Radius R], [$pi R^2/2$], [Parallel zur Durchmesserlinie: $R^4(9pi^2-64)/(72pi)$; Schwerpunktabstand $4R/(3pi)$],)
#heading(level: 3, outlined: false)[Gemeinsame Achsen herstellen]
Mit $d_(z i)=z'_(S i)-z'_S$ und $d_(y i)=y'_(S i)-y'_S$ gilt für *positive geometrische Teilflächen* und Vorzeichen $s_i=+1$ bzw. −1 für Löcher:
#form[$ I_y=sum s_i (I_(y i,S)+A_i d_(z i)^2), quad I_z=sum s_i (I_(z i,S)+A_i d_(y i)^2) $
$ I_(y z)=sum s_i (I_(y z,i,S)-A_i d_(y i) d_(z i)) $]
So wird das Minus einer Aussparung genau einmal angewendet. Zuerst die Eigenmomente um die jeweiligen *Teilflächenschwerpunktachsen* nehmen, dann mit Steiner auf die parallelen Achsen durch den Gesamtschwerpunkt verschieben.
#bild("ak24-querschnitt", [Querschnitt aus AK24 PDF-S. 18–23; eigene Darstellung.], height: 62mm)
#note("Von dir markiert", [„Prüfung: Flächenträgheitsmomente mit versch. Ausschnitten!“ (WZF 08.06.26). Die neuen Unterlagen enthalten genau solche Aufgaben: P2 S. 41–51 und AK24 mit einem Rechteck und zwei Halbkreisen.])
#src[FS TM2 S. 24–26; neue Lösung TM2 Nr. 10 S. 1–14; neue FTM-Notiz S. 1; AK24 S. 18–23.]
#heading(level: 3, outlined: false)[Hauptachsen und Achsendrehung]
Eine Symmetrieachse durch S ist eine Hauptachse. Dann verschwindet $I_(y z)$. Bei allgemeinen Querschnitten erhältst du:
#form[$ I_(1,2)=(I_y+I_z)/2 plus.minus sqrt(((I_y-I_z)/2)^2+I_(y z)^2), quad tan(2phi^*)=2I_(y z)/(I_y-I_z) $]
Die Zuordnung des Winkels zu I₁ oder I₂ kontrollierst du durch Einsetzen:
#form[$ I_eta=(I_y+I_z)/2+(I_y-I_z)/2 cos(2phi)+I_(y z) sin(2phi) $
$ I_(eta zeta)=-(I_y-I_z)/2 sin(2phi)+I_(y z) cos(2phi) $]
Der Mohrsche Trägheitskreis funktioniert analog zum Spannungskreis mit $P=(I_y,I_(y z))$ und $P'=(I_z,-I_(y z))$. Kontrolle: $I_1+I_2=I_y+I_z$.
#src[FS TM2 S. 26–27; neue Lösung TM2 Nr. 10 S. 9–14.]
#hoch(<k-tm2-4>, [Kapitelübersicht])

== TM2 4.4 Biegelinie: Randbedingungen und Superposition <a-tm2-4-4>
#form[$ w''=-M/(E I), quad Q'= -q, quad M'=Q $]
Für konstantes EI folgt $E I w^(4)=q$. Bei variablem I(x) bleibt $w''=-M/(E I(x))$ gültig; I(x) darf beim Integrieren nicht als Konstante behandelt werden.
#tab(columns: (1fr, 2fr), th([Rand], [Bedingungen ohne zusätzliche Randlast]),
 [Einspannung], [$w=0$, $w'=0$],
 [Gelenkiges Endlager], [$w=0$, $M=0$],
 [Freies Ende], [$Q=0$, $M=0$],
 [Parallelführung mit freier Querverschiebung], [$w'=0$, $Q=0$],)
Ein Endmoment oder eine Endkraft ersetzt die entsprechende Nullbedingung durch das richtige Lastvorzeichen. Ein *Zwischenlager* macht das Moment nicht automatisch null: Bei einem durchlaufenden Balken kann dort M≠0 sein.
#note("Von dir markiert", [WZF 15.06.26 S. 3: „Integrieren in d. Klausur nicht so wichtig, eher Randbedingungen aufstellen!“ AK24 fragt zusätzlich die Durchbiegung aus Tabellen und die Verträglichkeit von Balken und Stab.])
#heading(level: 3, outlined: false)[Mehrere Bereiche]
Je Bereich entstehen bei vierfacher Integration vier Konstanten. Am unverletzten Übergang sind w und w′ stetig; M und Q springen nur durch eingeleitete Momente bzw. Kräfte. Am inneren Drehgelenk ist M auf beiden Seiten null und w stetig; die Neigungen dürfen verschieden sein.
#heading(level: 3, outlined: false)[Tafeln anwenden]
Bei kleinen Verformungen und linear elastischem Material darfst du Lastfälle addieren: $w=w_1+w_2$. Suche für jede Last dieselbe Lagerung, dieselbe x-Koordinate und die richtige Stelle in der Tafel. Vorzeichen separat aus dem Drehsinn bzw. der Durchbiegungsrichtung bestimmen.
#form[$ w_("Kragarm,Endkraft")=frac(F L^3,3E I), quad w_("Kragarm,Endmoment")=frac(M_0 L^2,2E I) $]
Hier stehen die *Beträge* der Enddurchbiegungen. Die Tafel in FS TM2 S. 46–49 enthält auch Lasten an einer inneren Stelle.
#src[FS TM2 S. 28–30, 46–49; neue Lösung TM2 Nr. 11 S. 1–10; WZF 15.06.26 S. 1–5; AK24 S. 24–26.]
#hoch(<k-tm2-4>, [Kapitelübersicht])

== TM2 4.7 Ergänzung: Der Querschnitt aus AK24 <a-tm2-4-7>
Verwendet werden die *äußeren Maße* r=50 mm und t=3,75 mm. Das Hilfssystem liegt am Mittelpunkt des Halbkreises, z′ zeigt nach unten. Die Auswertung in den Aufgaben unten verbindet die Schwerpunktrechnung mit Steiner und dem Spannungsnachweis.
#note("Richtiges Maß für jede Rechnung", [Für die *exakte Materialfläche und Biege-FTM* rechnest du Außenfläche minus Innenfläche. Für *dünnwandige Torsion* brauchst du dagegen die *Wandmittellinie*. Das sind unterschiedliche Flächen und Radien.])
#src[AK24 S. 18–24; FS TM2 S. 24–26, 40–41.]
#bild("map-t2k4", [Mindmap: Schwerpunkt, FTM, Spannung und Biegelinie. Eigene Darstellung.], height: 43mm)
*Der Zusammenhang in TM2 Kapitel 4.* Der Schwerpunkt legt die Bezugsachsen fest; Steiner führt alle Teilmomente auf diese Achsen. I und W bestimmen die Biegespannung. EI bestimmt die Verformung, die du aus Integration, Randbedingungen oder durch Superposition aus der Tafel berechnest.
#hoch(<k-tm2-4>, [Kapitelübersicht])


#pagebreak()
#pagebreak(weak: true)
= TM2 Kapitel 5 · Torsion: Spannung und Verdrehung <k-tm2-5>

#überblick([Kapitel TM2 5 auf einen Blick],
  idee(<a-tm2-5-1>, [Das Torsionsmoment kommt aus dem Freischnitt.], [Spannung und Verdrehung hängen anschließend von unterschiedlichen Querschnittsgrößen ab.]),
  idee(<a-tm2-5-2>, [Ein geschlossenes dünnwandiges Profil trägt umlaufenden Schubfluss.], [Die Wandmittellinie und die dünnste Wand bestimmen die maßgebenden Größen.]),
  idee(<a-tm2-5-3>, [Ein offenes Profil braucht ein anderes Modell.], [Ein Längsschlitz unterbricht den geschlossenen Lastpfad.]),
)

#ablauf(
  chunk([Torsionsmoment und Profil einordnen], [Kreisquerschnitt gesondert mit Kreisformeln behandeln], ziel: <a-tm2-5-1>),
  entscheidung([Ist das dünnwandige Profil geschlossen und einzellig?],
    chunk([Geschlossenes Profil], [Bredt · umschlossene Mittellinienfläche], ziel: <a-tm2-5-2>),
    chunk([Offenes Profil prüfen], [dünne Streifen · Voraussetzungen der Näherung], ziel: <a-tm2-5-3>)),
  chunk([Spannung und Verdrehung prüfen], [Widerstandsmoment · Torsionssteifigkeit · Winkel in rad], ziel: <a-tm2-5-1>),
)
#src[Eigene Darstellung; Zusammenführung der nachfolgenden, jeweils belegten Abschnitte dieses Kapitels.]
#hoch(<ueberblick>, [Modul auf einen Blick])

Ein Torsionsmoment verdreht den Querschnitt. Die passende Formel hängt zuerst von der Form ab: Kreiswelle, dünnwandig geschlossen oder dünnwandig offen.

== TM2 5.1 Kreiswellen und allgemeiner Rechenweg <a-tm2-5-1>
#form[$ tau_("max")=abs(M_T)/W_T, quad theta'(x)=M_T(x)/(G I_T(x)), quad Delta theta=integral_0^l M_T(x)/(G I_T(x)) dif x $]
$M_T$ in Nmm, $I_T$ in mm⁴, $W_T$ in mm³, G in N/mm². Die Verdrehung aus dieser Rechnung ist in *rad*; für Grad mit $180/pi$ multiplizieren.
#tab(columns: 3, th([Kreisquerschnitt], [$I_T$], [$W_T$]),
 [Vollkreis, Radius R], [$pi R^4/2$], [$pi R^3/2$],
 [Kreisring, Außen R, innen r], [$pi(R^4-r^4)/2$], [$I_T/R$],)
Nur beim Kreis bzw. konzentrischen Kreisring stimmt das Torsionsträgheitsmoment mit dem polaren Flächenträgheitsmoment überein. Für andere Querschnitte nicht einfach $I_T=I_y+I_z$ setzen.
#note("Vorgehen", [Erst Mₜ aus Freischnitt und Hebelarm bestimmen, dann Querschnitt einordnen. Spannung und Verdrehung separat prüfen: Ein zulässiger Spannungswert garantiert noch keine zulässige Verdrehung.])
#src[FS TM2 S. 37–40; P2 S. 59–63; neue Lösung TM2 Nr. 12 S. 1–3.]
#hoch(<k-tm2-5>, [Kapitelübersicht])

== TM2 5.2 Dünnwandige geschlossene Profile <a-tm2-5-2>
Bei einer *geschlossenen einzelligen* Wand kann der Schubfluss einmal rundherum laufen. Für eine dünne Wand gilt die Bredtsche Beziehung:
#form[$ T=tau(s)t(s)=M_T/(2A_m), quad W_T=2A_m t_("min"), quad I_T=frac(4A_m^2,integral.cont dif s/t(s)) $]
$A_m$ ist die von der *Wandmittellinie* umschlossene Fläche. T ist Schubfluss in N/mm. Bei konstanter Wanddicke ist $I_T=4A_m^2 t/L_m$ mit der Mittellinienlänge $L_m$.
#bild("ak24-querschnitt", [Geschlossener Querschnitt aus AK24 PDF-S. 18, 23; eigene Darstellung.], height: 55mm)
#note("Wo liegt die größte Spannung?", [Bei konstantem Torsionsmoment liegt sie an der *dünnsten Wand*. Bei überall gleicher Dicke ist τ entlang des Umfangs gleich groß. Ist außerdem Mₜ entlang des Stabes konstant, gilt das über die ganze Länge, abseits örtlicher Einleitungseinflüsse.])
#src[FS TM2 S. 40–41; neue Lösung TM2 Nr. 12 S. 4–6; AK24 S. 18, 23.]
#hoch(<k-tm2-5>, [Kapitelübersicht])

== TM2 5.3 Dünnwandige offene Profile <a-tm2-5-3>
Ein Längsschlitz unterbricht den umlaufenden Schubfluss. Für schmale Rechteckstreifen mit Länge $b_i$ und Dicke $t_i$ gilt näherungsweise:
#form[$ I_T approx frac(1,3) sum b_i t_i^3, quad W_T approx I_T/t_("max"), quad tau_("max") approx abs(M_T)t_("max")/I_T $]
Anders als beim geschlossenen Profil liegt die größte Torsionsspannung bei diesem dünnwandigen offenen Streifenmodell im *dicksten* Teil. Die Näherung setzt $t_i << b_i$ und geeignete freie Verwölbung voraus.
#bild("ak_2018_torsion", [Offene und geschlossene Profile im Vergleich; TM_Prüfung_2018 PDF-S. 10.], height: 43mm)
#note("Selbst erklären", [Warum kann ein schmaler Schlitz die Verdrehung stark vergrößern, obwohl kaum Material fehlt? Er unterbricht den geschlossenen Lastpfad; dadurch ändert sich das passende Torsionsmodell grundlegend.])
#src[FS TM2 S. 40–41; neue Lösung TM2 Nr. 12 S. 4; ältere Klausur TM_Prüfung_2018 S. 10.]
#hoch(<k-tm2-5>, [Kapitelübersicht])

== TM2 5.4 Ergänzung: Torsion des AK24-Profils <a-tm2-5-4>
Für r=50 mm und t=3,75 mm ist der Mittellinienradius $r_m=r-t/2="48,125" "mm"$. Die gerade Mittellinienhöhe ist $h_m=3r-t/2="148,125" "mm"$.
#form[$ A_m=2r_m h_m+pi r_m^2/2, quad L_m=2h_m+2r_m+pi r_m $]
Der äußere Radius r ist nicht der Mittellinienradius. Die Materialfläche aus der Schwerpunktrechnung ist ebenfalls nicht Aₘ.
#src[AK24 S. 18, 23; FS TM2 S. 40–41; eigene Aufbereitung.]
#bild("map-klausur-torsion", [Mindmap zum Kapitel; eigene Darstellung.], height: 35mm)
*Der Zusammenhang in TM2 Kapitel 5.* Mₜ kommt aus dem Gleichgewicht. Der Querschnitt entscheidet über Iₜ und Wₜ. Wₜ bestimmt die Spannung, GIₜ die Verdrehung; bei geschlossenen Profilen steuert die dünnste Wand den größten Spannungswert.
#hoch(<k-tm2-5>, [Kapitelübersicht])


#pagebreak()
= Anhang
== Formelsammlung mit Voraussetzungen
Die Vorzeichen folgen dem jeweils gezeichneten Freikörperbild bzw. der lokalen Bezugsfaser. Diese Sammlung ersetzt nicht die Klärung der Voraussetzungen.
#tab(columns: (1fr, 1.8fr, 1.7fr), th([Thema], [Formel], [Voraussetzung / Einheit]),
 [Gleichgewicht], [$sum F_H=0$, $sum F_V=0$, $sum M_P=0$], [Je freiem starren Körper in der Ebene],
 [Kraftzerlegung], [$F_x=F cos alpha$, $F_y=F sin alpha$], [α gegen x gemessen; Pfeilvorzeichen beachten],
 [Moment], [$M_P=F d$], [d senkrecht zur Wirkungslinie; Nmm oder Nm],
 [Streckenlast], [$F_R=integral q(x) dif x$, $x_R=frac(integral x q(x) dif x,F_R)$], [Nur der betrachtete Abschnitt; q Kraft/Länge],
 [Schwerpunkt], [$z'_S=sum A_i z'_(S i)/sum A_i$], [Aussparungen mit Minus; y analog],
 [Bestimmtheit], [$r+v=3n$; Fachwerk $s+r=2k$], [Nur notwendige Zählbedingungen; Geometrie prüfen],
 [Schnittgrößen], [$Q'=-q$, $M'=Q$], [Gerader Balken, Vorlesungskonvention],
 [Haftung], [$abs(H)<=mu_0N$], [N≥0; Gleichheit erst im Grenzfall],
 [Stabspannung], [$sigma=N/A$], [Zentrisch, ausreichend fern von Lasteinleitung; N/mm²],
 [Stabdehnung], [$epsilon=N/(E A)+alpha_T Delta T$], [Linear elastisch; Zug positiv],
 [Längenänderung], [$Delta l=integral epsilon(x) dif x$], [Konstant: $N l/(E A)+alpha_T Delta T l$],
 [Hauptspannungen], [$sigma_(1,2)=(sigma_x+sigma_y)/2 plus.minus sqrt(((sigma_x-sigma_y)/2)^2+tau^2)$], [Ebener Zustand; dritte Hauptspannung 0],
 [Hauptrichtung], [$tan(2phi)=2tau/(sigma_x-sigma_y)$], [Zuordnung durch Einsetzen prüfen],
 [Kreis], [$C=((sigma_x+sigma_y)/2,0)$], [P=(σₓ,τ), P′=(σᵧ,−τ); gleicher Maßstab],
 [Schubmaximum], [$tau_("max")=(sigma_("größte")-sigma_("kleinste"))/2$], [Für räumliches Maximum alle drei Hauptwerte],
 [Hauptdehnungen], [$epsilon_(1,2)=(epsilon_x+epsilon_y)/2 plus.minus sqrt(((epsilon_x-epsilon_y)/2)^2+(gamma/2)^2)$], [Im Kreis γ/2 verwenden, nicht γ],
 [DMS], [$epsilon_phi=(epsilon_x+epsilon_y)/2+(epsilon_x-epsilon_y)/2 cos(2phi)+gamma/2 sin(2phi)$], [Drei unabhängige Messrichtungen],
 [Hooke eben], [$sigma_x=E(epsilon_x+nu epsilon_y)/(1-nu^2)$, $tau=G gamma$], [σz=0; isotrop, elastisch; Temperaturanteil abziehen],
 [Querdehnung], [$epsilon_z=-nu(sigma_x+sigma_y)/E$], [Ebener Spannungszustand, ohne Temperaturanteil],
 [Schubmodul], [$G=E/(2(1+nu))$], [Isotropes linear elastisches Material],
 [Biegespannung], [$sigma=M_y z/I_y$, $W_y=I_y/max(abs(z))$], [Gerade Biegung um Schwerpunkt-Hauptachse],
 [Rechteck / Kreis], [$I_y=b h^3/12$; Kreis $I=pi R^4/4$], [Eigene Schwerpunktachsen; mm⁴],
 [Steiner], [$I_y=sum s_i(I_(y i,S)+A_i d_(z i)^2)$], [sᵢ=−1 für Aussparungen; positive Teilflächen Aᵢ],
 [Deviationsmoment], [$I_(y z)=sum s_i(I_(y z,i,S)-A_i d_(y i)d_(z i))$], [Vorlesung: $I_(y z)=-integral y z dif A$],
 [Haupt-FTM], [$I_(1,2)=(I_y+I_z)/2 plus.minus sqrt(((I_y-I_z)/2)^2+I_(y z)^2)$], [Achsen durch S; Invariante I₁+I₂=Iᵧ+I_z],
 [FTM-Richtung], [$tan(2phi)=2I_(y z)/(I_y-I_z)$], [Zuordnung durch Transformation prüfen],
 [Biegelinie], [$w''=-M/(E I)$], [Kleine Verformung, Bernoulli-Balken],
 [Vierfach integrieren], [$E I w^(4)=q$], [Nur bei konstantem EI; je Bereich 4 Konstanten],
 [Kragarm, Endkraft], [$abs(w_L)=abs(F)L^3/(3E I)$], [Konstantes EI, Endkraft quer],
 [Kragarm, Endmoment], [$abs(w_L)=abs(M_0)L^2/(2E I)$], [Moment tatsächlich am Ende],
 [Verträglichkeit], [$X l^3/(3E I)=alpha_T Delta T a-X a/(E A)$], [Erwärmter Druckstab unter Kragarmende; X als Druckbetrag],
 [Torsion allgemein], [$tau_("max")=abs(M_T)/W_T$, $Delta theta=integral M_T/(G I_T) dif x$], [Winkel in rad; geeignetes Querschnittsmodell],
 [Vollwelle], [$I_T=pi d^4/32$, $W_T=pi d^3/16$], [Kreis; konzentrischer Ring durch Subtraktion],
 [Geschlossen dünn], [$W_T=2A_m t_("min")$, $I_T=4A_m^2/(integral.cont dif s/t)$], [Einzellig; Mittellinie; τmax an dünnster Wand],
 [Offen dünn], [$I_T approx sum b_i t_i^3/3$, $W_T approx I_T/t_("max")$], [Schmale Streifen; τmax im dicksten Teil],)
#note("Wichtige Zahlen", [
Stahlwerte in den Aufgaben: $E=210000 "N/mm"^2$, $nu="0,3"$; G aus der jeweiligen Angabe verwenden (AK24: 81000 N/mm²).

$1 "kNm"=10^6 "Nmm"$; $1 "N/mm"^2=1 "MPa"$; $1 "rad"=180/pi "°"$.

$1 "‰"=10^(-3)$; $1 "µm/m"=10^(-6)$; Temperaturdifferenzen in K und °C sind zahlenmäßig gleich.
])
#src[FS TM1 S. 8, 18–19, 21–27, 30–45, 48–49; FS TM2 S. 4–30, 37–41, 46–49; AK24 S. 24. Eigene Zusammenstellung.]

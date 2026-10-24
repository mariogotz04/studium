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
  #text(size: 8pt, fill: muted)[Feynman-Lernskript · Stand 22.10.2026]
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

#let abbildungen = (
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
#v(3mm)
#text(size: 12pt)[Freischneiden. Gleichgewicht aufstellen. Selbst erklären.]
#v(5mm)
#bild("cover", [Schematische Illustration der drei Grundbilder des Moduls. Eigens erzeugt, nicht maßstäblich.], height: 62mm)
#v(4mm)
#text(size: 12pt, fill: teal)[Freischneiden → Gleichgewicht → Schnittgrößen → Spannung und Verformung]
]

#note("Dein Feynman-Schritt", [Sieh dir die Abbildung an. Erkläre dann ohne Vorlage: *Welche Kräfte wirken? Was passiert im Inneren des Bauteils? Wann gilt die Formel?* Erst danach vergleichst du deine Erklärung mit dem Text und den Formeln.])

Das Lernskript hat zwei Teile: TM1 (Kapitel 0–7 und 9, Gliederung wie die Folien von Prof. Bongmba) und TM2 (Kapitel 0–5, Gliederung wie die Formelsammlung TM2, Inhalte aus dem Skript von Herrn Sosnowsky). Drin ist nur, was laut deinen Unterlagen behandelt wurde. Jedes Kapitel endet mit Fragen aus Übungen, Skript und Altklausuren; die Lösungen stehen getrennt dahinter. Im Anhang steht nur die Formelsammlung.

#pagebreak()
#heading(level: 1, outlined: false)[Wegweiser]
#block[
#set text(size: 9.5pt)
#set par(leading: 0.3em, spacing: 0.15em)
#outline(title: none, depth: 2, indent: auto)
]
#v(2mm)
#text(size: 8.5pt, fill: muted)[*Quellenkürzel:* Skript TM1 = Folien Prof. Bongmba (mit deinen Notizen); Skript TM2 = Vorlesungsskript Sosnowsky; FS TM1/TM2 = Formelsammlungen; WZF = Mitschrift bzw. Skript der WZF-Übung; Übung n = Übungsblatt bzw. Lösung Nr. n; Altklausur = Scans in „Altklausuren“; TM1-Buch / TM2-Buch = Gross/Hauger/Schröder/Wall, Technische Mechanik 1 bzw. 2 (gedruckte Seitenzahlen). Alle anderen Seitenangaben sind PDF-Seiten. „Eigene Ergänzung“ und „eigene Lösung“ stammen nicht aus deinen Unterlagen.]

#pagebreak()

#pagebreak()
= TM1 Kapitel 0 · Einführung <k-tm1-0>
#tab(columns: 2,
 [Vorlesungen], [Auf den Folien steht kein Datum (Foliensatz „Einführung“, Wintersemester 2025) → Badge #emph[TM1 WS 25/26]. Abschnitte 0.1–0.2.],
 [Quellen], [Skript TM1 S. 2–3 (Gesamtübersicht), S. 11–16 (Foliensatz „Einführung“) mit deinen Notizen auf S. 12, 13 und 15; Allgemeines.pdf (1 S., deine Notiz); TM1-Buch „Einführung“ (S. XIII–XV)],
 [Passende Übungen], [Keine eigene Übung. Die Gleichgewichtsidee aus 0.1 übst du ab Übung 0 (Aufg. 0.1, 0.2) – siehe Kapitel 1.],
)
Kapitel 0 ist die Landkarte: Es sagt dir, #strong[was Mechanik ist] und #strong[wo TM1 (Statik starrer Körper) im großen Fach Mechanik liegt]. Hier wird noch nicht gerechnet, aber du brauchst die Begriffe in jeder Klausuraufgabe.
#note([Dein Feynman-Schritt: die 4 Kernideen von Kapitel 0. Erst ohne Skript aufzählen und erklären, dann vergleichen.], [+ Mechanik ist die Lehre von den Bewegungen der Körper unter dem Einfluss von Kräften.
+ Ruhe ist ein Sonderfall der Bewegung – genau das untersucht die Statik (Gleichgewicht).
+ Kinematik beschreibt nur die Bewegung, Dynamik fragt nach den Kräften; Kinetik verbindet beides.
+ TM1 = Statik #strong[starrer] Körper: Körper verformen sich nicht, es zählt nur $sum F = 0$ und $sum M = 0$.
Zusammenfassung der Abschnitte 0.1–0.2; Quellen stehen dort.])
#note([Organisatorisches aus deiner Notiz (Allgemeines.pdf)], [Buchempfehlungen: #strong[Papula], Mathematik für Ingenieure und Naturwissenschaftler, Bd. 1–3 (Mathe-Grundlagen, z. B. Vektoren) sowie #strong[Gross/Hauger, Technische Mechanik 1 – Statik] (Springer) „+ Übungsbuch dazu bestellen“. Außerdem hast du dir die iLearn-Kurse für Vorlesung und WZF notiert (Zugangsdaten hier bewusst nicht abgedruckt). Auf Skript TM1 S. 9 (Literaturverzeichnis) steht von dir: „Online via VPN holen“ – die Springer-Bücher bekommst du über das Hochschulnetz.])
== 0.1 Aufgabe der Mechanik <a-tm1-0-1>
Mechanik fragt: #strong[Welche Kräfte wirken auf einen Körper, und wie bewegt er sich dadurch?] Sie ist das älteste Teilgebiet der Physik („Mutter der Physik“, sagen selbstbewusste Mechaniker).
„Bewegung“ ist dabei weit gemeint: das rollende Rad, die Strömung in einem Kanal, die Bahn eines Flugzeugs oder Satelliten – aber auch die #strong[Durchbiegung] eines Tragflügels oder Balkens. Ein wichtiger Sonderfall ist die #strong[Ruhe]: Gebäude, Brücken, Dämme und Fernsehtürme sollen sich gerade #emph[nicht] bewegen.
#note([Definition (Folie)], [Die Mechanik ist die Lehre der Bewegungen der Körper unter dem Einfluss von Kräften.])
#note([Von dir markiert (gelb, Skript TM1 S. 12)], [„Die #strong[Mechanik] ist das älteste #strong[Teilgebiet der Physik]“ und „Die Mechanik ist die #strong[Lehre der Bewegungen der Körper unter dem Einfluss von Kräften].“ – Diese Definition solltest du wörtlich können.], fill: sand)
#bild("tm1k01_aufgabe", [Skript TM1 S. 12 (obere Folie): Aufgabe der Mechanik, mit deinen Markierungen und deinem Tafelanschrieb der drei Gleichgewichtsbedingungen.], height: 45mm)
#note([Aus deiner Mitschrift (Skript TM1 S. 12 und 13)], [Neben die Definition hast du den Tafelanschrieb gesetzt:

$ sum F_x = 0, wide sum F_y = 0, wide sum M_((A)) = 0 $

Das ist der Kern der ganzen TM1: Ein ruhender Körper ist im Gleichgewicht. Bei „Die Durchbiegung eines Flugzeug-Tragflügels“ hast du „/ Balkens“ ergänzt – die Durchbiegung von Balken kommt in TM2 (Elastostatik).])
#note([In eigenen Worten], [Ein Regal im Lager steht still, obwohl Kartons darauf drücken. Es „bewegt“ sich nicht, weil Boden und Wand genau so stark zurückdrücken. Die Statik rechnet aus, #emph[wie stark] – damit das Regal nicht umkippt oder bricht. #text(fill: muted)[(eigene Ergänzung)]])
#note([Merke], [Ruhe = Bewegung mit Geschwindigkeit null und Beschleunigung null. Dann gilt Gleichgewicht: Summe aller Kräfte = 0 und Summe aller Momente = 0.])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Aufgabe der Mechanik:] „Beschreibung und Vorherbestimmung der Bewegungen von Körpern sowie der Kräfte, die mit diesen Bewegungen im Zusammenhang stehen.“ Die Beispiele der Folie (Rad, Kanal, Flugzeug, Satellit, Brücke, Damm, Fernsehturm) stammen fast wörtlich aus dem Buch. #text(fill: muted)[\[TM1-Buch S. XIII\]]
- #strong[Modelle statt Wirklichkeit:] Die Mechanik untersucht idealisierte Modelle wie den #emph[starren Körper] oder den #emph[Massenpunkt]. Ein Körper darf als starr gelten, wenn seine Verformung für die Frage keine wesentliche Rolle spielt. #text(fill: muted)[\[TM1-Buch S. XIII\]]
- #strong[Ingenieur-Vorgehen:] reales System → Modell → mathematische Lösung → zurück übersetzen und technisch bewerten. #text(fill: muted)[\[TM1-Buch S. XIV\]]])
#src[Skript TM1 S. 11–13 (Folien 1–5 „Einführung“, mit deinen Notizen); TM1-Buch S. XIII–XIV.]
== 0.2 Einteilung der Mechanik <a-tm1-0-2>
Die Folie teilt die Mechanik nach der #strong[Grundaufgabe] ein:
#tab(columns: 3,
 th([Gebiet], [Frage], [Deine Randnotiz]),
 [#strong[Kinematik]], [Wie läuft die Bewegung geometrisch ab? (Weg, Geschwindigkeit – ohne nach der Ursache zu fragen)], [„Bewegung“],
 [#strong[Dynamik]], [Lehre von den Kräften], [„Kräfte“],
 [#strong[Kinetik]], [Verbindung von Kinematik und Dynamik: Wie hängen Kräfte und Bewegungen zusammen?], [–],
 [#strong[Statik]], [Sonderfall: Gleichgewichtslehre der Kräfte an #strong[ruhenden] Körpern], [–],
)
Statik und Kinetik werden jeweils weiter geteilt: in starre und deformierbare Körper, die deformierbaren je nach Material in #strong[Elasto-] (elastisch, federt zurück), #strong[Plasto-] (bleibende Verformung) und #strong[Hydro-] (Flüssigkeiten).
#bild("tm1k01_einteilung", [Skript TM1 S. 15 (obere Folie): Gesamtbaum der Mechanik mit deinen Notizen „TM I (1. Semester)“, „TM II (2. Sem.)“, „TM III (Physik) (2. Sem.)“ und „Fluid- & Energietechnik (3. Sem.)“.], height: 58mm)
#note([Aus deiner Mitschrift (Skript TM1 S. 15)], [Du hast den Baum deinem Studienplan zugeordnet:
- #strong[Statik der starren Körper] → TM I (1. Semester)
- #strong[Elasto-Statik] → TM II (2. Semester)
- #strong[Kinetik der starren Körper] → TM III, bei dir in „Physik“ (2. Semester)
- #strong[Hydro-Statik] → Fluid- & Energietechnik (3. Semester)])
#tab(columns: 2,
 th([Fach], [Inhalt laut Folie (Skript TM1 S. 15 unten)]),
 [Technische Mechanik I], [Statik starrer Körper],
 [Technische Mechanik II], [Elasto-Statik],
 [Technische Mechanik III], [Kinematik und Kinetik starrer Körper],
)
#note([Widerspruch Folie ↔ Buch (nur Formulierung)], [Die Folie (Skript TM1 S. 14) nennt die Statik einen „Sonderfall der Kinetik“. Das Buch teilt die #strong[Dynamik] in #strong[Statik und Kinetik] und stellt beide nebeneinander \[TM1-Buch S. XIV\]. Der Baum auf der Folie S. 15 macht es genauso wie das Buch (Statik und Kinetik unter Dynamik). Beides passt zusammen: Ruhe ist der Sonderfall einer Bewegung mit $a = 0$; deshalb „Sonderfall“. Für die Klausur zeichnest du den Baum wie auf S. 15.], fill: sand)
#note([Fehler vermeiden], [„Dynamik = Bewegung“ ist falsch. Bewegung (ohne Kräfte) ist #strong[Kinematik]\; Dynamik ist die Lehre von den #strong[Kräften].], fill: sand)
#note([In eigenen Worten], [Kinematik ist der Fahrtenschreiber eines Lkw (wann war er wo, wie schnell). Dynamik fragt, welche Motor- und Bremskräfte gewirkt haben. Kinetik verbindet beides. Statik ist der Lkw auf dem Parkplatz – er steht, aber Räder und Boden tragen trotzdem Kräfte. #text(fill: muted)[(eigene Ergänzung)]])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Wortherkunft:] Kinematik von griech. #emph[kinesis] = Bewegung, Dynamik von griech. #emph[dynamis] = Kraft, Statik von lat. #emph[status] = Stehen. #text(fill: muted)[\[TM1-Buch S. XIV\]]
- #strong[Andere Einteilung:] nach dem Aggregatzustand in Mechanik fester, flüssiger und gasförmiger Körper; feste Körper weiter in starr, elastisch, plastisch. #text(fill: muted)[\[TM1-Buch S. XIV\]]
- #strong[Technische vs. Analytische Mechanik:] Die Technische Mechanik konzentriert sich auf die Probleme der konstruierenden und berechnenden Ingenieure (Brücken, Kräne, Maschinen, Fahrzeuge). #text(fill: muted)[\[TM1-Buch S. XIV–XV\]]
- #strong[Geschichte:] Archimedes (Hebel, Schwerpunkt), Stevin (Kräftezusammensetzung), Galilei, Newton (Bewegungsgesetze). #text(fill: muted)[\[TM1-Buch S. XV\]]])
#src[Skript TM1 S. 3 (Übersichtsfolie), S. 13–15 (Folien 6–10 mit deinen Notizen); TM1-Buch S. XIV–XV.]
#bild("map-t1k0", [Mindmap: Wo TM1 im Fach Mechanik liegt. Eigene Darstellung nach Skript TM1 S. 13–15.], height: 44mm)

*Der Zusammenhang in Kapitel 0.* Mechanik fragt nach Kräften und Bewegungen. Die Statik ist der Sonderfall Ruhe: Alle Kräfte und Momente heben sich auf. TM1 vereinfacht zusätzlich auf starre Körper, sodass nur noch Gleichgewichtsbedingungen gebraucht werden. Verformungen kommen erst in TM2 (Elastostatik) dazu.

#pagebreak()
== Verständnisfragen und Rechenaufgaben · Kapitel 0
#set enum(spacing: 0.85em)
Erkläre erst selbst, laut oder schriftlich. Die Lösungen folgen getrennt.

+ Wie lautet die Definition der Mechanik laut Folie?
+ Warum ist die Ruhe ein „Sonderfall der Bewegung“?
+ Nenne drei technische Beispiele für Bewegung und zwei für Ruhe.
+ Worin unterscheiden sich Kinematik und Dynamik? Was verbindet die Kinetik?
+ Was ist ein starrer Körper, und warum darf man ihn in TM1 annehmen?
+ Ordne zu: Elasto-, Plasto-, Hydro-Statik. Welches Materialverhalten steckt jeweils dahinter, und in welchem Fach kommt es bei dir vor?
+ Auf einen ruhenden Klotz wirken waagerecht $F_1 = 40 "N"$ nach rechts und $F_2 = 25 "N"$ nach links. Welche dritte waagerechte Kraft hält ihn in Ruhe? #text(fill: muted)[(eigene Aufgabe)]
+ Ein Balken wird links mit 200 N nach unten und rechts mit 200 N nach oben belastet, Abstand 2 m. Ist $sum F_y = 0$? Ist der Balken im Gleichgewicht? #text(fill: muted)[(eigene Aufgabe)]
+ Wie viele Gleichgewichtsbedingungen hat ein ebenes und wie viele ein räumliches Problem?

#heading(level: 3, outlined: false)[Vertiefende Verständnisfragen]
#block[
#set enum(start: 10)
+ *Buch:* Woher kommen die Wörter Kinematik, Dynamik und Statik? (TM1-Buch S. XIV)
+ *Buch:* Wann darf man einen Körper als Massenpunkt ansehen? (TM1-Buch S. XIII)
+ *Buch:* Welche vier Schritte durchläuft ein Ingenieur, wenn er ein technisches Problem mit Mechanik löst? (TM1-Buch S. XIV)
]

#pagebreak()
== Lösungen Kapitel 0
#set enum(spacing: 0.65em)
+ Die Mechanik ist die Lehre der Bewegungen der Körper unter dem Einfluss von Kräften. #nachschlagen[Lernskript, #stelle(<a-tm1-0-1>)]
+ Ruhe ist eine Bewegung mit Geschwindigkeit 0 und Beschleunigung 0. Es gelten dieselben Gesetze, und es herrscht Gleichgewicht. #nachschlagen[Lernskript, #stelle(<a-tm1-0-1>)]
+ Bewegung: rollendes Rad, Strömung im Kanal, Flugbahn, Durchbiegung eines Tragflügels. Ruhe: Gebäude, Brücke, Damm, Fernsehturm. #nachschlagen[Lernskript, #stelle(<a-tm1-0-1>)]
+ Kinematik beschreibt nur den geometrischen Ablauf der Bewegung, Dynamik ist die Lehre von den Kräften. Die Kinetik verbindet beide: Wie hängen Kräfte und Bewegungen zusammen? #nachschlagen[Lernskript, #stelle(<a-tm1-0-2>)]
+ Ein Körper, dessen Punkte ihre Abstände nicht ändern. Erlaubt, wenn die Verformung für die gesuchten Kräfte keine Rolle spielt, z. B. bei Lagerkräften. #nachschlagen[Lernskript, #stelle(<a-tm1-0-2>)]
+ Elasto: Verformung geht zurück (TM2). Plasto: bleibende Verformung. Hydro: Flüssigkeiten (Fluid- und Energietechnik). #nachschlagen[Lernskript, #stelle(<a-tm1-0-2>)]
+ $sum F_x = 40 - 25 + F_3 = 0 => F_3 = -15 "N"$, also 15 N nach *links*. #nachschlagen[Lernskript, #stelle(<a-tm1-0-1>)]
+ $sum F_y = -200 + 200 = 0$ stimmt. Die beiden Kräfte bilden aber ein Kräftepaar mit $M = 200 "N" dot 2 "m" = 400 "Nm"$. Wegen $sum M != 0$ dreht sich der Balken: *kein* Gleichgewicht. #nachschlagen[Lernskript, #stelle(<a-tm1-1-1>)]
+ Eben: 3 ($sum F_x, sum F_y, sum M$). Räumlich: 6 (drei Kraft-, drei Momentensummen). #nachschlagen[Lernskript, #stelle(<a-tm1-1-1>)]
+ Kinematik von griech. _kinesis_ = Bewegung, Dynamik von _dynamis_ = Kraft, Statik von lat. _status_ = Stehen. #nachschlagen[Lernskript, #stelle(<a-tm1-0-2>)\; TM1-Buch S. XIV]
+ Wenn seine Abmessungen sehr klein gegenüber den zurückgelegten Wegen sind (Stein beim Wurf, Planet im Sonnensystem). #nachschlagen[TM1-Buch S. XIII]
+ Reales System als Modell abbilden, Modell mit den Grundgesetzen analysieren, Lösung mechanisch deuten, technisch auswerten. #nachschlagen[Lernskript, #stelle(<a-tm1-0-1>)\; TM1-Buch S. XIV]

#pagebreak()
= TM1 Kapitel 1 · Grundbegriffe <k-tm1-1>
#tab(columns: 2,
 [Vorlesungen], [Auf den Folien steht kein Vorlesungsdatum (Foliensätze „Grundbegriffe“ und „Grundbegriffe – Vektorrechnung“, WS 2025) → Badge #emph[TM1 WS 25/26]\; Abschnitte 1.1–1.8. WZF (Sosnowsky) zu 1.3: Skript Teil 1 „Vektoren, Kraftbegriff, Kräftezerlegung“ (Foliendatum 22.09.25), „Manuskript – TM Übung 1“ (03.10.25), „Mathematisches Rüstzeug – Skalarprodukt“ (15.10.25).],
 [Quellen], [Skript TM1 S. 3 (Übersicht), S. 17–47 (Grundbegriffe; deine Mitschrift auf S. 31–32, 41, 43–45), S. 48–60 (Vektorrechnung); WZF-Skript TM1 S. 2–55 (+ deine Notiz S. 56); „Übungen \_Technische Mechanik 1“ (handschriftlich) S. 2–4; FS TM1 S. 4–9; TM1-Buch Kap. 1 (S. 1–13) und Anhang A.1 (S. 265–272)],
 [Passende Übungen], [Übung 0: 0.1, 0.2 (Gewichtskraft, Einheiten, Auflager – zu 1.7/1.8); Übung 1: 1.1–1.5 (Skalarprodukt, Projektion, Arbeit, Kreuzprodukt, Moment, Winkelfunktionen – zu 1.3); WZF-Skript Kontrollteil 1, Aufg. 1-1 bis 1-4 (S. 32–35). (Aufg. 0.3 ist eine Reibungsaufgabe → Kapitel 9.)],
)
Kapitel 1 liefert das #strong[Werkzeug für die ganze Statik]: Was ist eine Kraft, was ein Moment, wie rechnet man mit Vektoren, und wie macht man unsichtbare Kräfte durch #strong[Freischneiden] sichtbar? Wer das Freikörperbild und die Vektorrechnung sicher kann, hat in jeder späteren Aufgabe schon die halbe Miete.
#note([Dein Feynman-Schritt: die 6 Kernideen von Kapitel 1. Erst ohne Skript aufzählen und erklären, dann vergleichen.], [+ Eine Kraft hat Betrag, Richtung und Angriffspunkt; Angriffspunkt + Richtung = Wirkungslinie.
+ Statik = Gleichgewicht: $sum arrow(F) = arrow(0)$ und $sum arrow(M) = arrow(0)$ (2D: 3 Gleichungen, 3D: 6).
+ Kräfte sind Vektoren: komponentenweise addieren; Skalarprodukt → Projektion/Arbeit/Winkel, Kreuzprodukt → Moment.
+ Am starren Körper sind Kräfte linienflüchtig, Momente frei; Parallelverschieben einer Kraft erzeugt ein Moment.
+ Unsichtbare Kräfte werden durch Freischneiden sichtbar: Lager lösen → Reaktionen, Körper schneiden → innere Kräfte; dabei gilt actio = reactio.
+ Vorgehen: Problem formulieren → Ersatzmodell → Freikörperbild, Gleichungen, Lösung → Ergebnis deuten.
Zusammenfassung der Abschnitte 1.1–1.8; Quellen stehen dort.])
== 1.1 Kraft und Moment <a-tm1-1-1>
Kräfte und Momente kennst du aus dem Alltag. Du siehst sie aber #strong[nicht direkt] – du siehst nur ihre #strong[Wirkung]: Ein Gewicht an einer Feder verlängert die Feder.
- #strong[Herkunft von Kräften:] Schwerkraft, (Elektro-)Magnetismus, Druck auf einen Kolben.
- #strong[Herkunft von Momenten:] ein #strong[Kräftepaar], z. B. zwei gleich große, entgegengesetzte Kräfte an einem Radkreuz → Moment an der Schraube.
#tab(columns: 3,
 th([Wirkung], [durch Kräfte], [durch Momente]),
 [Spannung (innere Belastung, unsichtbar)], [→ TM2],
 [Verformung], [Dehnung/Stauchung, Schubverformung], [Biegung, Verdrillung],
 [Beschleunigung (falls $sum F_i != 0$ bzw. $sum M_i != 0$)], [Änderung der Geschwindigkeit], [Änderung der Drehzahl (Winkelgeschwindigkeit)],
)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k01_herkunft", [Skript TM1 S. 18 (obere Folie): Herkunft von Kräften, mit deiner Federskizze (Federsteifigkeit $k$, Masse $m_1$, $m arrow(g) = arrow(G)$, Verlängerung $Delta L$).], height: 50mm)],
 [#bild("tm1k01_wirkung", [Skript TM1 S. 18 (untere Folie): Kräftepaar am Radschlüssel und Wirkungen; deine Notizen „$F_2 = F_1$“ und Schubverformung („gleiche Höhe“, Winkel $gamma$).], height: 50mm)])
#heading(level: 3, outlined: false)[Warum sieht man in TM1 keine Kräfte? ★]
In der Statik starrer Körper sind Kräfte und Momente nicht direkt beobachtbar, weil
- Spannungen nicht sichtbar sind,
- starre Körper sich #strong[nicht verformen],
- Statik $hat(=)$ #strong[Gleichgewicht] ist ($sum F_i = 0$ und $sum M_i = 0$) → keine Bewegung bzw. Beschleunigung.
#form[$ bold("2D:") quad sum F_x = 0, quad sum F_y = 0, quad sum M_z = 0 wide wide bold("3D:") quad sum F_x = sum F_y = sum F_z = 0, quad sum M_x = sum M_y = sum M_z = 0 $]
Gleichgewichtsbedingungen: Kräfte in N, Momente in Nm. 2D: 3 Gleichungen, 3D: 6 Gleichungen.
#bild("tm1k01_statik_ggw", [Skript TM1 S. 19 (obere Folie): Statik = Gleichgewicht; deine Vorzeichenregel im Kasten rechts, die 2D-Bedingungen sind von dir gelb markiert.], height: 45mm)
#note([Aus deiner Mitschrift (Skript TM1 S. 19)], [Vorzeichenregel für Momente: „Moment #strong[gegen] Uhrzeigersinn: #strong[+]\; Moment #strong[im] Uhrzeigersinn: #strong[−]“ (das „gegen“, „im“ und die Vorzeichen hast du gelb markiert).])
#note([Von dir markiert (gelb, S. 18–19)], [„nicht direkt beobachtbar“, „Wirkung“, Spannung, Verformung (Kräfte → Dehnung, Momente → Biegung), Beschleunigung (Kraft → Änderung der Geschwindigkeit, Moment → Änderung der Drehzahl) und die 2D-Gleichgewichtsbedingungen $sum F_x = 0, sum F_y = 0, sum M_z = 0$.], fill: sand)
#note([In eigenen Worten], [Ein Gabelstapler hebt eine Palette und steht still. Du siehst keine Kraft – aber die Reifen werden leicht platter (Wirkung). In der Statik tun wir so, als wären Reifen und Gabel starr: Dann bleibt nur die Frage, welche Kräfte das Gleichgewicht halten. #text(fill: muted)[(eigene Ergänzung)]])
#note([Fehler vermeiden], [Ein Körper mit $sum F_y = 0$ ist noch nicht im Gleichgewicht. Zwei gleich große, entgegengesetzte Kräfte auf verschiedenen Wirkungslinien bilden ein Kräftepaar → $sum M != 0$ → Drehung. Immer alle drei (2D) Bedingungen prüfen.], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Definition der Kraft über die Schwerkraft:] „Eine Kraft ist eine physikalische Größe, die sich mit der Schwerkraft ins Gleichgewicht setzen lässt.“ #text(fill: muted)[\[TM1-Buch S. 3\]]
- #strong[Lernziele des Kapitels:] Besonders wichtig sind Schnittprinzip, Wechselwirkungsgesetz und Freikörperbild – sie werden bei nahezu allen Problemen der Statik angewendet. #text(fill: muted)[\[TM1-Buch S. 2\]]])
#src[Skript TM1 S. 18–19 (Folien 3–5 mit deinen Notizen); FS TM1 S. 4; TM1-Buch S. 2–3.]
== 1.2 Eigenschaften und Darstellung der Kraft <a-tm1-1-2>
Eine Kraft ist eine physikalische Größe mit #strong[drei Eigenschaften]:
+ #strong[Betrag] – die Größe der Kraft (in N).
+ #strong[Richtung] – Orientierung (Winkel) #emph[und] Richtungssinn (Pfeilrichtung).
+ #strong[Angriffspunkt (AP)] – wo die Kraft am Körper angreift.
Angriffspunkt + Richtung ergeben die #strong[Wirkungslinie (WL)]: die gedachte Gerade, auf der der Kraftpfeil liegt. Mathematisch beschreibt man die Kraft durch Vektoren (→ 1.3): Der #strong[Kraftvektor] $arrow(F)$ gibt Betrag und Richtung, der #strong[Ortsvektor] $arrow(s)$ den Angriffspunkt (Anfangspunkt des Kraftpfeils).
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k01_eigenschaften", [Skript TM1 S. 19 (untere Folie): drei Eigenschaften, Beispiel Seil mit Masse und Rolle; von dir gelb markiert: Größe, Richtung, Angriffspunkt, Wirkungslinie (AP + Richtung).], height: 50mm)],
 [#bild("tm1k01_darstellung", [Skript TM1 S. 20 (obere Folie): Kraftvektor $arrow(F)_A$, Ortsvektor $arrow(s)_A$, Wirkungslinie; Kräfte aus der Ebene heraus (⊙) und hinein (⊗).], height: 50mm)])
#heading(level: 3, outlined: false)[Grafische Darstellung]
#tab(columns: 2,
 th([Was?], [Wie dargestellt?]),
 [Kräfte in der Ebene], [als Pfeil, #strong[maßstäblich] möglich (z. B. 1 cm ≙ 20 N)],
 [Kräfte senkrecht zur Zeichenebene], [nur Richtungssinn und AP: ⊙ = heraus, ⊗ = hinein],
 [Kräfte im Raum], [nur qualitativ],
 [Moment], [als Vektor mit #strong[Doppelspitze] oder anschaulich als #strong[gekrümmter Pfeil]\; maßstäblich i. d. R. nicht möglich (Kräftepaar in der Ebene → $arrow(M)$ steht senkrecht zur Ebene)],
)
Den Richtungssinn des Momentenvektors legt die #strong[Rechtsschrauben-Regel] (Rechte-Hand-Regel) fest: Dreht man eine Schraube mit Rechtsgewinde im Drehsinn des Moments, bewegt sie sich in Richtung des Momentenvektors. Ein Moment gegen den Uhrzeigersinn in der xy-Ebene zeigt also aus der Ebene heraus (⊙, +z).
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k01_momentdarst", [Skript TM1 S. 20 (untere Folie): Kräfte im Raum, Darstellung des Moments; deine Notizen: „Festlager“ (A), „Loslager“ (B), „Linienlast“ $q(x)$, Koordinatensystem mit z aus der Ebene.], height: 50mm)],
 [#bild("tm1k01_rechtsschraube", [Skript TM1 S. 21 (obere Folie): Momentvektor senkrecht zur Ebene, Rechtsschrauben-Regel.], height: 50mm)])
#note([Merke], [Wirkungslinie = Angriffspunkt + Richtung. Zwei Kräfte mit gleichem Betrag und gleicher Richtung, aber anderer Wirkungslinie wirken auf einen Körper #strong[verschieden] (→ 1.4).])
#note([In eigenen Worten], [Beim Schieben eines Einkaufswagens zählt nicht nur, #emph[wie stark] und #emph[in welche Richtung] du schiebst, sondern auch #emph[wo]: Schiebst du außen an der Ecke, dreht sich der Wagen. #text(fill: muted)[(eigene Ergänzung)]])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Betrag messen:] durch Vergleich mit geeichten Gewichten – hält ein Gewicht $G$ der Kraft das Gleichgewicht, gilt $F = G$. #text(fill: muted)[\[TM1-Buch S. 3\]]
- #strong[Richtung = Wirkungslinie + Richtungssinn] auf ihr; der Pfeil zeigt den Richtungssinn. #text(fill: muted)[\[TM1-Buch S. 4\]]
- #strong[Kartesische Darstellung:] $arrow(F) = F_x arrow(e)_x + F_y arrow(e)_y + F_z arrow(e)_z$, $F = sqrt(F_x^2 +F_y^2 +F_z^2)$, $cos alpha = F_x /F$ usw. #text(fill: muted)[\[TM1-Buch S. 5\]]])
#src[Skript TM1 S. 19–21 (Folien 6–10; Folie 10 ist leer); FS TM1 S. 4–5; TM1-Buch S. 3–5.]
== 1.3 Vektorrechnung und Winkelfunktionen <a-tm1-1-3>
Die Folien 11–12 im Foliensatz „Grundbegriffe“ (Skript TM1 S. 22) sind leer; der Stoff steht im eigenen Foliensatz „Grundbegriffe – Vektorrechnung“ (Skript TM1 S. 48–60) und wurde in der WZF (Sosnowsky) mit Manuskript und Übung 1 vertieft.
Eine Kraft hat Betrag #emph[und] Richtung – sie ist ein #strong[Vektor]. Statt Pfeile zu zeichnen, schreibst du sie als Zahlenspalte (Komponenten) und rechnest Zeile für Zeile. Das ist der „rechnerische Kräfteplan“ der ganzen Statik.
#note([Definition (Folie)], [Eine Größe, die sowohl einen Betrag als auch eine Richtung besitzt, ist eine vektorielle Größe. In den Unterlagen: fette Buchstaben ($bold(A)$); an der Tafel: Pfeil ($arrow(A)$). Beispiele in TM1: Kraft $arrow(F)$, Moment $arrow(M)$, Ortsvektor $arrow(r), arrow(s)$.])
#note([Von dir markiert (Skript TM1 S. 49)], [„Geschwindigkeit $arrow(v)$“ und „Beschleunigung $arrow(a)$“ hast du durchgestrichen – sie kommen in TM1 (Statik) nicht vor. Gelb/grün markiert: Tafelschreibweise $arrow(A)$, „2D: Ebene – auch maßstäblich“, „3D: im Raum – qualitativ“ und die Komponentendarstellung.], fill: sand)
#heading(level: 3, outlined: false)[Darstellung, Betrag, Einheitsvektor ★]
#form[$ arrow(F) = mat(delim: "(", F_x ; F_y ) (2D), wide arrow(F) = mat(delim: "(", F_x ; F_y ; F_z ) (3D), wide | arrow(F)| = F = sqrt(F_x^2 +F_y^2 +F_z^2) $]
2D ist der Sonderfall von 3D mit $F_z = 0$. Betrag = Länge des Pfeils (Satz des Pythagoras).
#form[$ arrow(e) = frac(arrow(F), | arrow(F)|), quad | arrow(e)| = 1, wide arrow(F) = F dot arrow(e), wide arrow(e)_x = mat(delim: "(", 1; 0; 0), arrow(e)_y = mat(delim: "(", 0; 1; 0), arrow(e)_z = mat(delim: "(", 0; 0; 1), wide arrow(0) = mat(delim: "(", 0; 0; 0) $]
Einheitsvektor: Länge 1, zeigt in Richtung von $arrow(F)$; jede Komponente ist betragsmäßig ≤ 1. Nullvektor: Länge 0.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k01_vek_darst", [Skript TM1 S. 49 (untere Folie): grafische Darstellung 2D/3D und Komponenten, mit deinen Markierungen.], height: 50mm)],
 [#bild("tm1k01_vek_betrag", [Skript TM1 S. 50 (obere Folie): Betrag eines Vektors – von dir mit großem rotem „!“ markiert.], height: 50mm)])
#note([Von dir markiert „!“ ★ (Skript TM1 S. 50)], [Die Betragsformel $| arrow(F)| = sqrt(F_x^2 +F_y^2)$ bzw. $sqrt(F_x^2 +F_y^2 +F_z^2)$ – du brauchst sie in fast jeder Aufgabe (Resultierende, Einheitsvektor, Winkel). Auf S. 50 unten hast du außerdem „Einheitsvektor hat Länge (Betrag) = 1“ markiert.], fill: sand)
#note([Beispiel (WZF-Manuskript Übung 1, S. 5/10 = WZF-Skript S. 42)], [$arrow(a) = (2;3;1)^T$: $| arrow(a)| = sqrt(4+9+1) = sqrt(14) approx 3","74$. $arrow(b) = (4;3)^T$: $| arrow(b)| = sqrt(25) = 5$, $arrow(e)_b = (4/5; 3/5)^T$, Probe $| arrow(e)_b | = sqrt(16/25+9/25) = 1$ ✓.], fill: pale)
#heading(level: 3, outlined: false)[Multiplikation mit einem Skalar, Addition, Subtraktion]
#form[$ lambda arrow(F) = mat(delim: "(", lambda F_x ; lambda F_y ; lambda F_z ), | lambda arrow(F)| = | lambda | thin | arrow(F)| wide arrow(F)_1 plus.minus arrow(F)_2 = mat(delim: "(", F_("1x") plus.minus F_("2x"); F_("1y") plus.minus F_("2y"); F_("1z") plus.minus F_("2z")) $]
$lambda > 0$: gleicher Richtungssinn (parallel); $lambda < 0$: umgekehrter Richtungssinn (antiparallel); Division durch $mu != 0$ = Multiplikation mit $1/ mu$. Gleichheit: alle Komponenten gleich. Addition ist kommutativ und assoziativ.
Grafisch werden Vektoren #strong[aneinandergehängt] (Spitze an Fuß), die Reihenfolge ist egal; der Summenvektor geht vom ersten Fuß zur letzten Spitze. Subtraktion: $arrow(F)_1 - arrow(F)_2 = arrow(F)_1 + (-1) dot arrow(F)_2$.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k01_vek_add", [Skript TM1 S. 52 (untere Folie): Addition – Komponentendarstellung von dir gelb markiert.], height: 50mm)],
 [#bild("tm1k01_vek_sub", [Skript TM1 S. 53 (untere Folie): Subtraktion.], height: 50mm)])
#note([Beispiel (WZF-Manuskript S. 2/10)], [$(3;5;2)^T + (7;3;9)^T = (10;8;11)^T$; $3 dot (3;5;2)^T = (9;15;6)^T$; $frac(1, 3) (3;5;2)^T = (1; 5/3; 2/3)^T$.], fill: pale)
#note([Beispiel (WZF-Skript Aufg. 1-3, S. 34)], [Summen der Vektorgruppen: a) $(1;2;4)+(5;3;2)+(-8;-4;-7)+(2;2;3)+(-4;-3;-2)+(3;2;3) = (-1;2;3)$; b) $(1;2;4)+(-4;3;0)+(1;-6;-7)+(2;1;3) = (0;0;0)$; c) $(1;2;4)+(2;3;0)+(1;-6;-3)+(2;1;3) = (6;0;4)$. #strong[Was fällt auf?] Bei b) ist die Summe der Nullvektor: Wären das Kräfte an einem Punkt, wäre dieser im #strong[Gleichgewicht].], fill: pale)
#heading(level: 3, outlined: false)[Skalarprodukt ★]
#form[$ arrow(a) dot arrow(b) = | arrow(a)| thin | arrow(b)| cos phi = a_x b_x + a_y b_y + a_z b_z wide phi = arccos frac(arrow(a) dot arrow(b), | arrow(a)| thin | arrow(b)|) $]
Ergebnis ist ein #strong[Skalar] (Zahl), kein Vektor. $phi = plus.minus 90 degree => arrow(a) dot arrow(b) = 0$ (senkrecht). Kommutativ und distributiv, nicht assoziativ.
#form[$ b_a = | arrow(b)| cos phi = frac(arrow(a) dot arrow(b), | arrow(a)|), wide arrow(b)_a = b_a thin frac(arrow(a), | arrow(a)|) = frac(arrow(a) dot arrow(b), | arrow(a)|^2) thin arrow(a), wide W = arrow(s) dot arrow(F) [ "Nm" ] $]
Projektion von $arrow(b)$ auf $arrow(a)$: Länge $b_a$ (kann negativ sein!) und Vektor $arrow(b)_a$ (zeigt in Richtung $arrow(a)$). Anwendung: Arbeit einer Kraft längs eines Weges.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k01_skalarprodukt", [Skript TM1 S. 54 (obere Folie): Definition; Komponentenformeln von dir gelb markiert.], height: 50mm)],
 [#bild("tm1k01_winkel_faelle", [Skript TM1 S. 55 (obere Folie): Winkel zwischen zwei Vektoren; Vorzeichen von $arrow(a) dot arrow(b)$ zeigt spitzen/stumpfen/rechten Winkel.], height: 50mm)])
#strong[Vorzeichen deuten:] $arrow(a) dot arrow(b) > 0$ → spitzer Winkel ($| phi | < 90 degree$); $< 0$ → stumpfer Winkel; $= 0$ → senkrecht. Weil $arccos$ mehrdeutig ist, das „richtige“ $phi$ mit einer Skizze heraussuchen.
#strong[Rechenweg Projektion (WZF „Mathematisches Rüstzeug“, 15.10.25, WZF-Skript S. 51):] (1) Einheitsvektor $arrow(e)_a = arrow(a)/| arrow(a)|$; (2) Länge $b_a = arrow(a) dot arrow(b)/| arrow(a)|$; (3) Vektor $arrow(b)_a = b_a thin arrow(e)_a$.
#note([Beispiel (Übung 1, Aufg. 1.1 = WZF-Skript S. 52–55)], [$arrow(a) = (3;0;4)^T$, $arrow(b) = (4;-1;7)^T$.
+ $| arrow(a)| = sqrt(9+0+16) = 5$, $arrow(e)_a = (0","6; 0; 0","8)^T$.
+ $arrow(a) dot arrow(b) = 12 + 0 + 28 = 40$ → $b_a = 40/5 = 8$.
+ $arrow(b)_a = 8 dot (0","6;0;0","8)^T = (4","8; 0; 6","4)^T$; Probe $sqrt(4","8^2 +6","4^2) = 8$ ✓.
+ $| arrow(b)| = sqrt(66)$ → $phi = arccos frac(40, 5 sqrt(66)) = 10","02 degree$.], fill: pale)
#note([Beispiel (Folie S. 56; Übung 1, Aufg. 1.2): Arbeit.], [Folie: $arrow(F) = ( frac(sqrt(2), 2) ; frac(sqrt(2), 2) ;0)^T thin "N"$, $arrow(s) = (1;0;0)^T thin "m"$ → $W = frac(sqrt(2), 2) thin "Nm" approx 0","71 "Nm"$, $F_s = frac(sqrt(2), 2) "N"$, $phi = 45 degree$. \

Aufg. 1.2: $arrow(F) = (4;2;6)^T thin "N"$, $arrow(s) = (2;-1;2)^T thin "m"$: $arrow(F) dot arrow(s) = 8-2+12 = 18 "Nm" = W$; $| arrow(s)| = 3 "m"$ → $F_s = 18/3 = 6 "N"$; $arrow(F)_s = frac(18, 9) (2;-1;2)^T = (4;-2;4)^T "N"$; $phi = arccos frac(18, sqrt(56) dot 3) = 36","7 degree$. Anschaulich: 6 N entlang 3 m = 18 Nm.], fill: pale)
#bild("tm1k01_projektion_fs", [Skript TM1 S. 56 (untere Folie): Projektion von $arrow(F)$ auf $arrow(s)$ – den Exponenten im ersten Nenner hast du geschwärzt.], height: 45mm)
#note([Fehler auf der Folie (Skript TM1 S. 56 unten)], [Für die #strong[Länge] der Projektion steht dort $F_s = frac(arrow(s) dot arrow(F), | arrow(s)|^2)$. Richtig ist $F_s = frac(arrow(s) dot arrow(F), | arrow(s)|)$ (vgl. S. 55 unten und FS TM1 S. 7, Gl. 1.13). Das Quadrat gehört nur in die #strong[Vektor]-Formel $arrow(F)_s = frac(arrow(s) dot arrow(F), | arrow(s)|^2) arrow(s)$. Im Beispiel fällt es nicht auf, weil $| arrow(s)| = 1$ ist; die Einheit \[Nm/m\] auf der Folie passt auch nur zu $| arrow(s)|$. Du hast den Exponenten schon geschwärzt – richtig so.], fill: sand)
#note([Fehler im WZF-Manuskript (S. 6/10 = WZF-Skript S. 43)], [Beim Beispiel $arrow(a) = (3;2;1)^T$ ist $arrow(b)$ überschrieben (aus $(2;3;1)$ wurde $(2;3;2)$). Damit gilt $arrow(a) dot arrow(b) = 14$, aber $| arrow(b)| = sqrt(4+9+4) = sqrt(17)$ (nicht $sqrt(15)$) → $phi = 24","8 degree$. Außerdem ist $arrow(b)_a = sqrt(14) dot (4/5;3/5)^T$ falsch – dort wurde der Einheitsvektor des #emph[vorigen] Beispiels genommen. Richtig: $arrow(b)_a = frac(14, 14) thin (3;2;1)^T = (3;2;1)^T$. Für die Aufgabe auf derselben Seite ($arrow(b) = (2;3;1)^T$): $arrow(a) dot arrow(b) = 13$, $| arrow(a)| = | arrow(b)| = sqrt(14)$, $phi = arccos (13/14) = 21","8 degree$.], fill: sand)
#note([Unklare Notiz (WZF-Skript S. 51)], [Hinter $b_a = | arrow(b)_a | = frac(arrow(a) dot arrow(b), | arrow(a)|)$ hast du „$dot cos ( phi )$“ ergänzt. So wäre es falsch: Richtig ist $b_a = frac(arrow(a) dot arrow(b), | arrow(a)|) = | arrow(b)| cos phi$ – der Kosinus steckt schon im Skalarprodukt. Vermutlich wolltest du „$= | arrow(b)| cos phi$“ notieren. Auf S. 50 hast du in $| arrow(a)| = sqrt(a_1^2 +a_3^2 +a_3^2)$ den Tippfehler richtig zu $a_2^2$ korrigiert.], fill: sand)
#heading(level: 3, outlined: false)[Kreuzprodukt (Vektorprodukt) ★]
#form[$ arrow(c) = arrow(a) times arrow(b) = mat(delim: "(", a_x ; a_y ; a_z ) times mat(delim: "(", b_x ; b_y ; b_z ) = mat(delim: "(", a_y b_z - a_z b_y ; a_z b_x - a_x b_z ; a_x b_y - a_y b_x ), wide | arrow(c)| = | arrow(a)| thin | arrow(b)| sin phi $]
$arrow(c)$ steht senkrecht auf $arrow(a)$ und $arrow(b)$; $| arrow(c)|$ = Parallelogrammfläche (kleinerer Winkel, $0 <= phi <= 180 degree$); Richtungssinn nach Rechte-Hand-Regel ($arrow(a)$ Daumen, $arrow(b)$ Zeigefinger, $arrow(c)$ Mittelfinger). Anti-kommutativ: $arrow(a) times arrow(b) = - arrow(b) times arrow(a)$; parallele Vektoren → $arrow(c) = arrow(0)$.
#form[$ "2D (xy-Ebene):" quad mat(delim: "(", a_x ; a_y ; 0) times mat(delim: "(", b_x ; b_y ; 0) = mat(delim: "(", 0; 0; a_x b_y - a_y b_x ) wide wide arrow(M) = arrow(r) times arrow(F) [ "Nm" ] $]
In der Ebene zeigt das Kreuzprodukt immer in z-Richtung – deshalb steht das Moment eines ebenen Kraftsystems senkrecht zur Ebene.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k01_kreuz_komp", [Skript TM1 S. 57 (untere Folie): Komponentenformel; die Minuszeichen hast du gelb markiert, rechts dein Merkschema.], height: 50mm)],
 [#bild("tm1k01_kreuz_moment", [Skript TM1 S. 58 (untere Folie): Moment am Schraubenschlüssel $arrow(M) = arrow(r) times arrow(F) = (0;0;50)^T "Nm"$.], height: 50mm)])
#note([Aus deiner Mitschrift (Skript TM1 S. 57): Merkschema.], [Schreibe $a_x, a_y, a_z, a_x, a_y, a_z$ und daneben $b_x, b_y, b_z, b_x, b_y, b_z$ untereinander, streiche die #strong[erste und letzte Zeile] und multipliziere über Kreuz: Zeile $a_y /b_y$ und $a_z /b_z$ liefert $a_y b_z - a_z b_y$ usw. Die Minuszeichen in der Mitte jeder Zeile hast du gelb markiert – dort passieren die meisten Fehler.])
#note([Aus dem WZF-Manuskript (S. 7/10 und 8/10): Determinantenmethode.], [$arrow(c) = mat(delim: "|", arrow(e)_1, arrow(e)_2, arrow(e)_3 ; a_x, a_y, a_z ; b_x, b_y, b_z )$, Entwicklung nach der 1. Zeile mit Vorzeichenschema $+ - +$. Beispiel $(2;3;1) times (4;3;5)$: $arrow(e)_1 (3 dot 5-1 dot 3) - arrow(e)_2 (2 dot 5-1 dot 4) + arrow(e)_3 (2 dot 3-3 dot 4) = (12;-6;-6)^T$, $| arrow(c)| = sqrt(216) approx 14","7$. Zweierdeterminante: Hauptdiagonale minus Nebendiagonale.])
#note([Beispiel (Übung 1, Aufg. 1.4)], [$arrow(r) = (1;-5;2)^T thin "m"$, $arrow(F) = (2;0;3)^T thin "N"$:
$arrow(M) = mat(delim: "(", (-5) dot 3 - 2 dot 0; 2 dot 2 - 1 dot 3; 1 dot 0 - (-5) dot 2) = mat(delim: "(", -15; 1; 10) "Nm"$, $| arrow(M)| = sqrt(225+1+100) = sqrt(326) approx 18","06 "Nm"$.], fill: pale)
#heading(level: 3, outlined: false)[Richtung von Vektoren]
#form[$ F_x = | arrow(F)| cos alpha, quad F_y = | arrow(F)| cos beta, quad F_z = | arrow(F)| cos gamma, wide cos^2 alpha + cos^2 beta + cos^2 gamma = 1 $]
$alpha, beta, gamma$ = Winkel zur x-, y-, z-Achse. 2D: nur ein Winkel unabhängig ($beta = 90 degree - alpha$); 3D: nur zwei unabhängig.
#bild("tm1k01_richtung2", [Skript TM1 S. 59 (untere Folie): unabhängige Größen; „2D-Vektor: 2 unabhängige Größen“ und „3D-Vektor: 3 unabhängige Größen“ von dir gelb markiert.], height: 45mm)
#note([Merke], [Ein 2D-Vektor ist durch 2 Größen festgelegt ($F_x, F_y$ oder $| arrow(F)|, alpha$), ein 3D-Vektor durch 3 ($F_x, F_y, F_z$ oder $| arrow(F)|$ und zwei Winkel).])
#heading(level: 3, outlined: false)[Winkelfunktionen und Kraftkomponenten ★]
Im rechtwinkligen Dreieck (Hypotenuse H, Gegenkathete G, Ankathete A bezogen auf den Winkel $alpha$) gilt – Merksatz #strong[GAGA / HHAG] spaltenweise gelesen:
#form[$ sin alpha = frac(G, H), wide cos alpha = frac(A, H), wide tan alpha = frac(G, A), wide cot alpha = frac(A, G) wide => wide F_x = F cos alpha, quad F_y = F sin alpha $]
Gilt so nur, wenn $alpha$ von der #strong[x-Achse] aus gemessen wird. Umkehrfunktionen: $alpha = arcsin (G/H) = arccos (A/H) = arctan (G/A)$.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k01_wzf_winkel", [WZF-Skript S. 46 (Manuskript Übung 1, S. 9/10): Winkelfunktionen, Merksatz GAGA/HHAG; rechts deine Zusammenfassung (gelb) und dein großes rotes „!“.], height: 50mm)],
 [#bild("tm1k01_wzf_lesenkraft", [WZF-Skript S. 56 (deine Notiz „Lesen einer Kraft“): Betrag $F$, Richtung $alpha$, Wirklinie; $F_x = F cos alpha$, $F_y = F sin alpha$.], height: 50mm)])
#note([Von dir markiert „!“ ★ (WZF-Skript S. 46)], [„Winkelfunktionen: $tan = frac(G K, A K)$, $cos = frac(A K, H Y)$, $sin = frac(G K, H Y)$“. Im Manuskript daneben: „Taschenrechner! $!=$ Mathematik: $tan^(-1)$ ≙ cot?“ – Vorsicht, siehe Achtung-Kasten.], fill: sand)
#note([Fehler vermeiden: $tan^(-1)$ ist nicht $cot$!], [Auf dem Taschenrechner bedeutet $tan^(-1)$ die Umkehrfunktion #strong[arctan] (liefert einen Winkel). Der Kotangens ist $cot alpha = frac(1, tan alpha)$. In deiner Mitschrift zu Beispiel 1 (Skript TM1 S. 41) steht „$N = G dot tan^(-1)( alpha )$“ – gemeint ist $N = frac(G, tan alpha) = G cot alpha$. Schreib in der Klausur immer $cot alpha$ oder $1/ tan alpha$.], fill: sand)
#note([Fehler vermeiden (Quadrant und Vorzeichen)], [$arctan (F_y /F_x )$ liefert nur Winkel zwischen −90° und +90°. Liegt die Resultierende im 2. oder 3. Quadranten ($F_x < 0$), musst du 180° addieren. Merkhilfe aus deiner Übungsmitschrift: Quadrant I „Alle +“, II „Sin +“, III „Tan +“, IV „Cos +“. Und: Wenn ein Winkel nicht von der x-Achse gemessen ist, gilt „bei x immer cos“ nicht mehr – in deiner Notiz WZF-Skript S. 56 rechnest du z. B. $F_("x2") = F_2 sin beta_2$ (x-Achse ist dann Gegenkathete). Das Vorzeichen musst du dabei #strong[aus der Skizze] setzen: $F_2$ zeigt nach links oben, also $F_("x2") = -F_2 sin beta_2$.], fill: sand)
#note([Beispiel (deine Übungsmitschrift, „Übungen \_Technische Mechanik 1“ S. 2–4: „1. Beispielrechnung“)], [Geg.: $F_1 = 100 "N"$, $alpha_1 = 150 degree$; $F_2 = 80 "N"$, $alpha_2 = 45 degree$ (Winkel von der x-Achse). Ges.: $arrow(F)_R = arrow(F)_1 + arrow(F)_2$.
+ $F_("1x") = 100 cos 150 degree = -86","60 "N"$, $F_("1y") = 100 sin 150 degree = 50","00 "N"$
+ $F_("2x") = F_("2y") = 80 cos 45 degree = 56","57 "N"$
+ $F_("Rx") = -30","03 "N"$, $F_("Ry") = 106","57 "N"$ → $F_R = sqrt(30","03^2 +106","57^2) = 110","72 "N"$
+ $arctan frac(106","57, -30","03) = -74","26 degree$; weil $F_("Rx") < 0$ (2. Quadrant): $alpha_R = 180 degree - 74","26 degree = 105","74 degree$.
Kontrolle in deiner Mitschrift: grafisch (1 cm ≙ 20 N) abgelesen $F_R approx 5","56 "cm" approx 111 "N"$, $alpha approx 106 degree$; Kosinussatz mit dem Dreieckswinkel $180 degree - 150 degree + 45 degree = 75 degree$: $F_R = sqrt(100^2 +80^2 -2 dot 100 dot 80 cos 75 degree) = 110","72 "N"$; Sinussatz: $beta = arcsin ( frac(100, 110","72) sin 75 degree) = 60","74 degree$, $alpha_R = 45 degree + 60","74 degree = 105","74 degree$ ✓. \

#emph[Kleiner Schreibfehler in deiner Mitschrift:] „$-50 sqrt(3) = -86","66 "N"$“ – richtig ist $-86","60 "N"$; deine Weiterrechnung (−30,03 N) stimmt.], fill: pale)
#bild("tm1k01_ueb_beispiel", [„Übungen \_Technische Mechanik 1“ S. 2 (deine Mitschrift): 1. Beispielrechnung, vektorielle Lösung mit Quadrantenregel.], height: 45mm)
#note([Fehler im WZF-Manuskript (S. 10/10 = WZF-Skript S. 47)], [Dort steht $phi_R = arccos frac(R_y, R_x)$. Richtig ist $phi_R = arctan frac(R_y, R_x)$ (Quadrant beachten) oder $phi_R = arccos frac(R_x, | arrow(R)|)$. Außerdem werden dort $R_x = |F_("1x")| + |F_("2x")| + |F_("3x")|$ mit Betragsstrichen summiert – die Komponenten müssen aber #strong[mit Vorzeichen] addiert werden. „2. Weg: Summation der Komponenten – das wird in Zukunft unser Weg sein!“ (Manuskript).], fill: sand)
#note([Fehler im WZF-Skript (S. 6)], [„$( "rote Linie" )^2 = sqrt(( "grüne Linie" )^2 + ( "blaue Linie" )^2)$“ – Wurzel und Quadrat passen nicht zusammen. Richtig: $c^2 = a^2 + b^2$ bzw. $c = sqrt(a^2 +b^2)$.], fill: sand)
#strong[Allgemeines Dreieck] (FS TM1 S. 8, Gl. 1.20–1.21): Kosinussatz $a^2 = b^2 + c^2 - 2b c cos alpha$, Sinussatz $frac(a, sin alpha) = frac(b, sin beta) = frac(c, sin gamma)$. Additionstheoreme stehen in FS TM1 S. 9 (brauchst du in Kapitel 9).
#heading(level: 3, outlined: false)[Koordinatensysteme und Gleichungssysteme (WZF)]
- Kartesisch (rechtwinklig): Punkt $P(x;y)$; Achsen x, y, z #strong[rechtssinnig]. Polar: Abstand $r$ und Winkel $phi$. Umrechnung: $x = r cos phi$, $y = r sin phi$. Deine Notiz WZF-Skript S. 21: kartesisch „viel zu tun“, Polar „wenig zu tun“ – in TM1 rechnen wir fast immer kartesisch.
- Basisvektoren $arrow(e)_x, arrow(e)_y$ sind Einheitsvektoren und stehen senkrecht aufeinander.
- Lineare Gleichungssysteme schreibt man als $bold(A) thin arrow(x) = arrow(b)$ (Systemmatrix · Lösungsvektor = rechte Seite). Deine Ergänzung im Manuskript S. 3/10, von dir „#strong[wichtig!]“ markiert: $mat(delim: "[", 3, 4, 5; 2, 2, 1; 1, 7, 9) arrow(x) = mat(delim: "(", 23; 11; 32)$ → Lösen mit Gleichsetzungs-, Einsetzungs- oder Additionsverfahren (Gauß: II − ⅔·I, III − ⅓·I, …) → $arrow(x) = (2;3;1)^T$. Probe: $3 dot 2+4 dot 3+5 dot 1 = 23$ ✓.
- Matrix mal Vektor (deine Merkregel S. 4/10): „Man dreht den Vektor um und hat die Zahl dann vor der Spalte“: $bold(A) arrow(x) = 2 dot "Spalte"_1 + 3 dot "Spalte"_2 + 1 dot "Spalte"_3$.
#note([Beispiel (WZF-Skript Aufg. 1-2, S. 33): Polar → kartesisch.], [$\{50 "kN" ; 45 degree\} -> (35","36; 35","36) "kN"$; $\{25 "kN" ; 35 degree\} -> (20","48; 14","34) "kN"$; $\{43 "kN" ; 22","5 degree\} -> (39","73; 16","46) "kN"$; $\{30 "kN" ; 75 degree\} -> (7","76; 28","98) "kN"$.], fill: pale)
#note([Beispiel (Übung 1, Aufg. 1.5): Turmhöhe.], [I) $H = L tan alpha = 100 "m" dot tan 11","31 degree = 20 "m"$. II) $H = S sin alpha = 150 sin 15 degree = 38","82 "m"$, $L = S cos alpha = 144","89 "m"$. III a) $L = H tan beta = 50 tan 70 degree = 137","37 "m"$, $S = H/ cos beta = 146","19 "m"$. III b) $beta = arctan (200/30) = 81","47 degree$, $S = sqrt(30^2 +200^2) = 202","24 "m"$.], fill: pale)
#note([In eigenen Worten], [Ein Vektor ist wie eine Wegbeschreibung im Lager: „5 Regale nach rechts, 3 nach hinten“ (Komponenten) oder „5,83 Regale schräg unter 31°“ (Betrag + Winkel). Beides beschreibt denselben Weg; addieren kannst du aber nur die Komponenten einfach. #text(fill: muted)[(eigene Ergänzung)]])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Vektor als Betrag × Einheitsvektor:] $arrow(A) = A thin arrow(e)$; Multiplikation mit $lambda = -1$ kehrt den Richtungssinn um, $lambda = 0$ gibt den Nullvektor. #text(fill: muted)[\[TM1-Buch S. 265\]] #text(fill: muted)[\[TM1-Buch S. 268\]]
- #strong[Rechtssystem:] $arrow(e)_x, arrow(e)_y, arrow(e)_z$ entsprechen Daumen, Zeigefinger, Mittelfinger der rechten Hand. #text(fill: muted)[\[TM1-Buch S. 266\]]
- #strong[Zeilen-/Spaltenvektor:] $arrow(A) = (A_x, A_y, A_z )^T$ – „T“ = transponiert. #text(fill: muted)[\[TM1-Buch S. 267\]]
- #strong[Skalarprodukt dreifach deuten:] $A thin B cos phi$, Betrag von A mal Projektion von B auf A, oder umgekehrt; positiv bei spitzem, negativ bei stumpfem Winkel. #text(fill: muted)[\[TM1-Buch S. 270\]]
- #strong[Vektorprodukt:] $arrow(e)_x times arrow(e)_y = arrow(e)_z$, $arrow(e)_y times arrow(e)_z = arrow(e)_x$, $arrow(e)_z times arrow(e)_x = arrow(e)_y$; Koordinaten durch zyklisches Vertauschen x → y → z; Determinantenform. #text(fill: muted)[\[TM1-Buch S. 271–272\]]])
#src[Skript TM1 S. 22 (leere Folien), S. 48–60 (Vektorrechnung, mit deinen Markierungen); WZF-Skript S. 5–12, 18–22, 31–35 (Teil 1), S. 38–47 (Manuskript Übung 1, 03.10.25), S. 48–55 (Mathematisches Rüstzeug, 15.10.25), S. 56 (deine Notiz); „Übungen \_Technische Mechanik 1“ S. 2–4; Übung 1 + Lösung Übung 1 S. 1–3; FS TM1 S. 5–9; TM1-Buch S. 265–272.]

#bild("map-t1k1a", [Mindmap: Die vier Rechenwerkzeuge der Vektorrechnung. Eigene Darstellung nach Skript TM1 S. 48–60.], height: 44mm)

== 1.4 Kräfte und Momente am starren Körper <a-tm1-1-4>
Darf man einen Kraftpfeil verschieben, ohne dass sich etwas ändert? Das hängt vom Körper ab. Die Folie unterscheidet drei Arten von Vektoren:
#tab(columns: (1fr, 2fr),
 th([Vektorart], [Was ist erlaubt?]),
 [*freier* Vektor], [beliebig parallel zu sich selbst verschieben. Am starren Körper gilt das für *Momente* (deine Notiz „Moment“).],
 [*linienflüchtiger* Vektor], [nur längs seiner Wirkungslinie verschieben. Am starren Körper gilt das für *Kräfte* (deine Notiz „Kraft“).],
 [*gebundener* Vektor], [greift an einem festen Punkt an. Am *verformbaren* Körper (Ball) sind Kräfte und Momente gebunden.],
)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k01_starr", [Skript TM1 S. 23 (untere Folie): Regeln am starren Körper, von dir gelb markiert.], height: 52mm)],
 [#bild("tm1k01_zuordnung", [Skript TM1 S. 24 (obere Folie): Die Kraft muss beim richtigen Körper bleiben.], height: 52mm)])
Eine Kraft *parallel* zu verschieben ist nicht erlaubt: Sie hätte dann einen anderen Hebelarm, es entsteht ein zusätzliches Moment (genauer in #stelle(<a-tm1-3-1-1>)). Der Angriffspunkt darf gedanklich auch außerhalb des Körpers liegen. Er muss aber beim *selben* Körper bleiben: Bei zwei gelenkig verbundenen Stäben $K_1$ und $K_2$ darfst du $F_1$ nicht auf die Wirkungslinie in den anderen Stab schieben.

*Schreibweise:* In Skizzen steht beim Pfeil nur $F$, weil die Richtung im Bild klar ist. In Gleichungen bedeutet $F$ den Betrag $|arrow(F)|$.
#note([Von dir markiert (Skript TM1 S. 23)], [„freier Vektor“ mit deiner Notiz „Moment“, „linienflüchtiger Vektor“ mit „Kraft“, und für starre Körper: „Angriffspunkt darf längs der Wirkungslinie verschoben werden. Die Wirkung der Kraft ändert sich dabei nicht.“], fill: sand)
#note([In eigenen Worten], [Ob ich einen Wagen von hinten schiebe oder von vorne an derselben Linie ziehe, ist für den starren Wagen gleich. Bei einem Gummiball macht es einen Unterschied, weil er sich anders eindrückt. #text(fill: muted)[(eigene Ergänzung)]])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [Der starre Körper ist ein Modell: Die Abstände zwischen beliebigen Punkten bleiben gleich. Für viele Bauteile reicht es, weil die Verformungen klein sind. #text(fill: muted)[\[TM1-Buch S. 5\]]])
#src[Skript TM1 S. 23–24 (Folien 13–16, mit deinen Markierungen); FS TM1 S. 9; TM1-Buch S. 5–6. VL TM1 WS 25/26.]

== 1.5 Einteilung der Kräfte und Momente <a-tm1-1-5>
Kräfte lassen sich auf drei Arten sortieren. Jede Sortierung beantwortet eine andere Frage.
#bild("map-t1k1b", [Mindmap: Drei Arten, Kräfte einzuteilen. Eigene Darstellung nach Skript TM1 S. 25–29.], height: 44mm)

=== 1.5.1 Nach der Ausdehnung <a-tm1-1-5-1>
#tab(columns: (1fr, 1.3fr, 1fr, 0.8fr),
 th([Art], [Beispiel], [Modell], [Einheit]),
 [Volumenkraft], [Gewicht, Fliehkraft], [realitätsnah, über das ganze Volumen], [$"N/m"^3$],
 [Flächenkraft], [Wasserdruck, Schneelast, Kontaktpressung], [realitätsnah, an Flächen], [$"N/m"^2$],
 [Linienkraft (Streckenlast)], [Balken unter Eigengewicht, Walze auf Boden], [Idealisierung], [$"N/m"$],
 [Punktlast (Einzelkraft)], [Quader auf dem Boden: $G$ und $N$], [einfaches, oft starkes Modell], [N],
)
#form[$ d G = rho g thin d x thin d y thin d z, wide G = integral_V rho g thin d V, wide q_0 = frac(m g, l) $]
$rho$: Dichte in $"kg/m"^3$, $g = "9,81" "m/s"^2$, $l$: Balkenlänge in m. $q_0$ gilt für einen Balken mit gleichmäßig verteiltem Eigengewicht.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k01_linienkraft", [Skript TM1 S. 26 (untere Folie): Streckenlast; „$q_0 = m g\/l$“ von dir gelb markiert.], height: 48mm)],
 [#bild("tm1k01_punktlast", [Skript TM1 S. 27 (obere Folie): Quader real (Volumen- und Flächenkraft) und idealisiert (zwei Punktlasten).], height: 48mm)])
#note([Von dir markiert (Skript TM1 S. 27 unten)], [„Bei *starren* Körpern gilt: Reale, verteilte Lasten können oft durch *idealisierte Punktlasten* mit richtig gewähltem Angriffspunkt (z. B. Schwerpunkt) ersetzt werden.“ Wie man den Schwerpunkt findet, kommt in Kapitel 4.], fill: sand)

=== 1.5.2 Eingeprägte Kräfte und Reaktionen <a-tm1-1-5-2>
*Eingeprägte* Kräfte gibt das System physikalisch vor (Gewicht, Wasserdruck, Magnetkraft). Testfrage der Folie: _Wäre die Kraft auch da, wenn der Körper keine Verbindung zur Umgebung hätte?_ *Reaktionskräfte* (Zwangskräfte) entstehen erst, weil Lager oder Gelenke die Bewegung einschränken.
#bild("tm1k01_stein", [Skript TM1 S. 28 (untere Folie): Stein frei (nur $G$) und auf dem Boden ($G$ und Reaktion $N$); „eingepr. Kraft G und Reaktionskraft N“ von dir markiert.], height: 45mm)

=== 1.5.3 Äußere und innere Kräfte <a-tm1-1-5-3>
*Äußere* Kräfte sind eingeprägte Kräfte und Reaktionen, die von außen auf den Körper wirken. *Innere* Kräfte (Schnittgrößen $N$, $Q$, $M$) wirken im Inneren und sind für die Materialbeanspruchung verantwortlich (TM2).
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k01_aeussere", [Skript TM1 S. 29 (obere Folie): Freischnitt eines Kragbalkens ergibt die Reaktionen $F_A$ und $M_A$.], height: 45mm)],
 [#bild("tm1k01_innere", [Skript TM1 S. 29 (untere Folie): Schnitt durch den Balken ergibt die Schnittgrößen $N$, $Q$, $M$.], height: 45mm)])
#note([Fehler vermeiden], [Ob eine Kraft innen oder außen ist, hängt vom gewählten System ab. Schneidest du den Balken auseinander, wird die vorher innere Kraft am Schnittufer zur äußeren Kraft des Teilstücks.], fill: sand)
#src[Skript TM1 S. 25–29 (Folien 17–26, mit deinen Markierungen); FS TM1 S. 10; TM1-Buch S. 6–9. VL TM1 WS 25/26.]

== 1.6 Sichtbarmachen von Reaktionskräften und inneren Kräften <a-tm1-1-6>
=== 1.6.1 Schnittprinzip <a-tm1-1-6-1>
Kräfte sieht man nicht. Man macht sie sichtbar, indem man den Körper *gedanklich* von seiner Umgebung trennt.
- *Freischneiden* → Reaktionen: Lager und Gelenke lösen, für jede gelöste Bindung eine Reaktionskraft oder ein Reaktionsmoment ansetzen, mit dem Gleichgewicht ihre Größe bestimmen (Kapitel 5). Das Ergebnis ist das *Freikörperbild*.
- *Schneiden* → innere Kräfte: Körper gedanklich in zwei Teile zerlegen, an beiden Schnittufern die Schnittgrößen ansetzen, an einem Teil das Gleichgewicht bilden (Kapitel 7).
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k01_mitschrift_freischnitt", [Deine Mitschrift (Skript TM1 S. 31): Freikörperbild des Kragbalkens und Lösung $A_x = 0$, $A_y = F$, $M_A = F L$.], height: 70mm)],
 [#bild("tm1k01_mitschrift_schnitt", [Deine Mitschrift (Skript TM1 S. 32): Schnitt an der Stelle $x$, positives und negatives Schnittufer, $N$, $Q$, $M$.], height: 70mm)])
#note([Aus deiner Mitschrift (Skript TM1 S. 31–32)], [Kragbalken (Einspannung A links, Kraft $F$ am freien Ende, Länge $L$):
$ sum F_x = 0: A_x = 0, wide sum F_y = 0: A_y - F = 0, wide sum M_A = 0: M_A - L F = 0 $
also $A_x = 0$, $A_y = F$, $M_A = F L$. Nach dem Schnitt bei $x$ (rechtes Teilstück): $N = 0$, $Q = F$, $M = -(L - x) F$. Neben dem Schnitt hast du „rechte-Hand-Regel“ für das Koordinatensystem notiert und „=> Freikörperbild“ gelb markiert.])

=== 1.6.2 Wechselwirkungsgesetz <a-tm1-1-6-2>
Die Kräfte und Momente, die zwei Körper aufeinander ausüben, sind *gleich groß*, *entgegengesetzt* gerichtet und liegen auf *derselben Wirkungslinie*: *actio = reactio*. Drückt die Kugel mit $N$ auf den Boden, drückt der Boden mit $N$ zurück.
#bild("tm1k01_ww_gesetz", [Skript TM1 S. 33 (obere Folie): Kugel auf dem Boden; „actio = reactio“ von dir markiert.], height: 45mm)
#note([Wichtig laut Folie ★], [Skizze mit freigeschnittenen Teilkörpern zeichnen, die Teile *weit auseinanderrücken*, die Kräfte zwischen zwei Körpern jeweils entgegengesetzt gleich groß ansetzen.])

=== 1.6.3 Einfache Lager und Gelenke <a-tm1-1-6-3>
*Lager* verbinden einen Körper mit der Umgebung, *Gelenke* zwei Körper miteinander. Die Folie zeigt das am Gerberbalken: A ist ein Festlager, B und C sind Loslager, G ist ein Gelenk.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k01_lager", [Skript TM1 S. 33 (untere Folie): Gerberbalken; Symbole zeigen, was gesperrt (×) und was frei (✓) ist.], height: 52mm)],
 [#bild("tm1k01_gerber_frei", [Skript TM1 S. 34 (obere Folie): Freischnitt mit Lagerkräften $A_x, A_y, B, C$ und Gelenkkräften $G_x, G_y$.], height: 52mm)])
#tab(columns: (1fr, 1.4fr, 1fr),
 th([Bauteil], [gesperrt], [Reaktionen]),
 [Festlager A], [Verschiebung waagerecht und senkrecht; Drehung frei], [$A_x$, $A_y$],
 [Loslager B, C], [nur Verschiebung senkrecht zur Auflagefläche], [$B$ bzw. $C$],
 [Gelenk G], [gegenseitige Verschiebung beider Teile; Drehung frei], [$G_x$, $G_y$ (an beiden Teilen entgegengesetzt)],
)
Die vollständige Lagertabelle mit Einspannung, Pendelstütze und Schiebehülse folgt in #stelle(<a-tm1-2-4-2>).
#src[Skript TM1 S. 30–34 (Folien 27–32) und deine Mitschrift S. 31–32; FS TM1 S. 10–11; TM1-Buch S. 6–10. VL TM1 WS 25/26.]

== 1.7 Dimensionen, Einheiten, Rechnen <a-tm1-1-7>
Grundgrößen sind Länge (m), Zeit (s) und Masse (kg). Alles andere wird daraus abgeleitet.
#form[$ F = m a, wide [F] = "N" = frac("kg m", "s"^2), wide G = m g, quad g = "9,81" "m/s"^2, wide M = r F quad ["Nm"] $]
Gewicht eines Menschen: $80 "kg" dot "9,81" "m/s"^2 = 785 "N"$. Eine Tafel Schokolade (0,1 kg) wiegt etwa 1 N. Schraubenanzug: $M = "0,5" "m" dot 100 "N" = 50 "Nm"$. Weitere Einheiten: Volumenkraft $"N/m"^3$, Flächenkraft und Spannung $"N/m"^2$, Streckenlast $"N/m"$.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k01_einheiten", [Skript TM1 S. 35 (obere Folie): Grundgrößen und Kraft; „Kraft = Masse · Beschleunigung“ von dir markiert.], height: 50mm)],
 [#bild("tm1k01_falle", [Skript TM1 S. 37 (obere Folie): numerische Falle bei der Differenz großer Zahlen.], height: 50mm)])
*Zahlenmäßiges Rechnen:* Einheiten in der Rechnung mitziehen, kompatible Einheiten verwenden, drei signifikante Stellen reichen meist (Eingangsdaten sind oft nur auf ±10 % bekannt). *Falle:* Eine Masse von 10 t hängt an einem Seil, gezogen wird mit $F = 100 "kN"$. Grob gerechnet ($G approx 100 "kN"$) bleibt nichts übrig, genau ($G = "98,1" "kN"$) bleibt ein Überschuss von $"1,9" "kN" = 1900 "N"$. Bei Differenzen großer Zahlen also genau rechnen.
#note([Fehler vermeiden], [kN und N, mm und m nicht mischen. $g$ in $"m/s"^2$, Masse in kg; 1 t = 1000 kg. Ein Moment hat die Einheit Nm, nicht N.], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [Die Genauigkeit eines Ergebnisses kann nicht besser sein als die der Eingangsdaten; deshalb sind übertrieben viele Nachkommastellen sinnlos. #text(fill: muted)[\[TM1-Buch S. 10–12\]]])
#src[Skript TM1 S. 35–37 (Folien 33–37, mit deinen Markierungen); FS TM1 S. 11; Übung 0, Aufg. 0.1–0.2; TM1-Buch S. 10–12. VL TM1 WS 25/26.]

== 1.8 Lösung statischer Probleme: Vorgehen <a-tm1-1-8>
Jede Statikaufgabe läuft in vier Schritten ab. Schritt c) ist der Inhalt von TM1 und der Klausur.
#tab(columns: (0.4fr, 1.3fr, 2fr),
 th([], [Schritt], [Was du tust]),
 [a)], [Problem sauber formulieren], [z. B. Auflagerkräfte einer Brücke mit Lkw bestimmen],
 [b)], [Mechanisches Ersatzmodell], [Annahmen treffen: gewichtslos, reibungsfrei, starr, Kraft im Schwerpunkt. Aufwand und Nutzen abwägen.],
 [c)], [Lösung am Ersatzmodell ★], [Gegebenes/Gesuchtes notieren, Freikörperbild (actio = reactio), Gleichgewicht $sum F_x = 0$, $sum F_y = 0$, $sum M_((P)) = 0$ aufstellen, Gleichungssystem lösen, Ergebnisse kenntlich machen.],
 [d)], [Diskussion und Deutung], [Ergebnis anschaulich deuten und kritisch bewerten (Vorzeichen, Größenordnung).],
)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k01_modellguete", [Skript TM1 S. 38 (untere Folie): Brücke mit Lkw grob, mittel und genau modelliert.], height: 50mm)],
 [#bild("tm1k01_vorgehen_c", [Skript TM1 S. 39 (obere Folie): Schritt c) mit deiner Notiz „Ab hier nur wichtig“.], height: 50mm)])
#note([Von dir markiert (Skript TM1 S. 39–40)], [Über Schritt c) steht von dir „*Ab hier nur wichtig*“, und „Lösung am Ersatzmodell (≙ Inhalt von TM I)“ ist gelb markiert. Beim Beispiel Tragfläche (S. 40) hast du rot notiert: „*Nur das ist i. d. Prüfung relevant*“ – gemeint ist das fertige Ersatzmodell (Balken mit Streckenlast, Festlager, Pendelstütze), nicht die Modellbildung. In der Klausur bekommst du also das Modell und rechnest Schritt c).], fill: sand)
#note([In eigenen Worten], [Wie bei einer Kalkulation im Betrieb: erst klären, was gefragt ist, dann ein Rechenmodell mit vernünftigen Annahmen bauen, rechnen und am Ende prüfen, ob die Zahl plausibel ist. #text(fill: muted)[(eigene Ergänzung)]])
#src[Skript TM1 S. 37–40 (Folien 38–43, mit deinen Notizen); FS TM1 S. 11–12; TM1-Buch S. 11–13. VL TM1 WS 25/26.]

== 1.9 Beispiele aus der Vorlesung <a-tm1-1-9>
=== 1.9.1 Beispiel 1: Farbrolle an der Wand <a-tm1-1-9-1>
Ein Maler stellt seine Farbrolle (Walze mit Gewicht $G$, Stiel gewichtslos) unter dem Winkel $alpha$ an eine *glatte* Wand. Gesucht: Freikörperbilder, Kraft auf die Wand, Kraft vom Stiel auf die Walze.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k01_bsp1", [Skript TM1 S. 40 (untere Folie): Aufgabenstellung Beispiel 1.], height: 50mm)],
 [#bild("tm1k01_bsp1_mitschrift", [Deine Mitschrift (Skript TM1 S. 41): Freikörperbilder und Gleichgewicht.], height: 70mm)])
*Lösungsweg:* Glatte Wand → nur Normalkraft $N$ waagerecht. Der Stiel ist ein gewichtsloser, gelenkig angeschlossener Stab, seine Kraft $S$ wirkt in Stielrichtung.
$ sum F_x = 0: N - S cos alpha = 0, wide sum F_y = 0: -G + S sin alpha = 0 $
$ => S = frac(G, sin alpha), wide N = S cos alpha = G frac(cos alpha, sin alpha) = G cot alpha $
#note([Fehler vermeiden], [In deiner Mitschrift steht „$N = G dot tan^(-1)(alpha)$“. Gemeint ist $G \/ tan alpha = G cot alpha$, nicht der Arkustangens (siehe Kasten in #stelle(<a-tm1-1-3>)).], fill: sand)

=== 1.9.2 Beispiel 2 und 3: mehrere Körper befreien <a-tm1-1-9-2>
*Beispiel 2:* Gewichtsloser Gelenkstab, gehalten von einem Seil, Zugfeder $F = 3 "kN"$, Bolzen $G_B = 8 "kN"$, $alpha = 45 degree$, $beta = 30 degree$, $gamma = 60 degree$. Ergebnis laut Folie: Seilkraft $S = "6,66" "kN"$, Stabkraft $K = "10,278" "kN"$.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k01_bsp2", [Skript TM1 S. 42 (obere Folie): Aufgabenstellung Beispiel 2.], height: 50mm)],
 [#bild("tm1k01_bsp2_mitschrift", [Deine Mitschrift (Skript TM1 S. 43): Freikörperbild am Bolzen, Gleichgewicht I (rot) und II (grün).], height: 55mm)])
Am Bolzen greifen $S$, $F$, $K$ und $G_B$ an. Mit „bei x immer cos, bei y immer sin“ (Winkel jeweils zur x-Achse):
$ "I:" -S cos beta - F cos gamma + K cos alpha = 0, wide "II:" S sin beta - F sin gamma + K sin alpha - G_B = 0 $
I mal $sin beta$ plus II mal $cos beta$ eliminiert $S$:
$ K = frac(F sin(beta + gamma) + G_B cos beta, sin(alpha + beta)) = frac(3 dot 1 + 8 dot "0,866", "0,966") = "10,28" "kN", wide S = frac(K cos alpha - F cos gamma, cos beta) = "6,66" "kN" $
#note([Fehler in deiner Mitschrift (Skript TM1 S. 43–44)], [Bei den Zahlenwerten steht „$beta = 50 degree$“ und später „$cos 50 degree$“. Laut Aufgabe ist $beta = 30 degree$; nur damit kommen die Ergebnisse $K = "10,278" "kN"$ und $S = "6,66" "kN"$ heraus (beides nachgerechnet). Die Zahlen deiner Mitschrift stimmen also, nur die Winkelangabe ist verschrieben.], fill: sand)
*Beispiel 3:* Eine Rolle ($G = 80 "N"$) stützt sich reibungsfrei an einer Wand ab und hängt an einem gekrümmten Balken; Feder $F = 30 "N"$, $alpha = 30 degree$, $beta = 45 degree$. Ergebnis laut Folie: Kraft auf die Wand $N = 196 "N"$, Stabkraft $S = 202 "N"$. Der gekrümmte Balken ist gewichtslos und gelenkig angeschlossen; seine Kraft wirkt deshalb entlang der Verbindungslinie seiner Gelenke, auch wenn er gebogen ist #text(fill: muted)[(eigene Ergänzung, vgl. Stab in Abschnitt 2.4.1)].
#bild("tm1k01_bsp3", [Skript TM1 S. 42 (untere Folie): Aufgabenstellung Beispiel 3.], height: 48mm)
#src[Skript TM1 S. 40–46 (Folien 44–46) und deine Mitschrift S. 41, 43–46; Übung 0. VL TM1 WS 25/26.]

#bild("map-t1k1c", [Mindmap: Vom realen Bauteil zur Gleichung. Eigene Darstellung nach Skript TM1 S. 30–39.], height: 44mm)

*Der Zusammenhang in Kapitel 1.* Eine Kraft ist ein Vektor mit Betrag, Richtung und Angriffspunkt; mit der Vektorrechnung zerlegst und addierst du sie. Am starren Körper dürfen Kräfte auf ihrer Wirkungslinie wandern, Momente sogar frei. Weil man Kräfte nicht sieht, schneidet man frei: Lager werden zu Reaktionen, Schnitte liefern innere Kräfte, und actio = reactio verbindet die Teilkörper. Das Vorgehen a)–d) ordnet jede Aufgabe; der Kern ist immer Freikörperbild plus Gleichgewicht.

#pagebreak()
== Verständnisfragen und Rechenaufgaben · Kapitel 1
#set enum(spacing: 0.85em)
Erkläre erst selbst. Bei Rechenaufgaben zuerst ein Freikörperbild oder eine Skizze. Die Lösungen folgen getrennt.

+ Nenne die drei Eigenschaften einer Kraft. Was ist die Wirkungslinie?
+ Warum „sieht“ man in der Statik starrer Körper keine Kräfte?
+ Welche Wirkungen haben Kräfte und Momente? Ordne Dehnung, Biegung und Verdrillung zu.
+ Was ist ein freier, ein linienflüchtiger und ein gebundener Vektor? Welche Art sind Kräfte und Momente am starren Körper?
+ Warum darf man eine Kraft am starren Körper nicht parallel verschieben?
+ Erkläre den Unterschied zwischen eingeprägten Kräften und Reaktionskräften mit der Testfrage der Folie.
+ Was unterscheidet äußere von inneren Kräften? Wie macht man jeweils sichtbar?
+ Formuliere das Wechselwirkungsgesetz und nenne die Regeln der Folie für das Zeichnen.
+ Wie viele Reaktionen haben Festlager, Loslager und Gelenk?
+ Was bedeutet $arrow(a) dot arrow(b) < 0$? Was bedeutet $arrow(a) times arrow(b) = arrow(0)$?
+ Warum ist $tan^(-1)$ auf dem Taschenrechner nicht der Kotangens?
+ Nenne die Schritte a)–d) zur Lösung statischer Probleme. Welcher Schritt ist Klausurstoff?
+ Ein Balken (m = 120 kg, l = 4 m) liegt auf zwei Lagern. Wie groß ist die Streckenlast aus Eigengewicht? #text(fill: muted)[(eigene Aufgabe)]
+ *Übung 1, Aufg. 1.1:* $arrow(a) = (3; 0; 4)^T$, $arrow(b) = (4; -1; 7)^T$. Projektion von $arrow(b)$ auf $arrow(a)$ (Betrag und Vektor) und Winkel.
+ *Übung 1, Aufg. 1.3:* $arrow(a) = (1; 4; -6)^T$, $arrow(b) = (2; -1; 2)^T$, $arrow(c) = (0; 2; 3)^T$. Berechne a) $arrow(a) times arrow(b)$, b) $(arrow(a) - arrow(b)) times (3 arrow(c))$, c) $(-arrow(a) + 2 arrow(c)) times (-arrow(b))$, d) $(2 arrow(a)) times (-arrow(b) + 5 arrow(c))$.
+ *Übung 1, Aufg. 1.4:* Moment der Kraft $arrow(F) = (2; 0; 3)^T "N"$ am Hebelarm $arrow(r) = (1; -5; 2)^T "m"$.

#heading(level: 3, outlined: false)[Vertiefende Verständnisfragen und Rechenaufgaben]
#block[
#set enum(start: 17)
+ *Brücke, Übung 0, Aufg. 0.1:* Brücke 100 t, Schwerpunkt in der Mitte, Lager symmetrisch. Bestimme das Gewicht und die Lagerkräfte. Ein Lkw (20 t) steht a) über dem linken Lager, b) in der Mitte, c) über dem rechten Lager. Lagerkräfte?
+ *Rakete, Übung 0, Aufg. 0.2:* Startmasse 5096,9 kg. Kraft auf die Rampe? Schub 25 000 N, 50 000 N, 70 000 N: resultierende Kraft auf die Rakete, Kraft auf die Rampe, Bewegung?
+ *Farbrolle, Folie Beispiel 1:* Walze $G = 20 "N"$, $alpha = 60 degree$, glatte Wand. Bestimme $N$ und $S$. #text(fill: muted)[(Zahlen eigene Wahl)]
+ *Übung 1, Aufg. 1.5 III b:* Ein Turm ist 30 m hoch, Abstand 200 m. Wie lang ist die Sichtlinie $S$, und unter welchem Winkel $beta$ zur Senkrechten liegt sie?
+ *Buch:* Warum dürfen die Pfeile von actio und reactio nie in dasselbe Freikörperbild eines Körpers gezeichnet werden? (TM1-Buch S. 9)
]

#pagebreak()
== Lösungen Kapitel 1
#set enum(spacing: 0.65em)
+ Betrag, Richtung (Orientierung und Richtungssinn), Angriffspunkt. Wirkungslinie = Gerade durch den Angriffspunkt in Kraftrichtung. #nachschlagen[Lernskript, #stelle(<a-tm1-1-2>)]
+ Spannungen sind unsichtbar, starre Körper verformen sich nicht, und im Gleichgewicht gibt es keine Beschleunigung. #nachschlagen[Lernskript, #stelle(<a-tm1-1-1>)]
+ Spannung, Verformung, Beschleunigung. Kräfte: Dehnung/Stauchung und Schubverformung; Momente: Biegung und Verdrillung. #nachschlagen[Lernskript, #stelle(<a-tm1-1-1>)]
+ Frei: parallel verschiebbar; linienflüchtig: nur auf der Wirkungslinie; gebunden: fester Punkt. Am starren Körper sind Kräfte linienflüchtig, Momente frei. #nachschlagen[Lernskript, #stelle(<a-tm1-1-4>)]
+ Die Kraft bekäme einen anderen Hebelarm; es entstünde ein zusätzliches Moment, die Wirkung ändert sich. #nachschlagen[Lernskript, #stelle(<a-tm1-1-4>)]
+ Eingeprägt: wäre auch ohne Verbindung zur Umgebung da (Gewicht, Wasserdruck). Reaktion: entsteht erst durch Lager/Gelenke (Normalkraft $N$ des Bodens). #nachschlagen[Lernskript, #stelle(<a-tm1-1-5-2>)]
+ Äußere wirken von außen (eingeprägt + Reaktionen), sichtbar durch Freischneiden. Innere wirken im Körper (Schnittgrößen), sichtbar durch Schneiden. #nachschlagen[Lernskript, #stelle(<a-tm1-1-5-3>) und #stelle(<a-tm1-1-6-1>)]
+ Gleich groß, entgegengesetzt, gleiche Wirkungslinie. Teilkörper freischneiden, weit auseinanderrücken, Kräfte zwischen zwei Körpern entgegengesetzt gleich ansetzen. #nachschlagen[Lernskript, #stelle(<a-tm1-1-6-2>)]
+ Festlager 2 ($A_x, A_y$), Loslager 1, Gelenk 2 ($G_x, G_y$, an beiden Teilen entgegengesetzt). #nachschlagen[Lernskript, #stelle(<a-tm1-1-6-3>)]
+ $< 0$: stumpfer Winkel zwischen den Vektoren. Kreuzprodukt null: Vektoren sind parallel oder antiparallel. #nachschlagen[Lernskript, #stelle(<a-tm1-1-3>)]
+ $tan^(-1)$ ist die Umkehrfunktion arctan und liefert einen Winkel; $cot alpha = 1\/tan alpha$. #nachschlagen[Lernskript, #stelle(<a-tm1-1-3>)]
+ a) formulieren, b) Ersatzmodell, c) Lösung am Ersatzmodell (Freikörperbild, Gleichgewicht, lösen), d) deuten. Klausurstoff ist c). #nachschlagen[Lernskript, #stelle(<a-tm1-1-8>)]
+ $q_0 = m g\/l = 120 dot "9,81" \/ 4 = 294 "N/m"$. #nachschlagen[Lernskript, #stelle(<a-tm1-1-5-1>)]
+ $|arrow(a)| = 5$, $b_a = 40\/5 = 8$, $arrow(b)_a = (4","8; 0; 6","4)^T$, $phi = 10","02 degree$. #nachschlagen[Lernskript, #stelle(<a-tm1-1-3>)\; Lösung Übung 1 S. 1]
+ a) $(2; -14; -9)^T$, b) $(93; 9; -6)^T$, c) $(-12; -26; -1)^T$, d) $(236; -2; 38)^T$ (alle nachgerechnet, wie Kurzlösung). #nachschlagen[Lernskript, #stelle(<a-tm1-1-3>)\; Übung 1 S. 2]
+ $arrow(M) = (-15; 1; 10)^T "Nm"$, $|arrow(M)| = "18,06" "Nm"$. #nachschlagen[Lernskript, #stelle(<a-tm1-1-3>)]
+ $G = 100 000 "kg" dot "9,81" "m/s"^2 = 981 "kN"$; jedes Lager $"490,5" "kN"$ nach oben. $G_"Lkw" = "196,2" "kN"$. a) links 686,7 kN, rechts 490,5 kN; b) je 588,6 kN; c) links 490,5 kN, rechts 686,7 kN. Probe: Summe immer $981 + "196,2" = "1177,2" "kN"$. Hinweis: Die Kurzfassung auf dem Aufgabenblatt nennt „$G_"LKW" = "192,2" "kN"$“; richtig ist 196,2 kN, wie in der ausführlichen Lösung. #nachschlagen[Lernskript, #stelle(<a-tm1-1-7>)\; Lösung Übung 0 S. 1]
+ $G = 5096","9 dot "9,81" = 50 000 "N"$. Schub 25 000 N: Resultierende 25 000 N nach unten, Rampe trägt 25 000 N, Rakete steht. 50 000 N: Resultierende 0, Rampe 0, steht. 70 000 N: 20 000 N nach oben, Rampe 0, beschleunigt nach oben. #nachschlagen[Lernskript, #stelle(<a-tm1-1-7>)\; Lösung Übung 0 S. 1]
+ $S = G\/sin alpha = 20\/"0,866" = "23,1" "N"$, $N = G cot alpha = 20 dot "0,577" = "11,5" "N"$. Probe: $S cos alpha = "11,5" "N" = N$. #nachschlagen[Lernskript, #stelle(<a-tm1-1-9-1>)]
+ $S = sqrt(30^2 + 200^2) = "202,24" "m"$, $beta = arctan(200\/30) = "81,47" degree$. #nachschlagen[Lernskript, #stelle(<a-tm1-1-3>)\; Lösung Übung 1]
+ Im Freikörperbild eines Körpers stehen nur die Kräfte, die *auf ihn* wirken. Die Gegenkraft wirkt auf den anderen Körper und gehört in dessen Freikörperbild. #nachschlagen[Lernskript, #stelle(<a-tm1-1-6-2>)\; TM1-Buch S. 9]

#pagebreak()
= TM1 Kapitel 2 · Kräfte mit gemeinsamem Angriffspunkt <k-tm1-2>
#tab(columns: 2,
 [Vorlesungen], [VL 23.10.25 → 2.1 (Datum aus deinem Screenshot auf Skript S. 66); VL 27.10.25 → 2.2, 2.3, 2.4.1, 2.4.2 (handschriftliche Daten auf den Folien); 2.4.3 und Rechenbeispiele 1–5 ohne Datum (zwischen 27.10. und 30.10.25); VL 30.10.25 → Rechenbeispiel 6 (Tafelanschrieb); 2.5 nicht behandelt (Folien leer, von dir „nicht prüfungsrelevant“ notiert)],
 [Quellen], [Skript TM1 S. 61–96 (Foliensatz „Kräfte mit gemeinsamem Angriffspunkt“, Folien 1–52); deine Mitschrift S. 66–67, 69, 88–94; deine Notizen „Bauteile.pdf“ S. 1–3; FS TM1 S. 8, 13–20; TM1-Buch Kap. 2 (S. 15–41)],
 [Passende Übungen], [Übung 2: 2.1–2.4 · Übung 3: 3.1–3.4 · Übung 4: 4.1, 4.2, 4.3, 4.5 (Dreikraftsystem; Momenten-Lösung erst mit Kap. 3) · Übung 4.4 ist räumlich und von dir durchgestrichen],
)
Alle Kräfte gehen durch #strong[einen Punkt]. Dann gibt es kein Drehen, nur Verschieben – und Gleichgewicht heißt nur noch: #strong[Die Vektorsumme aller Kräfte ist null] (Krafteck geschlossen, $sum F_x = 0, sum F_y = 0$). Damit kannst du in der Ebene genau #strong[zwei Unbekannte] bestimmen.
#note([Dein Feynman-Schritt: die 5 Kernideen von Kapitel 2. Erst ohne Skript aufzählen und erklären, dann vergleichen.], [+ #strong[Zentrale Kräftegruppe:] Kräfte (bzw. Wirkungslinien) treffen sich in einem Punkt. Sie lassen sich durch eine Resultierende $arrow(F)_R = sum arrow(F)_i$ ersetzen.
+ #strong[Drei Rechenwege:] grafisch (anschaulich), vektoriell in Komponenten (bei $n > 2$ Kräften) und Dreieckssätze (bei 2–3 Kräften schnell).
+ #strong[Zerlegung:] In der Ebene ist eine Kraft nach #emph[zwei] Richtungen eindeutig zerlegbar, nach mehr Richtungen nicht.
+ #strong[Gleichgewicht:] Krafteck geschlossen ⇔ $sum F_x = 0, sum F_y = 0$ → 2 Gleichungen, 2 Unbekannte.
+ #strong[Freischneiden mit Idealisierungen:] Seil nur Zug, Stab Zug/Druck in Stabrichtung, glatter Kontakt nur $N$ senkrecht zur Berührtangente; Lager liefern je nach Typ 1–3 Reaktionen.
Zusammenfassung der Abschnitte 2.1–2.5; Quellen stehen dort.])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k2_definition", [Skript TM1 S. 62 (obere Folie 3): Definition der zentralen Kräftegruppe – von dir gelb markiert, „Angriffspunkt“ handschriftlich ergänzt.], height: 50mm)],
 [#bild("tm1k2_fachwerkknoten", [Skript TM1 S. 62 (untere Folie 4): Kräfte am Knoten eines Fachwerks; grün deine Skizze des freigeschnittenen Knotens III.], height: 50mm)])
#note([Von dir markiert (Skript S. 62)], [„Zentrales Kräftesystem“, „Zentrale Kräftegruppe“ und „treffen sich in einem Angriffspunkt“. Auf Folie 4 hast du am Fachwerk-Knoten III die Stabkräfte S#sub[1], S#sub[3], S#sub[4], S#sub[5] und F#sub[3] skizziert und S#sub[1] als „Druckstab“ notiert: Jeder Fachwerkknoten ist eine zentrale Kräftegruppe – das brauchst du später in Kap. 6 (Fachwerke).], fill: sand)
#note([Von dir notiert (Skript S. 61, Gliederung)], [Abschnitt „5 Zentrale Kräftegruppen im Raum“ ist durchgestrichen mit „nicht Prüfungsrelevant“. Abschnitt 2.5 ist darum hier nur kurz.], fill: sand)
== 2.1 Zusammensetzung von Kräften in der Ebene <a-tm1-2-1>
Greifen mehrere Kräfte an einem Punkt an, kannst du sie durch #strong[eine einzige Kraft] ersetzen, die genau dasselbe bewirkt: die #strong[Resultierende] $arrow(F)_R$ (oft auch $arrow(R)$). Mathematisch ist das einfach die Vektorsumme.
- #strong[Zwei Kräfte:] Kräfteparallelogramm. Die Diagonale ist $arrow(F)_R$. Ein halbes Parallelogramm (Kräftedreieck) reicht.
- #strong[Mehrere Kräfte:] Kräfte maßstäblich hintereinander zeichnen (Krafteck, Kräftepolygon). $arrow(F)_R$ zeigt vom Anfang der ersten zur Spitze der letzten Kraft. #strong[Reihenfolge beliebig.]
- #strong[Lageplan] = wo die Kräfte wirken (Wirkungslinien). #strong[Krafteck / Kräfteplan] = Kräfte aneinandergereiht, mit Kräftemaßstab.
- Kräfte bleiben auf ihrer Wirkungslinie. Im Krafteck zeichnest du nur #emph[parallel verschobene Hilfskräfte].
#note([In eigenen Worten], [Zwei Leute ziehen einen Schlitten an zwei Seilen leicht schräg nach vorne. Der Schlitten fährt so, als würde #emph[eine] Person mit der Resultierenden ziehen – schräg ziehen kostet Kraft, weil sich die Querkomponenten gegenseitig aufheben. #text(fill: muted)[(eigene Ergänzung)]])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k2_parallelogramm", [Skript TM1 S. 63 (obere Folie 5): Lageplan und Kräfteparallelogramm („Vektor-/Kräfteaddition“ von dir ergänzt).], height: 50mm)],
 [#bild("tm1k2_krafteck", [Skript TM1 S. 63 (untere Folie 6): mehrere Kräfte, Krafteck.], height: 50mm)])
#heading(level: 3, outlined: false)[Vektorielle Berechnung (vorteilhaft bei $n > 2$) ★]
+ #strong[Koordinatensystem wählen] (üblich: x nach rechts, y nach oben).
+ #strong[Komponenten] jeder Kraft bestimmen (Winkel $phi_i$ von der positiven x-Achse aus).
+ #strong[Komponentenweise addieren.]
+ #strong[Betrag und Richtung] von $F_R$ bestimmen.
#form[$ F_("ix") = F_i cos phi_i, wide F_("iy") = F_i sin phi_i quad [ "N" ] $


$ F_("Rx") = sum_(i=1)^n F_("ix"), wide F_("Ry") = sum_(i=1)^n F_("iy") $


$ F_R = sqrt(F_("Rx")^2 + F_("Ry")^2) quad [ "N" ], wide tan phi_R = frac(F_("Ry"), F_("Rx")) $]
Resultierende einer ebenen zentralen Kräftegruppe (Skript S. 64; FS TM1 S. 14, Gl. 2.3–2.6).
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k2_komponenten", [Skript TM1 S. 64 (obere Folie 7): Komponenten; rechts dein Merkkreis „S A / C T“.], height: 50mm)],
 [#bild("tm1k2_resultierende", [Skript TM1 S. 64 (untere Folie 8): Betrag und Richtung von $F_R$, von dir markiert.], height: 50mm)])
#note([Aus deiner Mitschrift (Skript S. 64)], [Kreis mit den Quadranten #strong[A] (I: alle positiv), #strong[S] (II: nur sin positiv), #strong[C] (IV: nur cos positiv), #strong[T] (III: nur tan positiv). Damit prüfst du schnell das Vorzeichen jeder Komponente.])
#note([Fehler vermeiden], [$arctan (F_("Ry")/F_("Rx"))$ liefert nur Winkel zwischen −90° und +90°. Ist $F_("Rx") < 0$, liegt $F_R$ im II. oder III. Quadranten: Dann musst du #strong[180° addieren]. Immer eine Skizze mit den Vorzeichen von $F_("Rx"), F_("Ry")$ machen (die Übung 2 fragt deshalb auch nach dem Quadranten).], fill: sand)
#heading(level: 3, outlined: false)[Dreieckssätze (vorteilhaft bei $n = 2$) ★]
#form[$ "Cosinussatz: " a^2 = b^2 + c^2 - 2b c cos alpha wide "Sinussatz: " frac(a, sin alpha) = frac(b, sin beta) = frac(c, sin gamma) $


$ sin ( pi - phi ) = sin phi, quad cos ( pi - phi ) = - cos phi, quad sin ( frac(pi, 2) - phi ) = cos phi, quad cos ( frac(pi, 2) - phi ) = sin phi $]
Seite $a$ liegt dem Winkel $alpha$ gegenüber (Skript S. 65; FS TM1 S. 8, Gl. 1.20–1.21 und S. 14, Gl. 2.7).
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k2_dreieckssaetze", [Skript TM1 S. 65 (obere Folie 9): Dreieckssätze, von dir markiert, mit deiner Notiz zum Cosinussatz.], height: 50mm)],
 [#bild("tm1k2_bsp_cosinussatz", [Skript TM1 S. 65 (untere Folie 10): Beispiel Resultierende zweier Kräfte mit Cosinus- und Sinussatz.], height: 50mm)])
#note([Aus deiner Mitschrift (Skript S. 65–67, 23.10.25)], [„Cosinussatz: eingeschlossener Winkel von zwei Seiten → Berechnung der gegenüberliegenden Seite.“ Dazu hast du dir das Umstellen notiert:
- Seite gesucht (Sinussatz): $a = b dot frac(sin alpha, sin beta)$, also „gesuchte Seite = bekannte Seite · sin(Gegenwinkel gesucht) / sin(Gegenwinkel bekannt)“.
- Winkel gesucht (Sinussatz): $alpha = arcsin ( frac(a sin beta, b) )$. #strong[Achtung:] $alpha$ und $180°- alpha$ haben denselben Sinus → zwei mögliche Lösungen (Mehrdeutigkeit).
- Winkel gesucht (Cosinussatz): $alpha = arccos ( frac(b^2 +c^2 -a^2, 2b c) )$ – eindeutig, weil arccos Werte von 0° bis 180° liefert.])
#note([Merke], [Kennst du zwei Seiten und den #strong[eingeschlossenen] Winkel → Cosinussatz. Kennst du eine Seite und ihren #strong[Gegenwinkel] → Sinussatz. Für einen gesuchten Winkel lieber den Cosinussatz nehmen (eindeutig).])
#note([Beispiel (Folie 10, Zahlen eigene Ergänzung)], [Geg.: $F_1 = 3 "kN"$, $F_2 = 4 "kN"$, Winkel zwischen den Kräften $alpha = 60°$. Ges.: $F_R$ und Winkel $beta$ zwischen $F_R$ und $F_2$.
+ Im Kräftedreieck liegt $F_R$ dem Winkel $pi - alpha = 120°$ gegenüber (nicht $alpha$!).
+ Cosinussatz: $F_R^2 = F_1^2 + F_2^2 - 2F_1 F_2 cos ( pi - alpha ) = F_1^2 +F_2^2 +2F_1 F_2 cos alpha = 9+16+12 = 37 upright(k N^2 )$ → $F_R = 6","08 "kN"$.
+ Sinussatz: $sin beta = frac(F_1, F_R) sin alpha = frac(3, 6","08) dot 0","866 = 0","427$ → $beta = 25","3°$.
+ Kontrolle vektoriell ($F_2$ auf der x-Achse): $F_("Rx") = 4 + 3 cos 60° = 5","5$, $F_("Ry") = 3 sin 60° = 2","598$ → $F_R = 6","08 "kN"$, $arctan (2","598/5","5) = 25","3°$. ✓], fill: pale)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Parallelogrammsatz als Axiom:] Die Wirkung zweier Kräfte an einem Punkt ist gleich der Wirkung der Diagonale des Kräfteparallelogramms; das ist die Vektoraddition $arrow(R) = arrow(F)_1 + arrow(F)_2$. #text(fill: muted)[\[TM1-Buch S. 17\]]
- #strong[Lageplan und Kräfteplan:] Der Kräfteplan braucht einen Kräftemaßstab (z. B. 1 cm ≙ 10 N). Arbeitest du nur mit einer Skizze des Kraftecks und rechnest mit Dreieckssätzen („grafoanalytisch“), brauchst du keinen Maßstab. #text(fill: muted)[\[TM1-Buch S. 18\]]
- #strong[Beispiel 2.2/2.3 Ringschraube:] $F_1 = 12 "kN"$ (45°), $F_2 = 8 "kN"$ (100°), $F_3 = 18 "kN"$ (205°), $F_4 = 4 "kN"$ (270°) → $R_x = -9","22 "kN"$, $R_y = 4","76 "kN"$, $R = 10","4 "kN"$. Da $R_x < 0$: $alpha_R = 180° - 27","3° approx 152","7°$ (Buch rundet über $tan alpha_R = -0","52$ auf 152,5°; grafisch abgelesen 155°). #text(fill: muted)[\[TM1-Buch S. 20\]] #text(fill: muted)[\[TM1-Buch S. 24\]]])
#src[Skript TM1 S. 61–65 (Folien 1–10); deine Mitschrift S. 64–67 (Screenshots vom 23.10.25); FS TM1 S. 8, 13–14; TM1-Buch S. 15–20, 22–24.]
== 2.2 Zerlegung von Kräften in der Ebene <a-tm1-2-2>
Zerlegen ist das Gegenteil von Zusammensetzen: Eine gegebene Kraft $arrow(F)$ wird durch zwei Kräfte $arrow(F)_1, arrow(F)_2$ mit #strong[vorgegebenen Wirkungslinien] ersetzt, sodass $arrow(F) = arrow(F)_1 + arrow(F)_2$.
- #strong[Zwei Richtungen] (Wirkungslinien durch den Angriffspunkt von $F$) → Zerlegung #strong[eindeutig].
- #strong[Mehr als zwei Richtungen] → beliebig viele Lösungen.
- Rechenwege: grafisch (Parallelogramm), vektoriell, Trigonometrie (Dreieckssätze, „deutlich einfacher!“).
#note([In eigenen Worten], [Ein Gabelstapler soll eine Palette diagonal über den Hof bewegen, darf aber nur „nach vorne“ und „seitwärts“ fahren. Die Diagonale lässt sich genau auf eine Art aus diesen zwei Fahrten zusammensetzen. Hätte er drei erlaubte Richtungen, gäbe es unendlich viele Kombinationen. #text(fill: muted)[(eigene Ergänzung)]])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k2_zerlegung_grafisch", [Skript TM1 S. 68 (obere Folie 11): grafische Zerlegung mit Parallelogramm (Beschriftung $F_1$, $W L_(F_1)$, $W L_(F_2)$ von dir korrigiert).], height: 50mm)],
 [#bild("tm1k2_mitschrift_zerlegung", [Deine Mitschrift (Skript TM1 S. 69 oben): Zerlegung von $F$ entlang $W L thin F_1$ und $W L thin F_2$, sauber nachgezeichnet.], height: 50mm)])
#heading(level: 3, outlined: false)[Zerlegung über Trigonometrie ★]
Gegeben: $F$ sowie die Winkel $alpha$ (zwischen $F$ und $F_1$) und $beta$ (zwischen $F$ und $F_2$). Im Kräftedreieck liegt $F$ dem Winkel $pi -( alpha + beta )$ gegenüber, $F_1$ dem Winkel $beta$ und $F_2$ dem Winkel $alpha$. Mit $sin ( pi -( alpha + beta )) = sin ( alpha + beta )$ liefert der Sinussatz:
#form[$ F_1 = F dot frac(sin beta, sin ( alpha + beta )), wide F_2 = F dot frac(sin alpha, sin ( alpha + beta )) quad [ "N" ] $]
Jede Teilkraft „gehört“ zum Winkel der #strong[anderen] Teilkraft (Skript S. 71, Folie 15).
#strong[Häufigster Fall:] zwei senkrechte Richtungen ($alpha + beta = 90°$, $sin 90° = 1$). Dann bleiben nur die x-y-Komponenten:
#form[$ F_x = F cos phi, wide F_y = F sin phi, wide phi = arcsin frac(F_y, F) = arccos frac(F_x, F) = arctan frac(F_y, F_x) $]
Senkrechte Zerlegung (Skript S. 71, Folie 16; TM1-Buch S. 22, Gl. 2.5).
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k2_zerlegung_trigo", [Skript TM1 S. 71 (obere Folie 15): Zerlegung über den Sinussatz.], height: 50mm)],
 [#bild("tm1k2_zerlegung_senkrecht", [Skript TM1 S. 71 (untere Folie 16): Zerlegung in zwei senkrechte Richtungen.], height: 50mm)])
#heading(level: 3, outlined: false)[Vektorielle Zerlegung]
#note([Von dir notiert (Skript S. 68, Folie 12)], [„Vektoriell (nicht so wichtig, da sehr aufwändig)“. Merke dir den Ansatz und das Ergebnis, nicht die lange Umformung.], fill: sand)
Gegeben $F, phi$ und die Richtungen $phi_1, phi_2$ (alle von der x-Achse aus). Ansatz $arrow(F) = arrow(F)_1 + arrow(F)_2$ komponentenweise:
#form[$ "(I)" F cos phi = F_1 cos phi_1 + F_2 cos phi_2, wide "(II)" F sin phi = F_1 sin phi_1 + F_2 sin phi_2 $


$ F_1 = F thin frac(sin ( phi - phi_2 ), sin ( phi_1 - phi_2 )), wide F_2 = F thin frac(sin ( phi - phi_1 ), sin ( phi_2 - phi_1 )) $]
2 Gleichungen, 2 Unbekannte (Skript S. 68–70, Folien 12–14).
#note([Aus deiner Mitschrift (27.10.25, Skript S. 69–70)], [Kürzerer Weg als auf der Folie: (I) mit $sin phi_1$ und (II) mit $cos phi_1$ multiplizieren und subtrahieren. Dann fällt $F_1$ heraus, und mit dem Additionstheorem bleibt $F sin ( phi - phi_1 ) = F_2 sin ( phi_2 - phi_1 )$. #emph[Kleiner Hinweis:] Die Klammern $( cos phi sin phi_1 - sin phi cos phi_1 )$ und $( cos phi_2 sin phi_1 - sin phi_2 cos phi_1 )$ sind eigentlich $sin ( phi_1 - phi )$ bzw. $sin ( phi_1 - phi_2 )$, nicht $sin ( phi - phi_1 )$ bzw. $sin ( phi_2 - phi_1 )$. Beide Vorzeichen drehen sich aber um, also ist dein Ergebnis für $F_2$ richtig.])
#bild("tm1k2_zerlegung_herleitung2", [Skript TM1 S. 70 (untere Folie 14): Herleitung von $F_2$ – mit Tippfehlern, siehe roter Kasten.], height: 45mm)
#note([Fehler auf der Folie (Skript S. 70, Folie 14)], [In der 2. und 3. Zeile steht im Zähler „$F cos phi_1 sin phi - F cos phi_1 sin phi_1$“ und im Nenner „$cos phi_1 sin phi_2 - cos phi_1 sin phi_1$“. Richtig ist $F( cos phi_1 sin phi - cos phi sin phi_1 )$ bzw. $cos phi_1 sin phi_2 - cos phi_2 sin phi_1$ (jeweils ein Index vertauscht). Nur so ergibt das Additionstheorem $sin ( phi - phi_1 )$ und $sin ( phi_2 - phi_1 )$. Das Endergebnis auf der Folie stimmt. Außerdem fehlt auf Folie 13 bei d) vorne „$F cos phi =$“ in der ersten Gleichung.], fill: sand)
#note([Beispiel (eigene Zahlen, beide Wege)], [$F = 10 "kN"$ unter $phi = 20°$; Richtungen $phi_1 = 60°$, $phi_2 = -40°$.
+ Vektoriell: $F_1 = 10 dot frac(sin (20°+40°), sin (60°+40°)) = 10 dot frac(0","866, 0","985) = 8","79 "kN"$, $F_2 = 10 dot frac(sin (20°-60°), sin (-40°-60°)) = 10 dot frac(-0","643, -0","985) = 6","53 "kN"$.
+ Trigonometrisch: Winkel zu $F$: $alpha = 60°-20° = 40°$ (zu $F_1$), $beta = 20°-(-40°) = 60°$ (zu $F_2$). $F_1 = 10 dot sin 60°/ sin 100° = 8","79 "kN"$, $F_2 = 10 dot sin 40°/ sin 100° = 6","53 "kN"$. ✓
+ Probe x: $8","79 cos 60° + 6","53 cos 40° = 4","40 + 5","00 = 9","40 = 10 cos 20°$. ✓], fill: pale)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Eindeutigkeit:] In der Ebene ist die Zerlegung nach zwei verschiedenen Richtungen eindeutig; das Krafteck kann in zwei Varianten gezeichnet werden, liefert aber dieselben Kräfte. #text(fill: muted)[\[TM1-Buch S. 21\]]
- #strong[Komponente vs. Koordinate:] Streng ist $arrow(F)_x = F_x arrow(e)_x$ die Komponente (ein Vektor) und $F_x$ die Koordinate (eine Zahl mit Vorzeichen). Im Alltag sagt man zu beiden „Komponente“. #text(fill: muted)[\[TM1-Buch S. 22\]]])
#src[Skript TM1 S. 68–71 (Folien 11–16); deine Mitschrift S. 69 (27.10.25); FS TM1 S. 15; TM1-Buch S. 21–23.]
== 2.3 Gleichgewicht (GGW) in der Ebene <a-tm1-2-3>
Ein ruhender Körper bleibt in Ruhe, wenn sich alle Kräfte gegenseitig aufheben. Bei einer zentralen Kräftegruppe heißt das: #strong[Die Resultierende ist der Nullvektor.]
- #strong[Zwei Kräfte] sind im GGW, wenn sie #strong[dieselbe Wirkungslinie] haben und #strong[entgegengesetzt gleich groß] sind.
- #strong[n Kräfte:] Das Krafteck ist #strong[geschlossen] (Ende der letzten Kraft = Anfang der ersten). Reihenfolge egal. Die Kräfte bilden eine #strong[Gleichgewichtsgruppe].
#note([In eigenen Worten], [Ein Lager-Ein- und -Ausgang: Wenn am Ende des Tages genauso viel hinaus- wie hereingekommen ist, ist der Bestand unverändert – die „Bilanz“ ist null. Beim Krafteck läufst du alle Kraftpfeile ab und landest wieder am Startpunkt. #text(fill: muted)[(eigene Ergänzung)]])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k2_ggw_zwei", [Skript TM1 S. 72 (obere Folie 17): GGW zweier Kräfte.], height: 50mm)],
 [#bild("tm1k2_ggw_mehrere", [Skript TM1 S. 72 (untere Folie 18): geschlossenes Krafteck, Reihenfolge egal (grün: andere Reihenfolge).], height: 50mm)])
#heading(level: 3, outlined: false)[Gleichgewichtsbedingungen ★]
#form[$ arrow(F)_R = sum_(i=1)^n arrow(F)_i = arrow(0) quad <==> quad sum_(i=1)^n F_("ix") = 0, wide sum_(i=1)^n F_("iy") = 0 $]
2 lineare Gleichungen → 2 Unbekannte bestimmbar (Skript S. 73, Folie 19; FS TM1 S. 16, Gl. 2.9–2.11).
#tab(columns: 2,
 th([Rechenweg], [Wann sinnvoll?]),
 [grafisch (geschlossenes Krafteck)], [zur Kontrolle, Richtungssinn ablesen; mit Maßstab auch quantitativ],
 [vektoriell $sum F_x = 0, sum F_y = 0$], [immer möglich, Standardweg in der Klausur],
 [Dreieckssätze], [bei $n = 3$ Kräften oft schneller; bei $n > 3$ zu umständlich],
)
#note([Merke – Lösungsschema für jede GGW-Aufgabe], [+ Körper/Knoten #strong[freischneiden], alle Kräfte einzeichnen (bekannte und unbekannte). Unbekannte Stab-/Seilkräfte als #strong[Zug] ansetzen.
+ #strong[Koordinatensystem] wählen (geschickt: eine Achse entlang einer Unbekannten spart Arbeit).
+ Komponenten aufschreiben, $sum F_x = 0$ und $sum F_y = 0$ aufstellen.
+ Gleichungssystem lösen; #strong[Vorzeichen deuten] (negativ = entgegen Ansatzrichtung, beim Stab: Druck).
+ Plausibilität prüfen (Grenzfälle, Krafteck-Skizze).])
#note([Fehler vermeiden], [Ins Freikörperbild gehören nur Kräfte, die #strong[auf] den freigeschnittenen Körper wirken – nicht die Kräfte, die der Körper auf seine Umgebung ausübt. Und: Hat eine zentrale ebene Kräftegruppe mehr als 2 Unbekannte, reichen die 2 GGW-Bedingungen nicht (statisch unbestimmt).], fill: sand)
#note([Beispiel (nach Übung 2, Aufg. 2.3)], [Einer senkrechten Kraft $F = 17 "kN"$ (nach oben) sollen $F_1$ (unter 30° zur Waagrechten nach links unten) und $F_2$ (unter 60° nach rechts unten) das GGW halten.
+ $sum F_x = 0 colon -F_1 cos 30° + F_2 cos 60° = 0 => F_2 = F_1 frac(cos 30°, cos 60°) = 1","732 thin F_1$
+ $sum F_y = 0 colon F - F_1 sin 30° - F_2 sin 60° = 0 => 17 = F_1 (0","5 + 1","732 dot 0","866) = 2","0 thin F_1$
+ $F_1 = 8","5 "kN"$, $F_2 = 14","7 "kN"$ (wie Kurzlösung Übung 2 S. 3). Mit Dreieckssätzen geht es schneller: Die Winkel zwischen $F$ und $F_1$, $F_2$ sind 120° und 150°, im Krafteck also 60° und 30°; da $60°+30° = 90°$: $F_1 = 17 sin 30° = 8","5 "kN"$, $F_2 = 17 sin 60° = 14","7 "kN"$.], fill: pale)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Statisch bestimmt:] Mit den zwei Bedingungen $sum F_("ix") = 0, sum F_("iy") = 0$ lassen sich höchstens zwei Unbekannte (Beträge und/oder Richtungen) bestimmen. Bei mehr Unbekannten ist das Problem statisch unbestimmt. #text(fill: muted)[\[TM1-Buch S. 26\]]
- #strong[Freikörperbild:] Körper durch gedachte Schnitte von seinen Bindungen befreien und alle auf ihn wirkenden Kräfte eintragen; das Koordinatensystem darf beliebig gewählt werden. #text(fill: muted)[\[TM1-Buch S. 26\]]
- #strong[Gleichgewichtsgruppe:] Eine Kräftegruppe, deren Krafteck geschlossen ist (Anfangs- und Endpunkt fallen zusammen). #text(fill: muted)[\[TM1-Buch S. 25\]]])
#src[Skript TM1 S. 72–73 (Folien 17–19); FS TM1 S. 15–16; Übung 2, Aufg. 2.3 und Kurzlösung S. 3; TM1-Buch S. 24–26.]
== 2.4 Beispiele ebener, zentraler Kräftegruppen <a-tm1-2-4>
=== 2.4.1 Einfache Bauteile <a-tm1-2-4-1>
Bevor du rechnen kannst, musst du wissen, #strong[welche Kräfte ein Bauteil überhaupt übertragen kann]. Dafür idealisiert man reale Teile. Die Idealisierung legt fest, in welche Richtung die Schnittkraft zeigt.
#tab(columns: 3,
 th([Bauteil], [Idealisierungen], [Folge für die Kraft]),
 [#strong[Seil]], [Länge ≫ Dicke, „biegeschlaff“; masselos; kein Kraftangriff innerhalb des Seilstücks], [#strong[nur Zug] in Seilrichtung; $F_S$ an beiden Enden entgegengesetzt gleich groß],
 [#strong[Seil über Rolle]], [Seil masselos; Rolle reibungsfrei], [Umlenkung: $F_S$ #strong[betragsmäßig gleich], Richtung folgt dem Seil],
 [#strong[Stab]], [i. A. Länge ≫ Durchmesser (kein „Muss“); masselos; beidseitig gelenkig gelagert; kein Kraft-/Momentenangriff innerhalb der Stablänge], [#strong[Zug oder Druck] in Stablängsrichtung; Stabkraft $S$ an beiden Enden entgegengesetzt gleich groß],
 [#strong[Balken]], [i. A. Länge ≫ Durchmesser; nicht notwendig masselos; beliebige Lagerung; Kraft-/Momentenangriff innerhalb der Balkenlänge], [zentrale #strong[und] nicht zentrale Kräftegruppen möglich],
 [#strong[Starrer Körper]], [beliebige Berandung, sonst wie Balken], [wie Balken],
)
#note([In eigenen Worten], [Ein Seil ist wie eine Kette beim Abschleppen: Ziehen geht, Schieben nicht. Ein Stab ist wie eine Deichsel: Er kann ziehen und schieben, aber nur entlang seiner Achse. #text(fill: muted)[(eigene Ergänzung)]])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k2_seil", [Skript TM1 S. 73 (untere Folie 20): Seil.], height: 50mm)],
 [#bild("tm1k2_rolle", [Skript TM1 S. 74 (obere Folie 21): Seil über Rolle.], height: 50mm)])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k2_stab", [Skript TM1 S. 74 (untere Folie 22): Zugstab und Druckstab.], height: 50mm)],
 [#bild("tm1k2_balken", [Skript TM1 S. 75 (obere Folie 23): Balken – zentral und nicht zentral ($F_B$ von dir korrigiert).], height: 50mm)])
#note([Fehler vermeiden (Hinweis von der Folie, S. 75)], [In manchen Aufgaben werden „Balken“ und „Stab“ nicht richtig benannt – verlass dich nicht auf den Begriff, sondern prüfe die Idealisierungen: gelenkig an beiden Enden #emph[und] keine Last dazwischen → Stab.], fill: sand)
#note([Aus deinen Notizen („Bauteile.pdf“ S. 1–2)], [Du hast einen #strong[gebogenen Zugstab] skizziert: Auch ein krummer Stab überträgt seine Kraft entlang der #strong[Verbindungslinie der beiden Gelenke] (gestrichelt), nicht entlang seiner Form. Zum Balken hast du notiert: zentrale Kräftegruppe → $sum F_x = 0, sum F_y = 0$ (Kap. 2); nicht zentral → zusätzlich $sum M_((A)) = 0$ (Kap. 3).])
#bild("tm1k2_gebogener_stab", [Deine Notiz („Bauteile.pdf“ S. 1): gebogener Zugstab, Kraft entlang der Gelenkverbindung.], height: 45mm)
#note([Fehler in der Kurzlösung (Übung 3, S. 2)], [Bei Aufg. 3.2 steht „$F_S = 3 "N"$“. Richtig ist $F_S = G = 3 "kN"$: Über eine reibungsfreie Rolle bleibt die Seilkraft betragsmäßig gleich (so auch in Lösung Übung 3 S. 2 und in deiner Rechnung).], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Masseloses Seil:] Das Seilgewicht wird vernachlässigt, wenn es klein gegenüber der Seilkraft ist. Über einer reibungsfrei gelagerten Rolle sind die Kräfte an beiden Seilenden gleich. #text(fill: muted)[\[TM1-Buch S. 27\]]
- #strong[Kontaktkraft:] An einer Berührstelle wirkt nach actio = reactio auf beide Körper die Kontaktkraft $K$, zerlegt in Normalkraft $N$ (senkrecht zur Berührungsebene) und Tangentialkraft $T$. Bei bloßer Berührung kann $N$ nur #strong[drücken]\; bei glatter Oberfläche ist $T = 0$. #text(fill: muted)[\[TM1-Buch S. 27–28\]]])
#src[Skript TM1 S. 73–75 (Folien 20–24); deine Notizen „Bauteile.pdf“ S. 1–2; FS TM1 S. 16–17; Lösung Übung 3 S. 2; TM1-Buch S. 27–28.]
=== 2.4.2 Einfache Lager und Gelenke (2D-Ebene) <a-tm1-2-4-2>
- #strong[Lager] ≙ Verbindung zur Umgebung. #strong[Gelenk] ≙ Verbindung zwischen Körpern.
- Jede Bewegung, die ein Lager #strong[verhindert], erzeugt eine #strong[Reaktion]: verhinderte Verschiebung → Reaktionskraft, verhinderte Drehung → Reaktionsmoment.
- #strong[Richtungssinn:] Auf einer Seite des Freischnitts frei wählen; auf der anderen Seite entgegengesetzt gleich groß ansetzen (#strong[Wechselwirkungsgesetz]).
- #strong[Koordinatensystem:] überwiegend x waagerecht, y senkrecht; manchmal ist ein gedrehtes KS vorteilhaft.
- Die Berechnung der Lagerreaktionen kommt in Kap. 5.
#note([In eigenen Worten], [Ein Hotelzimmer-Türstopper (Loslager) verhindert nur eine Richtung. Eine verschraubte Regalhalterung an der Wand (Einspannung) verhindert alles: hoch/runter, links/rechts und das Kippen. #text(fill: muted)[(eigene Ergänzung)]])
#tab(columns: 4,
 th([Lager / Verbindung], [verhindert], [Reaktionen], [Wertigkeit]),
 [#strong[Loslager] (Gleitlager, Pendelstütze, gespanntes Seil)], [Verschiebung senkrecht zur Bewegungsrichtung], [1 Kraft (senkrecht zur Bahn)], [1],
 [#strong[Schiebegelenk]], [relative Verschiebung senkrecht zur Führung], [1 Kraft], [1],
 [#strong[Kontakt ohne Reibung]], [Eindringen], [1 Kraft $N$ ⊥ Berührtangente; Abheben → $N = 0$; Walze/Kugel: $N$ zum Mittelpunkt], [1],
 [#strong[Festlager]], [beide Verschiebungen], [2 Kräfte ($F_x, F_y$, senkrecht aufeinander, nicht zwingend h/v)], [2],
 [#strong[Gelenk]], [relative Verschiebungen], [2 Kräfte $G_x, G_y$, am anderen Körper entgegengesetzt], [2],
 [#strong[Kontakt mit Reibung] (ohne Rutschen/Abheben)], [Eindringen und Gleiten], [$N$ ⊥ und $T$ ∥ zur Berührtangente], [2],
 [#strong[Schiebehülse]], [Verschiebung quer + Drehung], [1 Kraft + 1 Moment], [2],
 [#strong[Starre Einspannung]], [alles], [2 Kräfte + 1 Moment], [3],
 [#strong[Starre Verbindung]], [alle Relativbewegungen], [2 Kräfte + 1 Moment], [3],
)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k2_lager1", [Skript TM1 S. 76 (untere Folie 26): Festlager, Gelenk, Kontakt mit Reibung.], height: 50mm)],
 [#bild("tm1k2_lager2", [Skript TM1 S. 77 (obere Folie 27): Loslager, Schiebegelenk, Kontakt ohne Reibung.], height: 50mm)])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k2_lager3", [Skript TM1 S. 77 (untere Folie 28): Schiebehülse, starre Einspannung, starre Verbindung.], height: 50mm)],
 [#bild("tm1k2_skolaut2", [Skript TM1 S. 78 (untere Folie 30, nach Skolaut): Festlager (Schlagbaum), Hülse, Einspannung (Ampel). Folie 29 zeigt Loslager (Tretroller), Pendelstütze (Kipper-Zylinder), Seil.], height: 50mm)])
#note([Aus deinen Notizen („Bauteile.pdf“ S. 3) – Beispiel Gerberbalken], [Festlager A (keine Verschiebung möglich, Drehung möglich), Loslager B und C (horizontal verschieblich, Drehung möglich), Gelenk G (keine Relativverschiebung, Drehung möglich). Beim Freischnitt am Gelenk: $G_x, G_y$ am linken Teil, am rechten Teil entgegengesetzt.])
#bild("tm1k2_gerberbalken", [Deine Notizen („Bauteile.pdf“ S. 3): Gerberbalken, Bewegungsmöglichkeiten je Lager und dein roter Kasten „Prüfung“.], height: 45mm)
#note([Von dir markiert „Prüfung“ ★ („Bauteile.pdf“ S. 3)], [„Mehrteiliges Fachwerk mit Gelenk“. Das heißt: Lager- und Gelenkreaktionen sicher freischneiden können – die Grundlage dafür ist diese Tabelle.], fill: sand)
#note([Fehler vermeiden], [Am Gelenk die Kräfte auf beiden Teilen #strong[gleich benennen], aber #strong[entgegengesetzt] einzeichnen. Wer sie auf beiden Seiten gleich herum zeichnet, verletzt actio = reactio und bekommt falsche Vorzeichen.], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Wertigkeit:] Einwertige Lager (Loslager, Pendelstütze) übertragen eine Reaktion ($r = 1$), zweiwertige (Festlager, Parallelführung, Schiebehülse) zwei, die Einspannung ist dreiwertig ($r = 3$). #text(fill: muted)[\[TM1-Buch S. 114–116\]]])
#src[Skript TM1 S. 76–78 (Folien 25–30); deine Notizen „Bauteile.pdf“ S. 3; FS TM1 S. 17–19; TM1-Buch S. 114–116.]
=== 2.4.3 Einfache Systeme <a-tm1-2-4-3>
Jetzt werden Bauteile und Lager kombiniert. Du schneidest jeweils den Punkt (Knoten, Walze, Gelenk) frei, an dem sich alle Kräfte treffen – dann hast du wieder eine zentrale Kräftegruppe.
#tab(columns: 2,
 th([System], [Freischnitt / Besonderheit]),
 [1 #strong[Zweischlag]: 2 gelenkig verbundene Stäbe, 2 Festlager], [Gelenk G freischneiden: $F$, $S_1$, $S_2$ in Stabrichtung. Auf die Umgebung (Lager A, B) wirken die Stabkräfte entgegengesetzt.],
 [2 #strong[Rolle mit Seil auf schiefer Ebene] (reibungsfrei)], [$G$, Seilkraft $F$, Normalkraft $N$ senkrecht zur Ebene durch den Mittelpunkt.],
 [3 #strong[Seil mit 3 Kräften]], [Knoten freischneiden: $F_1, F_2, F_3$ zentral.],
 [4 #strong[Walze zwischen 2 schiefen Ebenen] (reibungsfrei)], [$N_1, N_2$ senkrecht zu den Ebenen, #strong[Wirkungslinie durch den Rollenmittelpunkt]. Neigt sich eine Ebene um $alpha$, ist ihre Normale um $alpha$ gegen die Senkrechte geneigt.],
 [5 #strong[Balken mit schrägem Lager]], [#strong[Dreikraftsystem] (siehe unten).],
)
#note([In eigenen Worten], [Eine Getränkedose, die in einer V-förmigen Rinne liegt, wird von beiden Wänden „zum Mittelpunkt hin“ gedrückt – egal, wo genau sie die Wand berührt. #text(fill: muted)[(eigene Ergänzung)]])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k2_sys_zweischlag_rolle", [Skript TM1 S. 79 (obere Folie 31): Zweischlag; Rolle mit Seil auf schiefer Ebene.], height: 50mm)],
 [#bild("tm1k2_sys_seil_walze", [Skript TM1 S. 79 (untere Folie 32): Seil mit 3 Kräften; Walze zwischen 2 schiefen Ebenen mit Winkelbetrachtung.], height: 50mm)])
#heading(level: 3, outlined: false)[Dreikraftsystem ★]
#note([Merke], [Wirken auf einen Körper #strong[drei Kräfte, von denen zwei nicht parallel sind], dann muss die Wirkungslinie der 3. Kraft durch den #strong[Schnittpunkt] der beiden anderen Wirkungslinien gehen. So wird aus dem Balken wieder eine zentrale Kräftegruppe, und du kennst die Richtung der unbekannten Lagerkraft. Bei 3 parallelen Kräften braucht man einen „Trick“ (Kap. 3).])
#bild("tm1k2_dreikraft", [Skript TM1 S. 80 (obere Folie 33): Balken mit schrägem Lager; rot deine Notiz „gemeinsamer Schnittpunkt“.], height: 45mm)
#note([Aus deiner Mitschrift (Skript S. 80)], [Zur Wirkungslinie von $F_A$: „muss diese WL sein, da sonst nicht im GG.“ Die Richtung von $F_B$ ist durch das schräge Loslager festgelegt (⊥ zur Gleitbahn), die von $F$ ist gegeben → ihr Schnittpunkt legt $W L_(F_A)$ fest.])
#note([Beispiel (Walze zwischen zwei Ebenen, eigene Zahlen)], [$G = 1 "kN"$, linke Ebene $alpha = 30°$, rechte Ebene $beta = 45°$.
+ $N_1$ zeigt um $alpha$ gegen die Senkrechte nach rechts oben, $N_2$ um $beta$ nach links oben.
+ $sum F_x = 0 colon N_1 sin alpha - N_2 sin beta = 0$; $sum F_y = 0 colon N_1 cos alpha + N_2 cos beta - G = 0$.
+ Lösung (Additionstheorem): $N_1 = G frac(sin beta, sin ( alpha + beta )) = frac(0","707, 0","966) = 0","732 "kN"$, $N_2 = G frac(sin alpha, sin ( alpha + beta )) = 0","518 "kN"$.
+ Probe: $0","732 dot 0","866 + 0","518 dot 0","707 = 0","634 + 0","366 = 1","000 "kN"$. ✓ Die flachere Ebene trägt mehr.], fill: pale)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Drei nichtparallele Kräfte] können nur dann im Gleichgewicht sein, wenn ihre Wirkungslinien durch einen Punkt gehen – sonst bliebe ein Moment übrig. #text(fill: muted)[\[TM1-Buch S. 63\]]])
#src[Skript TM1 S. 79–80 (Folien 31–33); deine Mitschrift S. 80; Übung 4, Aufg. 4.5 (Dreikraftsystem); TM1-Buch S. 63.]
=== 2.4.4 Rechenbeispiele <a-tm1-2-4-4>
Die sechs Beispiele zeigen immer denselben Ablauf: #strong[freischneiden → grafisch skizzieren → mit Dreieckssätzen oder $sum F_x = 0, sum F_y = 0$ rechnen]. Der Dozent rechnet jedes Beispiel auf mehreren Wegen, damit du siehst: gleiches Ergebnis, unterschiedlicher Aufwand.
#note([In eigenen Worten], [Wie bei einer Navigations-App: Es gibt die Fußgänger-Route (grafisch, anschaulich), die Autobahn (Dreieckssätze, schnell, aber nur bei wenigen Kräften) und die Landstraße (vektoriell, immer befahrbar, manchmal lang). #text(fill: muted)[(eigene Ergänzung)]])
#heading(level: 4, outlined: false)[Beispiel 1: Öse an fester Wand]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k2_bsp1_oese", [Skript TM1 S. 80 (untere Folie 34): Öse; grafische Lösung mit deiner Notiz „2× Z-Winkel“.], height: 50mm)],
 [#bild("tm1k2_bsp1_vektoriell", [Skript TM1 S. 81 (obere Folie 35): Cosinussatz und vektorielle Lösung mit $H_x, H_y$.], height: 50mm)])
Geg.: $F_1, F_2, alpha, beta$ (Winkel der Seile gegen die senkrechte Wand). Ges.: Kraft $H$ der Wand auf die Öse.
#form[$ "Cosinussatz: " H = sqrt(F_1^2 + F_2^2 - 2F_1 F_2 cos ( alpha + beta )) $


$ sum F_x = 0 colon -H_x + F_1 sin alpha + F_2 sin beta = 0, wide sum F_y = 0 colon H_y - F_1 cos alpha + F_2 cos beta = 0 $


$ H_x = F_1 sin alpha + F_2 sin beta, wide H_y = F_1 cos alpha - F_2 cos beta $]
Folie empfiehlt $H_x, H_y$ statt $H, gamma$ als Unbekannte → sofort „fertige Lösung“ (Skript S. 81).
Folie 36 zeigt: $H^2 = H_x^2 + H_y^2$ ausmultipliziert ergibt mit $sin^2 + cos^2 = 1$ und dem Additionstheorem wieder den Cosinussatz – gleiches Ergebnis, längerer Weg.
#note([Aus deiner Mitschrift (Skript S. 81, markiert „= Add.-theorem“)], [Du hast dir die Additionstheoreme notiert:
$sin alpha cos beta plus.minus cos alpha sin beta = sin ( alpha plus.minus beta )$, $cos alpha cos beta minus.plus sin alpha sin beta = cos ( alpha plus.minus beta )$. Also: $sin alpha sin beta - cos alpha cos beta = - cos ( alpha + beta )$.])
#note([Fehler auf der Folie (Skript S. 81, Folie 36)], [In der vierten Zeile steht „$+F_2 ( sin^2 beta + cos^2 beta )$“. Richtig ist $F_2^(thin 2)( sin^2 beta + cos^2 beta )$ – das Quadrat fehlt. Das Endergebnis stimmt.], fill: sand)
#note([Zahlenbeispiel (eigene Ergänzung)], [$F_1 = 2 "kN"$, $F_2 = 3 "kN"$, $alpha = 30°$, $beta = 45°$.
+ $H = sqrt(4 + 9 - 12 cos 75°) = sqrt(13 - 3","106) = 3","15 "kN"$.
+ $H_x = 2 dot 0","5 + 3 dot 0","707 = 3","12 "kN"$; $H_y = 2 dot 0","866 - 3 dot 0","707 = -0","39 "kN"$.
+ Probe: $sqrt(3","12^2 + 0","39^2) = 3","15 "kN"$. ✓ $H_y < 0$: Die Wand drückt die Öse leicht nach #strong[unten], nicht wie angesetzt nach oben (Winkel $gamma = arctan (0","39/3","12) = 7","1°$ unter der Waagrechten).], fill: pale)
#heading(level: 4, outlined: false)[Beispiel 2: Walze mit Seil auf schiefer Ebene]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k2_bsp2_walze", [Skript TM1 S. 82 (obere Folie 37): Walze, Freischnitt und Krafteck mit Winkeln.], height: 50mm)],
 [#bild("tm1k2_bsp2_rechnung", [Skript TM1 S. 82 (untere Folie 38): Sinussatz und vektorieller Ansatz.], height: 50mm)])
Geg.: $G, alpha$ (Neigung der Ebene), $beta$ (Seil gegen die Waagrechte); der Durchmesser hat keinen Einfluss. Ges.: $F_S, N$. Im Krafteck liegen gegenüber: $G$ ↔ $90°- alpha + beta$, $N$ ↔ $90°- beta$, $F_S$ ↔ $alpha$.
#form[$ F_S = G dot frac(sin alpha, cos ( alpha - beta )), wide N = G dot frac(cos beta, cos ( alpha - beta )) $


$ sum F_x = 0 colon -N sin alpha + F_S cos beta = 0, wide sum F_y = 0 colon -G + N cos alpha + F_S sin beta = 0 $]
Mit $sin (90°- alpha + beta ) = cos ( alpha - beta )$ und $cos alpha cos beta + sin alpha sin beta = cos ( alpha - beta )$ (Skript S. 82–83).
#note([Fehler auf der Folie (Skript S. 82, Folie 38)], [Im Sinussatz steht „$frac(N, 90- beta)$“. Richtig ist $frac(N, sin (90°- beta )) = frac(N, cos beta)$ – das „sin“ fehlt. Das Ergebnis $N = G cos beta / cos ( alpha - beta )$ stimmt (auch im TM1-Buch S. 30).], fill: sand)
#note([Zahlenbeispiel und Plausibilität (eigene Ergänzung)], [$G = 2 "kN"$, $alpha = 30°$, $beta = 10°$: $F_S = 2 dot 0","5/ cos 20° = 1","06 "kN"$, $N = 2 dot 0","985/0","940 = 2","10 "kN"$.
Grenzfälle: Seil parallel zur Ebene ($beta = alpha$) → $F_S = G sin alpha$, $N = G cos alpha$ (bekannter Hangabtrieb). Seil waagrecht ($beta = 0$) → $F_S = G tan alpha$, $N = G/ cos alpha$.], fill: pale)
#heading(level: 4, outlined: false)[Beispiel 3: Drei Gewichte am Seil]
#bild("tm1k2_bsp3_gewichte", [Skript TM1 S. 83 (untere Folie 40): drei Gewichte, zwei reibungsfreie Rollen; grafische Lösung als Schnittpunkt zweier Kreise.], height: 45mm)
Geg.: $G_1, G_2, G_3$. Ges.: Winkel $alpha_1, alpha_2$. Über die Rollen bleiben die Seilkräfte $G_1$ und $G_2$ erhalten.
#form[$ sum F_x = 0 colon -G_1 cos alpha_1 + G_2 cos alpha_2 = 0, wide sum F_y = 0 colon G_1 sin alpha_1 + G_2 sin alpha_2 - G_3 = 0 $


$ sin alpha_1 = frac(G_1^2 + G_3^2 - G_2^2, 2G_1 G_3), wide sin alpha_2 = frac(G_2^2 + G_3^2 - G_1^2, 2G_2 G_3) $]
Cosinussatz: die Seite wählen, bei der nur $alpha_1$ bzw. $alpha_2$ vorkommt; $cos (90°- alpha ) = sin alpha$ (Skript S. 84–85).
#note([Merke – „Trickkiste“ bei Winkel-Unbekannten ★], [Gleichungen so umstellen, dass auf einer Seite nur $G_1 cos alpha_1$ bzw. $G_1 sin alpha_1$ steht, beide #strong[quadrieren und addieren]. Wegen $cos^2 alpha_1 + sin^2 alpha_1 = 1$ fällt $alpha_1$ heraus und es bleibt eine Gleichung für $alpha_2$. Diesen Trick braucht auch Beispiel 6.])
#note([Fehler auf der Folie (Skript S. 84, Folie 42)], [„Aus $sum F_x = 0 -> cos alpha_1 = G_2 cos alpha_2$“ – links fehlt $G_1$. Richtig: $G_1 cos alpha_1 = G_2 cos alpha_2$. In der nächsten Zeile (Quadrate) steht es richtig.], fill: sand)
#note([Zahlenbeispiel (eigene Ergänzung)], [$G_1 = 30 "N"$, $G_2 = 40 "N"$, $G_3 = 50 "N"$.
$sin alpha_1 = frac(900 + 2500 - 1600, 2 dot 30 dot 50) = 0","6$ → $alpha_1 = 36","9°$; $sin alpha_2 = frac(1600 + 2500 - 900, 2 dot 40 dot 50) = 0","8$ → $alpha_2 = 53","1°$.
Probe: $-30 dot 0","8 + 40 dot 0","6 = 0$ ✓; $30 dot 0","6 + 40 dot 0","8 - 50 = 0$ ✓.
#strong[Hinweis (Folie 43):] Nicht jede Kombination $G_1, G_2, G_3$ ist physikalisch möglich – z. B. bei $G_3 > G_1 + G_2$ wird $sin alpha > 1$.], fill: pale)
#heading(level: 4, outlined: false)[Beispiel 4: „Zweischlag“ mit Gewicht]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k2_bsp4_zweischlag", [Skript TM1 S. 85 (untere Folie 44): Zweischlag, Krafteck ($S_1$ Zug, $S_2$ Druck).], height: 50mm)],
 [#bild("tm1k2_bsp4_vektoriell", [Skript TM1 S. 86 (untere Folie 46): vektoriell mit Zug als Ansatzrichtung.], height: 50mm)])
#form[$ S_1 = G dot frac(sin alpha_2, sin ( alpha_1 + alpha_2 )) ( "Zug" ), wide S_2 = -G dot frac(sin alpha_1, sin ( alpha_1 + alpha_2 )) ( "Druck" ) $]
Mit $sin (180°-( alpha_1 + alpha_2 )) = sin ( alpha_1 + alpha_2 )$ (Skript S. 86).
#note([Merke ★], [Bei den Dreieckssätzen musst du den Richtungssinn aus der grafischen Lösung ablesen. Setzt du dagegen alle Stabkräfte als #strong[Zug] an, „ergibt sich der Richtungssinn automatisch“: $S > 0$ → Zug, $S < 0$ → Druck (entgegen Ansatzrichtung).])
#note([Zahlenbeispiel (eigene Ergänzung)], [$G = 10 "kN"$, $alpha_1 = 30°$, $alpha_2 = 60°$ → $sin 90° = 1$: $S_1 = 10 sin 60° = 8","66 "kN"$ (Zug), $S_2 = -10 sin 30° = -5","00 "kN"$ (Druck). Probe y: $8","66 dot 0","866 - (-5) dot 0","5 - 10 = 7","5 + 2","5 - 10 = 0$. ✓], fill: pale)
#heading(level: 4, outlined: false)[Beispiel 5: Sieben Seile an einem festen Punkt A]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k2_bsp5_seile", [Skript TM1 S. 87 (obere Folie 47): sieben Seile, $S_1$ bis $S_5$ gegeben, $S_6, S_7$ gesucht.], height: 50mm)],
 [#bild("tm1k2_bsp6_windkanal", [Skript TM1 S. 87 (untere Folie 48): Beispiel 6, Kugel im Windkanal.], height: 50mm)])
Winkel von der positiven x-Achse aus (aus der Abbildung, wie in deiner Mitschrift S. 88): $alpha_1 = 255°$, $alpha_2 = 315°$, $alpha_3 = 0°$, $alpha_4 = 30°$, $alpha_5 = 90°$, $alpha_6 = 150°$, $alpha_7 = 210°$.
#tab(columns: 5,
 th([Seil], [$S_i$ \[N\]], [$alpha_i$], [$S_i cos alpha_i$ \[N\]], [$S_i sin alpha_i$ \[N\]]),
 [1], [2], [255°], [−0,52], [−1,93],
 [2], [1], [315°], [0,71], [−0,71],
 [3], [4], [0°], [4,00], [0],
 [4], [3], [30°], [2,60], [1,50],
 [5], [2], [90°], [0], [2,00],
 [#strong[Summe 1–5]], [#strong[6,79]], [#strong[0,86]],
)
+ $sum F_x = 0 colon 6","79 + S_6 cos 150° + S_7 cos 210° = 0$. Da $cos 150° = cos 210° = -0","866$: $S_6 + S_7 = 6","79/0","866 = 7","84 "N"$.
+ $sum F_y = 0 colon 0","86 + S_6 sin 150° + S_7 sin 210° = 0$. Da $sin 150° = 0","5$, $sin 210° = -0","5$: $S_6 - S_7 = -1","72 "N"$.
+ Addieren: $2S_6 = 6","12$ → #strong[$S_6 = 3","06 "N"$]\; #strong[$S_7 = 4","78 "N"$]. Beide positiv → beide Seile auf Zug, wie es bei Seilen sein muss.
#note([Aus deiner Mitschrift (Skript S. 88–89)], [Gleicher Weg, deine Komponenten-Tabelle und deine Ergebnisse $S_6 = 3","06 "N"$, $S_7 = 4","78 "N"$ stimmen. #emph[Kleiner Zahlendreher:] Oben rechts auf S. 88 steht „$S_6 = 3","085 "N"$“ – genau gerechnet ist $S_6 = 3","058 "N"$ (≈ 3,06 N wie in deiner Rechnung auf S. 89).])
#heading(level: 4, outlined: false)[Beispiel 6: Kugel im Windkanal]
Geg.: Drahtkraft $D = 45 "N"$, Federkraft $F = 30 "N"$, Gewicht $G = 50 "N"$, Windkraft $W = 30 "N"$ (nach rechts). Ges.: Winkel $alpha$ (Draht) und $beta$ (Feder), beide gegen die Decke gemessen. Diesmal sind #strong[zwei Winkel] unbekannt, nicht zwei Kräfte.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k2_bsp6_tafel", [Deine Mitschrift (Skript TM1 S. 92, 30.10.25): Skizze und Freischnitt der Kugel.], height: 50mm)],
 [#bild("tm1k2_bsp6_foto", [Dein Foto der Tafel (Skript TM1 S. 94): grafische Lösung, abgelesen $alpha approx 29°$, $beta approx 71°$; zweite Lösung „physikalisch nicht sinnvoll, da oberhalb …“ (Rest verdeckt).], height: 50mm)])
#strong[Weg 1 – vektoriell mit Trick (Tafel, 30.10.25):]
#form[$ "(1)" W - D cos alpha + F cos beta = 0, wide "(2)" D sin alpha - G + F sin beta = 0 $


$ (D cos alpha )^2 + (D sin alpha )^2 = (W + F cos beta )^2 + (G - F sin beta )^2 med => med D^2 = W^2 + G^2 + F^2 + 2F(W cos beta - G sin beta ) $


$ K = frac(D^2 - (W^2 +G^2 +F^2 ), 2F) = frac(2025 - 4300, 60) = -37","92 "N" = W cos beta - G sin beta $]
„Trick bei Winkelsuche!“ (rot an der Tafel): quadrieren und addieren eliminiert $alpha$.
+ Mit $x = sin beta$, $cos beta = sqrt(1-x^2)$: $K + G x = W sqrt(1-x^2)$ quadrieren → $(G^2 +W^2 )x^2 + 2K G x + (K^2 - W^2 ) = 0$, also $3400x^2 - 3791","7x + 537","7 = 0$.
+ Mitternachtsformel: $x_1 = 0","948$ → #strong[$beta = 71","5°$]\; aus (1), (2): #strong[$alpha = 28","6°$].
+ $x_2 = 0","167$ → $beta = 9","6°$ erfüllt die Gleichungen nicht (Scheinlösung durchs Quadrieren); $beta = 170","4°$ mit $alpha = 89","5°$ erfüllt sie, ist aber laut Tafel „physikalisch nicht sinnvoll“: Die Feder würde nach links oben ziehen, also auf die Drahtseite – das passt nicht zur Aufhängung in der Skizze.
#strong[Weg 2 – Dreieckssätze (deine Mitschrift S. 90–91):] $W$ und $G$ zu $R = sqrt(30^2 +50^2) = 58","31 "N"$ zusammenfassen, $gamma = arctan (50/30) = 59","04°$. Im Dreieck $D, F, R$: Winkel zwischen $D$ und $F$ ist $x = alpha + beta = arccos frac(D^2 +F^2 -R^2, 2D F) = 100","13°$; Sinussatz $y = arcsin ( sin x dot frac(D, R) ) = 49","44°$; $beta = 180° - gamma - y = 71","53°$; $alpha = x - beta = 28","60°$.
#note([Fehler vermeiden – Rechenfehler in deiner Mitschrift (Skript S. 91)], [Dort steht „$alpha = 100","13 - 71","53 = 25","61°$“. Richtig ist $100","13° - 71","53° = 28","60°$. Das passt zur vektoriellen Lösung ($alpha_1 = 28","607°$, S. 93) und zur Tafel (≈ 29°). Probe: $30 - 45 cos 28","6° + 30 cos 71","5° = 30 - 39","5 + 9","5 = 0$ ✓.], fill: sand)
#note([Fehler vermeiden], [Beim Sinussatz für einen Winkel gibt es zwei Kandidaten ($y$ und $180°-y$), beim Quadrieren entstehen Scheinlösungen. Darum #strong[jede Lösung in die Ausgangsgleichungen einsetzen] und an der Skizze prüfen.], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Öse (Beispiel 2.4):] Das Buch nimmt $H$ und den Winkel $gamma$ als Unbekannte und kommt durch Quadrieren und Addieren auf den Cosinussatz. Die Folie nimmt $H_x, H_y$ – das ist kürzer. Beides richtig. #text(fill: muted)[\[TM1-Buch S. 28–29\]]
- #strong[Walze (Beispiel 2.5):] gleiche Ergebnisse $S = G sin alpha / cos ( alpha - beta )$, $N = G cos beta / cos ( alpha - beta )$; die Wahl von x, y ist frei, eine geschickte Wahl spart Rechenarbeit. #text(fill: muted)[\[TM1-Buch S. 29–30\]]
- #strong[Drei Gewichte (Beispiel 2.6):] Eine physikalisch sinnvolle Lösung existiert nur für $0 < alpha_1, alpha_2 < pi /2$; beide Zähler müssen größer als null und kleiner als die Nenner sein. Kurzschreibweise „→ :“ und „↑ :“ für $sum F_x = 0$, $sum F_y = 0$. #text(fill: muted)[\[TM1-Buch S. 30–31\]]
- #strong[Stabzweischlag (Beispiel 2.7):] Konvention: Stabkräfte immer als Zugkräfte positiv ansetzen; ein Minus im Ergebnis bedeutet Druckstab. Die Kräfte auf die Stäbe sind nach actio = reactio entgegengesetzt zu denen auf das Gelenk. #text(fill: muted)[\[TM1-Buch S. 32–33\]]])
#src[Skript TM1 S. 80–87 (Folien 34–48); deine Mitschrift S. 81, 88–94 (Beispiel 6 vom 30.10.25); Übung 3, Aufg. 3.3 (ähnlich Beispiel 3); TM1-Buch S. 28–33.]
== 2.5 Zentrale Kräftegruppen im Raum <a-tm1-2-5>
#note([Von dir notiert (Skript S. 61)], [„nicht Prüfungsrelevant“ – Abschnitt 5 ist in der Gliederung durchgestrichen. Die Folien 49–50 (Skript S. 95) sind leer. Übung 4.4 (räumlich) hast du ebenfalls durchgestrichen. Darum hier nur das Nötigste aus der Formelsammlung zum Wiedererkennen.], fill: sand)
Im Raum kommt die z-Richtung dazu. Alles funktioniert wie in der Ebene, nur mit drei Komponenten und drei Gleichgewichtsbedingungen → #strong[3 Unbekannte] bestimmbar.
#form[$ F = sqrt(F_x^2 + F_y^2 + F_z^2), wide cos alpha = frac(F_x, F), cos beta = frac(F_y, F), cos gamma = frac(F_z, F), wide cos^2 alpha + cos^2 beta + cos^2 gamma = 1 $


$ "GGW: " sum F_("ix") = 0, quad sum F_("iy") = 0, quad sum F_("iz") = 0 $]
Richtungskosinus und GGW im Raum (FS TM1 S. 19–20, Gl. 2.12–2.20). Nur zwei Richtungskosinus sind frei wählbar.
#note([In eigenen Worten], [Ein Zeltmast mit drei Abspannleinen: Jede Leine zieht in x, y und z – erst wenn alle drei Summen null sind, steht der Mast. #text(fill: muted)[(eigene Ergänzung)]])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Aufhängung in einer Raumecke (Beispiel 2.8):] Seil 3 zur Ecke B (Abstände $a, b, c$), Stäbe 1 und 2 horizontal: $S_3 = G sqrt(a^2 +b^2 +c^2) /c$ (Zug), $S_1 = -G a/c$, $S_2 = -G b/c$ (Druck). Einheitsvektor $arrow(e)_("AB") = arrow(r)_("AB")/| arrow(r)_("AB")|$ gibt die Seilrichtung. #text(fill: muted)[\[TM1-Buch S. 36–38\]] – Zahlen (eigene Ergänzung): $a = b = 1 "m"$, $c = 2 "m"$, $G = 600 "N"$ → $S_3 = 735 "N"$, $S_1 = S_2 = -300 "N"$.
- #strong[Zusammenfassung des Kapitels:] Bei einer zentralen Kräftegruppe schneiden sich alle Wirkungslinien in einem Punkt; das KS kann beliebig, sollte aber zweckmäßig gewählt werden. #text(fill: muted)[\[TM1-Buch S. 41\]]])
#src[Skript TM1 S. 61, 95 (Folien 2, 49–50, leer); FS TM1 S. 19–20; TM1-Buch S. 33–41.]
#grid(columns: 2, gutter: 5mm,
 [#bild("map-t1k2a", [Mindmap: Resultierende und Zerlegung. Eigene Darstellung nach Skript TM1 S. 62–70.], height: 44mm)],
 [#bild("map-t1k2b", [Mindmap: Gleichgewicht am Punkt. Eigene Darstellung nach Skript TM1 S. 71–92.], height: 44mm)])

*Der Zusammenhang in Kapitel 2.* Treffen sich alle Wirkungslinien in einem Punkt, kann nichts drehen. Dann ersetzt eine einzige Resultierende alle Kräfte, und Gleichgewicht heißt nur noch: Krafteck geschlossen, $sum F_x = 0$ und $sum F_y = 0$. Damit bestimmst du zwei Unbekannte. Welche Richtung eine unbekannte Kraft hat, sagt dir die Idealisierung: Seil zieht, Stab zieht oder drückt in Stabrichtung, glatter Kontakt drückt senkrecht zur Berührfläche, Lager liefern je nach Typ eine bis drei Reaktionen. Drei nichtparallele Kräfte im Gleichgewicht schneiden sich in einem Punkt; so wird auch ein Balken mit schrägem Lager zur zentralen Kräftegruppe.

#pagebreak()
== Verständnisfragen und Rechenaufgaben · Kapitel 2
#set enum(spacing: 0.85em)
Erkläre erst selbst. Bei Rechenaufgaben zuerst ein Freikörperbild und eine Skizze des Kraftecks. Die Lösungen folgen getrennt.

+ Was ist eine zentrale Kräftegruppe? Müssen die Kräfte wirklich in einem Punkt angreifen?
+ Was ist der Unterschied zwischen Lageplan und Krafteck? Warum ist die Reihenfolge im Krafteck beliebig?
+ Wann nimmst du den vektoriellen Weg, wann die Dreieckssätze?
+ Du berechnest $phi_R = arctan(F_"Ry" \/ F_"Rx")$, und $F_"Rx"$ ist negativ. Was musst du tun?
+ Warum ist die Zerlegung einer Kraft nach zwei Richtungen eindeutig, nach drei aber nicht?
+ Welche zwei Bedingungen müssen zwei Kräfte erfüllen, um im Gleichgewicht zu sein?
+ Wie viele Unbekannte kannst du bei einer ebenen zentralen Kräftegruppe bestimmen? Wie heißt ein Problem mit mehr Unbekannten?
+ Nenne die Idealisierungen eines Stabes. Welche Kräfte kann er übertragen, welche ein Seil?
+ Was ändert eine reibungsfreie Rolle an der Seilkraft, was nicht?
+ Welche Reaktionen haben Festlager, Loslager und starre Einspannung? Begründe über die verhinderten Bewegungen.
+ Was besagt das Dreikraftsystem, und wozu nutzt du es beim Balken mit schrägem Lager?
+ Warum setzt man unbekannte Stabkräfte als Zug an? Was bedeutet ein negatives Ergebnis?
+ Erkläre den „Trick“ bei zwei unbekannten Winkeln (Beispiele 3 und 6). Warum musst du die Lösungen danach prüfen?
+ Drei Kräfte greifen an einem Punkt an: $F_1 = 5 "kN"$ (0°), $F_2 = 8 "kN"$ (90°), $F_3 = 6 "kN"$ (225°). Bestimme $F_R$ und $phi_R$. #text(fill: muted)[(eigene Aufgabe)]
+ Zwei Kräfte $F_1 = 4 "kN"$ und $F_2 = 7 "kN"$ schließen den Winkel 50° ein. Berechne $F_R$ mit dem Cosinussatz und den Winkel zwischen $F_R$ und $F_2$. #text(fill: muted)[(eigene Aufgabe)]
+ Eine Last $G = 12 "kN"$ hängt an zwei Seilen, die 40° bzw. 25° gegen die Senkrechte geneigt sind. Wie groß sind die Seilkräfte? #text(fill: muted)[(eigene Aufgabe)]
+ Eine Walze ($G = 5 "kN"$) liegt auf einer glatten schiefen Ebene ($alpha = 25°$) und wird von einem *waagerechten* Seil gehalten. Berechne $F_S$ und $N$. #text(fill: muted)[(eigene Aufgabe)]
+ Zweischlag an einer Wand: $G = 8 "kN"$, $alpha_1 = 45°$, $alpha_2 = 30°$ (Bezeichnungen wie Beispiel 4). Berechne $S_1$, $S_2$ und gib Zug oder Druck an. #text(fill: muted)[(eigene Aufgabe)]
+ Drei Gewichte am Seil wie in Beispiel 3: $G_1 = G_2 = 50 "N"$, $G_3 = 60 "N"$. Welche Winkel stellen sich ein? #text(fill: muted)[(eigene Aufgabe)]

#heading(level: 3, outlined: false)[Vertiefende Verständnisfragen und Rechenaufgaben]
#block[
#set enum(start: 20)
+ *Übung 2, Aufg. 2.1:* Ein Waggon wird mit $F = "1,1" "kN"$ über zwei Seile gezogen (40° und 25° zur Zugrichtung). Es soll keine Seitenkraft auftreten. Wie groß sind $F_1$ und $F_2$?
  #bild("tm1k2_ue21", [Übung 2 (Aufgabenblatt S. 1): Skizze zu Aufgabe 2.1.], height: 26mm)
+ *Übung 2, Aufg. 2.2:* Ein Telefonmast wird von vier waagerechten Drähten belastet: $F_1 = 400 "N"$, $F_2 = 500 "N"$, $F_3 = 350 "N"$, $F_4 = 450 "N"$ (Winkel nach Skizze). Gesucht: Betrag der Resultierenden, Winkel ihrer Wirkungslinie zu $F_3$, Richtungssinn.
  #bild("tm1k2_ue22", [Übung 2 (Aufgabenblatt S. 1): Skizze zu Aufgabe 2.2.], height: 34mm)
+ *Übung 2, Aufg. 2.3:* Einer senkrechten Kraft $F = 17 "kN"$ sollen $F_1$ und $F_2$ unter $alpha_1 = 30°$ und $alpha_2 = 60°$ zur Waagerechten das Gleichgewicht halten. Wie groß sind $F_1$ und $F_2$?
  #bild("tm1k2_ue23", [Übung 2 (Aufgabenblatt S. 1): Skizze zu Aufgabe 2.3.], height: 32mm)
+ *Übung 2, Aufg. 2.4:* Bestimme für die fünf Kräftesysteme die x- und y-Komponente der Resultierenden sowie $F_R$ nach Größe und Richtung.
  #bild("tm1k2_ue24", [Übung 2 (Aufgabenblatt S. 2): die fünf Kräftesysteme Abb. 2.4.1 bis 2.4.5.], height: 80mm)
+ *Übung 3, Aufg. 3.1:* Eine Kugel ($r = 20 "cm"$, $m = 15 "kg"$) hängt an einem Seil ($a = 60 "cm"$) an einer glatten Wand; das Seil ist im Kugelmittelpunkt befestigt. Gesucht: Seilkraft $F_S$ und Normalkraft $F_N$ der Wand.
  #bild("tm1k2_ue31", [Übung 3 (Aufgabenblatt S. 1): Skizze zu Aufgabe 3.1 mit deinen Markierungen.], height: 32mm)
+ *Übung 3, Aufg. 3.2:* Anordnung mit masseloser, reibungsfreier Rolle an einer Pendelstange, $G = 3 "kN"$, $beta = 80°$. Gesucht: Spannkraft $F_S$, Kraft auf die Stange zur Deckenhalterung, Winkel $alpha$ der Pendelstange.
  #bild("tm1k2_ue32", [Übung 3 (Aufgabenblatt S. 1): Skizze zu Aufgabe 3.2.], height: 32mm)
+ *Übung 3, Aufg. 3.3:* Drei Körper hängen nach Skizze im Gleichgewicht, $alpha = 25°$, $beta = 80°$, $G_1 = 30 "N"$. a) Stelle die Gleichgewichtsbedingungen für $G_2$ und $G_3$ auf. b) Berechne $G_2$ und $G_3$.
  #bild("tm1k2_ue33", [Übung 3 (Aufgabenblatt S. 1): Skizze zu Aufgabe 3.3.], height: 34mm)
+ *Übung 3, Aufg. 3.4:* Drehkran mit $l_1 = 3 "m"$, $l_2 = "1,5" "m"$, $l_3 = 4 "m"$, Last $F = 20 "kN"$. a) Kräfte im Zugstab $Z$ und im Druckstab $D$? b) Zerlege $F_Z$ in A in waagerechte und senkrechte Komponente. c) Ebenso $F_D$ in B.
  #bild("tm1k2_ue34", [Übung 3 (Aufgabenblatt S. 2): Skizze zu Aufgabe 3.4.], height: 36mm)
+ *Übung 4, Aufg. 4.1:* Ein Stabverband trägt am Knoten die Masse $m$. Berechne die Stabkräfte allgemein und für $m = 1500 "kg"$, $beta = 25°$.
  #bild("tm1k2_ue41", [Übung 4 (Aufgabenblatt S. 1): Skizze zu Aufgabe 4.1.], height: 26mm)
+ *Übung 4, Aufg. 4.2:* Eine große Walze (Gewicht $4G$, Radius $2r$) liegt auf zwei Walzen (je $G$, Radius $r$), die durch ein Seil (Länge $3r$) verbunden sind. Alle Walzen glatt. Gesucht sind alle Reaktionskräfte.
  #bild("tm1k2_ue42", [Übung 4 (Aufgabenblatt S. 1): Skizze zu Aufgabe 4.2.], height: 32mm)
+ *Übung 4, Aufg. 4.3:* Ein Bagger als Abbruchgerät: Bestimme die Kräfte in den Seilen 1, 2, 3 und im Ausleger infolge des Gewichts $G$. (Seile 1 und 2 sind in B befestigt, dort ist keine Rolle.)
  #bild("tm1k2_ue43", [Übung 4 (Aufgabenblatt S. 1): Skizze zu Aufgabe 4.3.], height: 32mm)
+ *Übung 4, Aufg. 4.5:* Ein homogener, glatter Stab (Gewicht $G$, Länge $4a$) stützt sich bei A an einer Ecke und bei B an einer glatten Wand (Abstand Ecke–Wand $a$). Für welchen Winkel $alpha$ ist er im Gleichgewicht? Hinweis vom Blatt: Dreikraftsystem.
  #bild("tm1k2_ue45", [Übung 4 (Aufgabenblatt S. 2): Skizze zu Aufgabe 4.5.], height: 30mm)
+ *Buch:* Warum dürfen Kräfte am starren Körper entlang ihrer Wirkungslinie verschoben werden, und was folgt daraus für zentrale Kräftegruppen? (TM1-Buch S. 16)
+ *Buch:* Was ist beim grafischen Lösen der Unterschied zwischen einem Kräfteplan mit Maßstab und dem „grafoanalytischen“ Vorgehen? (TM1-Buch S. 18)
+ *Buch:* Was ist der Unterschied zwischen der Komponente $arrow(F)_x$ und der Koordinate $F_x$? (TM1-Buch S. 22)
+ *Buch:* Unter welcher Bedingung hat die Aufgabe „drei Gewichte am Seil“ (Beispiel 2.6) eine physikalisch sinnvolle Lösung? (TM1-Buch S. 31)
]

#pagebreak()
== Lösungen Kapitel 2
#set enum(spacing: 0.65em)
+ Kräfte, deren Wirkungslinien sich in einem Punkt schneiden. Am starren Körper müssen sie nicht dort angreifen, weil Kräfte linienflüchtig sind. #nachschlagen[Lernskript, #stelle(<k-tm1-2>)]
+ Lageplan: Geometrie und Wirkungslinien. Krafteck: Kräfte maßstäblich aneinandergereiht. Die Vektoraddition ist kommutativ, darum ist die Reihenfolge egal. #nachschlagen[Lernskript, #stelle(<a-tm1-2-1>)]
+ Vektoriell bei mehr als zwei Kräften und als sicherer Standardweg; Dreieckssätze bei zwei Kräften (im Gleichgewicht: drei), wenn die Winkel im Kräftedreieck leicht abzulesen sind. #nachschlagen[Lernskript, #stelle(<a-tm1-2-1>)]
+ Der Taschenrechner liefert nur −90° bis +90°. Bei $F_"Rx" < 0$ liegt $F_R$ im II. oder III. Quadranten: 180° addieren. Immer eine Skizze mit Vorzeichen machen. #nachschlagen[Lernskript, #stelle(<a-tm1-2-1>)]
+ Zwei Gleichungen ($x$, $y$) liefern genau zwei Unbekannte. Drei Richtungen bedeuten drei Unbekannte bei zwei Gleichungen: unendlich viele Lösungen. #nachschlagen[Lernskript, #stelle(<a-tm1-2-2>)]
+ Gleiche Wirkungslinie, entgegengesetzt gleich groß: $arrow(F)_1 + arrow(F)_2 = arrow(0)$. #nachschlagen[Lernskript, #stelle(<a-tm1-2-3>)]
+ Zwei ($sum F_x = 0$, $sum F_y = 0$). Mehr Unbekannte: statisch unbestimmt. #nachschlagen[Lernskript, #stelle(<a-tm1-2-3>)]
+ Stab: gerade (oder gelenkig angeschlossen), masselos, keine Last zwischen den Enden. Er überträgt Zug oder Druck entlang der Gelenkverbindung. Seil: nur Zug. #nachschlagen[Lernskript, #stelle(<a-tm1-2-4-1>)]
+ Der Betrag der Seilkraft bleibt gleich, nur die Richtung ändert sich. #nachschlagen[Lernskript, #stelle(<a-tm1-2-4-1>)]
+ Festlager: 2 Kräfte (Verschiebungen verhindert, Drehung frei). Loslager: 1 Kraft senkrecht zur Bahn. Einspannung: 2 Kräfte und 1 Moment (alles verhindert). #nachschlagen[Lernskript, #stelle(<a-tm1-2-4-2>)]
+ Drei Kräfte, von denen zwei nicht parallel sind, sind nur dann im Gleichgewicht, wenn sich alle drei Wirkungslinien in einem Punkt schneiden. Beim Balken: Wirkungslinie von $F$ und die von $F_B$ (senkrecht zum schrägen Loslager) schneiden sich; $F_A$ muss durch diesen Punkt. #nachschlagen[Lernskript, #stelle(<a-tm1-2-4-3>)]
+ Eine Konvention für alle Stäbe: Das Vorzeichen zeigt die Beanspruchung. $S < 0$ heißt Druck. #nachschlagen[Lernskript, #stelle(<a-tm1-2-4-4>)]
+ Die Gleichungen so umstellen, dass $cos alpha_1$ und $sin alpha_1$ allein stehen, quadrieren, addieren; $sin^2 + cos^2 = 1$ eliminiert $alpha_1$. Quadrieren und arcsin erzeugen Schein- oder Zweitlösungen, also einsetzen und an der Skizze prüfen. #nachschlagen[Lernskript, #stelle(<a-tm1-2-4-4>) (Beispiele 3 und 6)]
+ $F_"Rx" = 5 + 6 cos 225° = "0,757" "kN"$, $F_"Ry" = 8 - "4,243" = "3,757" "kN"$, $F_R = "3,83" "kN"$, $phi_R = "78,6" degree$ (I. Quadrant). #nachschlagen[Lernskript, #stelle(<a-tm1-2-1>)]
+ $F_R = sqrt(16 + 49 + 2 dot 4 dot 7 cos 50°) = "10,05" "kN"$; $sin beta = 4 sin 50° \/ "10,05" = "0,305"$, also $beta = "17,8" degree$. #nachschlagen[Lernskript, #stelle(<a-tm1-2-1>)]
+ Seil unter 40°: $S = 12 sin 25° \/ sin 65° = "5,60" "kN"$; Seil unter 25°: $S = 12 sin 40° \/ sin 65° = "8,51" "kN"$. Das steilere Seil trägt mehr. #nachschlagen[Lernskript, #stelle(<a-tm1-2-2>)]
+ Wie Beispiel 2 mit $beta = 0$: $F_S = G tan alpha = "2,33" "kN"$, $N = G \/ cos alpha = "5,52" "kN"$. #nachschlagen[Lernskript, #stelle(<a-tm1-2-4-4>) (Beispiel 2)]
+ $S_1 = 8 sin 30° \/ sin 75° = "4,14" "kN"$ (Zug), $S_2 = -8 sin 45° \/ sin 75° = "-5,86" "kN"$ (Druck). #nachschlagen[Lernskript, #stelle(<a-tm1-2-4-4>) (Beispiel 4)]
+ $sin alpha_1 = (2500 + 3600 - 2500) \/ (2 dot 50 dot 60) = "0,6"$, also $alpha_1 = alpha_2 = "36,9" degree$. Probe y: $2 dot 50 dot "0,6" = 60$. #nachschlagen[Lernskript, #stelle(<a-tm1-2-4-4>) (Beispiel 3)]
+ $F_1 = "0,51" "kN"$, $F_2 = "0,78" "kN"$. Weg: $F_1 sin 40° = F_2 sin 25°$ (keine Seitenkraft) und $F_1 cos 40° + F_2 cos 25° = "1,1" "kN"$; oder Sinussatz im Kräftedreieck. #nachschlagen[Lernskript, #stelle(<a-tm1-2-2>)\; Lösung Übung 2 S. 1–2]
+ $F_"Rx" = "503,5" "N"$, $F_"Ry" = "249,9" "N"$, $F_R = "562,1" "N"$, Winkel zu $F_3$: $"26,4" degree$, nach rechts oben (I. Quadrant). #nachschlagen[Lernskript, #stelle(<a-tm1-2-1>)\; Übung 2 S. 3]
+ $F_1 = "8,5" "kN"$, $F_2 = "14,7" "kN"$. Mit $alpha_1 + alpha_2 = 90°$ ist das Kräftedreieck rechtwinklig: $F_1 = F sin 30°$, $F_2 = F cos 30°$. #nachschlagen[Lernskript, #stelle(<a-tm1-2-3>)\; Übung 2 S. 3]
+ 1: $F_R = "4,08" "kN"$, $phi = -"2,67" degree$. 2: $F_R = "0,646" "kN"$, $phi = "100,33" degree$. 3: $F_R = "19,00" "kN"$, $phi = -"51,67" degree$. 4: $F_R = "48,69" "kN"$, $phi = -"61,02" degree$. 5: $F_R = "1,30" "kN"$, $phi = "6,19" degree$. Komponenten stehen in der Kurzlösung. #nachschlagen[Lernskript, #stelle(<a-tm1-2-1>)\; Übung 2 S. 3]
+ $sin phi = r \/ a = 20 \/ 60$, also $phi = "19,47" degree$ zwischen Seil und Wand. $G = 15 dot "9,81" = "147,2" "N"$, $F_S = G \/ cos phi = 156 "N"$, $F_N = G tan phi = "52,1" "N"$. #nachschlagen[Lernskript, #stelle(<a-tm1-2-4-4>) (Beispiel 2); Übung 3 S. 2]
+ $F_S = G = 3 "kN"$ (reibungsfreie Rolle), Stangenkraft $F_D = "4,59" "kN"$, $alpha = 40°$. Achtung: In der Kurzlösung steht „$F_S = 3 "N"$“, richtig ist 3 kN. #nachschlagen[Lernskript, #stelle(<a-tm1-2-4-1>)\; Übung 3 S. 2]
+ Knoten am Körper 1: $-G_2 cos alpha + G_3 cos beta = 0$ und $G_2 sin alpha + G_3 sin beta - G_1 = 0$. Ergebnis $G_2 = "5,39" "N"$, $G_3 = "28,15" "N"$ (nachgerechnet; es passt, wenn beide Winkel gegen die Waagerechte gemessen werden). #nachschlagen[Lernskript, #stelle(<a-tm1-2-4-4>) (Beispiel 3); Übung 3 S. 2]
+ $F_Z = "28,48" "kN"$, $F_D = "40,14" "kN"$; $F_"Zx" = "26,67" "kN"$, $F_"Zy" = "10,0" "kN"$; $F_"Dx" = -"26,67" "kN"$, $F_"Dy" = -"30,0" "kN"$. #nachschlagen[Lernskript, #stelle(<a-tm1-2-2>)\; Übung 3 S. 2]
+ $S_1 = G \/ tan beta = "31,6" "kN"$ (Zug), $S_2 = G \/ sin beta = "34,8" "kN"$ (Druck), mit $G = m g = "14,7" "kN"$. Deine Rechnung auf dem Aufgabenblatt (S. 2) liefert genau das: $S_2 = -"34,819" "kN"$, $S_1 = "31,557" "kN"$. #nachschlagen[Lernskript, #stelle(<a-tm1-2-4-4>) (Beispiel 4); Übung 4 S. 2]
+ Das Seil bildet mit den Mittelpunkten ein gleichseitiges Dreieck (Seiten $3r$), also $alpha = 60°$. $N_1 = 4G \/ sqrt(3) = "2,31" G$ (große auf kleine Walze), $N_2 = 3 G$ (Boden), $S = 2G \/ sqrt(3) = "1,15" G$. Deine Rechnung (Aufgabenblatt S. 3–4) kommt auf $N_1 = "2,31" G$, $N_2 = "3,00" G$, $S = "1,16" G$ (Rundung). #nachschlagen[Lernskript, #stelle(<a-tm1-2-4-3>)\; Übung 4 S. 2]
+ $S_1 = S_2 = G \/ cos alpha$, $S_3 = G tan alpha$, Ausleger $D = 2 G$. Deine Rechnung steht auf dem Aufgabenblatt S. 5–6. #nachschlagen[Lernskript, #stelle(<a-tm1-2-3>)\; Übung 4 S. 2]
+ Drei Kräfte: $G$ (Stabmitte, senkrecht), $A$ (senkrecht zum Stab, glatte Ecke), $B$ (waagerecht, glatte Wand). Ihre Wirkungslinien schneiden sich in einem Punkt. Daraus folgt $cos^3 alpha = a \/ (2a) = "0,5"$, also $alpha = "37,5" degree$. #nachschlagen[Lernskript, #stelle(<a-tm1-2-4-3>) (Dreikraftsystem); Übung 4 S. 2]
+ Am starren Körper ändert eine Verschiebung längs der Wirkungslinie die Wirkung nicht. Darum genügt es, dass sich die Wirkungslinien in einem Punkt schneiden. #nachschlagen[Lernskript, #stelle(<a-tm1-2-1>)\; TM1-Buch S. 16]
+ Kräfteplan: maßstäblich gezeichnet, Ergebnis abgelesen. Grafoanalytisch: nur Skizze des Kraftecks, dann mit Cosinus- und Sinussatz rechnen. #nachschlagen[Lernskript, #stelle(<a-tm1-2-1>)\; TM1-Buch S. 18]
+ $arrow(F)_x = F_x arrow(e)_x$ ist ein Vektor (Komponente), $F_x$ eine Zahl mit Vorzeichen (Koordinate). #nachschlagen[Lernskript, #stelle(<a-tm1-2-1>)\; TM1-Buch S. 22]
+ Die Lösung ist nur sinnvoll für $0 < alpha_1, alpha_2 < 90°$: Die Zähler der $sin alpha$-Formeln müssen größer als null und kleiner als die Nenner sein. #nachschlagen[Lernskript, #stelle(<a-tm1-2-4-4>) (Beispiel 3); TM1-Buch S. 31]

#pagebreak()
= TM1 Kapitel 3 · Allgemeine Kräftesysteme und Gleichgewicht <k-tm1-3>
#tab(columns: 2,
 [Vorlesungen], [VL vor dem 10.11.25 (Datum nicht notiert) → 3.1.1 und Anfang 3.1.2; VL 10.11.25 → 3.1.2 (Berechnung von $M_((0))$), 3.1.3, 3.1.4 inkl. Rechenbeispiele aus deiner Mitschrift; 3.2 nur als Überblick (Kapitelübersicht)],
 [Quellen], [Skript TM1 S. 97–105 (deine Mitschrift 3.1.1–3.1.3), S. 106–111 (Foliensatz „Allgemeine Kräftesysteme – Gleichgewichtsbedingungen“), S. 112–117 (Mitschrift: Beispiele), Übersicht S. 4; FS TM1 S. 21–24; TM1-Buch Kap. 3 (S. 43–85)],
 [Passende Übungen], [Übung 5: 5.1–5.4 (Momentengleichgewicht, Kern dieses Kapitels); Übung 4: 4.5 (Dreikraftsystem, laut Blatt auch über Momentengleichgewicht lösbar); Übung 7: 7.1–7.3 (Gleichgewicht am Balken/Rahmen, Vorgriff auf Kap. 5)],
)
In Kapitel 2 gingen alle Wirkungslinien durch #strong[einen] Punkt. Jetzt liegen die Kräfte beliebig. Dann können sie einen Körper nicht nur verschieben, sondern auch #strong[drehen]. Das neue Werkzeug dafür ist das #strong[Moment]. Die ganze Statik der folgenden Kapitel (Lagerreaktionen, Schnittgrößen) baut auf den drei Gleichungen $sum F_x = 0, sum F_y = 0, sum M_((A)) = 0$ auf.
#note([Dein Feynman-Schritt: die 5 Kernideen von Kapitel 3. Erst ohne Skript aufzählen und erklären, dann vergleichen.], [+ #strong[Kräftepaar = reines Moment:] zwei gleich große, entgegengesetzte Kräfte auf parallelen Wirkungslinien verschieben nichts, sie drehen nur: $M = h_s F$.
+ #strong[Moment einer Kraft:] Kraft mal senkrechter Abstand zum Bezugspunkt. Es hängt vom Bezugspunkt ab.
+ #strong[Parallelverschiebung:] Verschiebt man eine Kraft parallel, muss man ihr „Versetzmoment“ $M_((0)) = h_s F$ dazunehmen.
+ #strong[Reduktion:] Jedes ebene Kräftesystem ist gleichwertig zu einer Kraft $F_R$ in A plus einem Moment $M_(R(A))$ (oder zu $F_R$ allein auf verschobener Wirkungslinie).
+ #strong[Gleichgewicht:] $F_R = 0$ und $M_(R(A)) = 0$ → in der Ebene 3 Gleichungen für 3 Unbekannte; im Raum 6.
Zusammenfassung der Abschnitte 3.1.1–3.2; Quellen stehen dort.])
#bild("tm1k3_uebersicht", [Skript TM1 S. 4 (untere Folie): Gliederung von Kapitel 3 mit der Gleichgewichtsbedingung am starren Körper.], height: 45mm)
== 3.1 Allgemeine Kraftgruppen in der Ebene <a-tm1-3-1>
#heading(level: 3, outlined: false)[Einführung: Warum jetzt Momente?]
Bisher (Kap. 2) schnitten sich alle Wirkungslinien (WL) in #strong[einem] Punkt. Dann reichen $sum F_x = 0$ und $sum F_y = 0$. Jetzt sind die Kräfte beliebig angeordnet und die WL schneiden sich #strong[nicht] in einem Punkt. Es kommt eine dritte Bedingung dazu: das Momentengleichgewicht $sum M = 0$.
#note([Aus deiner Mitschrift (Skript TM1 S. 97–98)], [- #strong[Bisher:] GGW zentraler Kräfte: $arrow(R) = sum arrow(F)_i = 0$ → $F_x = 0, F_y = 0$.
- #strong[Jetzt:] Kräfte mit beliebiger Anordnung → zusätzlich Momente $M_j$, $M_R = sum M_j$. GGW: $F_x = 0, F_y = 0, M_R = 0$.
- #strong[Hinweis:] Nicht zentrale Systeme kann man mit „diversen Tricks“ oft auf zentrale zurückführen (Beispiel unten). Mit $sum M_j = 0$ sind solche Tricks meist überflüssig: #strong[ein einheitliches Verfahren für zentrale und nicht zentrale Kräftesysteme.]])
#note([Von dir markiert], [In deiner Mitschrift (Skript TM1 S. 97) hast du „in #strong[einem] Punkt“ und zweimal „#strong[nicht]“ gelb markiert. Genau das ist der Unterschied zu Kap. 2: Schneiden sich die WL #strong[nicht] in einem Punkt, brauchst du das Momentengleichgewicht.], fill: sand)
#bild("tm1k3_trick", [Skript TM1 S. 98 (deine Mitschrift): „Trick“ für zwei parallele Kräfte. Man fügt $+K$ und $-K$ auf derselben WL hinzu (Summe null), bildet $R_1 = F_1 + (-K)$ und $R_2 = F_2 + K$ und bringt $R_1, R_2$ zum Schnitt. So findet man Betrag #strong[und] Lage der Resultierenden $R = F_1 + F_2$.], height: 45mm)
#note([In eigenen Worten], [Schiebst du einen Schrank genau in der Mitte, rutscht er gerade. Schiebst du ihn an einer Ecke, dreht er sich zusätzlich. Gleiche Kraft, andere Lage der Wirkungslinie → andere Wirkung. Diese Drehwirkung erfasst das Moment. #text(fill: muted)[(eigene Ergänzung)]])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Hebelgesetz:] Aus der Konstruktion mit $plus.minus K$ folgen für zwei parallele Kräfte $R = F_1 + F_2$ und das Hebelgesetz von Archimedes $a_1 F_1 = a_2 F_2$. #text(fill: muted)[\[TM1-Buch S. 45–46\]]
- #strong[Grafisches Verfahren:] Für viele Kräfte gibt es das „Seileck“ (Lageplan + Kräfteplan mit Pol). In der Vorlesung nicht behandelt, nur zur Info. #text(fill: muted)[\[TM1-Buch S. 63–66\]]])
#src[Skript TM1 S. 97–98 (Mitschrift), S. 4; TM1-Buch S. 45–46, 63–66.]
=== 3.1.1 Kräftepaar und reines Moment <a-tm1-3-1-1>
Zwei Kräfte $F_1$ und $F_2$ bilden ein #strong[Kräftepaar (KP)], wenn sie
- entgegengesetzt gleich groß sind ($|F_1 | = |F_2 | = F$),
- #strong[nicht] auf derselben WL liegen und
- parallele WL haben.
Ihre Summe ist null: $R = F_1 + F_2 = 0$. Der Körper wird also nicht verschoben. Er wird aber #strong[gedreht]. Diese reine Drehwirkung heißt #strong[„reines“ Moment]. Der Trick mit $plus.minus K$ funktioniert hier nicht: ein Kräftepaar lässt sich #strong[nicht] durch eine Einzelkraft ersetzen.
#note([Definition (Mitschrift / FS TM1 S. 21)], [Kräftepaar = zwei entgegengesetzt gleich große Kräfte auf parallelen, verschiedenen Wirkungslinien. Physikalische Wirkung: keine translatorische Bewegung, nur der Versuch, den Körper zu drehen → reines Moment $M$.])
#bild("tm1k3_kp_bsp", [Skript TM1 S. 99 (deine Mitschrift): Kräftepaar mit Abstand $h_s$, physikalische Wirkung und Beispiele (Lenkrad, Schraubenzieherklinge im Schraubenkopfschlitz).], height: 45mm)
#heading(level: 4, outlined: false)[Formeln ★]
#form[$ M = h_s dot F wide [ "Nm" ] = [ "m" ] dot [ "N" ] $]
$F$: Betrag einer der beiden Kräfte; $h_s$: senkrechter Abstand der beiden Wirkungslinien. Dazu gehört immer ein Drehsinn.
#note([Von dir markiert], [$M = h_s dot F$ hast du rot hinterlegt, die Vorzeichenfestlegung „$M$ ↺ $hat(=)$ +“ und die Einheit $[ "Nm" ] = [ "m" ] dot [ "N" ]$ rot eingerahmt (Skript TM1 S. 99–100).], fill: sand)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k3_vorzeichen", [Skript TM1 S. 100 (Mitschrift): Richtungssinn in der Ebene, Vorzeichenfestlegung (links herum = positiv = positive Drehung um die z-Achse).], height: 50mm)],
 [#bild("tm1k3_einheit", [Skript TM1 S. 100 (Mitschrift): im Raum $arrow(M) = arrow(h) times arrow(F) = arrow(r) times arrow(F)$; Einheit Nm.], height: 50mm)])
#note([Merke – Vorzeichen], [Moment #strong[gegen] den Uhrzeigersinn (↺) = #strong[positiv], im Uhrzeigersinn (↻) = negativ. Das ist die positive Drehung um die z-Achse, die aus der Zeichenebene herauszeigt (FS TM1 S. 21, Gl. 3.2).])
#heading(level: 4, outlined: false)[Eigenschaften von Kräftepaaren]
- #strong[Viele gleichwertige Paare:] Zu einem Moment $M$ gibt es beliebig viele gleichwertige KP. Beweis aus der Mitschrift: $M = h_s F = (h_s cos alpha ) dot frac(F, cos alpha) = h_s ' F_s '$.
- #strong[Frei verschiebbar:] Ein KP darf beliebig in der Ebene verschoben werden. Die Wirkung auf einen starren Körper ändert sich nicht. Im Gegensatz zur Kraft ist das Moment #strong[an keine Wirkungslinie gebunden].
- #strong[actio = reactio:] Wirkt Körper 1 mit $M$ auf Körper 2, wirkt Körper 2 mit $-M$ auf Körper 1. Beim Freischneiden trägst du an beiden Schnittufern entgegengesetzte Momente an.
- #strong[Mehrere KP:] Momente werden mit Vorzeichen addiert: $M_R = sum_(j=1)^m M_j$. #strong[GGW], falls nur Momente wirken: $M_R = sum M_j = 0$.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k3_kp_eigensch", [Skript TM1 S. 101 (Mitschrift): gleichwertige Kräftepaare (mit Foto des Tafelbildes) und Beweis der Verschiebbarkeit mit Hilfskräften $plus.minus 2F$.], height: 50mm)],
 [#bild("tm1k3_actio", [Skript TM1 S. 101 (Mitschrift): actio = reactio für Momente. Am Schnitt wirken auf beiden Teilen entgegengesetzt gleich große Momente (und Kräfte).], height: 50mm)])
#note([In eigenen Worten], [Beim Aufdrehen eines Wasserhahns (Drehgriff) drückst du mit Daumen und Zeigefinger gegeneinander. Die Kräfte heben sich auf, der Hahn wandert nicht weg, er dreht sich nur. Wo genau am Griff du anfasst, ist für die Drehwirkung egal, nur Kraft mal Abstand zählt. #text(fill: muted)[(eigene Ergänzung)]])
#note([Beispiel (eigene Ergänzung)], [Ein Monteur zieht eine Radmutter mit einem Kreuzschlüssel an. Er drückt links mit 120 N nach unten und rechts mit 120 N nach oben. Die Griffe liegen 40 cm auseinander. Ges.: Moment.
+ Kräftepaar: $F = 120 "N"$, $h_s = 0","40 "m"$.
+ $M = h_s F = 0","40 "m" dot 120 "N" = 48 "Nm"$. Drehsinn: im Uhrzeigersinn → $M = -48 "Nm"$.
+ Die resultierende Kraft auf die Mutter ist null, deshalb wird das Rad nicht seitlich belastet.], fill: pale)
#note([Fehler vermeiden], [$h_s$ ist immer der #strong[senkrechte] Abstand der Wirkungslinien, nicht der Abstand der Angriffspunkte. Und: Kraft und Moment haben verschiedene Einheiten (N bzw. Nm). Man darf sie nie addieren.], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Grenzfall:] Setzt man $F_2 = -F_1$ in die Formel für zwei parallele Kräfte ein, wird $R = 0$ und die Abstände $a_1, a_2 -> infinity$. Deshalb ist ein KP nicht auf eine Einzelkraft reduzierbar. #text(fill: muted)[\[TM1-Buch S. 46\]]
- #strong[Beispiele:] Ventilrad, Schraubenzieher mit Spiel im Schlitz, eingespannter Balken, dessen Ende verdreht wird. #text(fill: muted)[\[TM1-Buch S. 46–47\]]
- #strong[Einheit:] man schreibt „N m“ (Newtonmeter) und nicht „m N“, um Verwechslung mit Millinewton zu vermeiden. #text(fill: muted)[\[TM1-Buch S. 47\]]
- #strong[Symbol:] Das KP wird meist nicht mehr gezeichnet, sondern durch einen gebogenen Pfeil mit Betrag $M$ ersetzt. #text(fill: muted)[\[TM1-Buch S. 48\]]])
#src[Skript TM1 S. 98–102 (Mitschrift); FS TM1 S. 21–22 (Gl. 3.1–3.4); TM1-Buch S. 45–49.]
=== 3.1.2 Moment einer Kraft <a-tm1-3-1-2>
Eine Kraft darf man beim starren Körper #strong[längs] ihrer WL verschieben, ohne dass sich etwas ändert. Verschiebt man sie aber #strong[parallel] auf eine WL durch einen Bezugspunkt „0“, ändert sich die Wirkung. Damit alles gleich bleibt, muss man in „0“ zusätzlich ein Moment $M_((0))$ anbringen.
#strong[Beweis (Schraubenschlüssel, Mitschrift):] a) Ausgangszustand: $F$ auf WL $f$. b) In „0“ trägt man $+F arrow.b$ und $F arrow.t$ an (Summe null, ändert nichts). c) Neu zusammenfassen: das ursprüngliche $F$ und das $F arrow.t$ bilden ein Kräftepaar mit $|M_((0))| = h_s F$. Übrig bleibt $F$ durch „0“.
#bild("tm1k3_versatz", [Skript TM1 S. 102 (Mitschrift): Parallelverschiebung einer Kraft am Beispiel Schraubenschlüssel. Ergebnis (rot eingerahmt): Kraft $F$ im senkrechten Abstand $h_s$ von „0“ $hat(=)$ Kraft $F$ durch „0“ plus Moment $|M_((0))| = h_s F$.], height: 45mm)
#note([Merke], [Das Moment einer Kraft hängt vom #strong[Bezugspunkt] ab ($M_((0))$, Index = Bezugspunkt). Das Moment eines Kräftepaares hängt #strong[nicht] vom Bezugspunkt ab. Der senkrechte Abstand $h_s$ heißt #strong[Hebelarm].])
#heading(level: 4, outlined: false)[Berechnung über Komponenten ★]
Oft kennt man den Hebelarm $h_s$ nicht direkt. Dann zerlegt man die Kraft in $F_x = F cos alpha$ und $F_y = F sin alpha$ und nimmt die Abstände $h_x$, $h_y$ vom Bezugspunkt zum Angriffspunkt (oder einem beliebigen Punkt auf der WL):
#form[$ M_((0)) = +h_x F_y - h_y F_x = h_s dot F $]
$h_x F_y$ dreht links herum (+), $h_y F_x$ dreht rechts herum (−) (bei positiven $h_x, h_y, F_x, F_y$). FS TM1 S. 22, Gl. 3.5. Das ist die z-Komponente des Kreuzprodukts $arrow(M)_((0)) = arrow(h) times arrow(F)$ mit $arrow(h) = (h_x, h_y, 0)^T$, $arrow(F) = (F_x, F_y, 0)^T$.
#bild("tm1k3_m0_komp", [Skript TM1 S. 103 (Mitschrift vom 10.11.): Moment hängt vom Bezugspunkt ab; Vorzeichenfestlegung; Berechnung von $M_((0))$ über $h_x$ und $h_y$ (rot eingerahmt) und Herkunft aus dem Kreuzprodukt.], height: 45mm)
#strong[Mehrere Kräfte an einem Punkt:] Die Summe der Momente der Einzelkräfte ist gleich dem Moment der Resultierenden $arrow(R) = sum arrow(F)_i$. Für zwei Kräfte am gleichen Punkt: $M_((0)) = h_x (F_("1y")+F_("2y")) - h_y (F_("1x")+F_("2x")) = h_x R_y - h_y R_x$.
#grid(columns: 1, gutter: 5mm,
 [#bild("tm1k3_m0_summe", [Skript TM1 S. 103 (Mitschrift): Summe der Momente der Einzelkräfte $hat(=)$ Moment der Resultierenden (rot eingerahmt).], height: 50mm)])
#note([Von dir markiert], [Rot eingerahmt hast du: „Im Bezugspunkt 0 greift zusätzlich zu F ein Moment $M_((0))$ an“, die Äquivalenz „Kraft im Abstand $h_s$ $hat(=)$ Kraft durch 0 + $M_((0)) = h_s F$“, die Formel $M_((0)) = h_x F_y - h_y F_x$ und „Summe der Momente der Einzelkräfte $hat(=)$ Moment der Resultierenden“ (Skript TM1 S. 102–103).], fill: sand)
#note([In eigenen Worten], [Eine Wippe auf dem Spielplatz: Ein Kind (Gewicht 300 N) sitzt 2 m vom Drehpunkt. Bezogen auf den Drehpunkt erzeugt es 600 Nm. Bezogen auf einen Punkt direkt unter dem Kind ist sein Moment null. Gleiche Kraft, anderer Bezugspunkt, anderes Moment. #text(fill: muted)[(eigene Ergänzung)]])
#note([Beispiel (eigene Ergänzung)], [Eine Kraft $F = 500 "N"$ wirkt unter $alpha = 30 degree$ zur x-Achse im Punkt $P = (2 "m" ; 1 "m" )$. Ges.: Moment um den Ursprung 0.
+ Komponenten: $F_x = 500 cos 30 degree = 433","0 "N"$, $F_y = 500 sin 30 degree = 250","0 "N"$.
+ $M_((0)) = h_x F_y - h_y F_x = 2 dot 250","0 - 1 dot 433","0 = 67","0 "Nm"$ (links herum).
+ Kontrolle Hebelarm: $h_s = M_((0))/F = 67","0/500 = 0","134 "m"$. Die WL läuft also nur 13,4 cm am Ursprung vorbei. Plausibel, denn die Kraft zeigt fast auf 0 zu.], fill: pale)
#note([Fehler vermeiden (typische Fehler)], [(1) Vorzeichen von $h_x$, $h_y$ vergessen: Liegt der Angriffspunkt links von bzw. unter dem Bezugspunkt, sind $h_x$ bzw. $h_y$ negativ. (2) Bei $M = h_s F$ den schrägen statt den senkrechten Abstand nehmen. (3) Drehsinn „nach Gefühl“: lieber konsequent mit $h_x F_y - h_y F_x$ rechnen.], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Herleitung von $M = x F_y - y F_x$:] Mit $h = x sin alpha - y cos alpha$, $sin alpha = F_y /F$, $cos alpha = F_x /F$ folgt $M_((0)) = h F = x F_y - y F_x$ (Gl. 3.8). #text(fill: muted)[\[TM1-Buch S. 50–51\]]
- #strong[Satz:] „Die Summe der Momente von Einzelkräften ist gleich dem Moment der Resultierenden.“ Es ist egal, ob man erst addiert und dann das Moment bildet oder umgekehrt. #text(fill: muted)[\[TM1-Buch S. 51\]]
- #strong[Hebelarm] heißt der senkrechte Abstand zwischen 0 und der WL der Kraft. #text(fill: muted)[\[TM1-Buch S. 50\]]])
#src[Skript TM1 S. 102–104 (Mitschrift, Datum 10.11. auf S. 103/104); FS TM1 S. 22 (Gl. 3.5); TM1-Buch S. 49–51.]
=== 3.1.3 Die Resultierende ebener Kräftesysteme <a-tm1-3-1-3>
Auf einen starren Körper wirken beliebige Kräfte $arrow(F)_i$ ($i = 1 dots n$) und Momente $M_j$ ($j = 1 dots m$). Man wählt einen beliebigen Punkt A (er darf auch außerhalb des Körpers liegen) und schiebt alles nach A:
- Momente $M_j$: frei verschiebbar (3.1.1).
- Kräfte $arrow(F)_i$: parallel nach A schieben und dafür das #strong[„Verschiebe-Moment“] $M_(F_i (A))$ dazunehmen (3.1.2).
Ergebnis: eine zentrale Kräftegruppe in A plus Momente. Diese fasst man zusammen zu #strong[einer resultierenden Kraft] $arrow(F)_R$ und #strong[einem resultierenden Moment] $M_(R(A))$.
#heading(level: 4, outlined: false)[Formeln ★]
#form[$ M_(F_i (A)) = h_("is") F_i = h_("ix")F_("iy") - h_("iy")F_("ix") $


$ F_("Rx") = sum_(i=1)^n F_("ix"), quad F_("Ry") = sum_(i=1)^n F_("iy"), wide M_(R(A)) = sum_(j=1)^m M_j + sum_(i=1)^n M_(F_i (A)) $]
FS TM1 S. 23, Gl. 3.6 und 3.7. Betrag und Richtung von $F_R$ wie in Kap. 2: $F_R = sqrt(F_("Rx")^2 + F_("Ry")^2)$, $tan alpha_R = F_("Ry")/F_("Rx")$.
#strong[Weitere Reduktion:] Ist $F_R != 0$, kann man auch noch das Moment „wegschieben“. Man verschiebt $F_R$ parallel um den Abstand
#form[$ h_s = frac(M_(R(A)), F_R) $]
Auf dieser WL (Punkt B) gilt $M_(R(B)) = 0$. Dann beschreibt die eine Kraft $F_R$ die gesamte Wirkung. Ihre WL ist aber #strong[nicht frei wählbar], sondern durch $sum M_j$ und $sum M_(F_i)$ festgelegt.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k3_resultierende1", [Skript TM1 S. 104 (Mitschrift 10.11.): Reduktion – alle Kräfte und Momente nach A verschieben, Verschiebe-Moment $M_(F_i (A))$.], height: 50mm)],
 [#bild("tm1k3_resultierende2", [Skript TM1 S. 105 (Mitschrift 10.11.): $F_R$ und $M_(R(A))$ (rot eingerahmt); bei $F_R != 0$ Verschiebung um $h_s = M_(R(A))/F_R$ → $M_(R(B)) = 0$.], height: 50mm)])
#note([Von dir markiert], [Auf S. 104 hast du „#strong[zentral]“ rot hinterlegt: Nach dem Verschieben hast du eine #strong[zentrale] Kräftegruppe in A – also den Fall aus Kap. 2 plus Momente. Auf S. 105 ist die Formel für $M_(R(A))$ rot eingerahmt.], fill: sand)
#note([Fehler vermeiden – Schreibfehler in deiner Mitschrift (Skript TM1 S. 105)], [In der eingerahmten Formel steht beim zweiten Summenzeichen $sum_(j=1)^m M_(F_i (A))$. Richtig ist $sum_(i=1)^n M_(F_i (A))$: Es gibt $n$ Kräfte (Index $i$) und $m$ Momente (Index $j$). So steht es auch auf der Folie (Skript TM1 S. 107) und in FS TM1 S. 23 (Gl. 3.7).], fill: sand)
#note([Merke – die vier möglichen Ergebnisse einer Reduktion], [#tab(columns: 3,
 th([$F_R$], [$M_(R(A))$], [Ergebnis]),
 [$!= 0$], [$!= 0$], [Resultierende geht nicht durch A (Abstand $h_s = M_(R(A))/F_R$)],
 [$!= 0$], [$= 0$], [Resultierende geht durch A],
 [$= 0$], [$!= 0$], [reines Kräftepaar (Moment unabhängig von A)],
 [$= 0$], [$= 0$], [Gleichgewicht],
)
nach TM1-Buch S. 56–57])
#note([In eigenen Worten], [Eine Kostenstellenrechnung fasst viele einzelne Buchungen zu einer Summe zusammen. Genauso fasst die Reduktion viele Kräfte zu einem „Saldo“ $F_R$ zusammen. Beim Moment kommt es aber zusätzlich darauf an, #strong[wo] gebucht wurde (Hebelarm). #text(fill: muted)[(eigene Ergänzung)]])
#note([Beispiel (eigene Ergänzung, Lagerregal)], [Auf einem Regalträger wirken bei $x = 1 "m"$ eine Palette mit $F_1 = 2 "kN"$ und bei $x = 3 "m"$ eine mit $F_2 = 3 "kN"$ (beide nach unten). Zusätzlich wirkt ein Moment $M = +1 "kNm"$ (links herum). Bezugspunkt A bei $x = 0$. Ges.: Resultierende und Lage ihrer WL.
+ $F_("Ry") = -2 - 3 = -5 "kN"$ (nach unten), $F_("Rx") = 0$.
+ $M_(R(A)) = M + h_("1x")F_("1y") + h_("2x")F_("2y") = 1 + 1 dot (-2) + 3 dot (-3) = -10 "kNm"$.
+ Abstand: $h_s = |M_(R(A))|/F_R = 10/5 = 2 "m"$. Kontrolle mit Vorzeichen: Eine Kraft $-5 "kN"$ bei $x$ liefert $x dot (-5) = -10$ → $x = 2 "m"$.
+ Ergebnis: 5 kN nach unten bei $x = 2 "m"$. Ohne das Moment $M$ läge sie bei $x = 11/5 = 2","2 "m"$: das Moment verschiebt die WL.], fill: pale)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Gleichungen (3.9)–(3.11):] $R_x = sum F_("ix")$, $R_y = sum F_("iy")$, $M_R^((A)) = sum M_i^((A))$, $h = M_R^((A))/R$. #text(fill: muted)[\[TM1-Buch S. 52–53\]]
- #strong[Beispiel 3.1 (Sechseckscheibe):] Vier Kräfte $F$ bzw. $2F$ ergeben $R = 2F$ unter $60 degree$ und den Hebelarm $h = 2a$. Gute Übung zum Nachrechnen. #text(fill: muted)[\[TM1-Buch S. 53–54\]]])
#src[Skript TM1 S. 104–105 (Mitschrift 10.11.), S. 107; FS TM1 S. 22–23 (Gl. 3.6–3.7); TM1-Buch S. 52–54, 56–57.]
=== 3.1.4 Gleichgewichtsbedingungen <a-tm1-3-1-4>
Ein starrer Körper ist im Gleichgewicht (GGW), wenn er sich weder verschiebt noch dreht. Also müssen #strong[resultierende Kraft und resultierendes Moment null] sein. In der Ebene sind das drei Gleichungen. Damit kann man drei Unbekannte berechnen (z. B. drei Lagerkräfte).
#heading(level: 4, outlined: false)[Formeln ★]
#form[$ sum_(i=1)^n F_("ix") = 0, wide sum_(i=1)^n F_("iy") = 0, wide sum_(j=1)^m M_j + sum_(i=1)^n M_(F_i (A)) = sum_(i=1)^(n+m) M_(i(A)) = 0 $]
Kurz: $sum F_x = 0, sum F_y = 0, sum M_((A)) = 0$ – „Summe aller Momente bezüglich A = 0“. A ist ein in der Ebene #strong[frei wählbarer] Punkt. FS TM1 S. 23, Gl. 3.8.
#bild("tm1k3_ggw", [Skript TM1 S. 107 (obere Folie, von dir mit 10.11 datiert): GGW am starren Körper. 3 GGW-Bedingungen ≡ 3 Gleichungen → 3 Unbekannte.], height: 45mm)
- #strong[Freiheitsgrade:] Anzahl Gleichungen (3) = Anzahl Freiheitsgrade eines Körpers in der Ebene (2 Verschiebungen in x und y, 1 Drehung).
- Ist die Anzahl der Unbekannten ≠ Anzahl der Gleichungen → „statische Unbestimmtheit“ (Kap. 5.1.2).
- Die Wahl von A beeinflusst den #strong[Rechenaufwand]: Legt man A auf die WL einer unbekannten Kraft, fällt diese aus der Momentengleichung heraus.
#heading(level: 4, outlined: false)[Alternative Formen ★]
Statt 2 × ΣF + 1 × ΣM darf man auch nehmen:
#tab(columns: 3,
 th([Form], [Gleichungen], [Bedingung]),
 [Standard], [$sum F_x = 0, sum F_y = 0, sum M_((A)) = 0$], [A beliebig],
 [Alternative A (1 × ΣF, 2 × ΣM)], [$sum F_x = 0, sum M_((A)) = 0, sum M_((B)) = 0$], [$Delta x_("AB") != 0$ (A, B nicht senkrecht übereinander)],
 [], [$sum F_y = 0, sum M_((A)) = 0, sum M_((B)) = 0$], [$Delta y_("AB") != 0$ (A, B nicht waagerecht nebeneinander)],
 [Alternative B (3 × ΣM)], [$sum M_((A)) = 0, sum M_((B)) = 0, sum M_((C)) = 0$], [A, B, C #strong[nicht auf einer Geraden]],
)
#bild("tm1k3_alternativen", [Skript TM1 S. 108 (obere Folie): Alternativen A und B mit den Bedingungen $Delta x_("AB") != 0$, $Delta y_("AB") != 0$ bzw. A, B, C nicht auf einer Geraden.], height: 45mm)
#note([Merke – Warum die Bedingungen?], [Mit $sum F_x = 0$ und zwei Momentengleichungen um A und B ist eine Kraft parallel zur y-Achse noch nicht ausgeschlossen, wenn A und B auf einer senkrechten Linie liegen. Eine solche Kraft hätte um A und B ja dasselbe Moment. Erst wenn A und B horizontal versetzt sind ($Delta x_("AB") != 0$), folgt auch $sum F_y = 0$. Bei 3 × ΣM gilt dasselbe: liegen A, B, C auf einer Geraden, bleibt eine Kraft längs dieser Geraden unentdeckt.])
#note([Hinweis Nummerierung], [Die Folien dieses Abschnitts tragen die Überschrift „1.4 Gleichgewichtsbedingungen“ (Skript TM1 S. 107–110). In der Kapitelübersicht (Skript TM1 S. 4) und in der Formelsammlung heißt der Abschnitt 3.1.4. Gemeint ist dasselbe; im Lernskript wird 3.1.4 verwendet.], fill: sand)
#heading(level: 4, outlined: false)[Folienbeispiel: Balken mit $F_1$, $F_2$, $M$ ★]
Gegeben: $F_1, F_2, a, l$. Gesucht: das Moment $M$ so, dass Lager B #strong[nicht belastet] wird ($B = 0$). A ist ein Festlager ($A_x, A_y$), B ein Loslager.
#bild("tm1k3_bsp_balken", [Skript TM1 S. 108 (untere Folie): Balken mit $F_1$ (horizontal, auf Höhe $a$), $F_2$ (bei $l/2$) und Moment $M$; Freikörperbild und GGW.], height: 45mm)
#tab(columns: 3,
 th([Variante], [Gleichungen], [Ergebnis (mit $B = 0$)]),
 [Standard], [(1) $A_x + F_1 = 0$ \
(2) $A_y - F_2 + B = 0$ \
(3) $sum M_((A)) colon -F_2 frac(l, 2) + M - F_1 a + B l = 0$], [$A_x = -F_1$ \
$A_y = F_2$ \
$M = F_2 frac(l, 2) + F_1 a$ \
(alle Varianten liefern dasselbe)],
 [Alt. 1: ΣM(B) statt ΣM(A)], [(1), (2) und (3′) $-A_y l + F_2 frac(l, 2) + M - F_1 a = 0$],
 [Alt. 2: 1 × ΣF, 2 × ΣM], [(1a) $sum F_x$; (2a) $sum M_((A))$; (3a) $sum M_((B))$],
 [Alt. 3: 3 × ΣM], [(1b) $sum M_((A))$; (2b) $sum M_((B))$; (3b) $sum M_((C)) colon A_x a - A_y l + F_2 frac(l, 2) + M = 0$],
)
Punkt C ist der Angriffspunkt von $F_1$ oben am Pfosten über B. A, B, C liegen nicht auf einer Geraden → zulässig.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k3_bsp_alt2", [Skript TM1 S. 109 (untere Folie): Alternative 2.], height: 50mm)],
 [#bild("tm1k3_bsp_alt3", [Skript TM1 S. 110 (obere Folie): Alternative 3 (3 × ΣM).], height: 50mm)])
#note([Zahlen dazu (eigene Ergänzung)], [$F_1 = 2 "kN"$, $F_2 = 4 "kN"$, $a = 1 "m"$, $l = 4 "m"$.
+ $M = F_2 dot frac(l, 2) + F_1 a = 4 dot 2 + 2 dot 1 = 10 "kNm"$ (links herum).
+ $A_x = -2 "kN"$ (wirkt also nach links), $A_y = 4 "kN"$.
+ Probe mit ΣM(C), C = (4 m; 1 m): $A_x a - A_y l + F_2 frac(l, 2) + M = -2 - 16 + 8 + 10 = 0$ ✓], fill: pale)
#note([Merke – Bezugspunkt geschickt wählen], [Ein Punkt, durch den möglichst viele #strong[unbekannte] Kräfte gehen, liefert eine Gleichung mit nur einer Unbekannten. Mit einer weiteren GGW-Bedingung kannst du dann zur #strong[Probe] rechnen.])
#heading(level: 4, outlined: false)[Beispiele aus deiner Mitschrift]
#strong[(1) Balken lehnt an einer Mauer] (Skript TM1 S. 112): Balken (Länge $l$, Gewicht $G$) liegt unter dem Winkel $alpha$ auf einer glatten Mauerkante der Höhe $h$; unten hält ein Seil $S$. Alle Flächen glatt → Kontaktkräfte senkrecht zur Berührfläche ($N_1$ senkrecht zum Boden, $N_2$ senkrecht zum Balken). Der Kontaktpunkt liegt $h/ sin alpha$ vom unteren Ende entfernt.
#form[$ sum M_((1)) colon -G frac(l, 2) cos alpha + N_2 frac(h, sin alpha) = 0 med => med N_2 = frac(G thin l sin alpha cos alpha, 2h) $


$ sum F_x colon S - N_2 sin alpha = 0 => S = N_2 sin alpha, wide sum F_y colon N_1 - G + N_2 cos alpha = 0 => N_1 = G - N_2 cos alpha $]
Der Momentenbezugspunkt (1) liegt im Angriffspunkt von $N_1$ und $S$ → beide fallen heraus.
#bild("tm1k3_mauer", [Skript TM1 S. 112 (Mitschrift): Balken an der Mauer, Freikörperbild und Lösung.], height: 45mm)
#note([Fehler vermeiden – Fehler in deiner Mitschrift (Skript TM1 S. 112, letzte Zeile)], [Dort steht $N_1 = G dot (- frac(G frac(l, 2) cos alpha, h colon sin alpha) )$. Richtig ist $N_1 = G - N_2 cos alpha = G - frac(G frac(l, 2) cos alpha, h/ sin alpha) cos alpha = G(1 - frac(l sin alpha cos^2 alpha, 2h) )$. Es fehlen das Minuszeichen statt „·“ und der Faktor $cos alpha$. Zahlenprobe (eigene Ergänzung): $G = 200 "N"$, $l = 4 "m"$, $h = 1","5 "m"$, $alpha = 30 degree$ → $N_2 = 115","5 "N"$, $S = 57","7 "N"$, $N_1 = 100","0 "N"$.], fill: sand)
#strong[(2) Balken mit Parallelführung] (Skript TM1 S. 113): Links eine Führung, die nur eine horizontale Kraft $A$ und ein Moment $M_A$ aufnimmt, bei $a$ ein Loslager B, am Ende $F$. Mit $sum M_((B))$ folgt direkt $M_A = (L - a)F$; außerdem $A = 0$, $B = F$.
#strong[(3) Scheibe mit drei Stäben] (Skript TM1 S. 114): Eine Scheibe (Radius $r$) wird von drei Stäben gehalten und durch ein eingeprägtes Moment $M_0$ belastet. Jeder Stab liegt auf der Verlängerung einer Seite des eingeschriebenen gleichseitigen Dreiecks (Seitenlänge $a = 2r cos 30 degree = sqrt(3) thin r$). Trick: Momentengleichgewicht um die Schnittpunkte von je zwei Stäben (A, B, C) → jede Gleichung enthält nur eine Stabkraft:
#form[$ sum M_((C)) colon -M_0 - a thin S_1 cos 30 degree = 0 med => med S_1 = - frac(M_0, sqrt(3) thin r dot frac(sqrt(3), 2)) = - frac(2M_0, 3r) = S_2 = S_3 $]
Der Hebelarm $a cos 30 degree = 1","5 thin r$ ist die Höhe des Dreiecks. Negatives Vorzeichen → bei dem gewählten Drehsinn von $M_0$ sind die Stäbe gedrückt (Zugansatz).
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k3_parallelf", [Skript TM1 S. 113 (Mitschrift): Balken mit Parallelführung A und Loslager B.], height: 50mm)],
 [#bild("tm1k3_scheibe", [Skript TM1 S. 114 (Mitschrift): Scheibe mit drei Stäben; Momente um die Stabschnittpunkte.], height: 50mm)])
#heading(level: 4, outlined: false)[Folienbeispiel: Greifmechanismus ★]
Ein symmetrischer Greifer hält die Last $G = 460 "N"$ durch Reibung in A und B. Gelenke reibungsfrei, Greifer gewichtslos. Geg.: $a = 5 "cm"$, $b = 3 "cm"$, $c = 1","5 "cm"$, $d = 5","9 "cm"$, $h = 8","2 "cm"$. Ges.: Kräfte A und B.
#bild("tm1k3_greifer", [Skript TM1 S. 110 (untere Folie): Aufgabenstellung Greifmechanismus.], height: 45mm)
#note([Lösung (nach deiner Mitschrift S. 115–117, Zahlen nachgerechnet)], [+ #strong[Gesamtsystem:] $sum F_y colon -G + S = 0$ → Seilkraft $S = G = 460 "N"$.
+ #strong[Knoten C] (Seil + zwei Lenker 1, 2): Symmetrie → $S_("1y") = S_("2y")$. $sum F_y colon S + 2S_("1y") = 0$ → $S_("1y") = -230 "N"$. Lenkerneigung $tan alpha = frac(c, a/2) = frac(1","5, 2","5) = 0","6$ → $S_("1x") = S_("1y")/ tan alpha = -383","3 "N"$, $|S_1 | = sqrt(383","3^2 + 230^2) = 447","0 "N"$ (Druck).
+ #strong[Linker Arm] (Kräfte: Lenker oben, Querstab 3 auf Höhe $d$, Last in A): $sum M_((A)) colon -(h-d)S_3 - h thin S_("1x") + ( frac(a, 2) - frac(b, 2) )S_("1y") = 0$
   \
  → $S_3 = frac((2","5 - 1","5)(-230) - 8","2 thin (-383","3), 8","2 - 5","9) = frac(2913","3, 2","3) = 1266","7 "N"$ (Zug).
+ $sum F_x colon A_x = S_3 + S_("1x") = 1266","7 - 383","3 = 883","3 "N"$ (Anpresskraft); $sum F_y colon A_y = -S_("1y") = 230 "N" = G/2$ (Reibkraft).
+ $A = B = sqrt(883","3^2 + 230^2) = 912","8 "N"$.
Plausibel: Jede Backe trägt die halbe Last (230 N) über Reibung; dafür muss sie fast viermal so stark anpressen.], fill: pale)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k3_greifer_ges", [Skript TM1 S. 115 (Mitschrift): Gesamtsystem und Knoten C.], height: 50mm)],
 [#bild("tm1k3_greifer_arm", [Skript TM1 S. 116 (Mitschrift): Freikörperbild des Arms und Gleichgewicht.], height: 50mm)])
#note([Fehler vermeiden – Rundungs-/Schreibfehler in deiner Mitschrift (Skript TM1 S. 116)], [Dort steht $S_3 = 1266"," overline(3) "N"$. Richtig ist $2913"," overline(3)/2","3 = 1266"," overline(6) "N"$. Dein $A_x = 883"," overline(3) "N"$ auf S. 117 stimmt (passt zu $1266"," overline(6)$). Den Betrag $A$ hast du nur als Wurzel notiert: $A = 912","8 "N"$.], fill: sand)
#note([WI-Beispiel: Kippen eines Gabelstaplers (eigene Ergänzung)], [Ein Stapler wiegt $G = 30 "kN"$; sein Schwerpunkt liegt 1,0 m hinter der Vorderachse. Die Last $Q$ hängt 0,6 m vor der Vorderachse. Ab welcher Last kippt er?
+ An der Kippgrenze hebt die Hinterachse ab → Hinterachskraft = 0. Es bleibt nur die Vorderachskraft $V$.
+ $sum M_((V)) = 0$ (Bezugspunkt Vorderachse, $V$ fällt heraus): $G dot 1","0 "m" - Q dot 0","6 "m" = 0$.
+ $Q_(max) = frac(30 dot 1","0, 0","6) = 50 "kN"$. Mit Sicherheitsfaktor gibt der Hersteller deutlich weniger als Traglast an.], fill: pale)
#note([Fehler vermeiden (typische Fehler beim GGW)], [(1) Moment $M$ vergessen, weil es kein Pfeil ist. In $sum F$ kommt es #strong[nicht] vor, in $sum M$ #strong[immer] (unabhängig vom Bezugspunkt). (2) Positiven Drehsinn nicht festgelegt. (3) Unbekannte Kräfte „richtig herum“ raten wollen: einfach positiv ansetzen, das Vorzeichen des Ergebnisses zeigt die wahre Richtung. (4) Drei Momentengleichungen um Punkte auf einer Geraden.], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Bezugspunkt beliebig – Beweis:] $sum M^((A)) = sum M^((B)) - x_A sum F_("iy") + y_A sum F_("ix")$. Sind die Kraftsummen null, sind alle Momentensummen gleich. A darf auch außerhalb des Körpers liegen. #text(fill: muted)[\[TM1-Buch S. 54–55\]]
- #strong[Bedingungen der Alternativen] (3.14)–(3.16): A und B dürfen nicht auf einer Geraden senkrecht zur Richtung der Kraftbedingung liegen; A, B, C nicht auf einer Geraden. #text(fill: muted)[\[TM1-Buch S. 55–56\]]
- #strong[Tipp:] „Es ist meist zweckmäßig, den Bezugspunkt … so zu wählen, dass er auf der Wirkungslinie einer Kraft liegt.“ (Beispiel 3.2, gewichtsloser Balken auf einem Lager). #text(fill: muted)[\[TM1-Buch S. 57–58\]]
- #strong[Dreikräftesatz:] Drei nichtparallele Kräfte sind nur im GGW, wenn ihre WL durch einen Punkt gehen (genutzt in Übung 4.5 und Beispiel 3.5 Kugelkalotte). #text(fill: muted)[\[TM1-Buch S. 60–61, 63\]]
- #strong[Symbolik:] Das Buch schreibt das Momentengleichgewicht kurz als „$attach(A, t: arrow.ccw) colon$“ = Summe der Momente um A, Pfeilrichtung positiv. #text(fill: muted)[\[TM1-Buch S. 56\]]])
#src[Skript TM1 S. 106–111 (Folien „1.4 Gleichgewichtsbedingungen“, datiert 10.11.), S. 112–117 (Mitschrift: Beispiele); FS TM1 S. 23–24 (Gl. 3.8–3.10); TM1-Buch S. 54–61, 63.]
== 3.2 Allgemeine Kräftegruppen im Raum <a-tm1-3-2>
Im Raum kann sich ein Körper in drei Richtungen verschieben und um drei Achsen drehen (6 Freiheitsgrade). Das Moment wird zum #strong[Vektor] (Momentenvektor), berechnet über das Kreuzprodukt. Im Skript steht dieser Abschnitt nur in der Kapitelübersicht und in der Formelsammlung; ausführliche Folien oder eine Mitschrift dazu gibt es nicht. Auch in Kap. 5 ist „Einteilige räumliche Tragwerke“ in der Gliederung durchgestrichen (Skript TM1 S. 146). Lerne daher nur die Grundformeln.
#heading(level: 3, outlined: false)[Formeln]
#form[$ arrow(M) = arrow(h) times arrow(F) = mat(delim: "(", h_x ; h_y ; h_z ) times mat(delim: "(", F_x ; F_y ; F_z ) = mat(delim: "(", h_y F_z - h_z F_y ; h_z F_x - h_x F_z ; h_x F_y - h_y F_x ) $


$ sum F_("ix") = 0, sum F_("iy") = 0, sum F_("iz") = 0, wide sum M_("ix"(A)) = 0, sum M_("iy"(A)) = 0, sum M_("iz"(A)) = 0 $]
FS TM1 S. 24 (Gl. 3.11, 3.12). Bezugspunkt A beliebig. Die z-Komponente ist genau die ebene Formel $h_x F_y - h_y F_x$.
#note([Merke], [Der Momentenvektor steht senkrecht auf der Ebene aus $arrow(h)$ und $arrow(F)$. Seine Richtung folgt der #strong[Rechtsschraube]: Daumen der rechten Hand in Vektorrichtung, die Finger zeigen den Drehsinn. Ein Moment ist ein #strong[freier Vektor] (beliebig verschiebbar).])
#note([In eigenen Worten], [Ein Korkenzieher: Drehst du ihn rechts herum (von oben gesehen im Uhrzeigersinn), wandert er nach unten in den Korken. Drehsinn und Vorschubrichtung gehören fest zusammen, genau wie Drehsinn und Richtung des Momentenvektors. #text(fill: muted)[(eigene Ergänzung)]])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Momentenvektor] $arrow(M)^((0)) = arrow(r) times arrow(F)$; Betrag $M = r F sin phi = h F$ = Fläche des Parallelogramms aus $arrow(r)$ und $arrow(F)$. Darstellung meist als Doppelpfeil. #text(fill: muted)[\[TM1-Buch S. 67–69\]]
- #strong[Kraft- und Momentenvektoren] haben verschiedene Dimensionen und dürfen nie addiert werden. #text(fill: muted)[\[TM1-Buch S. 68\]]
- #strong[Gleichgewicht im Raum:] drei Kräfte- und drei Momentenbedingungen. #text(fill: muted)[\[TM1-Buch S. 74, 85\]]
- #strong[Dyname / Kraftschraube:] Ein räumliches System lässt sich auf Kraft + Moment reduzieren; die Zentralachse ist die WL, auf der beide parallel sind. Nicht in der Vorlesung. #text(fill: muted)[\[TM1-Buch S. 79–82\]]])
#src[Skript TM1 S. 4 (Übersicht), S. 100 (Mitschrift: $arrow(M) = arrow(h) times arrow(F)$), S. 146; FS TM1 S. 24; TM1-Buch S. 67–85.]
#grid(columns: 2, gutter: 5mm,
 [#bild("map-t1k3a", [Mindmap: Moment. Eigene Darstellung nach Skript TM1 S. 97–105.], height: 44mm)],
 [#bild("map-t1k3b", [Mindmap: Gleichgewicht am starren Körper. Eigene Darstellung nach Skript TM1 S. 106–117.], height: 44mm)])

*Der Zusammenhang in Kapitel 3.* Liegen die Wirkungslinien beliebig, kann ein Körper nicht nur verschoben, sondern auch gedreht werden. Die Drehwirkung misst das Moment: Kraft mal senkrechter Abstand. Ein Kräftepaar ist reines Moment und darf frei wandern; eine Kraft darf nur längs ihrer Wirkungslinie wandern, sonst kommt ein Versetzmoment dazu. So lässt sich jedes ebene System auf eine Kraft und ein Moment in einem Punkt reduzieren. Gleichgewicht heißt dann: beide null. Daraus folgen drei Gleichungen für drei Unbekannte, und mit klug gewähltem Bezugspunkt fällt in jeder Gleichung möglichst viel heraus.

#pagebreak()
== Verständnisfragen und Rechenaufgaben · Kapitel 3
#set enum(spacing: 0.85em)
Erkläre erst selbst. Bei Rechenaufgaben zuerst das Freikörperbild und den positiven Drehsinn festlegen. Die Lösungen folgen getrennt.

+ Wann bilden zwei Kräfte ein Kräftepaar? Nenne alle drei Bedingungen.
+ Warum kann ein Kräftepaar nicht durch eine Einzelkraft ersetzt werden?
+ Was bedeutet „ein Kräftepaar ist frei verschiebbar“? Gilt das auch für eine Kraft?
+ Welcher Drehsinn ist positiv? Welche Achse steckt dahinter?
+ Was passiert, wenn man eine Kraft parallel auf eine Wirkungslinie durch einen Punkt 0 verschiebt?
+ Warum hängt das Moment einer Kraft vom Bezugspunkt ab, das Moment eines Kräftepaares aber nicht?
+ Was ist der Hebelarm einer Kraft?
+ Auf welche zwei Größen kann man jedes ebene Kräftesystem reduzieren? Wann bleibt nur eine Einzelkraft übrig?
+ Warum gibt es in der Ebene genau drei Gleichgewichtsbedingungen?
+ Darf der Momentenbezugspunkt außerhalb des Körpers liegen? Begründe.
+ Welche Bedingung gilt für die Alternative „dreimal $sum M$“? Was geht sonst schief?
+ Wie wählst du den Momentenbezugspunkt, um möglichst wenig rechnen zu müssen?
+ Wie geht ein Moment $M$ in $sum F_x$, $sum F_y$ und $sum M$ ein?
+ Wie viele Gleichgewichtsbedingungen gibt es im Raum, und warum?
+ Ein Kräftepaar besteht aus zwei Kräften von je 250 N mit 0,8 m Abstand der Wirkungslinien; es dreht im Uhrzeigersinn. Gib $M$ mit Vorzeichen an. Welche Kraft bräuchte ein gleichwertiges Paar mit 0,5 m Abstand? #text(fill: muted)[(eigene Aufgabe)]
+ Eine Kraft $F = 1 "kN"$ wirkt im Punkt $(3 "m"; -1 "m")$ unter 45° zur x-Achse nach rechts oben. Berechne $M_((0))$ um den Ursprung und den Hebelarm. #text(fill: muted)[(eigene Aufgabe)]
+ Auf einem Balken ($x$ von 0 bis 6 m) wirken $F_1 = 4 "kN"$ bei $x = 1 "m"$ nach unten, $F_2 = 2 "kN"$ bei $x = 5 "m"$ nach unten und $M = -6 "kNm"$. Wo liegt die Wirkungslinie der Resultierenden? #text(fill: muted)[(eigene Aufgabe)]
+ Einfeldträger: Festlager A bei $x = 0$, Loslager B bei $x = 5 "m"$, $F = 10 "kN"$ nach unten bei $x = 2 "m"$, Moment $M = +5 "kNm"$ bei $x = 4 "m"$. Berechne $A_x$, $A_y$, $B$ und mache die Probe mit $sum M$ um B. #text(fill: muted)[(eigene Aufgabe)]
+ Folienbeispiel Balken: $F_1 = 3 "kN"$, $F_2 = 6 "kN"$, $a = "0,5" "m"$, $l = 3 "m"$. Wie groß muss $M$ sein, damit $B = 0$ ist? Wie groß sind dann $A_x$ und $A_y$? #text(fill: muted)[(Zahlen eigene Wahl)]
+ Greifer wie auf der Folie, aber $G = 600 "N"$ (alle Maße gleich). Wie groß sind $S_3$ und $A$? #text(fill: muted)[(Zahlen eigene Wahl)]

#heading(level: 3, outlined: false)[Vertiefende Verständnisfragen und Rechenaufgaben]
#block[
#set enum(start: 21)
+ *Übung 5, Aufg. 5.1:* Ein gewichtsloser Stab der Länge $l$ liegt waagerecht zwischen zwei glatten schiefen Ebenen ($alpha$, $beta$); darauf liegt $G$. a) Lagerkräfte? b) In welchem Abstand $x$ muss $G$ liegen, damit Gleichgewicht herrscht? c) Werte für $l = 120 "cm"$, $alpha = 35°$, $beta = 40°$, $G = 150 "kN"$.
  #bild("tm1k3_ue51", [Übung 5 (Aufgabenblatt S. 1): Skizze zu Aufgabe 5.1.], height: 32mm)
+ *Übung 5, Aufg. 5.2:* Eine homogene Kreisscheibe (Gewicht $G$, Radius $r$) wird von drei Stäben gehalten und durch ein Moment $M_0$ belastet. a) Stabkräfte $S_1$, $S_2$, $S_3$? b) Bei welchem Moment wird $S_1$ null?
  #bild("tm1k3_ue52", [Übung 5 (Aufgabenblatt S. 1): Skizze zu Aufgabe 5.2.], height: 30mm)
+ *Übung 5, Aufg. 5.3:* Zwei glatte Walzen (Gewicht $G$, Radius $r$, Mittelpunktabstand $a$) liegen in einer Vertiefung. Ein gewichtsloser Hebel (Länge $l$) wird mit $F$ belastet; auch sein Bodenkontakt ist glatt. Gesucht sind die Kräfte a) zwischen Hebel und Walzen, b) zwischen Hebel und Boden, c) zwischen Walzen und Boden bzw. Wänden.
  #bild("tm1k3_ue53", [Übung 5 (Aufgabenblatt S. 1): Skizze zu Aufgabe 5.3.], height: 36mm)
+ *Übung 5, Aufg. 5.4:* Vereinfachte Werkstoffprüfmaschine: Wie groß ist bei der Belastung $F$ die Zugkraft in der Probe? Gegengewicht $Q$ und Hebelgewichte gleichen sich aus.
  #bild("tm1k3_ue54", [Übung 5 (Aufgabenblatt S. 4): Skizze zu Aufgabe 5.4.], height: 36mm)
+ *Übung 4, Aufg. 4.5 noch einmal:* Löse den Stab an Ecke und Wand jetzt mit dem Momentengleichgewicht statt mit dem Dreikraftsystem (Skizze in Kapitel 2, Aufgabe 31).
+ *Buch:* Wie lautet das Hebelgesetz von Archimedes für zwei parallele Kräfte, und wie folgt es aus der Konstruktion mit $plus.minus K$? (TM1-Buch S. 45–46)
+ *Buch:* Warum schreibt man „N m“ und nicht „m N“? (TM1-Buch S. 47)
+ *Buch:* Zeige mit $sum M^((A)) = sum M^((B)) - x_A sum F_"iy" + y_A sum F_"ix"$, dass der Bezugspunkt beliebig ist. (TM1-Buch S. 54–55)
+ *Buch:* Was versteht man unter einem „freien Vektor“, und welche Größe ist einer? (TM1-Buch S. 71)
]

#pagebreak()
== Lösungen Kapitel 3
#set enum(spacing: 0.65em)
+ Gleich groß, entgegengesetzt gerichtet, auf parallelen, aber verschiedenen Wirkungslinien. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1-1>)]
+ Die Kräftesumme ist null, eine Ersatzkraft hätte also den Betrag null und könnte die Drehwirkung nicht abbilden. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1-1>)]
+ Man darf es an jede Stelle des starren Körpers legen, die Drehwirkung bleibt gleich. Eine Kraft darf nur längs ihrer Wirkungslinie verschoben werden. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1-1>)]
+ Gegen den Uhrzeigersinn ist positiv; das ist die positive Drehung um die z-Achse, die aus der Zeichenebene zeigt. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1-1>)]
+ Die Wirkung ändert sich. In 0 muss ein Moment $M_((0)) = h_s F$ mit passendem Drehsinn dazukommen. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1-2>)]
+ Bei einer Kraft ändert sich mit dem Bezugspunkt der Hebelarm. Beim Kräftepaar ändern sich beide Hebelarme gleich; die Differenz $h_s$ bleibt. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1-2>)]
+ Der senkrechte Abstand zwischen Bezugspunkt und Wirkungslinie. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1-2>)]
+ Auf $F_R$ in A und $M_(R(A))$. Ist $F_R != 0$, verschiebt man $F_R$ um $h_s = M_(R(A)) \/ F_R$; dann bleibt nur $F_R$. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1-3>)]
+ Ein Körper in der Ebene hat drei Freiheitsgrade (zwei Verschiebungen, eine Drehung); jede muss verhindert sein. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1-4>)]
+ Ja. Sind die Kraftsummen null, ist die Momentensumme um jeden Punkt gleich. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1-4>)]
+ A, B, C dürfen nicht auf einer Geraden liegen; sonst bliebe eine Kraft längs dieser Geraden unentdeckt. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1-4>)]
+ Auf den Schnittpunkt möglichst vieler unbekannter Kräfte. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1-4>)]
+ In $sum F_x$ und $sum F_y$ gar nicht, in jeder Momentensumme mit Wert und Vorzeichen, egal um welchen Punkt. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1-4>)]
+ Sechs: drei Kraft- und drei Momentenbedingungen, weil ein Körper im Raum drei Verschiebungen und drei Drehungen hat. #nachschlagen[Lernskript, #stelle(<a-tm1-3-2>)]
+ $M = -"0,8" dot 250 = -200 "Nm"$. Gleichwertig: $F' = 200 \/ "0,5" = 400 "N"$. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1-1>)]
+ $F_x = F_y = "707,1" "N"$. $M_((0)) = 3 dot "707,1" - (-1) dot "707,1" = 2828 "Nm" = "2,83" "kNm"$ (links herum), $h_s = "2,83" "m"$. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1-2>)]
+ $F_R = 6 "kN"$ nach unten, $M_(R(0)) = -4 dot 1 - 2 dot 5 - 6 = -20 "kNm"$, also $x = 20 \/ 6 = "3,33" "m"$. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1-3>)]
+ $A_x = 0$. $sum M_((A)): -10 dot 2 + 5 + 5 B = 0$, also $B = 3 "kN"$; $A_y = 10 - 3 = 7 "kN"$. Probe um B: $-5 dot 7 + 10 dot 3 + 5 = 0$. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1-4>)]
+ $M = 6 dot "1,5" + 3 dot "0,5" = "10,5" "kNm"$, $A_x = -3 "kN"$, $A_y = 6 "kN"$. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1-4>) (Folienbeispiel Balken)]
+ Alles skaliert linear mit $G$ (Faktor 600/460): $S_3 = "1652" "N"$, $A_x = "1152" "N"$, $A_y = 300 "N"$, $A = "1191" "N"$. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1-4>) (Greifmechanismus)]
+ a) $A = G sin beta \/ sin(alpha + beta) = "99,8" "kN"$, $B = G sin alpha \/ sin(alpha + beta) = "89,07" "kN"$. b) Aus $sum M_((A)) = 0$: $x = l sin alpha cos beta \/ sin(alpha + beta) = "54,59" "cm"$. Deine Rechnung (Aufgabenblatt S. 2) kommt über $B = G \/ (sin beta cot alpha + cos beta)$ zum selben $x = "54,59" "cm"$. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1-4>)\; Lösung Übung 5 S. 1–2]
+ a) $S_2 = sqrt(2) G$, $S_1 = M_0 \/ r + G$, $S_3 = M_0 \/ r$ (Ansatz und Vorzeichen wie in der Lösung). b) $S_1 = 0$ bei $M_0 = -r G$. Deine Gleichungen dazu stehen auf dem Aufgabenblatt S. 3. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1-4>)\; Lösung Übung 5 S. 2]
+ a) Aus $sum M_((0))$ am Hebel: $D_1 = D_2 = (l \/ a) F$. b) $N_3 = F$. c) $N_1 = G - (l\/a) F sqrt(1 - 4 r^2 \/ a^2)$, $N_2 = G + (l\/a) F sqrt(1 - 4 r^2 \/ a^2)$, $N_4 = N_5 = 2 r l F \/ a^2$. Der Abstand $x$ fällt heraus. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1-4>)\; Lösung Übung 5 S. 3–4]
+ $Z = 6 (6 F - Q)$; mit $Q$ als reinem Gegengewicht $Z = 36 F$. Jeder Hebel liefert über $sum M = 0$ am Drehpunkt eine Übersetzung. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1-4>)\; Übung 5 S. 4]
+ Kräfte: $G$ in Stabmitte (Abstand $2a$ von B längs des Stabs), $A$ senkrecht zum Stab (Abstand $a \/ cos alpha$ von B), $B$ waagerecht. $sum M_((B)) = 0$: $A dot a \/ cos alpha = G dot 2 a cos alpha$, also $A = 2 G cos^2 alpha$. $sum F_y = 0$: $A cos alpha = G$. Zusammen $cos^3 alpha = "0,5"$, $alpha = "37,5" degree$ wie mit dem Dreikraftsystem. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1-4>)\; Übung 4 S. 2]
+ $a_1 F_1 = a_2 F_2$. Aus den ähnlichen Dreiecken der Konstruktion folgt $a_1 \/ l = K \/ F_1$ und $a_2 \/ l = K \/ F_2$; gleichsetzen liefert das Hebelgesetz. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1>)\; TM1-Buch S. 45–46]
+ „mN“ wäre Millinewton; darum steht die Länge hinten: N m. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1-2>)\; TM1-Buch S. 47]
+ Gilt $sum F_"ix" = 0$ und $sum F_"iy" = 0$, fallen die Zusatzterme weg: $sum M^((A)) = sum M^((B))$. #nachschlagen[Lernskript, #stelle(<a-tm1-3-1-4>)\; TM1-Buch S. 54–55]
+ Ein Vektor, der beliebig parallel verschoben werden darf, ohne dass sich die Wirkung ändert: das Moment eines Kräftepaares. #nachschlagen[Lernskript, #stelle(<a-tm1-3-2>)\; TM1-Buch S. 71]

#pagebreak()
= TM1 Kapitel 4 · Schwerpunkt <k-tm1-4>
#tab(columns: 2,
 [Vorlesungen], [Foliensatz „Schwerpunkt“ (Wintersemester 2025, Folien 1–37). Deine Mitschrift zu Beispiel 1 ist auf den 17.11.25 datiert; die Beispiele 2–4 stehen ohne Datum dahinter. Im WZF hat Sosnowsky das Thema Streckenlast vertieft (Foliensatz Stand 1.12.2025).],
 [Quellen], [Skript TM1 S. 118–145 (Folien und deine Mitschrift S. 122–123, 139–145); WZF-Skript S. 62–100 (Streckenlast; S. 110–153 ist eine Kopie davon); FS TM1 S. 25–29 mit deiner Notiz auf S. 29; TM1-Buch Kap. 4 (S. 87–109)],
 [Passende Übungen], [Übung 6: 6.1–6.4 (deine Rechnung zu 6.1 a steht auf dem Aufgabenblatt S. 2)],
)
Ein Körper hat sein Gewicht nicht an einem Punkt, es ist über das ganze Volumen verteilt. Für das Gleichgewicht darfst du die verteilte Last aber durch #strong[eine einzige Kraft] ersetzen, wenn du sie am richtigen Ort ansetzt: im #strong[Schwerpunkt]. Genau diesen Ort berechnest du in Kapitel 4. Du brauchst ihn ab Kapitel 5 in fast jeder Aufgabe mit Streckenlast.
#note([Dein Feynman-Schritt: die 5 Kernideen von Kapitel 4. Erst ohne Skript aufzählen und erklären, dann vergleichen.], [+ #strong[Ersatzkraft:] Parallele Kräfte oder eine verteilte Last lassen sich durch eine Resultierende $F_R$ ersetzen. Ihr Ort $x_s$ folgt aus dem Momentengleichgewicht.
+ #strong[Gewichtetes Mittel:] $x_s = sum x_i F_i \/ sum F_i$. Bei verteilten Lasten wird die Summe zum Integral.
+ #strong[Streckenlast = Fläche:] $F_R$ ist die Fläche unter $q(x)$, und $F_R$ greift im Schwerpunkt dieser Fläche an (Rechteck: Mitte, Dreieck: 1/3 von der hohen Seite).
+ #strong[Zusammensetzen:] Bekannte Teilflächen in einer Tabelle sammeln; Löcher zählen als negative Flächen.
+ #strong[Symmetrie spart Arbeit:] Symmetrieachsen sind Schwerachsen; dort ist das statische Moment null.
Zusammenfassung der Abschnitte 4.1–4.3; Quellen stehen dort.])
#bild("tm1k4_inhalt", [Skript TM1 S. 118 (untere Folie 2): Gliederung des Foliensatzes „Schwerpunkt“.], height: 48mm)

== 4.0 Einführung <a-tm1-4-0>
Die Folie ordnet das Thema nach drei Fragen:
#tab(columns: 2,
 th([Frage], [Möglichkeiten laut Folie]),
 [Welcher Körper?], [1D: gerader Balken · 2D: Fläche oder Linie · 3D: Volumen],
 [Welche Last?], [Einzelkräfte $F_i$ oder kontinuierlich verteilte Lasten ($q$, $p$, $f$); konstant (z. B. $q = q_0$) oder veränderlich (z. B. $p(x, y)$)],
 [Welche Richtung?], [für den ganzen Körper gleich (parallel). Hergeleitet wird meist mit Lasten „nach unten“, die Formeln gelten aber für jede Richtung.],
)
#note([Ziel (Folie 4)], [Die verteilte Belastung wird ersetzt durch #strong[eine Resultierende] am „richtigen“ Angriffspunkt: dem #strong[Schwerpunkt].])
#note([In eigenen Worten], [Ein Kellner trägt ein Tablett mit Gläsern auf einer Hand. Er muss die Hand genau unter den gemeinsamen Schwerpunkt aller Gläser schieben, sonst kippt das Tablett. Mit diesem Bild (Butler mit Tablett) beginnt auch Sosnowsky im WZF. #text(fill: muted)[(Bild aus WZF-Skript S. 64)]])
#src[Skript TM1 S. 119 (Folien 3–4); WZF-Skript S. 63–64; TM1-Buch S. 88.]

== 4.1 Balken <a-tm1-4-1>
=== 4.1.1 Balken mit parallelen Einzelkräften <a-tm1-4-1-1>
Aus Kapitel 2 und 3 weißt du: Jede ebene Kräftegruppe (außer einem reinen Kräftepaar) lässt sich durch eine Resultierende $F_R$ ersetzen. Sind alle $F_i$ parallel, ist auch $F_R$ parallel zu ihnen. Die Folie führt dazu die #strong[Haltekraft] $H = -F_R$ ein: Sie liegt auf derselben Wirkungslinie wie $F_R$, zeigt aber entgegen und hält das System im Gleichgewicht.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k4_einzel", [Skript TM1 S. 120 (untere Folie 6): gewichtsloser Balken mit parallelen Kräften $F_1$ bis $F_n$, Haltekraft $H$ im Abstand $x_s$.], height: 50mm)],
 [#bild("tm1k4_einzel_ggw", [Skript TM1 S. 121 (obere Folie 7): Gleichgewicht liefert $F_R$ und $x_s$.], height: 50mm)])
Mit $sum F_"iy" = 0$ und $sum M_((0)) = 0$ am Balken:
#form[$ H - sum_(i=1)^n F_i = 0 quad => quad F_R = H = sum_(i=1)^n F_i, wide H dot x_s - sum_(i=1)^n x_i F_i = 0 quad => quad x_s = frac(sum_(i=1)^n x_i F_i, sum_(i=1)^n F_i) $]
FS TM1 S. 25 (Gl. 4.1, 4.2). $x_s$ heißt #strong[Kräftemittelpunkt] oder Schwerpunkt der Kräftegruppe. $x_i$: Abstand der Kraft $F_i$ vom Bezugspunkt 0.
#note([Merke], [$x_s$ ist ein #strong[gewichteter Mittelwert] der Orte $x_i$. Große Kräfte ziehen den Schwerpunkt zu sich.])
Wirken alle Kräfte #strong[schräg] unter demselben Winkel $alpha$, gilt dieselbe Formel mit den Beträgen, denn $sin alpha$ kürzt sich heraus:
$ |H| sin alpha dot x_s - sum x_i |F_i| sin alpha = 0 quad => quad x_s = frac(sum x_i |F_i|, sum |F_i|) $
#bild("tm1k4_schraeg", [Skript TM1 S. 121 (untere Folie 8): parallele Kräfte unter gleichem Winkel $alpha$.], height: 48mm)
#heading(level: 4, outlined: false)[Beispiel 1 aus deiner Mitschrift (17.11.25)]
Balken mit Festlager A und Loslager B, Abstände je $L$ (Gesamtlänge $3L$). Bei $x = L$ wirkt $3F$, bei $x = 2L$ wirkt $F$. Gesucht: Lagerkräfte. Du hast zwei Wege gerechnet:
#tab(columns: 2,
 th([Weg 1: ohne Schwerpunkt], [Weg 2: erst Resultierende]),
 [$sum F_x: A_x = 0$ \ $sum M_((A)): -L dot 3F - 2L dot F + 3L dot B = 0$ \ $=> B = 5\/3 F$ \ $sum F_y: A_y = 4F - B = 7\/3 F$], [$F_R = 3F + F = 4F$ \ $x_s = frac(L dot 3F + 2L dot F, 4F) = 5\/4 L$ \ $sum M_((A)): -5\/4 L dot 4F + 3L dot B = 0 => B = 5\/3 F$ \ $A_y = 4F - B = 7\/3 F$],
)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k4_bsp1a", [Deine Mitschrift (Skript TM1 S. 122): Beispiel 1, Lösung ohne Schwerpunkt.], height: 70mm)],
 [#bild("tm1k4_bsp1b", [Deine Mitschrift (Skript TM1 S. 123, datiert 17.11.25): Lösung mit Resultierender und Schwerpunkt.], height: 70mm)])
Beide Wege liefern dasselbe. Die Resultierende ist also nur eine Abkürzung; die Lagerkräfte ändern sich nicht.
#note([Fehler vermeiden], [Die Ersatzkraft ersetzt die Einzelkräfte #strong[nur für das Gleichgewicht des ganzen Körpers]. Für die Schnittgrößen (Kapitel 7) darfst du nicht vorher zusammenfassen, sonst verschwindet der Verlauf zwischen den Kräften. Der Zusammenhang folgt aus der Definition der Resultierenden #text(fill: muted)[(eigene Ergänzung)].], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Kräftemittelpunkt:] Das Buch leitet $x_s = sum x_i F_i \/ sum F_i$ genauso über das Momentengleichgewicht her und nennt $x_s$ „Kräftemittelpunkt oder Schwerpunkt“. #text(fill: muted)[\[TM1-Buch S. 89–90\]]])
#src[Skript TM1 S. 120–123 (Folien 5–8, Mitschrift 17.11.25); FS TM1 S. 25; TM1-Buch S. 89–90.]

=== 4.1.2 Balken mit Streckenlast <a-tm1-4-1-2>
Jetzt ist die Last stetig verteilt: $q(x)$ in N/m von $x = 0$ bis $l$. Man zerlegt sie in unendlich kleine Einzellasten $d F = q(x) dif x$. Aus der Summe wird ein Integral:
#form[$ F_R = H = integral_0^l q(x) dif x, wide x_s = frac(integral_0^l x q(x) dif x, integral_0^l q(x) dif x) $]
FS TM1 S. 25 (Gl. 4.3, 4.4). Die Streckenlast wird durch die wirkungsgleiche Kraft $F_R$ am Ort $x_s$ ersetzt. Laut Folie: „Häufige Anwendung in TM I und TM II.“
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k4_strecke", [Skript TM1 S. 124 (obere Folie 9): Streckenlast $q(x)$, Element $q(x) dif x$, Ersatzkraft $F_R$ im Schwerpunkt.], height: 50mm)],
 [#bild("tm1k4_strecke_ggw", [Skript TM1 S. 124 (untere Folie 10): aus $sum$ wird $integral$.], height: 50mm)])
#note([Merke ★], [#strong[$F_R$ = Fläche unter der Lastkurve.] #strong[$x_s$ = Schwerpunkt dieser Fläche.] Damit rechnest du fast jede Streckenlast ohne Integral.])
#heading(level: 4, outlined: false)[Die drei Grundfälle]
#tab(columns: 3,
 th([Last], [$F_R$], [$x_s$ (von links)]),
 [konstant $q_0$ (Rechteck)], [$q_0 l$], [$l\/2$],
 [linear steigend, 0 → $q_0$], [$q_0 l \/ 2$], [$2l\/3$],
 [linear fallend, $q_0$ → 0], [$q_0 l \/ 2$], [$l\/3$],
)
Folie 11 (konstant) und Folie 12–13 (fallend, $q(x) = q_0 (1 - x\/l)$) rechnen das per Integral; Sosnowsky zeigt im WZF alle drei Fälle einzeln (WZF-Skript S. 69–74).
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k4_konst", [Skript TM1 S. 125 (obere Folie 11): konstante Streckenlast, $F_R = q_0 l$, $x_s = l\/2$.], height: 50mm)],
 [#bild("tm1k4_dreieck1", [Skript TM1 S. 125 (untere Folie 12): dreieckförmige Last; Geradengleichung $q(x) = q_0 (1 - x\/l)$ aufstellen.], height: 50mm)])
#bild("tm1k4_dreieck2", [Skript TM1 S. 126 (obere Folie 13): $F_R = q_0 l\/2$, $x_s = l\/3$; unten rechts deine Skizzen zum Schwerpunkt rechtwinkliger Dreiecke (1/3 und 2/3).], height: 52mm)
#note([Von dir notiert (Skript TM1 S. 126)], [Neben „Schwerpunkt rechtwinkliger Dreiecke“ hast du zwei Dreiecke skizziert: Der Schwerpunkt liegt #strong[$1\/3 l$ von der hohen Seite] und #strong[$2\/3 l$ von der Spitze] entfernt. Das ist die Regel, mit der du Dreieckslasten ohne Integral erledigst.], fill: sand)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k4_wzf_steigend", [WZF-Skript S. 72: steigende Streckenlast, $x_"Res" = 2l\/3$ per Integral.], height: 42mm)],
 [#bild("tm1k4_wzf_fallend", [WZF-Skript S. 74: fallende Streckenlast, $x_"Res" = l\/3$.], height: 42mm)])
#bild("tm1k4_wzf_flaeche", [WZF-Skript S. 96: steigende Streckenlast als Geradengleichung $q(x) = q_0 x \/ L$ und als Fläche mit $F_"Res" = 1\/2 q_0 L$ bei $x = 2\/3 L$.], height: 52mm)
#note([Geradengleichung aufstellen (WZF-Skript S. 94–100)], [Jeder lineare Abschnitt ist eine Gerade $q(x) = m x + b$:
- steigend von 0 auf $q_0$: $b = 0$, $m = q_0 \/ L$, also $q(x) = q_0 x \/ L$
- fallend von $q_0$ auf 0: $b = q_0$, $m = -q_0 \/ L$, also $q(x) = q_0 - q_0 x \/ L$
- konstant: $m = 0$, $q(x) = q_0$])
#heading(level: 4, outlined: false)[Abschnittsweise definierte Lasten]
Ist $q(x)$ nicht über die ganze Länge eine Formel, gibt es zwei Wege (Folie 14):
+ #strong[Aus bekannten Teilstücken zusammensetzen] (Rechteck, Dreieck):
  $ F_R = sum_(i=1)^n F_"Ri", wide x_s = frac(1, F_R) sum_(i=1)^n x_"si" F_"Ri" $
+ #strong[Bereichsweise integrieren:]
  $ F_"Ri" = integral_(x_"Ai")^(x_"Ei") q_i (x) dif x, wide x_s = frac(1, F_R) sum_(i=1)^N integral_(x_"Ai")^(x_"Ei") x q_i (x) dif x $
FS TM1 S. 25–26 (Gl. 4.5–4.8).
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k4_teilstuecke", [Skript TM1 S. 127 (obere Folie 15): Last aus $n = 4$ bekannten Teilstücken.], height: 50mm)],
 [#bild("tm1k4_bereichsweise", [Skript TM1 S. 127 (untere Folie 16): bereichsweise Integration über $N = 3$ Bereiche.], height: 50mm)])
#heading(level: 4, outlined: false)[WZF: zwei Anwendungen mit beiden Wegen]
*Überlagerung (Trapez):* Rechteck $q_0$ plus steigendes Dreieck bis $2 q_0$ über die Länge $L$ (WZF-Skript S. 77–83).
#tab(columns: 4,
 th([Teil], [$x_i$], [$F_i$], [$x_i F_i$]),
 [1 Rechteck], [$0","5 L$], [$q_0 L$], [$0","5 q_0 L^2$],
 [2 Dreieck], [$2\/3 L$], [$0","5 q_0 L$], [$0","33 q_0 L^2$],
 [$sum$], [], [$1","5 q_0 L$], [$0","83 q_0 L^2$],
)
$x_s = "0,83" \/ "1,5" L = 5\/9 L approx "0,56" L$. Per Integral mit $q(x) = q_0 x \/ L + q_0$: Nenner $3\/2 q_0 L$, Zähler $5\/6 q_0 L^2$, also ebenfalls $x_s = 5\/9 L$.
#bild("tm1k4_wzf_trapez", [WZF-Skript S. 79: Überlagerung aus Rechteck (1) und Dreieck (2) mit Tabelle; Ergebnis $x_s = 0","56 L$.], height: 52mm)
*Dachlast:* Spitze $q_0$ bei $x = L\/4$, an beiden Enden null (WZF-Skript S. 84–90). Zerlegt in zwei Dreiecke:
#tab(columns: 4,
 th([Teil], [$x_i$], [$F_i$], [$x_i F_i$]),
 [1 (0 bis $L\/4$)], [$2\/3 dot L\/4 = "0,1667" L$], [$1\/2 dot 1\/4 q_0 L = "0,125" q_0 L$], [$"0,0208" q_0 L^2$],
 [2 ($L\/4$ bis $L$)], [$L\/4 + 1\/3 dot 3\/4 L = "0,5" L$], [$1\/2 dot 3\/4 q_0 L = "0,375" q_0 L$], [$"0,1875" q_0 L^2$],
 [$sum$], [], [$"0,5" q_0 L$], [$"0,2083" q_0 L^2$],
)
$x_s = "0,2083" \/ "0,5" L = "0,4167" L = 5\/12 L$. Die bereichsweise Integration auf S. 87–90 kommt auf dasselbe.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k4_wzf_dreiecke", [WZF-Skript S. 86: Dachlast aus zwei Dreiecken, oben allgemein, unten mit $L = 1$, $q_0 = 1$.], height: 48mm)],
 [#bild("tm1k4_wzf_dreieck_int", [WZF-Skript S. 87: bereichsweise Integration mit $q_I$ und $q_"II"$.], height: 48mm)])
#note([Fehler im WZF-Skript (S. 86)], [In der oberen, allgemeinen Tabelle steht „$x_s = 0","48 L$“. Das passt nicht zu den Zeilen darüber: $"0,2083" \/ "0,5" = "0,4167"$. Die untere Tabelle und die Integration (S. 90) liefern beide $0","4167 L$. Richtig ist also $x_s = 5\/12 L$.], fill: sand)
#note([Fehler vermeiden (Hinweis WZF-Skript S. 87)], [Beim rechten Dreieck läuft $x$ von $L\/4$ bis $L$; in der Geradengleichung steht deshalb $(x - L\/4)$. Würdest du für beide Dreiecke bei $x = 0$ beginnen, lägen sie übereinander.], fill: sand)
#note([Analogien (WZF-Skript S. 67–68)], [Dieselbe Formel gilt für jede Art von Schwerpunkt; nur das „Gewicht“ wechselt:
$ x_F = frac(sum F_i x_i, sum F_i), quad x_G = frac(sum G_i x_i, sum G_i), quad x_m = frac(sum m_i x_i, sum m_i), quad x_V = frac(sum V_i x_i, sum V_i), quad x_A = frac(sum A_i x_i, sum A_i), quad x_L = frac(sum l_i x_i, sum l_i) $])
#note([In eigenen Worten], [Schnee liegt auf einem Carport-Dach dicker an der Wand als vorne. Für die Stützen zählt nur: wie viel Schnee insgesamt (Fläche unter der Kurve) und wo sein Schwerpunkt liegt. Die genaue Form spielt für die Lagerkräfte danach keine Rolle mehr. #text(fill: muted)[(eigene Ergänzung)]])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Beispiel 4.1:] Balken mit dreieckförmiger Last, gerechnet wie Folie 13: Resultierende $q_0 l\/2$ im Abstand $l\/3$ von der hohen Seite. #text(fill: muted)[\[TM1-Buch S. 91\]]
- #strong[Flächenlast:] Für $p(x, y)$ folgt der Schwerpunkt analog mit Doppelintegralen. #text(fill: muted)[\[TM1-Buch S. 91\]]])
#src[Skript TM1 S. 124–127 (Folien 9–16, deine Notiz S. 126); WZF-Skript S. 62–100; FS TM1 S. 25–26; TM1-Buch S. 90–91.]

== 4.2 Flächen, Linienschwerpunkt <a-tm1-4-2>
=== 4.2.1 Fläche mit parallelen Einzelkräften <a-tm1-4-2-1>
Jetzt greifen parallele Kräfte $F_i$ an Punkten $(x_i, y_i)$ einer Fläche an (z. B. Lasten auf einer Platte). Es gibt zwei Momentengleichungen, um die x- und um die y-Achse. Vorzeichen nach der Rechtsschraubenregel:
#form[$ F_R = H = sum F_i, wide x_s = frac(sum x_i F_i, sum F_i), wide y_s = frac(sum y_i F_i, sum F_i) $]
FS TM1 S. 26 (Gl. 4.9, 4.10). $x_s, y_s$: Schwerpunkt der Kräftegruppe, „Kräftemittelpunkt“.
#bild("tm1k4_flaeche_einzel", [Skript TM1 S. 128 (untere Folie 18): Gleichgewicht $sum F_z$, $sum M_y$, $sum M_x$ für eine Fläche mit Einzelkräften.], height: 50mm)
#src[Skript TM1 S. 128 (Folien 17–18); FS TM1 S. 26.]

=== 4.2.2 Fläche mit verteilter Flächenlast <a-tm1-4-2-2>
Eine Flächenlast $p(x, y)$ in N/m² (z. B. Schneelast) wird in kleine Kräfte $d F = p(x, y) dif A$ zerlegt:
#form[$ F_R = H = integral p(x, y) dif A, wide x_s = frac(integral x p(x, y) dif A, integral p(x, y) dif A), wide y_s = frac(integral y p(x, y) dif A, integral p(x, y) dif A) $]
FS TM1 S. 26 (Gl. 4.11, 4.12). Laut Folie 21: „Anwendung erst in TM II“.
#bild("tm1k4_flaechenlast", [Skript TM1 S. 129 (obere Folie 19): Flächenlast $p(x, y)$ auf einer Platte, Element $dif A$, Ersatzkraft $F_R$.], height: 50mm)
#src[Skript TM1 S. 129–130 (Folien 19–21); FS TM1 S. 26.]

=== 4.2.3 Flächenschwerpunkt <a-tm1-4-2-3>
Sonderfall: $p = "const"$, z. B. das Eigengewicht einer Scheibe mit konstanter Dicke. Dann kürzt sich $p$ heraus, und der Schwerpunkt hängt #strong[nur noch von der Form] ab:
#form[$ x_s = frac(integral x dif A, A), wide y_s = frac(integral y dif A, A), wide z_s = 0 $]
FS TM1 S. 27 (Gl. 4.13). Der Flächenschwerpunkt liegt in der x-y-Ebene.
#bild("tm1k4_fsp", [Skript TM1 S. 130 (untere Folie 22): Flächenschwerpunkt bei $p = "const"$.], height: 48mm)
#heading(level: 4, outlined: false)[Statische Momente und Regeln ★]
Die Integrale im Zähler heißen #strong[Flächenmomente 1. Ordnung] (statische Momente):
$ S_x = integral y dif A = y_s A, wide S_y = integral x dif A = x_s A $
$S_y$ ist das statische Moment bezüglich der y-Achse, $S_x$ bezüglich der x-Achse. Regeln laut Folie:
- Die #strong[Tabelle in der Formelsammlung] verwenden (FS TM1 S. 29).
- Ein Koordinatensystem mit Ursprung im Schwerpunkt heißt #strong[Schwerpunktsystem], seine Achsen #strong[Schwerachsen]. Dort sind die statischen Momente null.
- Schwerpunkt und statisches Moment hängen vom Koordinatensystem ab (Folie 25: Rechteck mit $S_x = S_y = 0$ im Schwerpunktsystem, aber $S_(overline(x)) = h\/2 dot b h$ vom Rand aus).
- #strong[Symmetrieachsen sind Schwerachsen.] Zu jedem Element bei $+x$ gibt es eines bei $-x$, also $S_y = 0$ und $x_s = 0$.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k4_statmom", [Skript TM1 S. 131 (obere Folie 23): statische Momente und Regeln.], height: 50mm)],
 [#bild("tm1k4_symm", [Skript TM1 S. 131 (untere Folie 24): Symmetrie zur y-Achse.], height: 50mm)])
#bild("tm1k4_ksabh", [Skript TM1 S. 132 (obere Folie 25): Rechteck in zwei Koordinatensystemen.], height: 46mm)
#heading(level: 4, outlined: false)[Zusammengesetzte Flächen und Aussparungen ★]
Besteht die Fläche aus Teilen mit bekannten Schwerpunkten, wird das Integral zur Summe. Alle $x_"si"$, $y_"si"$ müssen im #strong[gemeinsamen] Koordinatensystem angegeben werden:
#form[$ x_s = frac(sum x_"si" A_i, sum A_i), wide y_s = frac(sum y_"si" A_i, sum A_i) $]
Löcher („fehlende Flächen“, Index $a$) zählen als #strong[negative Flächen]:
#form[$ x_s = frac(sum x_"si" A_i - sum x_"sa" A_a, sum A_i - sum A_a), wide y_s = frac(sum y_"si" A_i - sum y_"sa" A_a, sum A_i - sum A_a) $]
FS TM1 S. 27 (Gl. 4.14, 4.15).
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k4_zusammen1", [Skript TM1 S. 132 (untere Folie 26): Fläche aus $A_1$, $A_2$, $A_i$ im gemeinsamen KS.], height: 50mm)],
 [#bild("tm1k4_zusammen2", [Skript TM1 S. 133 (obere Folie 27): Summenformel.], height: 50mm)])
#bild("tm1k4_aussparung", [Skript TM1 S. 133 (untere Folie 28): Rechteck mit quadratischem Loch = Rechteck minus Quadrat.], height: 48mm)
#bild("tm1k4_fs_tabelle", [FS TM1 S. 29: Tabelle der Schwerpunktskoordinaten (aus Gross/Hauger/Schröder/Wall) mit deiner Notiz zum Kreisbogen unten.], height: 120mm)
#note([Von dir notiert (FS TM1 S. 29)], [Unter die Tabelle hast du „Kreisbogen: $x_s = R sin alpha \/ alpha$ (Linienschwerpunkt)“ geschrieben und einen Bogen mit Winkel $alpha$ an der x-Achse skizziert. Achtung: Die Formel gilt für einen Bogen mit #strong[Öffnungswinkel $2 alpha$], symmetrisch zur x-Achse (von $-alpha$ bis $+alpha$) \[TM1-Buch S. 108\]. In deiner Skizze reicht der Bogen nur von 0 bis $alpha$; dann gilt sie nicht direkt.], fill: sand)
#heading(level: 4, outlined: false)[Rechenschema als Tabelle]
#tab(columns: 6,
 th([Nr.], [$x_"si"$], [$y_"si"$], [$A_i$], [$x_"si" A_i$], [$y_"si" A_i$]),
 [1], [], [], [], [], [],
 [2], [], [], [], [], [],
 [$sum$], [–], [–], [$sum A_i$], [$sum x_"si" A_i$], [$sum y_"si" A_i$],
)
So rechnest du in deiner Mitschrift und in der Übungslösung. Ein Loch bekommt ein Minus bei $A_i$.
#heading(level: 4, outlined: false)[Beispiel 2 aus deiner Mitschrift: drei Flächen]
#bild("tm1k4_bsp2_aufg", [Deine Mitschrift (Skript TM1 S. 139): Beispiel 2, Flächen a), b), c).], height: 80mm)
*a) Stufenprofil* (Breiten $2L$, $2L$, $L$; Höhen links $4L$, Mitte $2L$, rechts $3L$). Zerlegt in drei Rechtecke:
#tab(columns: 6,
 th([Nr.], [$x_"si"$], [$y_"si"$], [$A_i$], [$x_"si" A_i$], [$y_"si" A_i$]),
 [1], [$L$], [$2L$], [$8L^2$], [$8L^3$], [$16L^3$],
 [2], [$3L$], [$L$], [$4L^2$], [$12L^3$], [$4L^3$],
 [3], [$4","5 L$], [$1","5 L$], [$3L^2$], [$13","5 L^3$], [$4","5 L^3$],
 [$sum$], [], [], [$15 L^2$], [$33","5 L^3$], [$24","5 L^3$],
)
$x_s = 33","5 \/ 15 L = 2","23 L$, $y_s = 24","5 \/ 15 L = 1","63 L$.
#note([Prüfe deine Mitschrift (Skript TM1 S. 140)], [Tabelle und Summen stimmen. Beim Ergebnis für $x_s$ steht aber eine Zahl, die wie „2,37 L“ aussieht; $33","5 \/ 15$ ergibt $2","23 L$. $y_s = 1","63 L$ stimmt.], fill: sand)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k4_bsp2a", [Deine Mitschrift (Skript TM1 S. 140): Teil a) mit Tabelle.], height: 70mm)],
 [#bild("tm1k4_bsp2b", [Deine Mitschrift (Skript TM1 S. 141): Teil b) L-Profil.], height: 50mm)])
*b) L-Profil* ($4L$ hoch, $4L$ breit, Wanddicke $L$): Steg $4L times L$ unten ($x = 2L$, $y = L\/2$, $A = 4L^2$) und Schenkel $L times 3L$ ($x = L\/2$, $y = 2","5 L$, $A = 3L^2$). $x_s = y_s = 9","5 \/ 7 L = 1","36 L$, wie in deiner Mitschrift. Beide Werte sind gleich, weil das Profil symmetrisch zur Winkelhalbierenden ist.
*c) Quadrat mit abgeschnittener Ecke* (Seite $c$, oben rechts ein Dreieck mit Katheten $c\/2$ weg):
#tab(columns: 6,
 th([Nr.], [$x_"si"$], [$y_"si"$], [$A_i$], [$x_"si" A_i$], [$y_"si" A_i$]),
 [1 Rechteck links], [$0","25 c$], [$0","5 c$], [$0","5 c^2$], [$0","125 c^3$], [$0","25 c^3$],
 [2 Quadrat unten rechts], [$0","75 c$], [$0","25 c$], [$0","25 c^2$], [$0","1875 c^3$], [$0","0625 c^3$],
 [3 Dreieck], [$0","667 c$], [$0","667 c$], [$0","125 c^2$], [$0","0833 c^3$], [$0","0833 c^3$],
 [$sum$], [], [], [$0","875 c^2$], [$0","396 c^3$], [$0","396 c^3$],
)
$x_s = y_s = 0","396 \/ 0","875 c = 0","452 c$. Kontrolle mit negativer Fläche: Quadrat ($c^2$, Schwerpunkt $c\/2$) minus Dreieck ($0","125 c^2$, Schwerpunkt bei $5\/6 c$): $x_s = (0","5 - 0","104) \/ 0","875 c = 0","452 c$.
#note([Fehler in deiner Mitschrift (Skript TM1 S. 142)], [Du kommst auf $x_s = 0","46 c$ und $y_s = 0","43 c$. Zwei Stellen sind falsch:
- Beim Dreieck (3) hast du den Schwerpunkt wie bei einem Rechteck gesetzt ($x = 0","75 c$, $y = 0","5 c$). Der Dreiecksschwerpunkt liegt bei einem Drittel der Katheten: $x = y = 0","5 c + 1\/3 dot 0","5 c = 0","667 c$.
- In der Spalte $A_i y_i$ ergibt die Summe $1\/8 + 1\/16 + 1\/16 = 1\/4$, nicht $3\/8$.
Die Fläche ist symmetrisch zur Diagonalen, deshalb muss $x_s = y_s$ herauskommen. Richtig ist $0","452 c$.], fill: sand)
#bild("tm1k4_bsp2c", [Deine Mitschrift (Skript TM1 S. 142): Teil c) mit Tabelle.], height: 55mm)
#note([In eigenen Worten], [Wie ein Notendurchschnitt mit Gewichtung: Jede Teilfläche ist eine Note ($x_"si"$), ihre Fläche das Gewicht (ECTS). Ein Loch ist wie eine Note, die du wieder herausrechnest. #text(fill: muted)[(eigene Ergänzung)]])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Statische Momente, Schwerachsen:] „Achsen durch den Schwerpunkt heißen Schwerachsen“; bezüglich jeder Schwerachse ist das statische Moment null. #text(fill: muted)[\[TM1-Buch S. 98\]]
- #strong[Symmetrie und negative Flächen:] Symmetrieachsen sind Schwerachsen; Ausschnitte als „negative“ Flächen einführen. #text(fill: muted)[\[TM1-Buch S. 99\]]
- #strong[Beispiel 4.3:] Schwerpunkt des rechtwinkligen Dreiecks per Integral: $x_s = 2\/3 a$, $y_s = h\/3$. #text(fill: muted)[\[TM1-Buch S. 100–101\]]
- #strong[Beispiel 4.6 / 4.7:] L-Profil und Dreieck mit Ausschnitt. #text(fill: muted)[\[TM1-Buch S. 104–105\]]
- #strong[Tab. 4.1:] dieselbe Tabelle wie in deiner Formelsammlung. #text(fill: muted)[\[TM1-Buch S. 106\]]])
#src[Skript TM1 S. 130–133 (Folien 22–28), S. 139–142 (Mitschrift Beispiel 2); FS TM1 S. 27, 29 (mit deiner Notiz); TM1-Buch S. 97–106.]

=== 4.2.4 Linienschwerpunkt <a-tm1-4-2-4>
Ein homogener, nicht gerader Balken (Draht) unter konstanter Streckenlast $q$ liegt in der x-y-Ebene. Man zerlegt ihn in kleine Stücke $d s$:
#form[$ F_R = integral q dif s = q l, wide x_s = frac(1, l) integral_0^l x dif s, wide y_s = frac(1, l) integral_0^l y dif s $]
Für zusammengesetzte Linien wird daraus eine Summe:
#form[$ x_s = frac(sum x_"si" l_i, sum l_i), wide y_s = frac(sum y_"si" l_i, sum l_i) $]
FS TM1 S. 27 (Gl. 4.16, 4.17).
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k4_linie1", [Skript TM1 S. 134 (obere Folie 29): gekrümmter Balken unter konstanter Streckenlast.], height: 50mm)],
 [#bild("tm1k4_linie2", [Skript TM1 S. 134 (untere Folie 30): Formeln zum Linienschwerpunkt.], height: 50mm)])
#note([Von dir eingerahmt (Skript TM1 S. 145)], [„Wenn schraffiert = Flächenschwerpunkt, wenn nicht schraffiert = Linien- bzw. Streckenschwerpunkt.“ So erkennst du in der Aufgabe, welche Formel gemeint ist: Gewichtet wird mit $A_i$ oder mit $l_i$.], fill: sand)
#heading(level: 4, outlined: false)[Beispiel 3: gekröpfter Draht (Folie 31, deine Mitschrift S. 143)]
Fünf gerade Stücke: zwei waagerechte Stücke $a$ unten, zwei senkrechte Stücke $c$, oben das Stück $b$. Wegen der Symmetrie ist $x_s = 0$.
$ y_s = frac(0 dot a + c\/2 dot c + c dot b + c\/2 dot c + 0 dot a, a + c + b + c + a) = frac(c^2 + c b, 2a + 2c + b) $
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k4_draht", [Skript TM1 S. 135 (obere Folie 31): gekröpfter Draht.], height: 50mm)],
 [#bild("tm1k4_bsp3", [Deine Mitschrift (Skript TM1 S. 143): Teilstücke $S_1$ bis $S_5$ und Lösung.], height: 60mm)])
#heading(level: 4, outlined: false)[Beispiel 4: Rahmen aus Geraden und Kreisbögen (Folie 32, deine Mitschrift S. 144–145)]
Der Rahmen besteht aus zwei Geraden (5 cm und 3 cm) und zwei Kreisbögen (Viertelkreis $R = 3$ cm, Halbkreis $R = 4$ cm). Ursprung unten links. Für einen Kreisbogen brauchst du Länge und Schwerpunktabstand $a = R sin alpha \/ alpha$ (halber Öffnungswinkel $alpha$):
#tab(columns: 6,
 th([Nr.], [$l_i$ in cm], [$x_"si"$], [$y_"si"$], [$x_"si" l_i$], [$y_"si" l_i$]),
 [1 unten], [5], [2,5], [0], [12,5], [0],
 [2 links], [3], [0], [1,5], [0], [4,5],
 [3 Viertelkreis], [$pi\/2 dot 3 = 4","712$], [6,910], [1,090], [32,573], [5,136],
 [4 Halbkreis], [$pi dot 4 = 12","566$], [4,0], [5,55], [50,265], [69,691],
 [$sum$], [25,278], [], [], [95,338], [79,327],
)
$x_s = 95","338 \/ 25","278 = 3","771 "cm"$, $y_s = 79","327 \/ 25","278 = 3","138 "cm"$, wie auf der Folie.
#note([Prüfe deine Mitschrift (Skript TM1 S. 144–145)], [Deine Tabelle stimmt. Zwei Kleinigkeiten beim Abschreiben: Die Summe der Spalte $x_"si" l_i$ ist $95","338$ (bei dir 95,328; $x_s = 3","771 "cm"$ ändert sich dadurch nicht). Bei $y_s$ steht „3,128 cm“; $79","327 \/ 25","278$ ergibt $3","138 "cm"$ wie auf der Folie.], fill: sand)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k4_rahmen", [Skript TM1 S. 135 (untere Folie 32): Rahmen mit Ergebnis $x_s = 3","771 "cm"$, $y_s = 3","138 "cm"$.], height: 55mm)],
 [#bild("tm1k4_bsp4", [Deine Mitschrift (Skript TM1 S. 144): Tabelle und Kreisbogen-Schwerpunkte.], height: 75mm)])
#bild("tm1k4_bsp4b", [Deine Mitschrift (Skript TM1 S. 145): Ergebnis und dein Merksatz schraffiert/nicht schraffiert.], height: 40mm)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Linienschwerpunkt:] gleiche Formeln (4.14), (4.15) wie in der Vorlesung. #text(fill: muted)[\[TM1-Buch S. 107–108\]]
- #strong[Beispiel 4.8 Kreisbogen:] Öffnungswinkel $2 alpha$, $x_s = r sin alpha \/ alpha$; Halbkreisbogen $x_s = 2r\/pi$. Die Halbkreis#strong[fläche] hat ihren Schwerpunkt dagegen bei $4r\/(3 pi)$, also näher am Mittelpunkt. #text(fill: muted)[\[TM1-Buch S. 108\]]])
#src[Skript TM1 S. 134–135 (Folien 29–32), S. 143–145 (Mitschrift Beispiele 3, 4); FS TM1 S. 27; TM1-Buch S. 107–108.]

== 4.3 Volumenschwerpunkt <a-tm1-4-3>
Eine parallele, nicht konstante Volumenkraft $f(x, y, z)$ in N/m³ (z. B. Gewicht eines Körpers mit ungleicher Dichte) hat ihren Schwerpunkt bei
#form[$ x_s = frac(integral x f dif V, integral f dif V), quad y_s = frac(integral y f dif V, integral f dif V), quad z_s = frac(integral z f dif V, integral f dif V) $]
(ohne Beweis, Folie 33). Für die Schwerkraft ist $f = rho(x, y, z) g$. Mit konstantem $g$ kürzt es sich heraus: Schwerpunkt = #strong[Massenmittelpunkt] $x_s = integral x rho dif V \/ m$. Ist auch $rho$ konstant, bleibt der #strong[Volumenmittelpunkt] $x_s = integral x dif V \/ V$.
#tab(columns: 3,
 th([Fall], [Formel], [Name]),
 [$rho != "const"$], [$x_s = frac(integral x rho dif V, m)$], [Massenmittelpunkt],
 [$rho g = "const"$], [$x_s = frac(integral x dif V, V)$], [Volumenmittelpunkt = Schwerpunkt],
 [Teilvolumina], [$x_s = frac(sum rho_i x_"si" V_i, sum rho_i V_i)$, bei $rho_i = rho$: $frac(sum x_"si" V_i, sum V_i)$], [zusammengesetzter Körper],
)
FS TM1 S. 27–28 (Gl. 4.18–4.25). „Fehlende“ Volumina werden wie bei Flächen als negatives Volumen angesetzt.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k4_vol1", [Skript TM1 S. 136 (obere Folie 33): parallele, nicht konstante Volumenkraft.], height: 48mm)],
 [#bild("tm1k4_vol2", [Skript TM1 S. 136 (untere Folie 34): Schwerkraft mit $rho(x, y, z)$.], height: 48mm)])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k4_vol3", [Skript TM1 S. 137 (obere Folie 35): homogener Körper, Volumenmittelpunkt.], height: 48mm)],
 [#bild("tm1k4_vol4", [Skript TM1 S. 137 (untere Folie 36): Teilvolumina zusammensetzen.], height: 48mm)])
#note([Merke], [Die Folie nennt die Grenzen: $g = "const"$ gilt nicht bei sehr großen Abmessungen (z. B. Gebirge). Für Bauteile im Maschinenbau sind Schwerpunkt, Massenmittelpunkt und (bei homogenem Material) Volumenmittelpunkt derselbe Punkt.])
#note([In eigenen Worten], [Ein Hammer aus Stahlkopf und Holzstiel: Der Schwerpunkt liegt nah am Kopf, obwohl der Stiel viel länger ist. Gewichtet wird mit $rho_i V_i$, nicht nur mit $V_i$. #text(fill: muted)[(eigene Ergänzung)]])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Schwerpunkt und Massenmittelpunkt:] gleiche Herleitung; bei konstantem $g$ fallen beide zusammen, bei konstanter Dichte auch der Volumenmittelpunkt. #text(fill: muted)[\[TM1-Buch S. 92–94\]]
- #strong[Beispiel 4.2:] Würfel mit herausgeschnittenem Teil, gelöst mit „negativem“ Volumen. #text(fill: muted)[\[TM1-Buch S. 96\]]])
#src[Skript TM1 S. 136–137 (Folien 33–36); FS TM1 S. 27–28; TM1-Buch S. 92–96.]

#grid(columns: 2, gutter: 5mm,
 [#bild("map-t1k4a", [Mindmap: Streckenlast ersetzen. Eigene Darstellung nach Skript TM1 S. 120–127 und WZF-Skript S. 62–100.], height: 44mm)],
 [#bild("map-t1k4b", [Mindmap: Schwerpunkt von Flächen, Linien, Körpern. Eigene Darstellung nach Skript TM1 S. 128–145.], height: 44mm)])

*Der Zusammenhang in Kapitel 4.* Parallele Kräfte lassen sich durch eine Resultierende ersetzen; wo sie angreift, sagt das Momentengleichgewicht. Das Ergebnis ist immer ein gewichteter Mittelwert: Orte, gewichtet mit Kraft, Fläche, Länge, Volumen oder Masse. Bei einer Streckenlast ist die Resultierende die Fläche unter der Lastkurve und greift in deren Schwerpunkt an. Bei Flächen, Linien und Körpern zerlegst du in bekannte Teile, Löcher zählen negativ, und Symmetrieachsen nehmen dir eine Koordinate ab. In Kapitel 5 setzt du die Ersatzkräfte ein, um Lagerkräfte zu berechnen.

#pagebreak()
== Verständnisfragen und Rechenaufgaben · Kapitel 4
#set enum(spacing: 0.85em)
Erkläre erst selbst. Bei Schwerpunkt-Aufgaben zuerst ein Koordinatensystem einzeichnen und die Teilflächen nummerieren. Die Lösungen folgen getrennt.

+ Was ist die Haltekraft $H$, und wie hängt sie mit $F_R$ zusammen?
+ Warum ist $x_s$ ein „gewichteter Mittelwert“? Womit wird gewichtet?
+ Warum darf man bei parallelen Kräften unter gleichem Winkel $alpha$ mit den Beträgen rechnen?
+ Welche Größe einer Streckenlast entspricht $F_R$, welche $x_s$?
+ Wo greift die Resultierende einer Dreieckslast an? Von welcher Seite misst du $1\/3$?
+ Nenne die zwei Wege für abschnittsweise definierte Streckenlasten.
+ Was sind statische Momente, und warum sind sie bezüglich einer Schwerachse null?
+ Warum ist jede Symmetrieachse eine Schwerachse?
+ Wie behandelst du ein Loch in einer Fläche?
+ Woran erkennst du in einer Skizze, ob ein Flächen- oder ein Linienschwerpunkt gesucht ist?
+ Wann sind Schwerpunkt, Massenmittelpunkt und Volumenmittelpunkt derselbe Punkt?
+ Darf man für die Schnittgrößen eine Streckenlast vorher durch ihre Resultierende ersetzen?
+ Ein Balken (Länge 6 m) trägt bei $x = 1 "m"$ 2 kN, bei $x = 3 "m"$ 4 kN und bei $x = 5 "m"$ 6 kN. Berechne $F_R$ und $x_s$. #text(fill: muted)[(eigene Aufgabe)]
+ Streckenlast fallend von $q_0 = 6 "kN/m"$ bei $x = 0$ auf 0 bei $l = 3 "m"$. Berechne $F_R$ und $x_s$ einmal mit der Dreiecksregel und einmal per Integral. #text(fill: muted)[(eigene Aufgabe)]
+ Trapezlast von $q_1 = 2 "kN/m"$ (links) auf $q_2 = 5 "kN/m"$ (rechts) über $l = 4 "m"$. Zerlege in Rechteck und Dreieck und berechne $F_R$ und $x_s$. #text(fill: muted)[(eigene Aufgabe)]
+ Einfeldträger (A links, B rechts, $l = 4 "m"$) mit der Trapezlast aus Aufgabe 15. Berechne die Lagerkräfte. #text(fill: muted)[(eigene Aufgabe)]
+ T-Querschnitt: Flansch $100 times 20 "mm"$ oben, Steg $20 times 80 "mm"$ darunter, symmetrisch. Wo liegt $y_s$ (von unten)? #text(fill: muted)[(eigene Aufgabe)]
+ Quadrat $60 times 60 "mm"$ mit kreisrundem Loch ($d = 20 "mm"$), Mittelpunkt des Lochs bei $(40; 40) "mm"$ (Ursprung unten links). Berechne $x_s$ und $y_s$. #text(fill: muted)[(eigene Aufgabe)]

#heading(level: 3, outlined: false)[Vertiefende Verständnisfragen und Rechenaufgaben]
#block[
#set enum(start: 19)
+ *Beispiel 2 aus der Vorlesung:* Berechne die Schwerpunkte der drei Flächen a), b), c) (Skizze in Abschnitt 4.2.3) selbst und vergleiche mit dem Lernskript.
+ *Übung 6, Aufg. 6.1:* Bestimme die Flächenschwerpunkte der Profile a), b), c) (Maße in mm).
  #bild("tm1k4_ue61", [Übung 6 (Aufgabenblatt S. 1): Profile zu Aufgabe 6.1.], height: 30mm)
+ *Übung 6, Aufg. 6.2:* Gesucht ist der Schwerpunkt der Fläche mit Rechteckausschnitt.
  #bild("tm1k4_ue62", [Übung 6 (Aufgabenblatt S. 1): Fläche zu Aufgabe 6.2.], height: 40mm)
+ *Übung 6, Aufg. 6.3:* In welchem Abstand $y$ muss das Loch ($d = 15 "cm"$) in die Platte, damit der Schwerpunkt bei $y_s = 25 "cm"$ liegt?
  #bild("tm1k4_ue63", [Übung 6 (Aufgabenblatt S. 1): Platte zu Aufgabe 6.3.], height: 48mm)
+ *Übung 6, Aufg. 6.4:* Bestimme $q(x)$, die Resultierende und ihren Angriffspunkt für a) die Trapezlast von $q_0\/2$ auf $q_0$, b) die Dachlast mit Spitze $q_0$ bei $L\/3$, c) die Viertelsinus-Last bis $q_0$.
  #bild("tm1k4_ue64", [Übung 6 (Aufgabenblatt S. 1): Streckenlasten zu Aufgabe 6.4.], height: 32mm)
+ *WZF:* Dachlast mit Spitze bei $L\/4$: Rechne $x_s$ mit zwei Dreiecken nach. Welcher Wert im WZF-Skript ist falsch?
+ *Buch:* Warum liegt der Schwerpunkt eines Halbkreisbogens ($2r\/pi$) weiter außen als der einer Halbkreisfläche ($4r\/(3 pi)$)? (TM1-Buch S. 108)
+ *Buch:* Leite den Schwerpunkt eines rechtwinkligen Dreiecks ($x_s = 2\/3 a$) mit dem Integral $integral x dif A$ her. (TM1-Buch S. 100–101)
]

#pagebreak()
== Lösungen Kapitel 4
#set enum(spacing: 0.65em)
+ $H$ hält die Kräfte im Gleichgewicht: gleiche Wirkungslinie wie $F_R$, gleich groß, entgegengesetzt, $H = -F_R$. #nachschlagen[Lernskript, #stelle(<a-tm1-4-1-1>)]
+ $x_s = sum x_i F_i \/ sum F_i$: Jeder Ort $x_i$ zählt so stark wie seine Kraft $F_i$. Bei Flächen wird mit $A_i$, bei Linien mit $l_i$, bei Körpern mit $V_i$ oder $m_i$ gewichtet. #nachschlagen[Lernskript, #stelle(<a-tm1-4-1-1>)\; WZF-Skript S. 67–68]
+ Im Momentengleichgewicht steht bei jeder Kraft derselbe Faktor $sin alpha$; er kürzt sich heraus. #nachschlagen[Lernskript, #stelle(<a-tm1-4-1-1>)]
+ $F_R$ ist die Fläche unter $q(x)$, $x_s$ ihr Schwerpunkt. #nachschlagen[Lernskript, #stelle(<a-tm1-4-1-2>)]
+ $F_R = q_0 l \/ 2$ im Abstand $l\/3$ von der #strong[hohen] Seite ($2l\/3$ von der Spitze). #nachschlagen[Lernskript, #stelle(<a-tm1-4-1-2>)]
+ Aus bekannten Teilstücken zusammensetzen oder bereichsweise integrieren. #nachschlagen[Lernskript, #stelle(<a-tm1-4-1-2>)]
+ $S_x = integral y dif A = y_s A$, $S_y = integral x dif A = x_s A$. Liegt die Achse im Schwerpunkt, ist der Abstand $y_s$ bzw. $x_s$ null, also auch das statische Moment. #nachschlagen[Lernskript, #stelle(<a-tm1-4-2-3>)]
+ Zu jedem Element bei $+x$ gibt es ein gleiches bei $-x$; ihre Beiträge zu $integral x dif A$ heben sich auf. #nachschlagen[Lernskript, #stelle(<a-tm1-4-2-3>)]
+ Als negative Fläche: im Zähler $-x_"sa" A_a$, im Nenner $-A_a$. #nachschlagen[Lernskript, #stelle(<a-tm1-4-2-3>)]
+ Schraffiert: Flächenschwerpunkt (gewichtet mit $A_i$). Nicht schraffiert (nur Linien): Linienschwerpunkt (gewichtet mit $l_i$). #nachschlagen[Lernskript, #stelle(<a-tm1-4-2-4>)]
+ Bei konstantem $g$ fallen Schwerpunkt und Massenmittelpunkt zusammen; bei zusätzlich konstanter Dichte auch der Volumenmittelpunkt. #nachschlagen[Lernskript, #stelle(<a-tm1-4-3>)]
+ Nein. Für die Lagerkräfte ja, für die Schnittgrößen nur im jeweils abgeschnittenen Teil (Kapitel 7). #nachschlagen[Lernskript, #stelle(<a-tm1-4-1-1>)]
+ $F_R = 12 "kN"$, $x_s = (2 + 12 + 30) \/ 12 = "3,67" "m"$. #nachschlagen[Lernskript, #stelle(<a-tm1-4-1-1>)]
+ $F_R = 6 dot 3 \/ 2 = 9 "kN"$, $x_s = l\/3 = 1 "m"$. Integral: $integral_0^3 6 (1 - x\/3) dif x = 9$, $integral_0^3 6 x (1 - x\/3) dif x = 27 - 18 = 9$, also $x_s = 1 "m"$. #nachschlagen[Lernskript, #stelle(<a-tm1-4-1-2>)]
+ Rechteck $2 dot 4 = 8 "kN"$ bei 2 m, Dreieck $3 dot 4 \/ 2 = 6 "kN"$ bei $2\/3 dot 4 = "2,67" "m"$. $F_R = 14 "kN"$, $x_s = (16 + 16) \/ 14 = "2,29" "m"$. #nachschlagen[Lernskript, #stelle(<a-tm1-4-1-2>)]
+ $sum M_((A)): -14 dot "2,29" + 4 B = 0$, also $B = 8 "kN"$; $A = 14 - 8 = 6 "kN"$. (Exakt: $14 dot 16\/7 = 32$, $B = 32\/4 = 8 "kN"$.) #nachschlagen[Lernskript, #stelle(<a-tm1-4-1-2>)]
+ Steg $1600 "mm"^2$ bei $y = 40$, Flansch $2000 "mm"^2$ bei $y = 90$. $y_s = (64 000 + 180 000) \/ 3600 = "67,8" "mm"$; $x_s$ liegt auf der Symmetrieachse. #nachschlagen[Lernskript, #stelle(<a-tm1-4-2-3>)]
+ Quadrat $3600 "mm"^2$ bei (30; 30), Loch $pi dot 10^2 = "314,2" "mm"^2$ bei (40; 40). $x_s = y_s = (108 000 - 12 566) \/ (3600 - "314,2") = "29,0" "mm"$. Das Loch schiebt den Schwerpunkt vom Loch weg. #nachschlagen[Lernskript, #stelle(<a-tm1-4-2-3>)]
+ a) $x_s = 2","23 L$, $y_s = 1","63 L$; b) $x_s = y_s = 1","36 L$; c) $x_s = y_s = 0","452 c$. #nachschlagen[Lernskript, #stelle(<a-tm1-4-2-3>) (Beispiel 2)]
+ a) $x_s = 22","5 "mm"$ (Symmetrie), $y_s = 5120 \/ 400 = 12","8 "mm"$. b) $x_s = 13 "mm"$, $y_s = 12","8 "mm"$. c) $x_s = -12","5 "mm"$, $y_s = -5","6 "mm"$ (Halbkreise als Flächen mit $x_s = 4r\/(3 pi)$, innerer Halbkreis negativ). Deine Rechnung zu a) (Aufgabenblatt S. 2) kommt auf $y_s = 12","8 "mm"$ und auf dem zweiten Weg, von oben gemessen, auf $19","2 "mm"$; das ist dieselbe Lage ($32 - 12","8 = 19","2$). #nachschlagen[Lernskript, #stelle(<a-tm1-4-2-3>)\; Lösung Übung 6 S. 1–2]
+ Zerlegung in Dreieck 1, Dreieck 2, Rechteck 3 und den Ausschnitt 4 als negative Fläche: $x_s = 98\/26 = "3,77"$, $y_s = 85\/39 = "2,18"$. #nachschlagen[Lernskript, #stelle(<a-tm1-4-2-3>)\; Lösung Übung 6 S. 2–3]
+ Mit $A_1 = 400$ (Fuß, $y = 5$), $A_2 = 1000$ (Steg, $y = 35$), Loch $A_3 = pi dot "7,5"^2 = "176,7" "cm"^2$: $y_s (A_1 + A_2 - A_3) = y_1 A_1 + y_2 A_2 - y_3 A_3$ nach $y_3$ auflösen: $y = "36,3" "cm"$. #nachschlagen[Lernskript, #stelle(<a-tm1-4-2-3>)\; Lösung Übung 6 S. 4]
+ a) $q(x) = q_0\/2 + q_0 x \/ (2L)$, $F_R = 3\/4 q_0 L$, $x_s = 5\/9 L$. b) $F_R = 1\/2 q_0 L$, $x_s = 4\/9 L$ (Spitze bei $L\/3$: $x_s = (L + L\/3)\/3$). c) $q(x) = q_0 sin(pi x \/ (2L))$, $F_R = 2\/pi q_0 L = 0","637 q_0 L$, $x_s = 2\/pi L = 0","637 L$. #nachschlagen[Lernskript, #stelle(<a-tm1-4-1-2>)\; Lösung Übung 6 S. 4–6]
+ $x_s = 0","2083 \/ 0","5 L = 0","4167 L$. Falsch ist die Angabe „0,48 L“ in der oberen Tabelle auf WZF-Skript S. 86. #nachschlagen[Lernskript, #stelle(<a-tm1-4-1-2>)\; WZF-Skript S. 86–90]
+ Beim Bogen sitzt die ganze „Masse“ auf dem Rand im Abstand $r$; bei der Fläche liegen viele Elemente näher am Mittelpunkt und ziehen den Schwerpunkt nach innen. #nachschlagen[Lernskript, #stelle(<a-tm1-4-2-4>)\; TM1-Buch S. 108]
+ Streifen $dif A = y(x) dif x$ mit $y = h x \/ a$: $integral_0^a x dot h x \/ a dif x = h a^2 \/ 3$, $A = a h \/ 2$, also $x_s = 2\/3 a$. #nachschlagen[Lernskript, #stelle(<a-tm1-4-1-2>)\; TM1-Buch S. 100–101]

#pagebreak()
= TM1 Kapitel 5 · Lagerreaktionen <k-tm1-5>
#tab(columns: 2,
 [Vorlesungen], [TM1 WS 25/26 – auf den Folien und in deiner Mitschrift zu diesem Kapitel steht kein Datum. Abschnitte 5.1 (Folien 3–28) und 5.3 (Folien 31–65); 5.2 (räumlich) wurde nicht behandelt.],
 [Quellen], [Skript TM1 S. 146–192 (Foliensatz „Lagerreaktionen“, 66 Folien); deine Mitschrift S. 159–163, 165–166, 176–178, 182–184, 191–192; FS TM1 S. 17–18 (Lager-Tabelle) und S. 30–32; TM1-Buch Kap. 5 (S. 111–143)],
 [Passende Übungen], [Übung 7: 7.1–7.5 (einteilige Tragwerke), 7.6 (mehrteiliges Tragwerk); Übung 8 (nur Lösung vorhanden): 8.1, 8.2 (mehrteilig, Einfrierprinzip); Übung 5: 5.1–5.4 (Gleichgewicht mit Lager- und Kontaktkräften, in Kapitel 3 eingebaut); dazu Altklausur-Aufgaben am Ende der vertiefenden Fragen],
)
Lager halten ein Bauteil fest. Dabei üben sie Kräfte und Momente aus, die #strong[Lagerreaktionen]. Kapitel 5 ist im Kern #strong[ein Rezept]: Freischneiden → Bestimmtheit prüfen (zählen!) → Gleichgewicht aufstellen → Gleichungen lösen. Bei mehreren Bauteilen machst du das für jedes Teil einzeln.
#note([Dein Feynman-Schritt: die 5 Kernideen von Kapitel 5. Erst ohne Skript aufzählen und erklären, dann vergleichen.], [+ #strong[Wertigkeit:] Jedes Lager sperrt Bewegungen. Für jede gesperrte Bewegung gibt es genau eine Lagerreaktion (Kraft oder Moment).
+ #strong[Zählen vor Rechnen:] einteilig $f = 3 - Sigma r = 0$, mehrteilig $3n = v + r$. Beides ist nur notwendig – Sonderfälle (beweglich, vorspannbar) per Anschauung ausschließen.
+ #strong[Rezept a)–d):] Freischnitt → statische Bestimmtheit → GGW-Bedingungen → Gleichungssystem lösen.
+ #strong[Mehrteilig:] Alle Teile einzeln freischneiden; Gelenkkräfte wirken auf die beiden Teile entgegengesetzt gleich groß.
+ #strong[Einfrieren:] Ein Teilsystem darf als starre Scheibe betrachtet werden. Das Gleichgewicht am Gesamtsystem liefert oft schnell einzelne Lagerreaktionen und dient als Probe.
Zusammenfassung der Abschnitte 5.1–5.3; Quellen stehen dort.])
#note([Hinweis zur Nummerierung], [Der Foliensatz nummeriert innerhalb von Kapitel 5 uneinheitlich: Abschnitte heißen „1 Einteilige ebene Tragwerke“, „1.1 Wertigkeit …“, „3 Mehrteilige …“ bzw. auf Folie 31 schon „5.3 Mehrteilige ebene Tragwerke“, die Unterabschnitte dann wieder „3.1 Verbindungselemente“ usw. Hier wird durchgehend mit der Kapitelnummer nummeriert (wie in der Formelsammlung TM1): Folie „1.2“ = #strong[5.1.2], Folie „3.1“ = #strong[5.3.1], Folie „3.4“ = #strong[5.3.4]. Deine Mitschrift zu Kapitel 6 verweist ebenfalls so („Kap. 5.3.4“ für das Einfrierprinzip).], fill: sand)
== 5.1 Einteilige ebene Tragwerke <a-tm1-5-1>
„Einteilig“ heißt: #strong[ein] Körper. „Eben“ heißt: Alles passiert in der x-y-Ebene, in z-Richtung ist das Bauteil unverschiebbar. Die Folien unterscheiden diese Bauteile:
#tab(columns: 2,
 th([Bauteil], [Merkmal]),
 [Stab], [gerade, nur Zug/Druck in Längsrichtung (siehe Kap. 2.4.1)],
 [Balken], [gerade, auch quer zur Achse belastet],
 [Bogen], [gekrümmter Balken],
 [Rahmen], [starr (biegesteif) verbundene Balken],
 [Scheibe], [flach, Kräfte nur in der Ebene],
 [Platte], [flach, Belastung auch senkrecht zur Ebene],
 [Schale], [gekrümmte Platte (engl. „shell“, oft auch für Scheibe/Platte benutzt)],
)
#note([Aus deiner Mitschrift (Skript TM1 S. 147)], [Neben der Platte steht in Klammern „grundsätzlich nicht behandelt“. Platten und Schalen brauchst du also nur als Begriffe.])
#bild("tm1k5_bauteile", [Skript TM1 S. 147 (obere Folie): Bauteile – Bogen (Laterne) und Rahmen mit Streckenlast, Kräften und Moment.], height: 45mm)
#strong[Lager] verbinden das Bauteil mit der Umgebung. Sie legen seine Lage fest und übertragen Kräfte bzw. Momente zwischen Bauteil und Umgebung. Im #strong[Freischnitt] entfernst du die Lager und zeichnest stattdessen die #strong[Lagerreaktionen] (= Reaktionskräfte) ein.
#note([In eigenen Worten], [Ein Regalbrett liegt auf zwei Haltern. Die Halter „merkst“ du erst, wenn du sie wegdenkst: Dann musst du mit den Händen genau die Kräfte aufbringen, die vorher die Halter geleistet haben. Genau diese Kräfte sind die Lagerreaktionen. #text(fill: muted)[(eigene Ergänzung)]])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k5_lager", [Skript TM1 S. 148 (untere Folie): Balken mit Festlager A und Stab als Stütze B (Loslager).], height: 50mm)],
 [#bild("tm1k5_freischnitt", [Skript TM1 S. 149 (obere Folie): Freischnitt – Lagerreaktionen $A_x, A_y, B$; am Stab wirkt B an beiden Enden entgegengesetzt.], height: 50mm)])
#note([Merke], [Im Freischnitt wirkt jede Lagerreaktion auf das Bauteil und – entgegengesetzt gleich groß – auf die Umgebung (actio = reactio). Den Richtungssinn darfst du frei annehmen. Ein negatives Ergebnis heißt nur: Die Kraft wirkt andersherum.])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Begriffe:] Stab = nur Zug/Druck in Achsrichtung; quer belastet = Balken; gekrümmt = Bogen; abgewinkelt starr verbunden = Rahmen; Scheibe in der Ebene, Platte quer dazu belastet; gekrümmtes Flächentragwerk = Schale. #text(fill: muted)[\[TM1-Buch S. 113\]]
- #strong[Bezeichnung:] Lagerreaktionen bezeichnet man meist wie die Lager selbst (A, B …). #text(fill: muted)[\[TM1-Buch S. 113\]]])
#src[Skript TM1 S. 147–149; FS TM1 S. 30; TM1-Buch S. 113.]
=== 5.1.1 Wertigkeit von Lagern <a-tm1-5-1-1>
Ein freier Körper in der Ebene hat #strong[3 Freiheitsgrade (FG)]: 2 Verschiebungen (x und y) und 1 Drehung. Jedes Lager sperrt einige davon. Die #strong[Wertigkeit] $r$ eines Lagers ist die Zahl der Reaktionen, die es überträgt – also die Zahl der gesperrten Bewegungen.
#form[$ f = 3 - Sigma r $]
$f$: verbleibende Freiheitsgrade, $Sigma r$: Anzahl aller Lagerreaktionen (FS TM1 Gl. 5.2).
#tab(columns: 4,
 th([Wertigkeit], [Beispiele (Folie)], [gesperrt], [Lagerreaktionen]),
 [einwertig $r = 1$, $f = 2$], [Rollenlager (Loslager), Pendelstab, Kontakt ohne Reibung], [Verschiebung senkrecht zur Auflage], [1 Kraft, Richtung bekannt (z. B. $A_y$)],
 [zweiwertig $r = 2$, $f = 1$], [gelenkiges Lager (Festlager), Doppelstütze, Kontakt mit Reibung], [beide Verschiebungen], [2 Kräfte $A_x, A_y$],
 [zweiwertig $r = 2$, $f = 1$], [Parallelführung, Schiebehülse], [Drehung + eine Verschiebung], [1 Kraft + 1 Moment],
 [dreiwertig $r = 3$, $f = 0$], [feste Einspannung, Doppelstütze + Pendelstab], [alles], [$A_x, A_y, M_A$],
)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k5_einwertig", [Skript TM1 S. 150 (obere Folie): einwertige Lager.], height: 50mm)],
 [#bild("tm1k5_zweiwertig", [Skript TM1 S. 150 (untere Folie): zweiwertige Lager (Festlager, Doppelstütze).], height: 50mm)])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k5_zweiwertig2", [Skript TM1 S. 151 (obere Folie): Parallelführung und Schiebehülse – je 1 Kraft + 1 Moment.], height: 50mm)],
 [#bild("tm1k5_dreiwertig", [Skript TM1 S. 151 (untere Folie): dreiwertige Lager – Einspannung mit $A_x, A_y, M_A$.], height: 50mm)])
#note([In eigenen Worten], [Ein Einkaufswagen auf ebenem Boden (Rollen) kann noch rollen und sich drehen → wie ein Loslager. Ein Fahrrad am Bügel mit Schloss durchs Vorderrad kann sich nur noch drehen → Festlager. Ein einbetonierter Pfosten kann gar nichts mehr → Einspannung. #text(fill: muted)[(eigene Ergänzung)]])
#note([Merke ★], [Faustregel fürs Freischneiden: #strong[Wo das Lager eine Bewegung sperrt, entsteht eine Reaktion.] Sperrt es eine Verschiebung → Kraft in dieser Richtung. Sperrt es die Drehung → Moment.])
#note([Fehler vermeiden], [Beim Loslager (Rollenlager) wirkt die Kraft #strong[senkrecht zur Rollbahn], nicht automatisch senkrecht nach oben. Bei einer schrägen Rollbahn ist auch die Lagerkraft schräg. Und: Beim Pendelstab wirkt die Kraft immer #strong[in Stabrichtung].], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Einwertige Lager:] Rollenlager, Gleitlager, Pendelstütze; Richtung der Lagerkraft bekannt, nur der Betrag ist unbekannt. Kehrt sich die Kraft um, muss die Konstruktion ein Abheben verhindern. #text(fill: muted)[\[TM1-Buch S. 114\]]
- #strong[Zweiwertige Lager:] Festlager nimmt eine Kraft beliebiger Richtung auf ($A_H, A_V$); Parallelführung und Schiebehülse übertragen je eine Kraft und ein Moment. #text(fill: muted)[\[TM1-Buch S. 115\]]
- #strong[Dreiwertig:] Doppelstütze mit etwas versetztem dritten Stab oder Einspannung (Einspannmoment $M_A$). #text(fill: muted)[\[TM1-Buch S. 115–116\]]
- #strong[Bezeichnung:] Das Buch schreibt $A_H, A_V$ (horizontal/vertikal), die Folien $A_x, A_y$. Gleiche Bedeutung. #text(fill: muted)[\[TM1-Buch S. 115\]]])
#src[Skript TM1 S. 149–151; FS TM1 S. 18 (Tabelle Lager/Gelenke) und S. 30; TM1-Buch S. 113–116.]
=== 5.1.2 Statische Bestimmtheit <a-tm1-5-1-2>
In der Ebene hast du für einen Körper genau #strong[3 Gleichgewichtsbedingungen]. Damit kannst du höchstens 3 Unbekannte ausrechnen. Ein einteiliges Tragwerk heißt #strong[statisch bestimmt], wenn sich alle Lagerreaktionen aus diesen 3 Gleichungen berechnen lassen. Der Normalfall ist also $Sigma r = 3$, d. h. $f = 0$.
#form[$ Sigma F_x = 0, wide Sigma F_y = 0, wide Sigma M_((A)) = 0 wide => wide f = 3 - Sigma r = 3 - 3 = 0 $]
Normalfall: statisch bestimmt (FS TM1 Gl. 5.3/5.4).
#note([Aus deiner Mitschrift (Skript TM1 S. 152)], [Neben die drei GGW-Bedingungen hast du gleichwertige Sätze geschrieben: statt $Sigma F_x, Sigma F_y, Sigma M_((A))$ geht auch $Sigma F_x = 0, Sigma M_((A)) = 0, Sigma M_((B)) = 0$ oder $Sigma F_y = 0, Sigma M_((A)) = 0, Sigma M_((B)) = 0$ oder sogar drei Momentengleichungen $Sigma M_((A)), Sigma M_((B)), Sigma M_((C)) = 0$. Wichtig dabei #text(fill: muted)[(eigene Ergänzung)]: Die Momentenpunkte dürfen nicht auf einer Geraden liegen (bei zwei Momenten + einer Kraftsumme darf die Verbindungslinie AB nicht senkrecht zur Kraftrichtung stehen). Genau so hast du Beispiel 5.3b gelöst (siehe 5.1.3).])
#bild("tm1k5_ggw", [Skript TM1 S. 152 (obere Folie) mit deiner Mitschrift: gleichwertige Sätze von GGW-Bedingungen.], height: 45mm)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k5_bsp12", [Skript TM1 S. 152 (untere Folie): Beispiel 1 (von dir notiert: „Normalfall“) mit $r = 2 + 1$; Beispiel 2 (von dir notiert: „z. B. Flugzeugtragflügel“) mit Einspannung $r = 3$.], height: 50mm)],
 [#bild("tm1k5_bsp3", [Skript TM1 S. 153 (obere Folie): Beispiel 3 – Scheibe mit drei Pendelstützen, $f = 3 - (1+1+1) = 0$ (r = 1 von dir gelb markiert).], height: 50mm)])
#heading(level: 4, outlined: false)[Sonderfälle: $f = 0$ und trotzdem nicht bestimmt ★]
Zählen allein reicht nicht. Die Folien zeigen zwei Sonderfälle mit drei einwertigen Lagern:
- #strong[Sonderfall 1 – alle drei Kräfte parallel:] Drei senkrechte Pendelstützen. Nichts hält den Balken waagerecht fest → er ist #strong[endlich beweglich]. Außerdem ist er #strong[vorspannbar]: Ist Stütze C zu kurz, lässt sie sich nur mit Zwang einbauen.
- #strong[Sonderfall 2 – alle drei Wirkungslinien schneiden sich in einem Punkt D (zentral):] Die Scheibe kann sich um D drehen („Schlackern“), zwar nur #strong[infinitesimal] klein, aber das reicht: unbrauchbar und vorspannbar.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k5_sonderfall1", [Skript TM1 S. 153 (untere Folie): Sonderfall 1 – drei parallele Pendelstützen, mit deiner Notiz.], height: 50mm)],
 [#bild("tm1k5_sonderfall2", [Skript TM1 S. 154 (obere Folie): Sonderfall 2 – Wirkungslinien schneiden sich in D.], height: 50mm)])
#note([Aus deiner Mitschrift (Skript TM1 S. 153)], [„Durch horizontale Kraft $F_3$ ist das BT \[Bauteil\] beweglich!“ – Genau: $Sigma F_x = F_3 = 0$ ist nicht erfüllbar, weil keine Lagerkraft eine x-Komponente hat. Die Zeile $f = 3 - Sigma r = 0$ hast du dort zusätzlich rot hervorgehoben.])
#note([Von dir markiert (gelb, Skript TM1 S. 154)], [„$f = 0$ ist #strong[notwendig], aber #strong[nicht hinreichend] für #strong[statische Bestimmtheit].“], fill: sand)
#note([Merke ★ – allgemein gültige Regel (Folie, rot umrandet)], [Ein einteiliges ebenes Tragwerk ist statisch bestimmt bei
+ 3 Reaktionskräften, die #strong[nicht alle parallel] und #strong[nicht zentral] (durch einen Punkt) sind, oder
+ 2 nicht parallelen Reaktionskräften und einem Moment.])
#bild("tm1k5_regel", [Skript TM1 S. 154 (untere Folie): allgemeine Regel, mit deiner gelben Markierung.], height: 45mm)
#heading(level: 4, outlined: false)[Statische Unbestimmtheit]
#form[$ n = cases( r - 3 & (r > 3) quad "Überbestimmtheit", 3 - r & (r < 3) quad "Unterbestimmtheit" ) $]
Grad $n$ der statischen Über- bzw. Unterbestimmtheit (FS TM1 Gl. 5.7). Beide können auch gleichzeitig auftreten.
#bild("tm1k5_unbestimmt", [Skript TM1 S. 155 (untere Folie): Balken mit 5 Lagerreaktionen → 2-fach überbestimmt (Berechnung in TM II); Balken nur mit Festlager → 1-fach unterbestimmt (Physik, TM III).], height: 45mm)
#note([In eigenen Worten], [Ein Tisch mit drei Beinen steht immer fest (statisch bestimmt). Ein Tisch mit vier Beinen wackelt, wenn ein Bein zu kurz ist – die Beinkräfte hängen davon ab, wie genau die Beine passen (statisch überbestimmt, „vorspannbar“). #text(fill: muted)[(eigene Ergänzung)]])
#note([Fehler vermeiden (Begriffe)], [Die Folien sagen „statisch #strong[über]bestimmt“ für $r > 3$. Im Buch und in TM2 heißt das gleiche „statisch #strong[unbestimmt] (x-fach)“. Die Folie nutzt „statisch unbestimmt“ als Oberbegriff für Über- #emph[und] Unterbestimmtheit. Ein unterbestimmtes System ist beweglich – das Buch nennt das „kinematisch unbestimmt“.], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Kinematisch unbestimmt:] Ein Tragwerk, das endliche oder infinitesimale Bewegungen ausführen kann (z. B. drei parallele Stützen, Wirkungslinien durch einen Punkt P). Solche Ausnahmefälle muss man ausschließen. #text(fill: muted)[\[TM1-Buch S. 116–117\]]
- #strong[Statisch bestimmt hängt nur von der Lagerung ab], nicht von der Belastung. #text(fill: muted)[\[TM1-Buch S. 117\]]
- #strong[x-fach statisch unbestimmt:] Zahl der unbekannten Lagerreaktionen ist um x größer als die Zahl der Gleichgewichtsbedingungen; Berechnung nur mit Verformungen (Elastostatik, Band 2). #text(fill: muted)[\[TM1-Buch S. 118\]]])
#src[Skript TM1 S. 152–155; deine Mitschrift S. 152–154; FS TM1 S. 30–31; TM1-Buch S. 116–118.]
=== 5.1.3 Berechnung der Lagerreaktionen <a-tm1-5-1-3>
Das Vorgehen ist immer gleich. Du hast es auf der Folie rot markiert – es ist das Kochrezept für fast jede Statikaufgabe:
#note([Merke ★ – Allgemeines Vorgehen (einteilig)], [+ #strong[a) Freischnitt:] Lager entfernen, Lagerreaktionen mit angenommener Richtung einzeichnen.
+ #strong[b) Statische Bestimmtheit prüfen:] $f = 3 - Sigma r = 0$? Kräfte nicht alle parallel/zentral?
+ #strong[c) GGW-Bedingungen aufstellen:] $Sigma F_x = 0, Sigma F_y = 0, Sigma M_((P)) = 0$ mit beliebigem Punkt P.
+ #strong[d) Gleichungssystem lösen] nach den 3 Unbekannten.])
#note([Von dir markiert (Skript TM1 S. 156)], [Über „Allgemeines Vorgehen“ steht ein roter Strich. Das gleiche Zeichen steht auch beim Vorgehen für mehrteilige Tragwerke (S. 171). Beide Rezepte sind klausurrelevant.], fill: sand)
#bild("tm1k5_vorgehen", [Skript TM1 S. 156 (obere Folie): Bauteil mit Lagerung und Belastung, a) Freischnitt.], height: 45mm)
#note([In eigenen Worten], [Wie beim Kochen: Erst alle Zutaten auf den Tisch (Freischnitt), dann prüfen, ob das Rezept überhaupt aufgeht (Bestimmtheit), dann kochen (Gleichungen). Wer mit dem Rechnen anfängt, bevor das Freikörperbild sauber ist, verbrennt fast immer etwas. #text(fill: muted)[(eigene Ergänzung)]])
#note([Fehler vermeiden (typische Fehler)], [- Momentenpunkt ungeschickt gewählt: Nimm einen Punkt, durch den möglichst viele Unbekannte gehen (meist ein Lager). Dann hat die Momentengleichung nur eine Unbekannte.
- Schräge Kräfte nicht zerlegt: Erst Komponenten bilden (sin/cos am Dreieck prüfen!), dann einsetzen.
- Hebelarm falsch: Hebelarm ist der #strong[senkrechte] Abstand der Wirkungslinie vom Bezugspunkt.
- Drehsinn: Vorher festlegen (z. B. gegen den Uhrzeiger positiv) und durchhalten.], fill: sand)
#heading(level: 4, outlined: false)[Beispiel 5.1: Balken mit fester Einspannung]
#bild("tm1k5_bsp51", [Skript TM1 S. 157 (obere Folie): Beispiel 5.1 und Freischnitt mit $A_x, A_y, M_A$.], height: 45mm)
#note([Beispiel 5.1 (Folien 23–24)], [Geg.: $F_1$ waagerecht in Höhe $b$ über dem Balken, $F_2$ am Balkenende unter dem Winkel $alpha$ zur Senkrechten, Länge $l$. Ges.: Lagerreaktionen.
+ Statische Bestimmtheit: $f = 3 - 3 = 0$; 2 nicht parallele Kräfte + Moment → statisch bestimmt.
+ $Sigma F_x = 0 colon A_x + F_1 + F_2 sin alpha = 0 => A_x = -F_1 - F_2 sin alpha$
+ $Sigma F_y = 0 colon A_y - F_2 cos alpha = 0 => A_y = F_2 cos alpha$
+ $Sigma M_((A)) = 0 colon M_A - b F_1 - l F_2 cos alpha = 0 => M_A = b F_1 + l F_2 cos alpha$
$F_1$ hat den Hebelarm $b$ (senkrechter Abstand zur Balkenachse), nicht $a$!], fill: pale)
#note([Widerspruch Folie ↔ Buch], [Das gleiche Beispiel steht im Buch (Beispiel 5.2). Dort kommt $M_A = -(b F_1 + l F_2 cos alpha )$ heraus, auf der Folie $M_A = +(b F_1 + l F_2 cos alpha )$. Beides ist richtig: Das Buch hat den Pfeil für $M_A$ im Freikörperbild andersherum angenommen. Das Buch schreibt selbst: Ein negatives Vorzeichen heißt, die Reaktion wirkt entgegengesetzt zur angenommenen Richtung. #text(fill: muted)[\[TM1-Buch S. 120\]]], fill: sand)
#heading(level: 4, outlined: false)[Beispiel 5.2: Balken mit vier Kräften]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k5_bsp52", [Skript TM1 S. 158 (obere Folie): Beispiel 5.2.], height: 50mm)],
 [#bild("tm1k5_bsp53a", [Skript TM1 S. 158 (untere Folie): Beispiel 5.3a.], height: 50mm)])
#note([Beispiel 5.2 (Folie 25, nachgerechnet wie in deiner Mitschrift S. 162–163)], [Geg.: $K_1 = 200$ kN (senkrecht), $K_2 = 300$ kN unter 75° zum Balken, $K_3 = 200$ kN (senkrecht), $K_4 = 300$ kN unter 60° zum Balken. Abstände ab A: 1 m, 3 m, 6 m, 10 m; B bei 11 m. Ges.: $A_x, A_y, B$.
+ Zerlegen: $K_("2x") = 300 cos 75° = 77","65$ kN, $K_("2y") = 300 sin 75° = 289","78$ kN; $K_("4x") = 300 cos 60° = 150$ kN, $K_("4y") = 300 sin 60° = 259","81$ kN.
+ $Sigma F_x = 0 colon A_x + 77","65 + 150 = 0 => A_x = -227","65$ kN (zeigt also nach links).
+ $Sigma M_((A)) = 0 colon -1 dot 200 - 3 dot 289","78 - 6 dot 200 - 10 dot 259","81 + 11 thin B = 0 => 11 thin B = 4867","41 => B = 442","49$ kN.
+ $Sigma F_y = 0 colon A_y + B - 200 - 289","78 - 200 - 259","81 = 0 => A_y = 507","09$ kN.
Probe: $A_y + B = 949","58$ kN $= Sigma K_("iy")$ ✓.], fill: pale)
#note([Aus deiner Mitschrift (S. 159–163)], [Du hast Beispiel 5.2 zweimal gerechnet. Beim ersten Mal hattest du $A_y = 507","10$ kN (Rundung), beim zweiten Mal mit mehr Stellen $507","094$ kN – Folie: 507,09 kN ✓. Die Komponenten $K_("2y")$ und $K_("4y")$ hast du gelb markiert. Tipp aus deiner Lösung: Bei jeder schrägen Kraft ein kleines Dreieck mit „sin“ und „cos“ an die Seiten schreiben.])
#note([Beispiel 5.3a (Folie 26, wie in deiner Mitschrift S. 160–161)], [Geg.: $K_1 = 150$ kN waagerecht nach links, greift an einem Ausleger $l/2 = 1","5$ m #emph[unter] der Balkenachse bei $x = 3$ m an; $K_2 = 300$ kN unter 60° bei $x = 6$ m; $K_3 = 100$ kN senkrecht am Kragarmende $x = 10","5$ m; B bei $x = 9$ m, $l = 3$ m.
+ $Sigma F_x = 0 colon A_x - 150 + 300 cos 60° = 0 => A_x = 0$.
+ $Sigma M_((A)) = 0 colon -150 dot 1","5 - 6 dot 300 sin 60° - 10","5 dot 100 + 9 thin B = 0 => 9B = 2833","85 => B = 314","87$ kN.
+ $Sigma F_y = 0 colon A_y - 259","81 + B - 100 = 0 => A_y = 44","94$ kN.
Deine Notiz dazu: „$K_1$ dreht sich im Uhrzeigersinn!“ – $K_1$ liegt unterhalb von A und zeigt nach links → Drehung im Uhrzeigersinn → negatives Moment, Hebelarm 1,5 m.], fill: pale)
#heading(level: 4, outlined: false)[Beispiel 5.3b: Tragfläche eines Sportflugzeugs]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k5_bsp53b", [Skript TM1 S. 164 (obere Folie): Tragfläche als Balken mit Festlager A, Pendelstütze BC (45°) und Auftrieb $q_0$.], height: 50mm)],
 [#bild("tm1k5_bsp53b_fkb", [Deine Mitschrift (Skript TM1 S. 165): Freikörperbild, $R = q_0 L$ bei $L/2$, Stütze S#sub[1] unter 45°.], height: 50mm)])
#note([Beispiel 5.3b (Folie 27, Lösung aus deiner Mitschrift S. 165–166)], [Geg.: $q_0$ (nach oben, Auftrieb) über die Länge $L$; A Festlager, Stütze von B (bei $L/4$) nach C ($L/4$ unter A) unter 45°. Ges.: Lagerreaktionen (Teilaufgaben 2 und 3 = Schnittgrößen, siehe Kap. 7).
+ Freischnitt: $A_x, A_y$ bei A, Stabkraft $S_1$ bei B in Stabrichtung; Resultierende $R = q_0 L$ bei $x = L/2$.
+ Bestimmtheit: $f = 3 - (2+1) = 0$; 3 Kräfte, nicht alle parallel oder zentral ✓.
+ Drei Momentengleichungen um A, B und C (liegen nicht auf einer Geraden): \
  
  $Sigma M_((A)) colon - frac(L, 4) S_1 sin 45° + frac(L, 2) q_0 L = 0 => S_1 = 2 sqrt(2) thin q_0 L$ \
  
  $Sigma M_((B)) colon - frac(L, 4) A_y + q_0 L dot frac(L, 4) = 0 => A_y = q_0 L$ \
  
  $Sigma M_((C)) colon - frac(L, 4) A_x + frac(L, 2) q_0 L = 0 => A_x = 2q_0 L$
+ Probe $Sigma F_x$: $A_x - S_1 cos 45° = 2q_0 L - 2q_0 L = 0$ ✓; $Sigma F_y$: $A_y + q_0 L - S_1 sin 45° = q_0 L + q_0 L - 2q_0 L = 0$ ✓ #text(fill: muted)[(eigene Probe)].
Plausibel: Die Stütze greift nahe am Lager an (kurzer Hebel $L/4$), die Last wirkt bei $L/2$ → die Stützkraft ist mit $2 sqrt(2) thin q_0 L approx 2","83 thin q_0 L$ deutlich größer als die Last selbst. Mit $S_1$ zur Stütze hin angesetzt ist $S_1 > 0$ eine Zugkraft: Der Auftrieb will den Flügel hochklappen, die Strebe hält ihn unten.], fill: pale)
#heading(level: 4, outlined: false)[Eigenes Beispiel mit Zahlen]
#note([Beispiel (eigene Ergänzung): Lagerregal-Traverse.], [Eine Regaltraverse (Länge 4 m) liegt links auf einem Festlager A und rechts auf einem Loslager B. Paletten wirken als Streckenlast $q = 2$ kN/m auf ganzer Länge, dazu eine Einzellast $F = 6$ kN bei 1 m ab A. Ges.: Lagerkräfte.
+ Resultierende der Streckenlast: $R = 2 dot 4 = 8$ kN bei 2 m.
+ $Sigma F_x = 0 => A_x = 0$.
+ $Sigma M_((A)) = 0 colon 4 thin B - 6 dot 1 - 8 dot 2 = 0 => B = 5","5$ kN.
+ $Sigma F_y = 0 colon A_y + B - 6 - 8 = 0 => A_y = 8","5$ kN.
Plausibel: Die Einzellast sitzt näher an A → A trägt mehr. WI-Bezug: So prüft man, ob die zulässige Lagerlast der Regalstütze (Herstellerangabe) eingehalten ist.], fill: pale)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Richtungssinn frei wählbar], aber bei Pendelstützen gilt die Stab-Konvention: Zugkräfte positiv. #text(fill: muted)[\[TM1-Buch S. 118\]]
- #strong[Probe mit einer weiteren Momentengleichung:] Um B gerechnet liefert $A_V$ direkt aus einer Gleichung – oft zweckmäßiger als $Sigma F_y$. #text(fill: muted)[\[TM1-Buch S. 120\]]
- #strong[Superpositionsprinzip:] Bei mehreren Lasten darf man die Lagerreaktionen jedes Lastfalls einzeln berechnen und addieren (wegen der Linearität der Gleichgewichtsbedingungen). Nicht auf den Folien, aber eine nützliche Rechenhilfe. #text(fill: muted)[\[TM1-Buch S. 121–122\]]])
#src[Skript TM1 S. 156–158, 164; deine Mitschrift S. 159–163, 165–166; FS TM1 S. 31; TM1-Buch S. 118–122.]
== 5.2 Einteilige räumliche Tragwerke <a-tm1-5-2>
Dieser Abschnitt ist im Inhaltsverzeichnis des Foliensatzes durchgestrichen (Skript TM1 S. 146), die Folien 29–30 fehlen im Skript. Er wurde also #strong[nicht behandelt]. Nur zur Einordnung steht in der Formelsammlung: Ein Körper im Raum hat 6 Freiheitsgrade (3 Translationen, 3 Rotationen), also $f = 6 - Sigma r$; statisch bestimmt im Normalfall bei $Sigma r = 6$ (FS TM1 S. 31). Ein Festlager ist im Raum dreiwertig, eine Einspannung sechswertig #text(fill: muted)[\[TM1-Buch S. 123\]].
#src[Skript TM1 S. 146; FS TM1 S. 31; TM1-Buch S. 123–125.]
== 5.3 Mehrteilige ebene Tragwerke <a-tm1-5-3>
=== 5.3.1 Verbindungselemente <a-tm1-5-3-1>
Jetzt besteht das Tragwerk aus #strong[mehreren] Körpern (Anzahl $n$). Jeder Körper hat 3 Freiheitsgrade, zusammen also $3n$. Es gibt zwei Arten von Verbindungen:
- #strong[Körper – Umgebung:] Lager mit $r$ Lagerreaktionen (wie bisher),
- #strong[Körper – Körper:] Verbindungselemente mit $v$ Verbindungsreaktionen.
Zwei Körper ohne Verbindung haben relativ zueinander 3 FG (2 Translationen, 1 Rotation). Ein Verbindungselement schränkt die Bewegung zwischen #strong[je 2] Körpern ein. Seine #strong[Wertigkeit] $v$ ist die Zahl der übertragenen Reaktionen.
#tab(columns: 3,
 th([Wertigkeit], [Beispiele], [übertragen]),
 [$v = 1$], [Pendelstab, Schiebegelenk, Kontakt ohne Reibung], [1 Kraft (Pendelstab: $S$ in Stabrichtung; Kontakt: Normalkraft $N$)],
 [$v = 2$], [Gelenk, Kontakt mit Reibung], [2 Kräfte ($G_x, G_y$ bzw. $N, T$), kein Moment],
 [$v = 2$], [Parallelführung, Schiebehülse], [1 Kraft + 1 Moment ($G_x, M_G$ bzw. $G_y, M_G$)],
)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k5_verb1", [Skript TM1 S. 168 (obere Folie): einwertige Verbindungselemente.], height: 50mm)],
 [#bild("tm1k5_verb2", [Skript TM1 S. 168 (untere Folie): zweiwertig – Gelenk, Kontakt mit Reibung.], height: 50mm)])
#bild("tm1k5_verb3", [Skript TM1 S. 169 (obere Folie): zweiwertig – Parallelführung und Schiebehülse (Kraft + Moment).], height: 45mm)
#note([Fehler vermeiden: Nicht zulässig (Folie 32)!], [- a) Mehr als 2 Körper über #strong[ein] Verbindungselement verbunden,
- b) 2 oder mehr Körper über #strong[ein] Lager mit der Umgebung verbunden.
Abhilfe: Am gleichen Ort in mehrere Verbindungselemente bzw. Lager aufspalten. Treffen sich z. B. 3 Körper in einem Gelenkpunkt, zählt das als 2 Gelenke, also $v = 2 dot 2 = 4$.], fill: sand)
#bild("tm1k5_nichtzulaessig", [Skript TM1 S. 167 (untere Folie): unzulässige Verbindungen und Abhilfe durch Aufspalten; hier $n = 4$, $Sigma r = 4$, $v = 4 dot 2 = 8$.], height: 45mm)
#note([In eigenen Worten], [Ein Gelenk ist wie ein Scharnier an der Tür: Es hält Tür und Rahmen zusammen (Kräfte), aber die Tür kann sich frei drehen (kein Moment). Eine Parallelführung ist wie eine Schublade: Sie kann rein und raus gleiten, aber nicht kippen. #text(fill: muted)[(eigene Ergänzung)]])
#note([Merke], [Am Verbindungselement gilt actio = reactio: Auf Körper 1 wirkt $G_x, G_y$, auf Körper 2 wirken dieselben Kräfte #strong[entgegengesetzt]. Die Richtung darfst du an einem der beiden Körper frei wählen – am anderen liegt sie dann fest.])
#note([Widerspruch Folie ↔ Formelsammlung (Bezeichnung)], [Die Folien und das Buch nennen die Zahl der Verbindungsreaktionen $v$ (kleines „v“), die Formelsammlung TM1 schreibt $V$ (großes V, Gl. 5.11). Gemeint ist dasselbe. Nicht mit einer Vertikalkraft $V$ (z. B. $V_y$ beim PKW-Beispiel) verwechseln!], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Pendelstab] $v = 1$ (Kraft S in Längsrichtung), #strong[Gelenk] $v = 2$ (reibungsfrei → kein Moment), #strong[Parallelführung (Querkraftgelenk)] $v = 2$ (eine Kraft N und ein Moment M). #text(fill: muted)[\[TM1-Buch S. 126\]]])
#src[Skript TM1 S. 167–169; FS TM1 S. 18, 32; TM1-Buch S. 126.]
=== 5.3.2 Statische Bestimmtheit mehrteiliger Tragwerke <a-tm1-5-3-2>
Du schneidest alle $n$ Bauteile frei. Für jedes hast du 3 GGW-Bedingungen, zusammen $3n$ Gleichungen. Unbekannt sind $r$ Lagerreaktionen und $v$ Verbindungsreaktionen. Statisch bestimmt (Normalfall), wenn Gleichungen = Unbekannte:
#form[$ 3 dot n = v + r $]
$n$: Anzahl der Körper, $v$: Verbindungsreaktionen (Körper–Körper), $r$: Lagerreaktionen (Körper–Umgebung). FS TM1 Gl. 5.11. Notwendig, aber nicht hinreichend.
#note([Von dir markiert (gelb, Skript TM1 S. 170)], [die Bedingung $3n = v + r$ und die Bedeutung von $r$ (Lagerreaktionen), $v$ (Verbindungsreaktionen) und $n$ (Anzahl der Körper). ★], fill: sand)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k5_mbest_bsp", [Skript TM1 S. 170 (untere Folie): Beispiel 1 ($n = 3, v = 4, r = 5$) und Beispiel 2 ($n = 2, v = 2, r = 4$).], height: 50mm)],
 [#bild("tm1k5_mbest_sonder", [Skript TM1 S. 171 (obere Folie): Normalfall (Dreigelenk-Dach) und Sonderfall (drei Gelenke auf einer Geraden).], height: 50mm)])
Beide Systeme auf Folie 39 erfüllen $3n = 6 = v + r$. Trotzdem:
- #strong[Normalfall] (Gelenk G oben, Stäbe schräg): statisch bestimmt, nicht vorspannbar, nicht beweglich.
- #strong[Sonderfall] (A, G, B auf einer Geraden): statisch unbestimmt, horizontal #strong[vorspannbar] („klemmt“), in vertikaler Richtung #strong[infinitesimal beweglich] („wackelt“).
#note([In eigenen Worten], [Eine Wäscheleine, straff zwischen zwei Pfosten gespannt: In der Mitte (wie das Gelenk G) gibt sie bei der kleinsten Last nach unten nach – sie „wackelt“. Erst durch Durchhang (Knick wie beim Normalfall) kann sie eine Last tragen. #text(fill: muted)[(eigene Ergänzung)]])
#note([Merke], [Für $n = 1$ und $v = 0$ wird $3n = v + r$ zu $r = 3$ – das ist der einteilige Fall aus 5.1.2.])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Bedingung $r + v = 3n$:] notwendig; ist das Tragwerk außerdem unbeweglich, ist es statisch bestimmt. #text(fill: muted)[\[TM1-Buch S. 127\]]
- #strong[Kinematisch unbestimmt trotz erfüllter Zählung:] z. B. Pendelstütze am „falschen“ Balken oder Gelenk infinitesimal verschieblich. #text(fill: muted)[\[TM1-Buch S. 128\]]
- #strong[Allgemein:] $f = 3n - (r + v)$; $f > 0$ beweglich (Getriebe), $f < 0$ statisch unbestimmt. Systeme können #strong[äußerlich] statisch bestimmt (Lagerreaktionen berechenbar), aber #strong[innerlich] unbestimmt sein. #text(fill: muted)[\[TM1-Buch S. 137–138\]]
- #strong[Prüfung der Beweglichkeit:] Gleichungssystem $A thin x = b$ ist eindeutig lösbar, wenn $det A != 0$; grafisch mit dem Polplan. Nicht auf den Folien. #text(fill: muted)[\[TM1-Buch S. 139–140\]]])
#src[Skript TM1 S. 170–171; FS TM1 S. 32; TM1-Buch S. 126–128, 137–140.]
=== 5.3.3 Berechnung der Lager- und Gelenkreaktionen <a-tm1-5-3-3>
Gleiches Rezept wie bei einem Körper – nur machst du alles für #strong[jedes Teil einzeln]:
#note([Merke ★ – Allgemeines Vorgehen (mehrteilig)], [+ #strong[a) Alle Teile freischneiden.] Achtung: Jede äußere Kraft $F_i$ und jedes Moment $M_j$ gehört zu #strong[genau einem] Bauteil – richtig zuordnen! Gelenkkräfte an beiden Teilen entgegengesetzt.
+ #strong[b) Statische Bestimmtheit prüfen:] $3n = v + r$.
+ #strong[c) GGW-Bedingungen] $Sigma F_x = 0, Sigma F_y = 0, Sigma M_((P)) = 0$ für jeden Körper → $3n$ Gleichungen.
+ #strong[d) Gleichungssystem lösen] nach den $r + v$ Unbekannten.])
#bild("tm1k5_mfreischnitt", [Skript TM1 S. 172 (obere Folie): alle Teile freigeschnitten – $n = 3$, $v = 4$, $r = 5$.], height: 45mm)
#note([Fehler vermeiden (typische Fehler)], [- Eine Kraft, die genau im Gelenk angreift, nur an #strong[einem] Teil ansetzen, nicht an beiden.
- Gelenkkraft am zweiten Teil mit gleicher statt entgegengesetzter Richtung angesetzt → Vorzeichenchaos.
- Momentengleichung um das Gelenk ist besonders praktisch: Die Gelenkkräfte fallen heraus.], fill: sand)
#heading(level: 4, outlined: false)[Beispiel 5.4: Balken + Winkel]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k5_bsp54", [Skript TM1 S. 173 (obere Folie): Beispiel 5.4 – Balken 1 (Lager B) und Winkel 2 (eingespannt in A), verbunden im Gelenk G.], height: 50mm)],
 [#bild("tm1k5_bsp54_fs", [Skript TM1 S. 173 (untere Folie): Freischnitt und Bestimmtheit $n = 2, v = 2, r = 1 + 3 = 4$ → $6 = 6$ ✓.], height: 50mm)])
#note([Beispiel 5.4 (Folien 43–47)], [F am linken Ende von Balken 1, B im Abstand $a$, G im Abstand $b$ hinter B; Winkel 2: waagerecht $c$, senkrecht $h$, eingespannt in A.
+ GGW Körper 1: $Sigma F_x colon G_x = 0$ (1); $Sigma F_y colon -F + B + G_y = 0$ (2); $Sigma M_((B)) colon F dot a + G_y dot b = 0$ (3).
+ GGW Körper 2: $Sigma F_x colon -G_x + A_x = 0$ (4); $Sigma F_y colon A_y - G_y = 0$ (5); $Sigma M_((G)) colon A_x h + A_y c + M_A = 0$ (6).
+ Lösen: $G_x = 0$, $A_x = 0$, $G_y = -F frac(a, b)$, $B = F(1 + frac(a, b) )$, $A_y = -F frac(a, b)$, $M_A = F frac(a, b) c$.
Interpretation: $G_y < 0$ → Balken 1 „hebelt“ um B, das Gelenk zieht den Winkel nach oben. B ist größer als F (Hebelwirkung wie bei einer Wippe).], fill: pale)
#note([Aus den Büchern], [- Das Buch rechnet das gleiche System als Beispiel 5.6 und macht am Ende die #strong[Probe am Gesamtsystem] mit erstarrtem Gelenk (Erstarrungsprinzip): $Sigma M_((B))$ am Ganzen muss ebenfalls null ergeben. #text(fill: muted)[\[TM1-Buch S. 128–129\]]])
#heading(level: 4, outlined: false)[Beispiel 5.5: PKW und Anhänger]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k5_pkw", [Skript TM1 S. 179 (obere Folie): PKW (15 kN) mit Anhänger (5 kN), Achsen A, H, V und Kupplung G.], height: 50mm)],
 [#bild("tm1k5_pkw_fs", [Skript TM1 S. 179 (untere Folie): Freischnitt – Anhänger und PKW getrennt.], height: 50mm)])
#note([Beispiel 5.5 (Folien 48–53, wie in deiner Mitschrift S. 176–178)], [Abstände: A – 5 kN: 0,25 m; 5 kN – G: 1 m; G – H: 1 m; H – 15 kN: 1,4 m; 15 kN – V: 1,4 m. A und V einwertig, H zweiwertig, Kupplung G ein Gelenk.
+ Bestimmtheit: $n = 2$, $r = 1 + 2 + 1 = 4$, $v = 2$ → $3n = 6 = 4 + 2$ ✓.
+ Anhänger: $Sigma F_x colon G_x = 0$; $Sigma M_((G)) colon -1","25 thin "m" dot A_y + 1 thin "m" dot 5 thin "kN" = 0 => A_y = 4","0$ kN; $Sigma F_y colon A_y - 5 + G_y = 0 => G_y = 1","0$ kN.
+ PKW: $Sigma F_x colon -G_x + H_x = 0 => H_x = 0$; $Sigma M_((H)) colon 1 dot G_y - 1","4 dot 15 + 2","8 thin V_y = 0 => V_y = frac(21 - 1, 2","8) = 7","14$ kN.
+ $Sigma F_y colon -G_y + H_y - 15 + V_y = 0 => H_y = 15 + 1 - 7","14 = 8","86$ kN.
Probe gesamt: $4","0 + 8","86 + 7","14 = 20$ kN = 5 kN + 15 kN ✓. Die Anhängelast von 1 kN drückt auf die Kupplung und entlastet die Vorderachse (ohne Anhänger: $V_y = 7","5$ kN) #text(fill: muted)[(eigene Ergänzung)].], fill: pale)
#note([Aus deiner Mitschrift (S. 176–177)], [Du hast die Vorderachse mit „$K_y$“ statt $V_y$ bezeichnet und an der Skizze die Wertigkeiten notiert: A $r = 1$, G $v = 2$, H $r = 2$, V $r = 1$. Deine Ergebnisse stimmen mit der Folie überein.])
#heading(level: 4, outlined: false)[Beispiel 5.6: Rahmen]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k5_rahmen", [Skript TM1 S. 181 (untere Folie): Beispiel 5.6 – Rahmen ACG mit Streckenlast $q_0 = F/a$ und Kraft F, Strebe GB, Lager A und B.], height: 50mm)],
 [#bild("tm1k5_rahmen_mit", [Deine Mitschrift (Skript TM1 S. 182): Freischnitt von Körper 1 (Rahmen A–C–G) und Körper 2 (Strebe G–B).], height: 50mm)])
#note([Beispiel 5.6 (Folie 54, Lösung nach deiner Mitschrift S. 182–184, nachgerechnet)], [Koordinaten: A (0; 0), C (0; $frac(3, 4) a$), G ($a$; $frac(3, 4) a$), B ($2a$; $- frac(1, 4) a$). Lasten: F waagerecht bei C, $q_0 a = F$ als Resultierende bei $a/2$.
+ Bestimmtheit: $n = 2$, $r = 4$, $v = 2$ → $6 = 6$ ✓.
+ Körper 1: $A_x + F + G_x = 0$ (1); $A_y - F + G_y = 0$ (2); $Sigma M_((G)) colon frac(3, 4) a A_x - a A_y + frac(a, 2) F = 0$ (3).
+ Körper 2: $B_x - G_x = 0$ (4); $B_y - G_y = 0$ (5); $Sigma M_((G)) colon a B_x + a B_y = 0 => B_y = -B_x$ (6).
+ Lösung: $A_x = - frac(2, 7) F, A_y = frac(2, 7) F, G_x = - frac(5, 7) F, G_y = frac(5, 7) F, B_x = - frac(5, 7) F, B_y = frac(5, 7) F$.
Die Folie gibt die Beträge $A_x = frac(2, 7) F, B_x = frac(5, 7) F$ an – dort zeigen $A_x$ und $B_x$ offenbar nach links; mit deinen Pfeilen nach rechts werden sie negativ. Gleicher Inhalt.], fill: pale)
#note([Fehler vermeiden – Vorzeichenfehler in deiner Mitschrift (S. 184)], [Aus (1) folgt $G_x = -A_x - F = frac(2, 7) F - F = - frac(5, 7) F$. Du hast $G_x = - frac(2, 7) F + F = + frac(5, 7) F$ geschrieben (Vorzeichen von $A_x$ beim Umstellen nicht umgedreht). Dein $B_x = - frac(5, 7) F$ ist richtig – und wegen (4) $G_x = B_x$ muss auch $G_x = - frac(5, 7) F$ sein. Die Folie hat ebenfalls $G_x = - frac(5, 7) F$.], fill: sand)
#note([Merke – Abkürzung mit dem Pendelstab #text(fill: muted)[(eigene Ergänzung)]], [Die Strebe GB ist unbelastet und an beiden Enden gelenkig angeschlossen. Dann ist sie ein #strong[Pendelstab]: Die Kraft wirkt nur in Stabrichtung (hier 45°). Daraus folgt sofort $B_y = -B_x$ (Gl. 6) ohne Rechnung. Mit $Sigma M_((A))$ am Gesamtsystem (eingefroren): $2a B_y + frac(a, 4) B_x - frac(3, 4) a F - frac(a, 2) F = 0$ und $B_x = -B_y$ folgt $frac(7, 4) B_y = frac(5, 4) F => B_y = frac(5, 7) F$.])
#src[Skript TM1 S. 171–175, 179–181; deine Mitschrift S. 176–178, 182–184; FS TM1 S. 32; TM1-Buch S. 128–129.]
=== 5.3.4 Erstarrungs- oder Einfrierprinzip <a-tm1-5-3-4>
Ein Teil des Systems (Bauteile + Verbindungselemente) darf man sich #strong[„eingefroren“] vorstellen, also als #strong[eine starre Scheibe]. Das ist erlaubt, weil ein System im Gleichgewicht auch dann im Gleichgewicht bleibt, wenn man seine Gelenke festklebt.
- #strong[a)] Ist das Teilsystem in sich statisch bestimmt (oder überbestimmt), kann es als ein starrer Körper betrachtet werden. Die inneren Verbindungsreaktionen kann man – wenn das Teilsystem in sich bestimmt ist – bei Bedarf getrennt berechnen.
- Ist #strong[eingefrorenes Teilsystem + Rest] statisch bestimmt, sind alle äußeren Lager- und Verbindungsreaktionen bestimmbar.
- #strong[b)] Das GGW am Gesamtsystem nach außen muss immer erfüllt sein. Die 3 äußeren GGW-Bedingungen sind aber #strong[überzählig]: Sie liefern keine neuen Unbekannten, nur Abkürzungen und Proben.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k5_einfrier1", [Skript TM1 S. 185 (obere Folie): Gesamtsystem $n = 5, v = 12, r = 4$ → $15 != 16$, statisch überbestimmt.], height: 50mm)],
 [#bild("tm1k5_einfrier2", [Skript TM1 S. 185 (untere Folie): Teilsystem einfrieren → starre Scheibe $n = 1, v = 0, r = 3$.], height: 50mm)])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k5_einfrier3", [Skript TM1 S. 186 (obere Folie): Scheibe + Stütze $n = 2, v = 2, r = 4$ → statisch bestimmt.], height: 50mm)],
 [#bild("tm1k5_einfrier4", [Skript TM1 S. 186 (untere Folie): GGW am Gesamtsystem – $B_y = A_y = F/2$, aber $A_x, B_x, G_x, G_y$ noch offen.], height: 50mm)])
#form[$ Sigma M_((A)) = 0 colon quad B_y dot l - F dot frac(l, 2) = 0 med => med B_y = frac(F, 2), wide A_y = frac(F, 2) $]
Abkürzung am eingefrorenen Gesamtsystem (Folie 58–59).
#bild("tm1k5_einfrier5", [Skript TM1 S. 187 (untere Folie): vollständige Lösung – GGW an beiden Teilkörpern, 6 Gleichungen für 6 Unbekannte (+3 überzählige).], height: 45mm)
#note([Merke ★], [Für die #strong[vollständige] Lösung (alle Lager- und Verbindungsreaktionen) brauchst du immer das GGW an den #strong[einzelnen Bauteilen] + statische Bestimmtheit. Das Gesamtsystem liefert nur Abkürzungen für einzelne Lagerreaktionen und eine Probe.])
#note([Weiterführung von Folie 58 #text(fill: muted)[(eigene Ergänzung)]], [Die rechte Stütze ist unbelastet und oben (Gelenk) und unten (Festlager) gelenkig → Pendelstab, senkrecht. Sie kann nur senkrechte Kräfte übertragen: $B_x = 0$ und am Gelenk $G_x = 0$. Aus $Sigma F_x = A_x - B_x = 0$ folgt $A_x = 0$. Senkrecht: $G_y = B_y = F/2$ (die Stütze drückt mit $F/2$ nach oben auf die Scheibe).], fill: pale)
#note([In eigenen Worten], [Wenn du wissen willst, wie schwer ein Umzugskarton mit Inhalt ist, stellst du den ganzen Karton auf die Waage – du musst ihn nicht auspacken (Einfrieren). Willst du wissen, wie stark die Bücher im Karton auf den Boden drücken, musst du hineinschauen (Teilkörper). #text(fill: muted)[(eigene Ergänzung)]])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Erstarrungsprinzip:] Man stellt sich die gelenkige Verbindung als erstarrt vor und wendet die Gleichgewichtsbedingungen auf das Gesamtsystem an – im Buch als Probe genutzt. #text(fill: muted)[\[TM1-Buch S. 129\]]
- #strong[Beim Dreigelenkbogen] dienen die Gleichgewichtsbedingungen am Gesamtsystem als Rechenkontrolle. #text(fill: muted)[\[TM1-Buch S. 133\]]])
#note([Bezug zu Übung 8 (Lösung 8.1)], [In der Musterlösung steht ausdrücklich „Gesamtkörper (Einfrierprinzip!) – GGW Gesamtkörper wäre nicht unbedingt nötig“, es erleichtert aber die Rechnung (Lösung Übung 8 S. 1).])
#src[Skript TM1 S. 185–187; FS TM1 S. 32; Lösung Übung 8 S. 1; TM1-Buch S. 129, 133.]
=== 5.3.5 Dreigelenkbogen, Gerberträger (Gelenkbalken) <a-tm1-5-3-5>
Beide Bauformen entstehen aus dem gleichen Problem: Ein statisch bestimmtes System ist zu nachgiebig. Man setzt zusätzliche Lager → jetzt ist es statisch überbestimmt. Lösung: #strong[zusätzliche Gelenke einbauen], bis $3n = v + r$ wieder stimmt.
#tab(columns: 4,
 th([], [Ausgangspunkt], [mehr Lager], [+ Gelenk(e)]),
 [Dreigelenkbogen], [Rahmen mit Fest- + Loslager: $n = 1, r = 3$ ✓, aber zu nachgiebig (Loslager wandert)], [2 Festlager: $r = 4 != 3$ → überbestimmt], [1 Gelenk G: $n = 2, r = 4, v = 2$ → $6 = 6$ ✓],
 [Gerberträger], [langer Balken $n = 1, r = 3$ ✓, aber zu biegeweich], [Zwischenstützen: $r = 5 != 3$ → überbestimmt], [2 Gelenke: $n = 3, r = 5, v = 4$ → $9 = 9$ ✓],
)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k5_dgb1", [Skript TM1 S. 188 (obere Folie): Rahmen mit Fest-/Loslager (zu nachgiebig) bzw. 2 Festlagern (überbestimmt).], height: 50mm)],
 [#bild("tm1k5_dgb2", [Skript TM1 S. 188 (untere Folie): Dreigelenkbogen mit Gelenk G und Freischnitt.], height: 50mm)])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k5_gerber1", [Skript TM1 S. 189 (obere Folie): langer Balken – zu biegeweich bzw. überbestimmt.], height: 50mm)],
 [#bild("tm1k5_gerber2", [Skript TM1 S. 189 (untere Folie): Gerberträger mit Gelenken $G_1, G_2$ und Freischnitt.], height: 50mm)])
#form[$ "Gerberträger:" quad n = g + 1, quad v = 2g med => med 3(g+1) = 2g + r med => med g = r - 3 $]
$g$: Anzahl der nötigen Gelenke bei $r$ Lagerreaktionen (TM1-Buch Gl. 5.5, S. 135).
#note([In eigenen Worten], [Dreigelenkbogen: Zwei Leute lehnen sich Schulter an Schulter gegeneinander (Gelenk oben), die Füße stehen fest auf dem Boden (Festlager). Das Dreieck steht stabil, obwohl keiner allein stehen könnte. #text(fill: muted)[(eigene Ergänzung)]])
#note([Fehler vermeiden], [Die Gelenke beim Gerberträger dürfen nicht beliebig sitzen. Ein Balkenteil darf nicht ohne ausreichende Lagerung „herumhängen“ (z. B. zwei Gelenke im selben Feld ohne Stütze dazwischen) – sonst ist der Träger beweglich, obwohl die Zählung stimmt #text(fill: muted)[\[TM1-Buch S. 135\]].], fill: sand)
#heading(level: 4, outlined: false)[Beispiel 5.7: Gerberträger mit schwerem Teil]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k5_bsp57", [Skript TM1 S. 190 (obere Folie): Beispiel 5.7 – Teil I gewichtslos mit F, Teil II schwer ($G_("II") = 1000$ kN), $l = 2$ m.], height: 50mm)],
 [#bild("tm1k5_bsp57_fs", [Deine Mitschrift (Skript TM1 S. 191): Freischnitt Teil 1 und Teil 2 mit Maßen.], height: 50mm)])
#note([Beispiel 5.7 (Folie 65, Lösung nach deiner Mitschrift S. 191–192)], [A bei $x = 0$ (Loslager), F = 500 kN bei 2 m, Gelenk G bei 4 m, B bei 6 m (Loslager), C bei 12 m (Festlager). Teil II reicht von G bis C (8 m), Schwerpunkt in der Mitte (4 m vor C).
+ Bestimmtheit: $n = 2$, $r = 1 + 1 + 2 = 4$, $v = 2$ → $6 = 6$ ✓.
+ Teil I: $Sigma F_x colon G_x = 0$; $Sigma M_((A)) colon -2 dot 500 + 4 thin G_y = 0 => G_y = 250$ kN; $Sigma F_y colon A_y - 500 + 250 = 0 => A_y = 250$ kN.
+ Teil II: $Sigma F_x colon -G_x + C_x = 0 => C_x = 0$; $Sigma M_((C)) colon 4 dot 1000 - 6 thin B_y + 8 dot 250 = 0 => B_y = 1000$ kN; $Sigma F_y colon -250 + 1000 - 1000 + C_y = 0 => C_y = 250$ kN.
Ergebnis wie Folie: $A = 250$ kN, $B = 1000$ kN, $C = 250$ kN, $G = 250$ kN. Probe: $250 + 1000 + 250 = 1500$ kN = 500 + 1000 ✓.], fill: pale)
#note([Merke – Reihenfolge beim Gerberträger], [Fang mit dem Teil an, das nur auf dem Gelenk und #strong[einem] Lager „aufliegt“ (eingehängter Träger, hier Teil I). Dessen Gelenkkraft gibst du dann als Last an das tragende Teil weiter.])
#note([Von dir markiert], [Unter den Folienergebnissen von Beispiel 5.6 und 5.7 hast du jeden Wert mit einem kleinen Kreuz abgehakt (Skript TM1 S. 182, 191) – vermutlich als „nachgerechnet“. Bei 5.6 passt das für $G_x$ nicht ganz (siehe Vorzeichenfehler oben).], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Zweigelenkbogen → Dreigelenkbogen:] Bogen mit Rollenlager verschiebt sich stark; zwei Festlager verhindern das, kosten aber die statische Bestimmtheit; ein Gelenk an beliebiger Stelle stellt sie wieder her. #text(fill: muted)[\[TM1-Buch S. 131–132\]]
- #strong[Dreigelenkbogen muss kein Bogen sein:] Jedes System aus zwei gelenkig verbundenen Teilkörpern beliebiger Form mit zwei Festlagern (insgesamt drei Gelenke) heißt so – z. B. Rahmen oder zwei Fachwerkscheiben. #text(fill: muted)[\[TM1-Buch S. 132\]]
- #strong[Gelenkbalken (Gerber-Träger)], benannt nach Heinrich Gottfried Gerber (1832–1912); falsche Gelenkanordnung → kinematisch unbestimmt. #text(fill: muted)[\[TM1-Buch S. 135\]]
- #strong[Tipp aus Beispiel 5.9:] Momentengleichungen um Gelenke und Lager verwenden – dann folgt jede Unbekannte aus einer einzigen Gleichung. #text(fill: muted)[\[TM1-Buch S. 135\]]])
#src[Skript TM1 S. 188–190; deine Mitschrift S. 191–192; FS TM1 S. 32; TM1-Buch S. 131–136.]
#grid(columns: 2, gutter: 5mm,
 [#bild("map-t1k5a", [Mindmap: einteilige Tragwerke. Eigene Darstellung nach Skript TM1 S. 147–165.], height: 44mm)],
 [#bild("map-t1k5b", [Mindmap: mehrteilige Tragwerke. Eigene Darstellung nach Skript TM1 S. 166–192.], height: 44mm)])

*Der Zusammenhang in Kapitel 5.* Ein Lager sperrt Bewegungen, und für jede gesperrte Bewegung entsteht eine Reaktion: das ist seine Wertigkeit. In der Ebene hat ein Körper drei Freiheitsgrade, also brauchst du genau drei passend angeordnete Reaktionen, dann ist er statisch bestimmt und die drei Gleichgewichtsbedingungen liefern alle Lagerkräfte. Bei mehreren Teilen kommen Gelenke dazu; dann zählt $3n = v + r$, und du schneidest jedes Teil frei, wobei an jedem Gelenk actio = reactio gilt. Das Einfrierprinzip erlaubt, das ganze System wie einen starren Körper zu behandeln, und spart Gleichungen. Gelenkbalken und Dreigelenkbogen sind die typischen Klausurformen.

#pagebreak()
== Verständnisfragen und Rechenaufgaben · Kapitel 5
#set enum(spacing: 0.85em)
Erkläre erst selbst. Bei Rechenaufgaben: Freischneiden, Bestimmtheit zählen, Gleichungen aufstellen, lösen. Die Lösungen folgen getrennt.

+ Was versteht man unter der Wertigkeit eines Lagers?
+ Nenne je ein Beispiel für ein ein-, zwei- und dreiwertiges Lager und die zugehörigen Lagerreaktionen.
+ Wie viele Freiheitsgrade hat ein freier Körper in der Ebene und welche?
+ Warum ist $f = 0$ nicht hinreichend für statische Bestimmtheit? Beschreibe die beiden Sonderfälle der Folien.
+ Was bedeutet „vorspannbar“?
+ Wie berechnet man den Grad der Über- bzw. Unterbestimmtheit? Was ist ein unterbestimmtes System in der Praxis?
+ Zähle die vier Schritte a)–d) zur Berechnung der Lagerreaktionen auf.
+ Welche gleichwertigen Sätze von Gleichgewichtsbedingungen gibt es neben $Sigma F_x, Sigma F_y, Sigma M$? Worauf musst du achten?
+ Welche zwei Verbindungsarten sind laut Folie „nicht zulässig“ und wie hilft man sich?
+ Erkläre die Bedingung $3n = v + r$: Woher kommt die linke, woher die rechte Seite?
+ Was besagt das Einfrierprinzip? Was liefert es – und was nicht?
+ Warum baut man Dreigelenkbögen und Gerberträger? Was wäre ohne die Gelenke?
+ Woran erkennst du einen Pendelstab und warum spart das Rechenarbeit?
+ Balken, Länge 6 m, Festlager A links, Loslager B rechts. Senkrechte Kraft $F = 12 "kN"$ im Abstand 2 m von A. Berechne $A_x$, $A_y$, $B$. #text(fill: muted)[(eigene Aufgabe)]
+ Kragträger (links eingespannt), Länge 2 m, Streckenlast $q_0 = 3 "kN/m"$ auf ganzer Länge, am freien Ende $F = 4 "kN"$ nach unten. Berechne $A_x$, $A_y$, $M_A$. #text(fill: muted)[(eigene Aufgabe)]
+ Bestimme durch Zählen, ob statisch bestimmt, über- oder unterbestimmt (mit Grad): a) Balken auf Festlager und zwei Loslagern; b) Einspannung und Loslager; c) Balken nur auf zwei senkrechten Loslagern; d) Gerberträger mit $n = 3$, Festlager, drei Loslager, zwei Gelenke. #text(fill: muted)[(eigene Aufgabe)]
+ Gelenkträger: Teil I von A (Festlager, $x = 0$) über B (Loslager, $x = 4 "m"$) bis Gelenk G ($x = 5 "m"$). Teil II von G bis C (Loslager, $x = 9 "m"$), Last $F = 8 "kN"$ bei $x = 7 "m"$. Berechne $C$, $G$, $B$, $A_y$. #text(fill: muted)[(eigene Aufgabe)]
+ Dreigelenkrahmen: Festlager A (0; 0) und B (6 m; 0), Riegel in 3 m Höhe, Gelenk G in der Mitte (3 m; 3 m). Auf dem linken Riegel wirkt $F = 20 "kN"$ senkrecht bei $x = "1,5" "m"$. Berechne alle Lagerkräfte. #text(fill: muted)[(eigene Aufgabe)]
+ Wie Beispiel 5.5 (PKW und Anhänger, gleiche Maße), aber der Anhänger wiegt 8 kN. Berechne $A_y$, $G_y$, $V_y$, $H_y$. #text(fill: muted)[(eigene Aufgabe)]

#heading(level: 3, outlined: false)[Vertiefende Verständnisfragen und Rechenaufgaben]
#block[
#set enum(start: 20)
+ *Übung 7, Aufg. 7.1:* Lagerreaktionen des Balkens mit $F_1 = 4 "kN"$, $F_2 = 2 "kN"$ (unter $alpha = 45°$), $F_3 = 3 "kN"$, $M_0 = 4 "kNm"$, $q_0 = 5 "kN/m"$, $a = 1 "m"$.
  #bild("tm1k5_ue71", [Übung 7 (Aufgabenblatt S. 1): Balken zu Aufgabe 7.1.], height: 26mm)
+ *Übung 7, Aufg. 7.2:* Bestimme die Lagerreaktionen für die Systeme a) und b).
  #bild("tm1k5_ue72", [Übung 7 (Aufgabenblatt S. 1): Systeme a) und b) zu Aufgabe 7.2.], height: 30mm)
+ *Übung 7, Aufg. 7.3:* Lagerreaktionen des Rahmens mit $alpha = 60°$, $F_1 = 2000 "N"$, $F_2 = 3000 "N"$, $a = 5 "m"$.
  #bild("tm1k5_ue73", [Übung 7 (Aufgabenblatt S. 1): Rahmen zu Aufgabe 7.3.], height: 40mm)
+ *Übung 7, Aufg. 7.4:* Eingespannter, gekröpfter Träger: $F_1 = 10 "kN"$, $F_2 = 8 "kN"$, $q_1 = 3 "kN/m"$, $q_2 = 20 "kN/m"$, $a = 4 "m"$, $b = 5 "m"$, $c = 3 "m"$. Gesucht: Reaktionen in A.
  #bild("tm1k5_ue74", [Übung 7 (Aufgabenblatt S. 1): Träger zu Aufgabe 7.4.], height: 40mm)
+ *Übung 7, Aufg. 7.5:* Gekröpfter Träger mit $F_1 = 3 "kN"$, $F_2 = "1,5" "kN"$, $q = 1 "kN/m"$, $a = 1 "m"$. Gesucht: Lagerreaktionen.
  #bild("tm1k5_ue75", [Übung 7 (Aufgabenblatt S. 2): Träger zu Aufgabe 7.5.], height: 36mm)
+ *Übung 7, Aufg. 7.6:* Lager- und Gelenkreaktionen des mehrteiligen Tragwerks.
  #bild("tm1k5_ue76", [Übung 7 (Aufgabenblatt S. 2): Tragwerk zu Aufgabe 7.6.], height: 40mm)
+ *Übung 8, Aufg. 8.1:* Zwei Rahmenteile, verbunden im Gelenk C, gelagert in A und B; jedes Teil trägt die Ersatzkraft $R = q a$ ($q = 2 "kN/m"$, $a = 2 "m"$). Bestimme alle Lager- und Gelenkkräfte. (Das Aufgabenblatt fehlt; Skizze aus der Lösung.)
  #bild("tm1k5_ue81", [Lösung Übung 8 S. 1: Freikörperbilder der beiden Teile zu Aufgabe 8.1.], height: 40mm)
+ *Übung 8, Aufg. 8.2:* Teil 1 (senkrechter Stab mit Ersatzkraft $R = 1\/2 q a$ in der Höhe $s = a\/3$, Lager C) und Teil 2 (schräger Stab mit Moment $M_0$, Parallelführung A) sind im Gelenk B verbunden. Bestimme die Reaktionen. (Skizze aus der Lösung.)
  #bild("tm1k5_ue82", [Lösung Übung 8 S. 2: Freikörperbilder zu Aufgabe 8.2.], height: 36mm)
+ *Buch:* Was nennt das Buch „kinematisch unbestimmt“? Gib die beiden Beispiele aus Abb. 5.6. (TM1-Buch S. 116–117)
+ *Buch:* Was besagt das Superpositionsprinzip, und warum gilt es? (TM1-Buch S. 121)
+ *Buch:* Was bedeutet „äußerlich statisch bestimmt, innerlich statisch unbestimmt“? (TM1-Buch S. 138)
+ *Buch:* Wie prüft das Buch formal, ob ein System mit $f = 0$ unbeweglich ist? (TM1-Buch S. 139)
+ *Altklausur SS 2018 (TM_Prüfung_2018.pdf S. 3):* Ein Rahmen ist in $A$ fest eingespannt, in $E$ durch eine Parallelführung gelagert und hat in $G$ ein Gelenk (Geometrie wie im Bild, dort schon mit geänderter Lagerung). Ist das System statisch bestimmt? Begründe mit der Abzählformel.
  #bild("ak_2018_rahmen", [Altklausur SS 2018, Aufg. 1: Rahmen $A$–$B$–$G$–$C$–$D$–$E$ mit Streckenlast $q_0$, Kraft $F$ und Moment $M_0$; rechts die Tabelle mit Zahlenwerten und Lagerreaktionen für das geänderte System.], height: 50mm)
+ *Altklausur SS 2016, Musterlösung (PrüfungenTM2.pdf S. 18):* Ein Rahmen hat in $A$ eine Parallelführung, in $C$ eine Pendelstütze und in $G$ ein Gelenk (Geometrie wie im Bild). Ist das System statisch bestimmt?
  #bild("ak_ss16_rahmen", [Altklausur SS 2016, Aufg. 1, Abb. 4: dachförmige Streckenlast zwischen $G$ und $C$, Kraft $F$, Moment $M_0$; im Bild schon die geänderte Lagerung (Festlager $A$ und $C$, Querkraftgelenk $G$) mit Zahlentabelle.], height: 50mm)
]

#pagebreak()
== Lösungen Kapitel 5
#set enum(spacing: 0.65em)
+ Die Zahl der Reaktionen (Kräfte und Momente), die ein Lager überträgt = Zahl der Bewegungen, die es sperrt. #nachschlagen[Lernskript, #stelle(<a-tm1-5-1-1>)]
+ Einwertig: Loslager/Pendelstab → 1 Kraft. Zweiwertig: Festlager → $A_x, A_y$; Parallelführung/Schiebehülse → 1 Kraft + 1 Moment. Dreiwertig: Einspannung → $A_x, A_y, M_A$. #nachschlagen[Lernskript, #stelle(<a-tm1-5-1-1>)]
+ 3: Verschiebung in x, Verschiebung in y, Drehung um die z-Achse. #nachschlagen[Lernskript, #stelle(<a-tm1-5-1-2>)]
+ Die Zählung prüft nur die Anzahl, nicht die Anordnung. Sonderfall 1: alle Lagerkräfte parallel → endlich beweglich quer dazu. Sonderfall 2: alle Wirkungslinien durch einen Punkt → infinitesimale Drehung („Schlackern“). Beide vorspannbar. #nachschlagen[Lernskript, #stelle(<a-tm1-5-1-2>)]
+ Man kann im System innere Kräfte erzeugen, ohne dass eine Last wirkt – z. B. eine zu kurze Stütze nur mit Zwang einbauen. #nachschlagen[Lernskript, #stelle(<a-tm1-5-1-2>)]
+ $n = r - 3$ (über), $n = 3 - r$ (unter). Unterbestimmt = beweglich, kein Tragwerk (eher ein Mechanismus/Getriebe; Physik, TM III). #nachschlagen[Lernskript, #stelle(<a-tm1-5-1-2>)]
+ a) Freischnitt, b) statische Bestimmtheit prüfen, c) GGW-Bedingungen aufstellen, d) Gleichungssystem lösen. #nachschlagen[Lernskript, #stelle(<a-tm1-5-1-3>)]
+ $Sigma F_x, Sigma M_((A)), Sigma M_((B))$ oder $Sigma F_y, Sigma M_((A)), Sigma M_((B))$ oder drei Momentengleichungen um A, B, C. Momentenpunkte nicht auf einer Geraden; bei zwei Momentenpunkten darf AB nicht senkrecht zur verwendeten Kraftrichtung liegen. #nachschlagen[Lernskript, #stelle(<a-tm1-5-1-3>)]
+ Mehr als 2 Körper an einem Verbindungselement; 2 oder mehr Körper an einem Lager. Abhilfe: am gleichen Ort in mehrere Verbindungselemente/Lager aufspalten. #nachschlagen[Lernskript, #stelle(<a-tm1-5-3-1>)]
+ Links: 3 GGW-Bedingungen je Körper → $3n$ Gleichungen. Rechts: Unbekannte = $v$ Verbindungsreaktionen + $r$ Lagerreaktionen. Notwendig, nicht hinreichend. #nachschlagen[Lernskript, #stelle(<a-tm1-5-3-2>)]
+ Ein (Teil-)System darf als starre Scheibe betrachtet werden; das GGW am Gesamtsystem gilt immer. Es liefert schnell einzelne Lagerreaktionen und Proben, aber nicht alle inneren Gelenkkräfte – dafür braucht man die Teilkörper. #nachschlagen[Lernskript, #stelle(<a-tm1-5-3-4>)]
+ Mit Fest- und Loslager zu nachgiebig (Bogen) bzw. zu biegeweich (langer Balken); mehr Lager → statisch überbestimmt. Gelenke stellen $3n = v + r$ wieder her. #nachschlagen[Lernskript, #stelle(<a-tm1-5-3-5>)]
+ Gerader (oder beliebig geformter) Körper, nur an zwei Gelenken angeschlossen und dazwischen unbelastet. Kraft wirkt nur entlang der Verbindungslinie der Gelenke → Richtung bekannt, nur 1 Unbekannte. #nachschlagen[Lernskript, #stelle(<a-tm1-5-3-3>)]
+ $A_x = 0$; $Sigma M_((A)) colon 6B - 12 dot 2 = 0 => B = 4$ kN; $A_y = 12 - 4 = 8$ kN. #nachschlagen[Lernskript, #stelle(<a-tm1-5-1-3>)]
+ $A_x = 0$; $A_y = 3 dot 2 + 4 = 10$ kN; $M_A = 6 dot 1 + 4 dot 2 = 14$ kNm (gegen das Abkippen gerichtet). #nachschlagen[Lernskript, #stelle(<a-tm1-5-1-3>)]
+ a) $r = 4$ → 1-fach überbestimmt; b) $r = 4$ → 1-fach überbestimmt; c) $r = 2$ → 1-fach unterbestimmt (waagerecht beweglich); d) $r = 2+3 = 5$, $v = 4$, $3n = 9 = 9$ → statisch bestimmt (bei sinnvoller Gelenklage). #nachschlagen[Lernskript, #stelle(<a-tm1-5-1-2>)]
+ Teil II: $Sigma M_((G)) colon 4C - 8 dot 2 = 0 => C = 4$ kN; $G = 8 - 4 = 4$ kN (Teil I trägt Teil II mit 4 kN). Teil I: G drückt mit 4 kN nach unten bei $x = 5$ m: $Sigma M_((A)) colon 4B - 5 dot 4 = 0 => B = 5$ kN; $A_y = 4 - 5 = -1$ kN → A zieht mit 1 kN nach unten (Kragarm hebelt). #nachschlagen[Lernskript, #stelle(<a-tm1-5-3-5>)]
+ Gesamt: $Sigma M_((A)) colon 6B_y - 1","5 dot 20 = 0 => B_y = 5$ kN, $A_y = 15$ kN. Rechter Teil (unbelastet, Pendelstab G–B unter 45°): $Sigma M_((G)) colon 3B_y + 3B_x = 0 => B_x = -5$ kN (zeigt nach links, zur Mitte). $Sigma F_x$ gesamt: $A_x = +5$ kN (nach rechts, zur Mitte). Gelenkkraft auf den rechten Teil: $G_x = 5$ kN, $G_y = -5$ kN. #nachschlagen[Lernskript, #stelle(<a-tm1-5-3-5>)]
+ $A_y = 8 dot 1/1","25 = 6","4$ kN; $G_y = 8 - 6","4 = 1","6$ kN; $V_y = (21 - 1","6)/2","8 = 6","93$ kN; $H_y = 15 + 1","6 - 6","93 = 9","67$ kN. Probe: Summe = 23 kN ✓. #nachschlagen[Lernskript, #stelle(<a-tm1-5-3-3>)]
+ $B_H = -"1,41" "kN"$ (zeigt entgegen dem Ansatz), $B_V = "6,30" "kN"$, $A_V = "7,11" "kN"$. Deine Rechnung auf dem Aufgabenblatt (S. 2–3) kommt genau darauf: $B_x = -"1,414"$, $A_y = "7,11"$, $B_y = "6,30" "kN"$. #nachschlagen[Lernskript, #stelle(<a-tm1-5-1-3>)\; Übung 7 S. 2]
+ a) $A_H = F$, $A_V = c\/b dot F$, $B_V = c\/b dot F$ (Richtungen nach Ansatz). b) Pendelstäbe: $S_1 = sqrt(2) F$, $S_2 = -F$, $B = F$. Dein Ansatz zu b) steht auf dem Aufgabenblatt S. 3–4 mit dem Hinweis „bei FKB: Pendelstäbe wegschneiden!“. #nachschlagen[Lernskript, #stelle(<a-tm1-5-1-3>)\; Übung 7 S. 2]
+ $A_H = "598,1" "N"$, $A_V = "598,1" "N"$, $B = "901,9" "N"$. #nachschlagen[Lernskript, #stelle(<a-tm1-5-1-3>)\; Übung 7 S. 2]
+ $A_H = 12 "kN"$, $A_V = 118 "kN"$, $M_A = 344 "kNm"$. Deine Rechnung (Aufgabenblatt S. 5): $q_1$-Resultierende $3 dot 4 = 12 "kN"$, $q_2$-Resultierende $5 dot 20 = 100 "kN"$; Ergebnis $A_x = -12$, $A_y = 118$, $M_A = 344$, genau wie die Kurzlösung (Vorzeichen nach deinem Ansatz). #nachschlagen[Lernskript, #stelle(<a-tm1-5-1-3>)\; Übung 7 S. 2]
+ $A_H = -"2,75" "kN"$, $A_V = "3,5" "kN"$, $B_H = "5,75" "kN"$. #nachschlagen[Lernskript, #stelle(<a-tm1-5-1-3>)\; Übung 7 S. 2]
+ $A_H = -"0,5" q_0 a$, $B_H = "0,5" q_0 a$, $E_H = F_H = "0,75" q_0 a$, $F_V = 2 q_0 a$, Stabkraft $S = q_0 a$. #nachschlagen[Lernskript, #stelle(<a-tm1-5-3-3>)\; Übung 7 S. 2]
+ Gesamtkörper (Einfrierprinzip): $A_H = B_H$, $B_V = R$. Teilkörper liefern $C_V = 0$, $A_V = R$, $C_H = -"0,5" R$. Mit $R = 4 "kN"$: $A_V = B_V = 4 "kN"$, $A_H = B_H = 2 "kN"$, $C_H = -2 "kN"$, $C_V = 0$. #nachschlagen[Lernskript, #stelle(<a-tm1-5-3-4>)\; Lösung Übung 8 S. 1–2]
+ Teil 1: $sum M_((C))$ liefert $B_H = 1\/3 R = 1\/6 a q$. Teil 2: $A_H = B_H = 1\/6 a q$, $B_V = 0$ und damit $C_V = 0$ (die Parallelführung A überträgt keine senkrechte Kraft), $C_H = R - B_H = 1\/3 a q$, $M_A = M_0 - 1\/2 a A_H$. #nachschlagen[Lernskript, #stelle(<a-tm1-5-3-3>)\; Lösung Übung 8 S. 2]
+ Ein Tragwerk, das endliche oder infinitesimale Bewegungen ausführen kann. Beispiele: Balken auf drei parallelen Stützstäben (waagerecht verschieblich); Scheibe, deren drei Lagerkraft-Wirkungslinien sich in einem Punkt P schneiden (Drehung um P). #nachschlagen[Lernskript, #stelle(<a-tm1-5-1-2>)\; TM1-Buch S. 116–117]
+ Bei mehreren Lasten berechnet man die Lagerreaktionen je Lastfall und addiert sie. Es gilt, weil die Gleichgewichtsbedingungen linear sind. #nachschlagen[Lernskript, #stelle(<a-tm1-5-1-3>)\; TM1-Buch S. 121]
+ Alle Lagerreaktionen folgen aus dem GGW am Gesamtsystem (äußerlich bestimmt), die Verbindungsreaktionen zwischen den Teilen aber nicht (innerlich unbestimmt). #nachschlagen[Lernskript, #stelle(<a-tm1-5-3-2>)\; TM1-Buch S. 138]
+ Gleichgewichtsbedingungen als lineares Gleichungssystem $A thin x = b$ schreiben; ist $det A != 0$, ist das System eindeutig lösbar und damit statisch und kinematisch bestimmt (alternativ: Polplan). #nachschlagen[Lernskript, #stelle(<a-tm1-5-1-2>)\; TM1-Buch S. 139]
+ Lagerwertigkeiten $3 + 2 = 5$, Gelenk 2, zusammen $5 + 2 = 7$. Zwei Teilkörper liefern $3 dot 2 = 6$ Gleichungen. $7 > 6$: einfach statisch unbestimmt. #nachschlagen[Lernskript, #stelle(<a-tm1-5-3-2>)\; Altklausur SS 2018 (TM_Prüfung_2018.pdf S. 3), eigene Lösung]
+ Lager $2 + 1 = 3$, Gelenk 2, zusammen 5. Zwei Teilkörper brauchen 6. $5 < 6$: das System ist beweglich (es kann sich waagrecht verschieben), also kein brauchbares Tragwerk. #nachschlagen[Lernskript, #stelle(<a-tm1-5-3-2>)\; Altklausur SS 2016, Musterlösung (PrüfungenTM2.pdf S. 18)]

#pagebreak()
= TM1 Kapitel 6 · Fachwerke <k-tm1-6>
#tab(columns: 2,
 [Vorlesungen], [TM1 WS 25/26 – auf den Folien und in deiner Mitschrift zu diesem Kapitel steht kein Datum. Folien 1–12 und 15–28; an Stelle der Folien 13–14 stehen sechs Seiten deiner Mitschrift „6.3 Bestimmung der Stabkräfte“.],
 [Quellen], [Skript TM1 S. 193–211 (Foliensatz „Fachwerke“, 29 Folien); deine Mitschrift S. 199–204; FS TM1 S. 33–35; TM1-Buch Kap. 6 (S. 145–165)],
 [Passende Übungen], [Übung 8 (nur Lösung vorhanden): 8.3, 8.4, 8.5 (Knotenpunktverfahren); Übung 9: 9.1 (Ritter’sches Schnittverfahren); dazu Altklausur-Aufgaben am Ende der vertiefenden Fragen],
)
Ein Fachwerk ist ein Tragwerk nur aus geraden Stäben, die in Gelenken (Knoten) verbunden sind. Weil jeder Stab nur an seinen beiden Enden gelenkig angeschlossen ist und keine Last zwischen den Knoten trägt, ist jeder Stab ein #strong[Pendelstab]: Er überträgt nur eine Kraft in Stabrichtung, Zug oder Druck. Kapitel 6 ist deshalb Kapitel 5 in vereinfachter Form: Statt jedes Bauteil freizuschneiden, schneidest du jeden #strong[Knoten] frei und hast dort nur zwei Gleichungen.
#note([Dein Feynman-Schritt: die 5 Kernideen von Kapitel 6. Erst ohne Skript aufzählen und erklären, dann vergleichen.], [+ #strong[Ideales Fachwerk:] gerade Stäbe, zentrisch, gelenkig und reibungsfrei in Knoten verbunden, Lasten nur in den Knoten. Dann trägt jeder Stab nur Zug oder Druck.
+ #strong[Zählen:] An jedem Knoten 2 Gleichungen, also $2k = s + r$. Das ist notwendig, aber nicht hinreichend – das Fachwerk darf nicht beweglich sein.
+ #strong[Bildungsgesetze:] Wer ein Fachwerk nach einem der 3 Bildungsgesetze aufbaut, bekommt ein starres, statisch bestimmtes Fachwerk.
+ #strong[Knotenpunktverfahren:] Lagerreaktionen am Gesamtsystem, Nullstäbe suchen, alle Knoten freischneiden (Stabkräfte vom Knoten weg = Zug positiv), je $Sigma F_x = 0$, $Sigma F_y = 0$.
+ #strong[Ritter’sches Schnittverfahren:] Für einzelne Stabkräfte das Fachwerk durch 3 Stäbe schneiden und Momentengleichungen um die Schnittpunkte von je zwei Stabkräften aufstellen.
Zusammenfassung der Abschnitte 6.1–6.3; Quellen stehen dort.])
#note([Hinweis zur Nummerierung], [Die Folien nummerieren „1 Statische Bestimmtheit von Fachwerken“, „2 Aufbau …“, „3.1 Knotenpunktverfahren“ usw. Hier steht wie in der Formelsammlung TM1 die Kapitelnummer davor: Folie „3.1“ = #strong[6.3.1]. Deine Mitschrift macht es genauso („6.3 Bestimmung der Stabkräfte“, „gem. Kap. 6.1 bzw. 6.2“).], fill: sand)

== 6.1 Statische Bestimmtheit von Fachwerken <a-tm1-6-1>
Ein #strong[Fachwerk] (oder Stabwerk) ist laut Folie
- ein mehrteiliges Tragwerk,
- bestehend aus geraden Stäben,
- die Stäbe sind in den Knoten zentrisch, gelenkig und reibungsfrei verbunden,
- äußere Lasten greifen nur in den Knoten an.
Stäbe bekommen arabische Ziffern (Anzahl $s$), Knoten römische Ziffern (Anzahl $k$). Im Beispiel der Folie: $s = 11$, $k = 7$.
#bild("tm1k6_def", [Skript TM1 S. 194 (obere Folie): Definition und Beispiel-Fachwerk mit 11 Stäben und 7 Knoten, mit deinen Notizen.], height: 62mm)
#note([Aus deiner Mitschrift (Skript TM1 S. 194)], [Du hast das Fachwerk zuerst wie ein mehrteiliges Tragwerk aus Kapitel 5 gezählt: Ein Verbindungselement verbindet nur 2 Bauteile miteinander. Ein Knoten mit drei Stäben (z. B. 2, 3, 6) zählt deshalb wie zwei Gelenke, also $v = 4$; an Knoten IV mit vier Stäben $v = 6$. Summe: $n = 11$, $v = 2+4+6+6+6+4+2 = 30$, $r = 3$, also $3n = 33 = v + r$ ✓. Gleich danach hast du notiert: Bei Fachwerken wird nicht mehr $3n = v + r$ verwendet, sondern $2k = s + r$. Beide Zählungen passen zusammen, die zweite ist nur kürzer.])
Bisher (Kapitel 5.3) hast du das Gleichgewicht an jedem #strong[Teilkörper] aufgestellt. Beim Fachwerk stellst du es an jedem #strong[Knoten] auf. An einem Knoten treffen sich alle Kräfte in einem Punkt (zentrale Kräftegruppe, Kapitel 3). Deshalb gilt:
- pro Knoten 2 Gleichgewichtsbedingungen $Sigma F_x = 0$, $Sigma F_y = 0$,
- $Sigma M = 0$ ist am Knoten nicht sinnvoll und nicht nötig,
- an einem Knoten dürfen (und sollen meist) mehr als 2 Stäbe hängen.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k6_nichtfw", [Skript TM1 S. 194 (untere Folie): Ein Dreieck mit Kraft $F$ mitten auf dem Stab ist kein Fachwerk; rechts ein freigeschnittener Knoten III.], height: 50mm)],
 [#bild("tm1k6_bedingung", [Skript TM1 S. 195 (obere Folie): Gleichungen, Unbekannte und die Bedingung $2k = s + r$ am Beispiel.], height: 50mm)])
Gleichungen: $2k$. Unbekannte: $s$ Stabkräfte $S_i$ und $r$ Lagerreaktionen. Daraus folgt die
#form[$ 2 k = s + r quad "(eben)", quad quad 3 k = s + r quad "(räumlich)" $]
Im Beispiel: $k = 7$, $s = 11$, $r = 3$ → $2k = 14 = s + r = 14$, die notwendige Bedingung ist erfüllt.
#note([Merke ★], [$2k = s + r$ ist #strong[notwendig, aber nicht hinreichend] – genau wie $f = 0$ in Kapitel 5. Die Formel zählt nur. Ob die Stäbe so angeordnet sind, dass das Fachwerk starr ist, musst du zusätzlich prüfen.])
#heading(level: 3, outlined: false)[Trotz erfüllter Gleichung statisch unbestimmt]
#bild("tm1k6_unbestimmt", [Skript TM1 S. 195 (untere Folie): zwei Fachwerke mit $2k = 12 = s + r$, die trotzdem nicht statisch bestimmt sind.], height: 52mm)
- #strong[Beispiel 1:] Das linke Rechteck hat zwei gekreuzte Diagonalen 3 und 4 (ohne Verbindung in der Mitte). Das rechte Feld hat gar keine. Links ist ein Stab zu viel: $S_3$ und $S_4$ sind vorspannbar. Rechts fehlt ein Stab: Die Stäbe 7, 8, 9 sind beweglich.
- #strong[Beispiel 2:] Der Knoten VI sitzt zwischen den Stäben 5 und 6 genau auf einer Geraden. Die Stäbe 5 und 6 sind vorspannbar, und der Knoten kann senkrecht ausweichen (infinitesimal beweglich).
#note([Von dir markiert (gelb, Skript TM1 S. 195)], [Du hast den Stab 3 und den Satz „$S_4 arrow.l.r S_3$ vorspannbar“ gelb markiert und ergänzt: „$S_3$ entweder zu kurz oder zu lang“. Gemeint ist: Ist ein Stab ein bisschen zu kurz oder zu lang gefertigt, kann man ihn nur mit Zwang einbauen. Dann stehen die Stäbe 3 und 4 schon ohne Last unter Spannung. Das ist das Kennzeichen von „vorspannbar“ (vergleiche Kapitel 5.1.2).], fill: sand)
#note([In eigenen Worten], [Ein Fachwerk ist ein Gerüst aus lauter Stangen, die an den Enden nur mit Bolzen verbunden sind. Jede Stange kann nur ziehen oder drücken, wie eine Fahrradspeiche. Damit das Gerüst nicht wackelt, braucht jede Ecke genug Stangen, aber nicht zu viele – sonst klemmt etwas. #text(fill: muted)[(eigene Ergänzung)]])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Ideales Fachwerk:] Nur unter den beiden Annahmen (gelenkige, zentrische Knoten; Lasten nur in Knoten) werden alle Stäbe rein auf Zug oder Druck beansprucht. In echten Konstruktionen sind die Stäbe verschweißt oder an Knotenbleche angeschlossen, und das Eigengewicht wirkt längs der Stäbe. Diese Lasten vernachlässigt man oder verteilt sie auf die Nachbarknoten. #text(fill: muted)[\[TM1-Buch S. 147\]]
- #strong[Knoten mit Lagern zählen mit.] Das Beispiel der Folie (11 Stäbe, 7 Knoten) ist Abb. 6.1 im Buch. #text(fill: muted)[\[TM1-Buch S. 147\]]
- #strong[Kinematisch bestimmt] heißt: Die Lage aller Knoten liegt fest. Bewegliche Fachwerke (endlich oder infinitesimal) sind kinematisch unbestimmt und müssen ausgeschlossen werden („Ausnahmefachwerke“, Abb. 6.2b, c). #text(fill: muted)[\[TM1-Buch S. 148–149\]]
- Zwei Festlager sind erlaubt, wenn die Zählung aufgeht: Abb. 6.2a hat $k = 7$, $s = 10$, $r = 4$, also $14 = 14$. #text(fill: muted)[\[TM1-Buch S. 148\]]])
#src[Skript TM1 S. 194–195; FS TM1 S. 33; TM1-Buch S. 147–149.]

== 6.2 Aufbau von Fachwerken <a-tm1-6-2>
Wie baut man ein Fachwerk, das sicher starr und statisch bestimmt ist? Dafür gibt es drei #strong[Bildungsgesetze].
#heading(level: 3, outlined: false)[1\. Bildungsgesetz]
+ Ausgangspunkt: 1 Stab mit 2 Gelenken.
+ 2 Stäbe mit einem Gelenk („Zweischlag“) dazu – es entsteht ein Dreieck.
+ Weitere Zweischläge anfügen.
+ Lager hinzufügen ($r = 3$).
#bild("tm1k6_bg1", [Skript TM1 S. 196 (obere Folie): 1. Bildungsgesetz – Stab ①, Zweischläge ② und ③, Lager ④.], height: 44mm)
#note([In eigenen Worten], [Jeder neue Knoten wird mit genau zwei Stäben an zwei schon feste Knoten gehängt. Zwei Stäbe, die nicht auf einer Linie liegen, halten einen Punkt in der Ebene fest – so wie zwei gespannte Schnüre einen Ring festhalten. Pro Schritt kommen 1 Knoten (2 Gleichungen) und 2 Stäbe (2 Unbekannte) dazu, die Bilanz bleibt also ausgeglichen. #text(fill: muted)[(eigene Ergänzung)]])
#heading(level: 3, outlined: false)[2\. Bildungsgesetz]
+ Ausgangspunkt: 2 getrennte Fachwerke, jedes für sich statisch bestimmt.
+ Verbindung durch 3 Stäbe: je 1 Knoten von FW 1 mit 1 Knoten von FW 2; nicht alle parallel; die Stäbe bzw. ihre Verlängerungen schneiden sich nicht in einem Punkt.
+ Lager hinzufügen ($r = 3$).
Statt 2 der 3 Stäbe darf auch ein gemeinsamer Knoten treten (Verbindung durch 1 Knoten + 1 Stab, $r = 3$). Verbindet man nur durch 1 Knoten, braucht man eine zusätzliche Lagerreaktion ($r = 4$).
#bild("tm1k6_bg2", [Skript TM1 S. 197 (obere Folie): FW1 und FW2, verbunden durch 3 Stäbe ②.], height: 50mm)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k6_bg2b", [Skript TM1 S. 197 (untere Folie): Verbindung durch 1 Knoten, dazu $r = 4$.], height: 50mm)],
 [#bild("tm1k6_bg2c", [Skript TM1 S. 198 (obere Folie): Verbindung durch 1 Knoten + 1 Stab, $r = 3$.], height: 50mm)])
#heading(level: 3, outlined: false)[3\. Bildungsgesetz]
+ Ausgangspunkt: ein statisch bestimmtes Fachwerk.
+ 1 Stab entfernen – das Fachwerk wird beweglich.
+ Den Stab an geeigneter Stelle wieder einfügen – das Fachwerk ist wieder starr.
#bild("tm1k6_bg3", [Skript TM1 S. 198 (untere Folie): 3. Bildungsgesetz – Stab ② (rot) entfernt, Stab ③ (grün, gestrichelt) neu eingefügt.], height: 44mm)
#note([Merke], [Bildungsgesetz 1 und 2 sind das Fachwerk-Gegenstück zur Regel aus Kapitel 5: drei Verbindungen, nicht alle parallel und nicht durch einen Punkt. Beim 3. Bildungsgesetz bleiben $s$ und $k$ gleich, deshalb bleibt auch $2k = s + r$ erfüllt.])
#note([Fehler vermeiden], [Bei den Zweischlägen dürfen die beiden neuen Stäbe nicht auf einer Geraden liegen. Sonst entsteht ein Knoten wie VI in Beispiel 2 von Folie 6: Er kann senkrecht ausweichen, das Fachwerk ist beweglich. #text(fill: muted)[\[TM1-Buch S. 149\]]], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- Ein nach dem 1. Bildungsgesetz gebautes Fachwerk heißt #strong[einfaches Fachwerk]. Für den unbelagerten Aufbau gilt $2k = s + 3$; mit $r = 3$ Lagerreaktionen ist dann $2k = s + r$ erfüllt. #text(fill: muted)[\[TM1-Buch S. 149–150\]]
- Verbindet man zwei einfache Fachwerke nur in einem Knoten und ersetzt das einwertige Lager durch ein zweiwertiges, entsteht ein #strong[Dreigelenkbogen] (vergleiche Kapitel 5.3.5). #text(fill: muted)[\[TM1-Buch S. 150\]]])
#src[Skript TM1 S. 196–198; FS TM1 S. 33–34; TM1-Buch S. 149–151.]

== 6.3 Ermittlung der Stabkräfte <a-tm1-6-3>
Ist das Fachwerk statisch bestimmt (Abschnitt 6.1 bzw. 6.2), berechnest du die Stabkräfte. Dafür gibt es drei Verfahren: das Knotenpunktverfahren (rechnerisch, alle Stäbe), den Cremona-Plan (zeichnerisch, nicht prüfungsrelevant) und das Ritter’sche Schnittverfahren (rechnerisch, einzelne Stäbe).
#src[Skript TM1 S. 193 (Inhalt), deine Mitschrift S. 199; FS TM1 S. 34; TM1-Buch S. 151.]

=== 6.3.1 Knotenpunktverfahren <a-tm1-6-3-1>
Das allgemeine Vorgehen steht in deiner Mitschrift (S. 199–200) und genauso in der Formelsammlung (S. 34):
#note([Merke ★ – Knotenpunktverfahren a)–e)], [
+ #strong[a) Fachwerk „einfrieren“] (Kap. 5.3.4) und am Gesamtsystem die Lagerreaktionen bestimmen.
+ #strong[b) Nullstäbe bestimmen] – Stäbe, die offensichtlich keine Kraft übertragen (drei Regeln, siehe unten).
+ #strong[c) Alle Knoten freischneiden.] Alle Stabkräfte vom Knoten weg zeichnen: $S_i > 0$ = Zugstab, $S_i < 0$ = Druckstab. Nullstäbe und Lagerreaktionen berücksichtigen.
+ #strong[d) 2 GGW-Bedingungen an jedem Knoten:] $Sigma F_x = 0$, $Sigma F_y = 0$. $Sigma M = 0$ ist nicht sinnvoll und nicht nötig, GGW am Stab ist nicht nötig. Das gibt $2k$ Gleichungen für $r + s$ Unbekannte.
+ #strong[e) Gleichungssystem] nach den Unbekannten lösen.])
#bild("tm1k6_mit_vorgehen", [Deine Mitschrift (Skript TM1 S. 199 oben): allgemeines Vorgehen a) und b) mit deiner Bemerkung.], height: 50mm)
#note([Von dir notiert (Skript TM1 S. 199)], [- Neben die Nullstab-Regeln hast du gelb markiert geschrieben: „→ wichtig zum Einheften i. d. FS!“ Die Regeln stehen in der Formelsammlung TM1 auf S. 35.
- #strong[Bemerkung:] a) und b) sind nicht unbedingt nötig. Das Gleichgewicht an allen Knoten (c–e) liefert auch die Lagerreaktionen und die Nullstäbe. ABER: Mit den „überzähligen“ Informationen aus a) und b) wird das Gleichungssystem e) viel einfacher.], fill: sand)
#heading(level: 4, outlined: false)[Warum man den Stab nicht freischneiden muss]
#bild("tm1k6_mit_stab", [Deine Mitschrift (Skript TM1 S. 199 unten): Stab 3 zwischen zwei Knoten freigeschnitten – das GGW am Stab liefert nur $S_3 = S_3$ und $0 = 0$.], height: 66mm)
Ein Stab, der nur an seinen Enden belastet ist, hat an beiden Enden dieselbe Kraft $S$, entgegengesetzt gerichtet. Das Gleichgewicht am Stab bringt also nichts Neues: „Stab kann man bei Berechnung weglassen. Nur Knoten rechnen!“ (deine Mitschrift). Weil du alle Stabkräfte vom Knoten weg zeichnest, ist actio = reactio automatisch erfüllt (FS TM1 S. 34).
#bild("tm1k6_mit_ggw", [Deine Mitschrift (Skript TM1 S. 200 oben): d) 2 GGW-Bedingungen an jedem Knoten, $2 dot k$ Gleichungen für $r + s$ Unbekannte.], height: 40mm)
#heading(level: 4, outlined: false)[Regeln zum Auffinden von Nullstäben ★]
#tab(columns: 3,
 th([Regel], [Bedingung], [Folge]),
 [1 – unbelasteter Knoten], [genau 2 Stäbe, nicht in einer Richtung (unbelasteter Zweischlag)], [beide Stäbe sind Nullstäbe],
 [2 – Knoten mit äußerer Last], [genau 2 Stäbe, Last genau in Richtung eines Stabes (belasteter Zweischlag)], [der andere Stab ist ein Nullstab],
 [3 – Knoten ohne äußere Last], [genau 3 Stäbe, 2 davon in gleicher Richtung], [der 3. Stab ist ein Nullstab],
)
#bild("tm1k6_mit_nullregeln", [Deine Mitschrift (Skript TM1 S. 200 unten): die drei Regeln mit Skizzen und den Gleichungen.], height: 80mm)
#note([Prüfe deine Mitschrift (Skript TM1 S. 200, Regel 2)], [Bei Regel 2 liegt Stab 1 waagerecht, die Last $F$ wirkt waagerecht in Richtung von Stab 1. Du hast notiert „$Sigma F_x = 0 → S_2 = 0$“ und „$Sigma F_y = 0 → S_1 = F$“. Die Zuordnung ist vertauscht: Senkrecht wirkt nur die Komponente von $S_2$, also liefert #strong[$Sigma F_y = 0$ den Wert $S_2 = 0$]. Waagerecht bleiben $S_1$ und $F$, also liefert #strong[$Sigma F_x = 0$ den Wert $S_1 = F$]. So steht es auch in der Formelsammlung (FS TM1 S. 35). Die Ergebnisse selbst sind richtig.], fill: sand)
#bild("tm1k6_mit_bemerkung", [Deine Mitschrift (Skript TM1 S. 201 oben): Bemerkung zu den Regeln mit zwei kleinen Fachwerken.], height: 56mm)
#note([Aus deiner Mitschrift (Skript TM1 S. 201)], [- #strong[Regel 1:] Die Stäbe $S_1$, $S_2$ sind überflüssig und können entfallen – das ist die Umkehrung des 1. Bildungsgesetzes. Im Bild sind die Stäbe 6 und 7 am unbelasteten Knoten VI Nullstäbe; das Fachwerk trägt ohne sie genauso.
- #strong[Regel 2 und 3:] Der Nullstab $S_2$ bzw. $S_3$ ist trotzdem nötig – wegen der Stabilität bei Druck bzw. der statischen Bestimmtheit. Greift im Beispiel eine Kraft $F$ an Knoten VI an, tragen die Stäbe 6 und 7 sofort.])
#note([In eigenen Worten], [Ein Nullstab ist bei #strong[dieser] Belastung kraftlos, aber nicht nutzlos. Ändert sich die Last, kann er sofort gebraucht werden. Außerdem hält er lange Druckstäbe seitlich fest, damit sie nicht ausknicken. #text(fill: muted)[(eigene Ergänzung)]])
#heading(level: 4, outlined: false)[Beispiel aus deiner Mitschrift (= Folie 15, Beispiel 1)]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k6_mit_bsp", [Deine Mitschrift (Skript TM1 S. 201 unten): Fachwerk mit 6 Knoten und 9 Stäben, Kraft $F$ an Knoten I; statische Bestimmtheit.], height: 62mm)],
 [#bild("tm1k6_mit_lager", [Deine Mitschrift (Skript TM1 S. 202 oben): Lagerreaktionen am eingefrorenen Fachwerk.], height: 62mm)])
Geometrie: Knoten V (Festlager A) bei $(0; 0)$, VI (Loslager B) bei $(a; 0)$, IV bei $(0; a)$, III bei $(a; a)$, II bei $(a; 2a)$, I bei $(2a; 2a)$. Die Kraft $F$ wirkt an Knoten I nach unten. Alle Diagonalen liegen unter 45°, also $sin 45° = cos 45° = 1\/sqrt(2)$.
+ #strong[Bestimmtheit:] Aufbau nach dem 1. Bildungsgesetz; $s = 9$, $k = 6$, $r = 3$ → $2 dot 6 = 12 = 9 + 3$ ✓.
+ #strong[Lagerreaktionen:] $Sigma F_x = 0$: $A_x = 0$. $Sigma M_((A)) = 0$: $a B_y - 2 a F = 0$ → $B_y = 2F$. $Sigma F_y = 0$: $A_y + B_y - F = 0$ → $A_y = -F$ (zeigt also nach unten).
+ #strong[Nullstäbe:] Regel 2 → $S_9 = 0$ (Knoten VI: Lagerkraft $B$ in Richtung von Stab 8) und danach $S_7 = 0$ (Knoten V: Stab 9 fällt weg, $A$ wirkt in Richtung von Stab 6). Regel 1 und 3 liefern hier nichts.
+ #strong[Knoten (alle Stabkräfte vom Knoten weg):]
  - I: $Sigma F_y$: $-S_2\/sqrt(2) - F = 0$ → $S_2 = -sqrt(2) F$; $Sigma F_x$: $-S_1 - S_2\/sqrt(2) = 0$ → $S_1 = F$.
  - II: $Sigma F_x$: $S_1 - S_4\/sqrt(2) = 0$ → $S_4 = sqrt(2) F$; $Sigma F_y$: $-S_4\/sqrt(2) - S_3 = 0$ → $S_3 = -F$.
  - III: $Sigma F_x$: $-S_5 + S_2\/sqrt(2) = 0$ → $S_5 = -F$; $Sigma F_y$: $S_3 - S_8 + S_2\/sqrt(2) = 0$ → $S_8 = -2F$.
  - IV: $Sigma F_y$: $-S_6 + S_4\/sqrt(2) = 0$ → $S_6 = F$. Probe V und VI: $S_6 = -A_y = F$ ✓, $S_8 = -B_y = -2F$ ✓.
#tab(columns: 10,
 th([$i$], [1], [2], [3], [4], [5], [6], [7], [8], [9]),
 [$S_i$], [$F$], [$-sqrt(2) F$], [$-F$], [$sqrt(2) F$], [$-F$], [$F$], [0], [$-2F$], [0],
)
Mit $F = 3$ MN und $a = 3$ m sind das genau die Ergebnisse von Folie 15: 3,00 / −4,24 / −3,00 / 4,24 / −3,00 / 3,00 / 0 / −6,00 / 0 MN. Positive Werte sind Zugstäbe, negative Druckstäbe.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k6_mit_knoten", [Deine Mitschrift (Skript TM1 S. 202 unten, Foto): alle Knoten freigeschnitten.], height: 62mm)],
 [#bild("tm1k6_mit_ggw_knoten", [Deine Mitschrift (Skript TM1 S. 203 oben): GGW an den Knoten I bis VI.], height: 62mm)])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k6_mit_tabelle", [Deine Mitschrift (Skript TM1 S. 203 unten): Stabkrafttabelle und Auflösung.], height: 48mm)],
 [#bild("tm1k6_mit_rest", [Deine Mitschrift (Skript TM1 S. 204): letzte Stabkräfte, Vorzeichen und Hinweis.], height: 30mm)
  #bild("tm1k6_mit_nulltab", [Deine Mitschrift (Skript TM1 S. 202): Nullstäbe nach Regel 2: Stäbe 9 und 7.], height: 18mm)])
#note([Prüfe deine Mitschrift (Skript TM1 S. 201–203)], [In deiner Skizze (S. 201) sitzt Knoten V links unten am Festlager A und Knoten VI rechts unten am Loslager B. Beim Freischneiden (Foto S. 202) und in den Gleichungen (S. 203–204) sind V und VI vertauscht: Dort steht bei „VI“ die Kraft $A_y$ und bei „V“ die Kraft $B$. Außerdem steht bei Knoten „VI“ „$S_2 + A_y = 0$“; gemeint ist $S_6 + A_y = 0$ (Stab 6 hängt am Lager A). Die Ergebnisse $S_6 = F$ und $S_8 = -2F$ stimmen. Bei Knoten III ist „$-S_5 dot S_2 dot 1\/sqrt(2)$“ als $-S_5 + S_2\/sqrt(2) = 0$ zu lesen.], fill: sand)
#note([Merke], [Nicht alle Knoten-GGW werden gebraucht, weil Nullstäbe und Lagerreaktionen vorab bestimmt sind (deine Mitschrift S. 204, Folie 22). Die übrigen Gleichungen sind eine gute #strong[Probe].])
#heading(level: 4, outlined: false)[Beispiel 2 der Folien: Fachwerk mit Einzellast]
#bild("tm1k6_bsp2", [Skript TM1 S. 205 (untere Folie): Fachwerk mit 8 Knoten, 13 Stäben und Kraft $F$ an Knoten V; Bestimmtheit $2k = 16 = s + r$.], height: 52mm)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k6_bsp2_lager", [Skript TM1 S. 206 (obere Folie): Lagerreaktionen $B_x = 0$, $B_y = 2\/3 F$, $A = 1\/3 F$.], height: 52mm)],
 [#bild("tm1k6_bsp2_null", [Skript TM1 S. 206 (untere Folie): Nullstäbe und alle Knoten freigeschnitten.], height: 52mm)])
- #strong[Lagerreaktionen:] $Sigma M_((A))$: $-F dot 4l + B_y dot 6l = 0$ → $B_y = 2\/3 F$; $A = F - B_y = 1\/3 F$; $B_x = 0$.
- #strong[Nullstäbe:] Regel 1 → $S_10 = S_13 = 0$ (Knoten VII); Regel 2 → $S_4 = 0$ (Knoten II, Lagerkraft $A$ in Richtung Stab 1); Regel 3 → $S_5 = 0$ (Knoten III) und $S_9 = 0$ (Knoten VI).
- #strong[Winkel:] Die Diagonalen gehen über $2l$ waagerecht und $l$ senkrecht: $cos alpha = 2\/sqrt(5)$, $sin alpha = 1\/sqrt(5)$.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k6_bsp2_ggw1", [Skript TM1 S. 207 (obere Folie): GGW an den Knoten I–IV.], height: 52mm)],
 [#bild("tm1k6_bsp2_ggw2", [Skript TM1 S. 207 (untere Folie): GGW an den Knoten V–VIII.], height: 52mm)])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k6_bsp2_loesung", [Skript TM1 S. 208 (obere Folie): Lösung des Gleichungssystems Schritt für Schritt.], height: 56mm)],
 [#bild("tm1k6_bsp2_tabelle", [Skript TM1 S. 208 (untere Folie): Stabkrafttabelle; + Zugstäbe, − Druckstäbe.], height: 30mm)])
#tab(columns: 14,
 th([$i$], [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13]),
 [$S_i \/ F$], [$-1/3$], [$-2/3$], [$sqrt(5)/3$], [0], [0], [$-2/3$], [$-sqrt(5)/3$], [$4/3$], [0], [0], [$-(2 sqrt(5))/3$], [$4/3$], [0],
)
#note([Merke – Reihenfolge der Knoten], [Fang an einem Knoten an, an dem höchstens 2 unbekannte Stabkräfte hängen (hier II, dann I). Danach arbeitest du dich von Knoten zu Knoten weiter. So löst du jede Gleichung einzeln und brauchst kein großes Gleichungssystem.])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Beispiel 2 der Folien ist Beispiel 6.1 im Buch] (gleiche Nummern, gleiche Ergebnisse, inkl. Stabkrafttabelle). #text(fill: muted)[\[TM1-Buch S. 153–155\]]
- #strong[Vorzeichenregel:] Zugkräfte sind positiv und wirken vom Knoten weg; man nimmt zunächst alle Stäbe als Zugstäbe an. Ein negatives Ergebnis heißt Druck. #text(fill: muted)[\[TM1-Buch S. 152\]]
- Die 3 GGW-Bedingungen am Gesamtsystem sind nicht unabhängig von den Knotengleichungen. Bestimmt man die Lager vorab, dienen drei Knotengleichungen als Probe. #text(fill: muted)[\[TM1-Buch S. 152\]]
- Das Gleichungssystem ist eindeutig lösbar, wenn die Determinante der Koeffizientenmatrix ungleich null ist. Dann ist das Fachwerk statisch und kinematisch bestimmt. #text(fill: muted)[\[TM1-Buch S. 165\]]])
#src[Skript TM1 S. 199–208 (deine Mitschrift S. 199–204, Folien 15–22); FS TM1 S. 34–35; TM1-Buch S. 151–155, 165.]

=== 6.3.2 Cremona-Plan <a-tm1-6-3-2>
Der Cremona-Plan ist die #strong[zeichnerische] Lösung: An jedem Knoten zeichnet man das Krafteck maßstäblich (historisch). Er eignet sich nur für einfache Fachwerke. Laut Folie ist er #strong[nicht prüfungsrelevant]\; Details stehen in der Literatur (Gross-Hauger-Schröder-Wall). Ein Bild gibt es auf der Folie nicht.
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [Der Cremona-Plan fügt die Kraftecke aller Knoten zu einem einzigen Plan zusammen, in dem jede Stabkraft nur einmal vorkommt. Man umläuft dafür jeden Knoten in einem festen Umlaufsinn. #text(fill: muted)[\[TM1-Buch S. 157–161\]]])
#src[Skript TM1 S. 209 (obere Folie); TM1-Buch S. 157–161.]

=== 6.3.3 Ritter’sches Schnittverfahren <a-tm1-6-3-3>
#strong[Ziel:] einzelne Stabkräfte ermitteln, ohne das ganze Fachwerk durchzurechnen. #strong[Vorgehen:] Das Fachwerk wird durch einen Schnitt in 2 Teilfachwerke zerlegt. Jedes Teilfachwerk wird „eingefroren“ und ist dann eine starre Scheibe, für die 3 GGW-Bedingungen gelten. Der Schnitt geht durch
- #strong[3 Stäbe], nicht alle parallel und nicht alle an einem einzigen Knoten angeschlossen, oder
- #strong[1 Stab und 1 Knoten].
#note([In eigenen Worten], [Beim Knotenpunktverfahren hast du pro Schnitt-Stück 2 Gleichungen, beim Ritter-Schnitt 3 – weil das abgeschnittene Teil ein ausgedehnter starrer Körper ist und kein Punkt. Drei Gleichungen reichen für genau drei unbekannte Stabkräfte. #text(fill: muted)[(eigene Ergänzung)]])
#heading(level: 4, outlined: false)[1\. Beispiel]
#bild("tm1k6_ritter1", [Skript TM1 S. 210 (obere Folie): Schnitt durch die Stäbe 1, 2, 3 in „links“ und „rechts“; Vorgehensweise in 3 Schritten.], height: 56mm)
+ GGW am Gesamtsystem → Lagerreaktionen ($A_x$, $A_y$, $B$).
+ Schnitt durch die 3 Stäbe → 2 Teilfachwerke („links“ und „rechts“).
+ GGW an einem oder beiden Teilfachwerken: entweder $Sigma F_x$, $Sigma F_y$, $Sigma M_((P))$, oder $Sigma F_x$ durch eine weitere Momentengleichung ersetzen (einfache Auflösung möglich!).
#bild("tm1k6_ritter1_rech", [Skript TM1 S. 210 (untere Folie): Rechnung am rechten Teil mit Momenten um C und D.], height: 60mm)
Am rechten Teil (Stabkräfte als Zug, vom Teil weg): Die Momentengleichung um #strong[C] (Schnittpunkt von $S_2$ und $S_3$) enthält nur $S_1$, die um #strong[D] (Schnittpunkt von $S_1$ und $S_2$) nur $S_3$:
#form[$ S_1 = (F a - 2 a B)/b, quad quad S_3 = (a B)/b, quad quad S_2 = (B - F)/(sin alpha), quad tan alpha = b/a $]
#note([Fehler auf der Folie (Folie 26)], [Die Momentengleichung um C ist auf der Folie mit „$S_1 dot b - F dot a - B dot 2a = 0$“ angeschrieben. Daraus würde $S_1 = (F a + 2 a B)\/b$ folgen. #strong[Richtig ist $S_1 dot b - F dot a + B dot 2a = 0$]: $B$ zeigt nach oben und greift $2a$ rechts von C an, dreht also gegen den Uhrzeigersinn (positiv) – genau wie $S_1$. Das Ergebnis auf der Folie, $S_1 = (F a - B dot 2 a)\/b$, ist richtig. Mit $B = 2\/3 F$ (aus $Sigma M_((A))$) wird $S_1 = -F a\/(3 b)$, also ein Druckstab – wie für einen Obergurt zu erwarten.], fill: sand)
#heading(level: 4, outlined: false)[2\. und 3. Beispiel]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k6_ritter2", [Skript TM1 S. 211 (obere Folie): Kragfachwerk an der Wand; rechtes Teilsystem ohne Lagerreaktionen.], height: 50mm)],
 [#bild("tm1k6_ritter3", [Skript TM1 S. 211 (untere Folie): Schnitt durch 1 Knoten P und 1 Stab; $Sigma M_((P)) = 0$ liefert $S_1$.], height: 50mm)])
- #strong[2\. Beispiel:] Wählt man das Teilsystem „rechts“, an dem kein Lager hängt, muss man die Lagerreaktionen #strong[nicht] berechnen.
- #strong[3\. Beispiel:] Schnitt durch 1 Knoten (P) und 1 Stab (1). Vorgehen: 1) Lagerreaktionen (Einfrieren, GGW am Gesamtsystem), 2) Schnitt durch 1 Knoten und 1 Stab, 3) $Sigma M_((P)) = 0$ mit P = „geschnittener“ Knoten. Die beiden Stabkräfte $S_a$, $S_b$ gehen durch P und fallen heraus.
#note([Merke ★], [Lege den Momentenbezugspunkt immer in den #strong[Schnittpunkt zweier geschnittener Stäbe]. Dann enthält die Gleichung nur noch die dritte Stabkraft. Wähle das Teilfachwerk, an dem weniger (oder keine) Lagerkräfte und Lasten hängen.])
#note([Fehler vermeiden], [- Die geschnittenen Stabkräfte immer als #strong[Zug] (vom Teilfachwerk weg) ansetzen, an beiden Teilen entgegengesetzt.
- Nicht drei Stäbe schneiden, die alle an #strong[einem] Knoten hängen – dann ist das nur ein freigeschnittener Knoten mit 2 Gleichungen.
- Hebelarme von schrägen Stabkräften: Kraft in Komponenten zerlegen und den Angriffspunkt auf der Wirkungslinie geschickt wählen.], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- Das Verfahren stammt von August Ritter (1826–1908). Man verwendet möglichst Momentengleichungen um die Schnittpunkte von je zwei Stabkräften. #text(fill: muted)[\[TM1-Buch S. 161–162\]]
- Bei räumlichen Fachwerken muss der Schnitt durch 6 Stäbe oder durch 3 Stäbe und einen Knoten gehen (6 GGW-Bedingungen). #text(fill: muted)[\[TM1-Buch S. 163\]]
- Beispiel 6.4: Kraft in einem einzelnen Stab mit einer Momentengleichung am linken Teil; Probe mit der Momentengleichung am rechten Teil. #text(fill: muted)[\[TM1-Buch S. 163–164\]]])
#src[Skript TM1 S. 209–211 (Folien 24–28; Folie 24 ist reiner Text); FS TM1 S. 35; TM1-Buch S. 161–165.]

#grid(columns: 2, gutter: 5mm,
 [#bild("map-t1k6a", [Mindmap: Aufbau und Bestimmtheit von Fachwerken. Eigene Darstellung nach Skript TM1 S. 194–198.], height: 44mm)],
 [#bild("map-t1k6b", [Mindmap: Ermittlung der Stabkräfte. Eigene Darstellung nach Skript TM1 S. 199–211.], height: 44mm)])

*Der Zusammenhang in Kapitel 6.* Ein Fachwerk ist ein mehrteiliges Tragwerk, bei dem jedes Teil ein Pendelstab ist. Deshalb musst du nicht mehr jedes Bauteil freischneiden, sondern nur noch die Knoten, und an jedem Knoten gelten zwei Gleichungen. Daraus folgt die Zählregel $2k = s + r$. Sie ist wie in Kapitel 5 nur notwendig; die drei Bildungsgesetze sorgen dafür, dass das Fachwerk wirklich starr ist. Zum Rechnen bestimmst du zuerst die Lagerreaktionen am eingefrorenen Gesamtsystem und streichst die Nullstäbe. Dann gehst du mit dem Knotenpunktverfahren von Knoten zu Knoten. Brauchst du nur einzelne Stäbe, schneidest du mit Ritter durch drei Stäbe und nimmst Momente um die Schnittpunkte der anderen beiden.

#pagebreak()
== Verständnisfragen und Rechenaufgaben · Kapitel 6
#set enum(spacing: 0.85em)
Erkläre erst selbst. Bei Rechenaufgaben: Bestimmtheit zählen, Lagerreaktionen, Nullstäbe, dann Knoten oder Ritter-Schnitt. Die Lösungen folgen getrennt.

+ Nenne die vier Merkmale eines (idealen) Fachwerks. Warum überträgt dann jeder Stab nur Zug oder Druck?
+ Warum stellt man an einem Knoten nur 2 Gleichgewichtsbedingungen auf und keine Momentengleichung?
+ Erkläre $2k = s + r$. Woher kommt die linke, woher die rechte Seite? Was gilt räumlich?
+ Warum ist $2k = s + r$ nicht hinreichend? Beschreibe die beiden Gegenbeispiele der Folie.
+ Beschreibe das 1. Bildungsgesetz. Warum bleibt die Zählbedingung bei jedem Schritt erfüllt?
+ Auf welche zwei Arten darf man nach dem 2. Bildungsgesetz zwei Fachwerke verbinden, und wie viele Lagerreaktionen braucht man jeweils?
+ Was passiert beim 3. Bildungsgesetz mit $k$, $s$ und der Zählbedingung?
+ Zähle die Schritte a)–e) des Knotenpunktverfahrens auf. Welche Schritte sind streng genommen nicht nötig, und warum macht man sie trotzdem?
+ Warum zeichnet man alle Stabkräfte vom Knoten weg? Was bedeutet dann ein negatives Ergebnis?
+ Nenne die drei Regeln zum Auffinden von Nullstäben.
+ Warum baut man Nullstäbe trotzdem ein?
+ Wann nimmt man das Ritter’sche Schnittverfahren statt des Knotenpunktverfahrens? Durch welche Stäbe darf der Schnitt gehen?
+ Wohin legst du beim Ritter-Schnitt den Momentenbezugspunkt und warum?
+ Ist der Cremona-Plan prüfungsrelevant? Was ist er?
+ Dreieck-Fachwerk: Festlager A $(0; 0)$, Loslager B $(4 "m"; 0)$, Knoten C $(2 "m"; 2 "m")$. Stäbe 1 = A–C, 2 = B–C, 3 = A–B. In C wirkt $F = 10 "kN"$ senkrecht nach unten. Prüfe die Bestimmtheit und berechne Lager- und Stabkräfte. #text(fill: muted)[(eigene Aufgabe)]
+ Folie 15, Beispiel 1: Begründe mit den Regeln, warum die Stäbe 9 und 7 Nullstäbe sind. In welcher Reihenfolge musst du die Regel anwenden? #text(fill: muted)[(eigene Aufgabe)]
+ Folie 25, 1. Beispiel mit Zahlen: $a = 2 "m"$, $b = "1,5" "m"$, $F = 9 "kN"$. Berechne $B$ und mit dem Ritter-Schnitt $S_1$, $S_2$, $S_3$. Mache die Probe mit $Sigma F_x = 0$ am rechten Teil. #text(fill: muted)[(eigene Aufgabe)]
+ Zähle: a) 2 Dreiecke mit gemeinsamer Seite ($k = 4$, $s = 5$), Fest- und Loslager; b) ein Quadrat aus 4 Stäben ohne Diagonale, Fest- und Loslager; c) Fachwerk mit $k = 7$, $s = 10$ und zwei Festlagern. Ist die Zählbedingung erfüllt, und ist das Fachwerk starr? #text(fill: muted)[(eigene Aufgabe)]

#heading(level: 3, outlined: false)[Vertiefende Verständnisfragen und Rechenaufgaben]
#block[
#set enum(start: 19)
+ *Übung 8, Aufg. 8.3:* Quadratisches Fachwerk (Seitenlänge $a$), um 45° gedreht. Festlager in IV, Loslager in III, Kraft $2F$ waagerecht an I, $F$ senkrecht an II. Stäbe laut Lösung: 1 = IV–I, 2 = IV–II, 3 = IV–III, 4 = I–II, 5 = II–III. Bestimme Lager- und Stabkräfte. (Das Aufgabenblatt fehlt; Skizze aus der Lösung.)
  #bild("tm1k6_ue83", [Lösung Übung 8 S. 3: Fachwerk zu Aufgabe 8.3.], height: 38mm)
+ *Übung 8, Aufg. 8.4:* $F_1 = 100 "kN"$ (senkrecht an I), $F_2 = 300 "kN"$ (waagerecht an II). Quadrat III–II–IV–V mit Seite $a$, Knoten I liegt bei $(2a; 2a)$, wenn V im Ursprung liegt. Festlager in V, Loslager in IV. Bestimme Lager- und Stabkräfte. (Skizze aus der Lösung.)
  #bild("tm1k6_ue84", [Lösung Übung 8 S. 5: Fachwerk zu Aufgabe 8.4.], height: 40mm)
+ *Übung 8, Aufg. 8.5:* Das Fachwerk aus Aufgabe 9.1 (Skizze unten): Lager A (fest) und B (los), $2F$ nach unten an III, $F$ waagerecht an IV, Felder $2a$, Höhe $a$. Bestimme alle Lager- und Stabkräfte mit dem Knotenpunktverfahren.
+ *Übung 9, Aufg. 9.1:* Bestimme für die Stäbe 4, 5 und 6 aus Aufgabe 8.5 die Stabkräfte mit dem Ritter’schen Schnittverfahren.
  #bild("tm1k6_ue91", [Übung 9 (Aufgabenblatt S. 1): Fachwerk zu Aufgabe 9.1 (und 8.5).], height: 30mm)
+ *Buch:* Was bedeutet „kinematisch bestimmt“, und wie hängt es mit der statischen Bestimmtheit zusammen? (TM1-Buch S. 148, 165)
+ *Buch:* Warum sind die drei Gleichgewichtsbedingungen am Gesamtsystem beim Knotenpunktverfahren keine zusätzlichen Gleichungen? (TM1-Buch S. 152)
+ *Buch:* Durch wie viele Stäbe muss ein Ritter-Schnitt bei einem räumlichen Fachwerk gehen, und warum? (TM1-Buch S. 163)
+ *Altklausur SS 2018 (TM_Prüfung_2018.pdf S. 6):* Fachwerk wie im Bild ($A$ Festlager, $B$ Loslager, Kräfte $F$ in Knoten II und $2F$ in Knoten VI). a) Welche Stäbe sind Nullstäbe? Nenne jeweils Knoten und Regel. b) Wie bestimmst du $S_6$, $S_7$ und $S_8$ am schnellsten?
  #bild("ak_2018_fachwerk", [Altklausur SS 2018, Aufg. 1 g): Fachwerk mit 13 Stäben über drei Felder der Breite $a$, Knoten I bis VIII, Winkel $alpha$ an den Diagonalen.], height: 50mm)
+ *Altklausur SS 2016, Musterlösung (PrüfungenTM2.pdf S. 21):* Fachwerk wie im Bild ($A$ Festlager, $B$ waagrecht gestützt, Kraft $F$ in Knoten VI in Richtung von Stab 7). a) Bestimme alle Nullstäbe mit Begründung. b) Stelle die Gleichgewichtsbedingungen am Knoten II auf (Zugstäbe positiv).
  #bild("ak_ss16_fachwerk", [Altklausur SS 2016, Aufg. 1 g), Musterlösung: Fachwerk mit Knoten I bis VI, Stäben 1 bis 9, Winkel $alpha$; rote Kreise markieren die Nullstäbe.], height: 50mm)
]

#pagebreak()
== Lösungen Kapitel 6
#set enum(spacing: 0.65em)
+ Mehrteiliges Tragwerk aus geraden Stäben; Stäbe zentrisch, gelenkig und reibungsfrei in Knoten verbunden; Lasten nur in den Knoten. Dann ist jeder Stab ein Pendelstab (zwei Gelenke, keine Last dazwischen) und überträgt nur eine Kraft in Stabrichtung. #nachschlagen[Lernskript, #stelle(<a-tm1-6-1>)\; TM1-Buch S. 147]
+ Am Knoten greifen alle Kräfte in einem Punkt an (zentrale Kräftegruppe). Die Momentengleichung um den Knoten ist dann immer $0 = 0$. #nachschlagen[Lernskript, #stelle(<a-tm1-6-1>)]
+ Links: 2 Gleichungen pro Knoten, $k$ Knoten. Rechts: $s$ Stabkräfte + $r$ Lagerreaktionen = Unbekannte. Räumlich: $3k = s + r$. #nachschlagen[Lernskript, #stelle(<a-tm1-6-1>)]
+ Die Formel zählt nur, sie prüft nicht die Anordnung. Beispiel 1: links zwei Diagonalen (vorspannbar), rechts keine (beweglich). Beispiel 2: Knoten VI zwischen zwei Stäben auf einer Geraden (vorspannbar, senkrecht beweglich). #nachschlagen[Lernskript, #stelle(<a-tm1-6-1>)]
+ Ein Stab, dann immer 2 Stäbe mit neuem Knoten (Zweischlag) anfügen, zuletzt Lager mit $r = 3$. Pro Schritt +1 Knoten (+2 Gleichungen) und +2 Stäbe (+2 Unbekannte). #nachschlagen[Lernskript, #stelle(<a-tm1-6-2>)]
+ Durch 3 Stäbe (nicht parallel, nicht durch einen Punkt) mit $r = 3$, oder durch 1 Knoten + 1 Stab mit $r = 3$. Nur durch 1 Knoten: $r = 4$. #nachschlagen[Lernskript, #stelle(<a-tm1-6-2>)]
+ $k$ und $s$ ändern sich nicht (ein Stab raus, einer rein), also bleibt $2k = s + r$ erfüllt. Das Fachwerk ist nach dem Umsetzen wieder starr. #nachschlagen[Lernskript, #stelle(<a-tm1-6-2>)]
+ a) Einfrieren, Lagerreaktionen; b) Nullstäbe; c) alle Knoten freischneiden; d) je 2 GGW; e) lösen. a) und b) sind nicht nötig, weil c)–e) alles liefern, aber sie machen das Gleichungssystem viel einfacher. #nachschlagen[Lernskript, #stelle(<a-tm1-6-3-1>)]
+ Dann gilt die Vorzeichenregel automatisch und actio = reactio ist erfüllt: positiv = Zug, negativ = Druck (der Stab drückt in Wirklichkeit auf den Knoten). #nachschlagen[Lernskript, #stelle(<a-tm1-6-3-1>)]
+ 1) Unbelasteter Knoten mit genau 2 Stäben, nicht in einer Richtung → beide Nullstäbe. 2) Belasteter Knoten mit genau 2 Stäben, Last in Richtung eines Stabes → der andere ist Nullstab. 3) Unbelasteter Knoten mit genau 3 Stäben, 2 davon in einer Richtung → der dritte ist Nullstab. #nachschlagen[Lernskript, #stelle(<a-tm1-6-3-1>)\; FS TM1 S. 35]
+ Sie sind nur bei dieser Last kraftlos. Sie sichern die Stabilität von Druckstäben (Knicken) und die statische Bestimmtheit; bei anderer Last tragen sie. #nachschlagen[Lernskript, #stelle(<a-tm1-6-3-1>)]
+ Wenn nur einzelne Stabkräfte gesucht sind. Schnitt durch 3 Stäbe (nicht alle parallel, nicht alle an einem Knoten) oder durch 1 Stab und 1 Knoten. #nachschlagen[Lernskript, #stelle(<a-tm1-6-3-3>)]
+ In den Schnittpunkt zweier geschnittener Stäbe (bzw. in den geschnittenen Knoten). Dann fallen diese zwei Kräfte heraus, und jede Gleichung liefert genau eine Stabkraft. #nachschlagen[Lernskript, #stelle(<a-tm1-6-3-3>)]
+ Nein (laut Folie nicht prüfungsrelevant). Er ist die zeichnerische Lösung: die Kraftecke aller Knoten maßstäblich gezeichnet. #nachschlagen[Lernskript, #stelle(<a-tm1-6-3-2>)]
+ $k = 3$, $s = 3$, $r = 3$ → $6 = 6$, Dreieck → starr. Symmetrie: $A_y = B = 5 "kN"$, $A_x = 0$. Knoten C (Stäbe unter 45°): $Sigma F_x$: $S_1 = S_2$; $Sigma F_y$: $-2 S_1 sin 45° - 10 = 0$ → $S_1 = S_2 = -"7,07" "kN"$ (Druck). Knoten A: $Sigma F_x$: $S_3 + S_1 cos 45° = 0$ → $S_3 = 5 "kN"$ (Zug). Probe $Sigma F_y$ in A: $5 - 5 = 0$ ✓. #nachschlagen[Lernskript, #stelle(<a-tm1-6-3-1>)]
+ Zuerst Knoten VI (Loslager B): belasteter Zweischlag, die Lagerkraft $B$ wirkt genau in Richtung von Stab 8 → Regel 2: $S_9 = 0$. Danach Knoten V (Festlager A, $A_x = 0$): Ohne Stab 9 hängen nur Stab 6 und 7 dran, $A_y$ wirkt in Richtung von Stab 6 → wieder Regel 2: $S_7 = 0$. Die Reihenfolge ist wichtig, weil $S_9 = 0$ zuerst feststehen muss. #nachschlagen[Lernskript, #stelle(<a-tm1-6-3-1>)]
+ $Sigma M_((A))$: $B dot 3a = F dot 2a$ → $B = 6 "kN"$. $tan alpha = "1,5"\/2$ → $sin alpha = "0,6"$, $cos alpha = "0,8"$. $S_1 = (9 dot 2 - 2 dot 2 dot 6)\/"1,5" = -4 "kN"$; $S_3 = 2 dot 6\/"1,5" = 8 "kN"$; $S_2 = (6 - 9)\/"0,6" = -5 "kN"$. Probe: $-S_1 - S_2 cos alpha - S_3 = 4 + 4 - 8 = 0$ ✓. #nachschlagen[Lernskript, #stelle(<a-tm1-6-3-3>)]
+ a) $8 = 5 + 3$ ✓, starr (1. Bildungsgesetz). b) $8 = 4 + 3 = 7$ → unterbestimmt, beweglich (Rechteck kippt zum Parallelogramm). c) $14 = 10 + 4$ ✓; starr nur, wenn keine Ausnahme vorliegt (wie Abb. 6.2a im Buch). #nachschlagen[Lernskript, #stelle(<a-tm1-6-1>)\; TM1-Buch S. 148]
+ Lager: $A_H = 2F$, $A_V = -3F$, $B = 4F$. Stäbe: $S_1 = sqrt(2) F$, $S_2 = 3F$, $S_3 = -2 sqrt(2) F$, $S_4 = -sqrt(2) F$, $S_5 = -2 sqrt(2) F$. Weg: Knoten I liefert $S_1$, $S_4$; Knoten III liefert $S_3 = S_5 = -B\/sqrt(2)$; Knoten II liefert $S_2 = F + 2F$. #nachschlagen[Lernskript, #stelle(<a-tm1-6-3-1>)\; Lösung Übung 8 S. 2–4]
+ $A_H = 300 "kN"$, $A_V = -400 "kN"$ (nach unten; die Lösung schreibt „Zugkraft!“), $B_V = 500 "kN"$. Mit $tan alpha_1 = 1\/2$, $alpha_2 = 45°$: $S_1 = sqrt(5) F_1 = "223,61"$, $S_2 = -2 sqrt(2) F_1 = -"282,84"$, $S_3 = 100$, $S_4 = 400$, $S_5 = -"424,26"$, $S_6 = -200$, $S_7 = 300$ (alle in kN). Druckstäbe: 2, 5, 6. #nachschlagen[Lernskript, #stelle(<a-tm1-6-3-1>)\; Lösung Übung 8 S. 5–7]
+ $cos alpha = 2\/sqrt(5)$, $sin alpha = 1\/sqrt(5)$. Lager: $A_H = F$, $A_V = 7\/6 F$, $B = 5\/6 F$. Stäbe (in $F$): $S_1 = -(7 sqrt(5))\/6 approx -"2,61"$, $S_2 = 10\/3$, $S_3 = 2$, $S_4 = -2\/3$, $S_5 = -(5 sqrt(5))\/6 approx -"1,86"$, $S_6 = 10\/3$, $S_7 = 5\/6$, $S_8 = -(5 sqrt(5))\/6$, $S_9 = 5\/3$. Druckstäbe: 1, 4, 5, 8. (In der Tabelle der Lösung steht für $S_4$ gerundet „−0,66“; genauer ist −0,67.) #nachschlagen[Lernskript, #stelle(<a-tm1-6-3-1>)\; Lösung Übung 8 S. 7–9]
+ Schnitt durch 4, 5, 6; rechtes Teil. $Sigma M_((V))$: $a S_4 - a F + 2a B = 0$ → $S_4 = F - 2B = -2\/3 F$. $Sigma F_y$: $S_5 sin alpha + B = 0$ → $S_5 = -sqrt(5) B = -(5 sqrt(5))\/6 F$. $Sigma F_x$: $S_6 = -S_4 + F - 2\/sqrt(5) S_5 = 10\/3 F$. Gleiche Werte wie in 8.5 ✓. #nachschlagen[Lernskript, #stelle(<a-tm1-6-3-3>)\; Lösung Übung 9 S. 1]
+ Die Lage aller Knoten liegt fest, das Fachwerk ist unbeweglich. Statisch bestimmt ist es, wenn zusätzlich die Zahl der Unbekannten gleich der Zahl der Gleichungen ist. Mathematisch: Determinante der Koeffizientenmatrix $!= 0$. #nachschlagen[Lernskript, #stelle(<a-tm1-6-1>)\; TM1-Buch S. 148, 165]
+ Sie folgen aus den Knotengleichungen (sind nicht unabhängig) und sind deshalb nur eine Probe. Bestimmt man die Lager vorab, werden dafür drei Knotengleichungen zur Probe frei. #nachschlagen[Lernskript, #stelle(<a-tm1-6-3-1>)\; TM1-Buch S. 152]
+ Durch 6 Stäbe oder 3 Stäbe und einen Knoten, weil ein starrer Körper im Raum 6 GGW-Bedingungen hat. #nachschlagen[Lernskript, #stelle(<a-tm1-6-3-3>)\; TM1-Buch S. 163]
+ a) Vier Nullstäbe. Knoten I: Stäbe 1 und 2 (Regel 1, unbelasteter Knoten mit zwei Stäben). Knoten IV: Stab 5 (Regel 3, Stäbe 4 und 8 liegen auf einer Linie). Knoten VII = Lager $B$: Stab 10 (Regel 2, die Lagerkraft wirkt in Richtung von Stab 13). b) Ritterschnitt durch die Stäbe 6, 7 und 8: drei unbekannte Stabkräfte, die nicht durch einen Punkt gehen. #nachschlagen[Lernskript, #stelle(<a-tm1-6-3-1>), #stelle(<a-tm1-6-3-3>)\; Altklausur SS 2018 (TM_Prüfung_2018.pdf S. 6), eigene Lösung]
+ a) Stäbe 6 und 9 (Knoten V, Regel 1), Stab 1 (Knoten I, Regel 2: die Lagerkraft $B$ wirkt in Richtung von Stab 2), Stab 8 (Knoten VI, Regel 2: $F$ wirkt in Richtung von Stab 7), Stab 5 (Knoten IV, Regel 3), danach Stab 4 (Knoten IV hat nur noch einen Stab). b) $arrow.r: A_H + S_3 cos alpha + S_4 = 0$, $arrow.t: A_V + S_1 + S_3 sin alpha = 0$. #nachschlagen[Lernskript, #stelle(<a-tm1-6-3-1>)\; Altklausur SS 2016, Musterlösung (PrüfungenTM2.pdf S. 21)]

#pagebreak()
= TM1 Kapitel 7 · Schnittgrößen <k-tm1-7>
#tab(columns: 2,
 [Vorlesungen], [Auf den Folien S. 212–274 steht kein handschriftliches Datum → Badge #strong[TM1 WS 25/26] (Abschnitte 7.1–7.3). WZF (Sosnowsky): Foliensatz „Querkraftplan“ vom #strong[15.12.25]\; deine WZF-Mitschrift vom #strong[18.12.25] (Querkraftplan, abgewandelte Aufg. 9.3, „Einschub Querkraftplan“) → Abschnitt 7.2.6.],
 [Quellen], [Skript TM1 S. 212–274 (Foliensatz „Schnittgrößen“, Folien 1–100) mit deinen Mitschriften S. 219–221, 226–227, 241–245, 261–263; WZF „Querkraftplan“ (19 S.); WZF-Mitschrift 18.12.25 (in „09 Mechanik Übung.pdf“ S. 2–3); FS TM1 S. 36–45; TM1-Buch Kap. 7 (S. 169–211). Wiederholung in TM2: Skript TM2 S. 5–51 (eigenes Kapitel).],
 [Passende Übungen], [Übung 9: 9.2, 9.3, 9.4 · Übung 10: 10.1, 10.2, 10.3, 10.4 · Übung 11: 11.1, 11.2, 11.3 (nur Lösungsblatt vorhanden) · Übung 12: 12.1 (Gerberträger, N/Q/M), 12.2 und 12.3 (Rahmen; nur Lösungsblatt vorhanden); dazu Altklausur-Aufgaben am Ende der vertiefenden Fragen],
)
Bisher hast du einen Balken nur #strong[von außen] betrachtet: Lagerreaktionen aus dem Gleichgewicht. Jetzt schaust du #strong[hinein]: Du schneidest den Balken an einer beliebigen Stelle $x$ und fragst, welche inneren Kräfte dort wirken. Das sind die drei #strong[Schnittgrößen] Normalkraft $N$, Querkraft $Q$ und Biegemoment $M$. Ihre Verläufe $N(x),Q(x),M(x)$ zeigen, #strong[wo] der Balken am stärksten beansprucht wird – die Grundlage für TM2 (Spannung, Biegung, Bemessung). Dieses Kapitel ist das klausurrelevanteste von TM1.
#note([Hinweis zur Nummerierung], [Die Folien sind Kapitel 7 („7 Schnittgrößen“), schreiben die Unterabschnitte aber ohne die 7: „2.1“, „2.2“ … „2.6“ und „3“. Im Text der Folien selbst wird dann wieder „Kap. 7.2.1“, „7.2.6“ zitiert. Hier steht durchgehend die volle Nummer: #strong[Folie „2.2“ = Abschnitt 7.2.2], Folie „2.4“ = 7.2.4, Folie „3“ = 7.3. Die Nummern stimmen mit dem TM1-Buch (Kap. 7) überein.], fill: sand)
#note([Dein Feynman-Schritt: die 6 Kernideen von Kapitel 7. Erst ohne Skript aufzählen und erklären, dann vergleichen.], [+ #strong[Schneiden macht innere Kräfte sichtbar:] An jeder Schnittstelle wirken $N, Q, M$; sie folgen aus dem Gleichgewicht am linken #emph[oder] rechten Teil.
+ #strong[Ein Vorzeichen für alles:] Positive Schnittgrößen zeigen am positiven Schnittufer in positive, am negativen Schnittufer in negative Koordinatenrichtung.
+ #strong[Felder:] An jedem Lastangriffspunkt, Lager und Anfang/Ende einer Streckenlast ändert sich die Formel – also feldweise rechnen.
+ #strong[Belastung → Querkraft → Moment:] $Q' = -q$, $M' = Q$. Daraus folgen Sprünge, Knicke, Parabeln und $M_(max)$ bei $Q=0$.
+ #strong[Integrieren statt schneiden:] $Q=- integral q thin d x + C_1$, $M= integral Q thin d x + C_2$; Konstanten aus Rand- und Übergangsbedingungen.
+ #strong[Punktweise reicht oft] ★: Lagerreaktionen, Werte an markanten Stellen, Verlauf dazwischen aus der Tabelle – so läuft es in der Klausur. Bei Rahmen genauso, plus gestrichelte Faser und „vor/nach Ecke“.
Zusammenfassung der Abschnitte 7.1–7.3; Quellen stehen dort.])
#note([Das Rezept in einem Kasten ★], [(Folien 7–10, FS TM1 S. 37, ergänzt um Kontrollen):
+ #strong[Lagerreaktionen] aus dem Gleichgewicht am Gesamtsystem (bei Gelenken: Teilkörper).
+ #strong[Felder festlegen:] Grenzen an jeder Einzelkraft, jedem Einzelmoment, jedem Lager, Anfang/Ende jeder Streckenlast (bei Integration: auch Gelenke mit Einzellast).
+ #strong[Schnitt] an variabler Stelle $x$ in jedem Feld (oder punktweise an markanten Stellen), $N, Q, M$ #strong[positiv] einzeichnen, Gleichgewicht am linken #emph[oder] rechten Teil (Momente um den Schnittpunkt $S$!).
+ #strong[Skizze] von $N$, $Q$, $M$ mit Werten, Vorzeichen (+/−) und Verlaufstyp.
+ #strong[Kontrolle:] $Q$ springt am Ende auf 0, $M=0$ an gelenkigem Endlager / freiem Ende / Gelenk, Steigung von $M$ = Wert von $Q$, $M_(max)$ bei $Q=0$.])
== 7.1 Einführung <a-tm1-7-1>
Ein Balken trägt Lasten $F_1, F_2, M_0, q(x)$ und gibt sie an die Lager weiter. Die Fragen der Folie: #strong[Wo] ist die Belastung im Balken am größten, #strong[wie groß] ist sie, und wie #strong[verläuft] sie über die Länge? Antwort: Du schneidest den Balken an einer veränderlichen Stelle $S$ bei der Koordinate $x$. Am Schnitt wirken drei innere Größen:
- #strong[Normalkraft $N$]: in Balkenrichtung (Zug positiv, Druck negativ).
- #strong[Querkraft $Q$]: senkrecht zur Balkenachse, in der Schnittfläche.
- #strong[Biegemoment $M$]: dreht um die $y$-Achse, biegt den Balken.
Weil $S$ wandert, sind es Funktionen: $N=N(x)$, $Q=Q(x)$, $M=M(x)$. In TM1 bestimmst du nur diese inneren Kräfte; den Einfluss der Querschnittsabmessungen (Spannung, Verformung) machst du in TM2.
#note([In eigenen Worten], [Stell dir den Balken als Kette von Leuten vor, die eine schwere Bank tragen. Schneidest du „zwischen zwei Leuten“, fragst du: Wie stark zieht/drückt der linke Teil am rechten ($N$), wie stark „hält er ihn hoch“ ($Q$), und wie stark „verdreht“ er ihn ($M$)? Diese drei Antworten hängen davon ab, an welcher Stelle du schneidest. #text(fill: muted)[(eigene Ergänzung)]])
#bild("tm1k7_einfuehrung", [Skript TM1 S. 213 (untere Folie 4): Schnitt bei $x$; links und rechts wirken $N, Q, M$ entgegengesetzt (Wechselwirkung). Rechts unten deine Skizze des alten Koordinatensystems ($y$ nach oben, $+M$ gegen den Uhrzeigersinn); im roten Kasten deine Notiz zu $d Q/d x$ und $d M/d x$.], height: 45mm)
#note([Fehler vermeiden – deine Notiz im roten Kasten (S. 213)], [Dort steht „$frac(d Q, d x) = q$“. Richtig ist mit dem Koordinatensystem der Vorlesung ($z$ nach unten, $q$ nach unten positiv) #strong[$frac(d Q, d x) = -q(x)$] (Folie 28/29, FS TM1 S. 37 Gl. 7.4). Die zweite Zeile $frac(d M, d x) =Q$ stimmt. Das Minus ist eine der häufigsten Fehlerquellen – Herleitung in 7.2.2.], fill: sand)
#heading(level: 3, outlined: false)[Neues Koordinatensystem und Schnittufer ★]
Bisher galt in der Ebene: $x$ nach rechts, $y$ nach oben, Moment positiv gegen den Uhrzeigersinn. #strong[Jetzt] gilt für Balken:
- $x$: nach rechts, in Balkenrichtung
- $z$: nach #strong[unten]
- $y$: senkrecht aus der Zeichenebene heraus (Rechtssystem)
#note([Definition Schnittufer (Folie 5)], [Der Schnitt erzeugt zwei Ufer.
- #strong[Linker Teil = positives Schnittufer:] die $x$-Achse tritt hier #strong[aus] (Flächennormale zeigt in $+x$).
- #strong[Rechter Teil = negatives Schnittufer:] die $x$-Achse tritt hier #strong[ein] (Flächennormale zeigt in $-x$).])
#note([Merke – Vorzeichenfestlegung (Folie 5, FS TM1 S. 37 Gl. 7.3) ★], [#strong[Positive Schnittgrößen zeigen am positiven Schnittufer in positive Koordinatenrichtung und am negativen Schnittufer in negative Koordinatenrichtung.] \

Konkret am #strong[linken Teil] (rechtes Ende = positives Ufer): $N$ nach rechts (zieht), $Q$ nach #strong[unten], $M$ gegen den Uhrzeigersinn. \

Am #strong[rechten Teil] (linkes Ende = negatives Ufer): $N$ nach links (zieht), $Q$ nach #strong[oben], $M$ im Uhrzeigersinn. \

Folge: Positives $M$ biegt den Balken nach unten durch („lächelnder“ Balken), die #strong[Unterseite] (Seite von $+z$, später „gestrichelte Faser“) wird gezogen. Diese Konvention gilt in diesem ganzen Kapitel ohne Ausnahme.])
#bild("tm1k7_vorzeichen", [Skript TM1 S. 214 (obere Folie 5): neues Koordinatensystem und Schnittufer mit deinen Tafelskizzen: links positives Ufer (+) mit $N$ nach rechts, $Q$ nach unten; rechts negatives Ufer (−) mit $N$ nach links, $Q$ nach oben; $M$ jeweils entgegengesetzt.], height: 45mm)
#note([Aus deiner Mitschrift (Folie 5)], [Unter „linker Teil“ hast du notiert: „→ werden alle Kräfte positiv angenommen“, unter „rechter Teil“: „→ werden alle Kräfte negativ angenommen“. Gemeint ist: Du zeichnest die Schnittgrößen #strong[immer] in ihrer positiven Richtung ein. Am rechten Teil zeigen diese positiven Pfeile aber in die #strong[negativen] Koordinatenrichtungen. Das Ergebnis der Rechnung (Zahl mit Vorzeichen) sagt dir dann, ob die Schnittgröße wirklich positiv ist.])
#note([Fehler vermeiden (typische Fehler)], [- Schnittgrößen „so wie es physikalisch aussieht“ einzeichnen statt immer positiv → Vorzeichen falsch. Immer positiv einzeichnen, die Rechnung liefert das Vorzeichen.
- Am rechten Teil $Q$ nach unten zeichnen → falsch, dort zeigt positives $Q$ nach #strong[oben].
- Momentengleichgewicht nicht um den Schnittpunkt $S$ bilden → $N$ und $Q$ tauchen in der Momentengleichung auf, unnötige Unbekannte.], fill: sand)
Häufig betrachtet man nur $Q$ und $M$: entweder ist $N=0$ (Belastung und Lagerung erzeugen keine Längskraft), oder $N != 0$, aber sein Einfluss ist klein. $N$ bestimmt man bei Bedarf genauso wie $Q$ und $M$ (Folie 6).
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Woher kommen N, Q, M?] Die im Schnitt verteilten Flächenkräfte werden durch ihre Resultierende $R$ und ihr Moment bezüglich des #strong[Schwerpunkts] der Querschnittsfläche ersetzt; $R$ zerlegt man in $N$ (normal zum Schnitt) und $Q$ (in der Schnittebene). #text(fill: muted)[\[TM1-Buch S. 169\]]
- #strong[Schnittufer über den Normalenvektor:] Zeigt der nach außen gerichtete Normalenvektor in $+x$, ist es das positive Ufer; $M$ ist ein Momentenvektor in $y$-Richtung (positiv als Rechtsschraube). #text(fill: muted)[\[TM1-Buch S. 170–171\]]
- #strong[x nach links:] Lässt man $x$ nach links zeigen (dann $y$ in die Ebene hinein), ändert sich #strong[nur die positive Richtung von $Q$]\; $M$ und $N$ bleiben gleich. #text(fill: muted)[\[TM1-Buch S. 171\]]])
#src[Skript TM1 S. 212–214 (Folien 1–6) mit deinen Notizen S. 213–214; FS TM1 S. 36–37; TM1-Buch S. 169–171.]
== 7.2 Schnittgrößen am geraden Balken <a-tm1-7-2>
Der gerade Balken ist der wichtigste Fall. Du lernst vier Wege, die Verläufe zu bestimmen: abschnittsweise schneiden (7.2.1), integrieren (7.2.2–7.2.4), mit dem Föppl-Symbol (7.2.5) und punktweise (7.2.6).
=== 7.2.1 Balken mit Einzelkräften <a-tm1-7-2-1>
Ein Balken auf zwei gelenkigen Lagern $A$ (Festlager) und $B$ (Loslager) trägt senkrechte Einzelkräfte $F_i$ (bei $x=a_i$) und Einzelmomente $M_j$ (bei $x=b_j$). Du gehst in vier Schritten vor – genau das Rezept von oben.
#bild("tm1k7_einzelkraefte", [Skript TM1 S. 215 (obere Folie 7): Balken mit Einzelkräften $F_i$ und Einzelmomenten $M_j$; unten Freikörperbild mit den Feldern I–V.], height: 45mm)
#heading(level: 4, outlined: false)[Schritt 1: Lagerreaktionen]
#form[$ sum M_((A))=0 colon med B= frac(1, l) [ sum_(i=1)^n a_i F_i - sum_(j=1)^m M_j ], wide sum M_((B))=0 colon med A= frac(1, l) [ sum_(i=1)^n (l-a_i )F_i + sum_(j=1)^m M_j ] $]
Folie 8; $A_x =0$, $A_z =A$. Die $M_j$ sind hier gegen den Uhrzeigersinn eingezeichnet. Einheiten: $F$ in N, $M$ in Nm, $l, a$ in m.
#heading(level: 4, outlined: false)[Schritt 2: Felder festlegen]
Grenzen sind: jeder Angriffspunkt von Kräften/Momenten (auch von Lagerreaktionen) sowie Anfang und Ende jeder Streckenlast. Die Koordinate $x$ läuft zunächst immer vom Balkenanfang aus.
#note([Fehler vermeiden (Folie 6)], [Der Angriffspunkt eines Einzelmoments $M_j$ ist hier #strong[nicht frei verschieblich] – anders als beim Gleichgewicht am starren Körper! Er ist eine Feldgrenze, und beim Momentengleichgewicht um $S$ zählt $M_j$ nur, wenn es auf dem betrachteten (linken oder rechten) Teil sitzt.], fill: sand)
#heading(level: 4, outlined: false)[Schritt 3: Freischnitt und Gleichgewicht]
#bild("tm1k7_freischnitte", [Skript TM1 S. 216 (obere Folie 9): Schnitte 3I, 3II … 3V. Links jeweils der linke Teilbalken mit positivem Schnittufer (+), rechts der rechte Teilbalken mit negativem Schnittufer (−).], height: 45mm)
#form[$ sum F_z =0 colon med -A+ sum F_i +Q(x)=0 med => med Q(x)=A- sum F_i $


$ sum M_((S))=0 colon med -x A+ sum (x-a_i )F_i + sum M_j +M(x)=0 med => med M(x)=A x- sum (x-a_i )F_i - sum M_j $]
Folie 10, Gleichgewicht am linken Teil; summiert wird nur über die Lasten links vom Schnitt. In deiner Mitschrift ergänzt: $sum F_x =0 => N=0$.
#heading(level: 4, outlined: false)[Schritt 4: Skizze und Zusammenhänge]
#bild("tm1k7_verlauf_einzel", [Skript TM1 S. 217 (obere Folie 11): $Q$ ist feldweise konstant und springt an jeder Kraft; $M$ ist feldweise linear, knickt an jeder Kraft und springt an jedem Einzelmoment. $M=0$ an beiden gelenkigen Endlagern.], height: 45mm)
- #strong[Querkraft] $Q(x)=A- sum F_i$: Sprung um $-F_i$ an jeder Kraft, dazwischen konstant. Bei gelenkigen Lagern an beiden Enden: $Q(0)=A$, $Q(l)=-B$.
- #strong[Moment] $M(x)= underbrace(sum a_i F_i - sum M_j, C_1 ) +x underbrace((A- sum F_i ), C_2 )$: Geraden; Steigungsänderung („Knick“) an jedem $F_i$; Sprung um $-M_j$ an jedem (linksdrehenden) $M_j$. Gelenkige Endlager: $M(0)=0$, $M(l)=0$.
- #strong[Zusammenhang:] $frac(d M, d x) =C_2 =A- sum F_i =Q(x)$ – #strong[die Steigung von $M$ ist gleich $Q$] (Folie 13).
#note([Merke – Sprungregeln beim Lesen von links nach rechts], [(aus Folien 12–13 und Beispiel 4 abgeleitet): $Q$ positiv nach oben, $M$ positiv nach oben aufgetragen.
- Kraft nach #strong[unten] → $Q$ springt um ihren Betrag nach #strong[unten]\; Kraft nach oben (Lager) → Sprung nach oben.
- Einzelmoment #strong[im Uhrzeigersinn] → $M$ springt nach #strong[oben] ($+M_0$); gegen den Uhrzeigersinn → nach unten ($-M_0$).
- Einzelkraft → $M$ hat dort einen #strong[Knick]\; Einzelmoment → $Q$ bleibt unverändert.])
#note([„Tricks“ zur Verringerung des Arbeitsaufwands (Folie 12)], [Gegen Ende des Balkens das Gleichgewicht am #strong[rechten] Teilbalken aufstellen – erheblich kürzer, z. B. im Feld V: $sum F_z =0 colon med -B-Q(x)=0 => Q(x)=-B$; $sum M_((S))=0 colon med -M(x)+B(l-x)=0 => M(x)=B(l-x)$. Am rechten Teil (negatives Ufer) zeigt $Q$ nach oben und $M$ im Uhrzeigersinn.])
#heading(level: 4, outlined: false)[Beispiel 1: schräge Einzelkraft (Folien 14–16)]
#bild("tm1k7_bsp1", [Skript TM1 S. 218 (untere Folie 14): Balken mit Kraft $sqrt(2) F$ unter 45° bei $x=a$; Zerlegung in $F$ senkrecht und $F$ waagerecht (nach links).], height: 45mm)
#note([Beispiel 1 (Folien 14–16, deine Mitschrift S. 219–221)], [Geg.: $F, a, l$. Ges.: $N, Q, M$.
+ #strong[Lager:] $sum F_x colon A_x -F=0 => A_x =F$; $sum M_((A)) colon -F a+B l=0 => B=F frac(a, l)$; $sum F_z colon A_z -F+B=0 => A_z =F(1- frac(a, l) )$.
+ #strong[Felder:] I: $0 <= x <= a$; II: $a < x <= l$.
+ #strong[Schnittgrößen:] #strong[Feld I (links):] $N=-A_x =-F$ (Druck); $Q=A_z =F(1- frac(a, l) )$; $M=A_z x=F(1- frac(a, l) )x$. \
  
  #strong[Feld II (rechts):] $N=0$; $-B-Q=0 => Q=-B=-F frac(a, l)$; $-M+B(l-x)=0 => M=F a(1- frac(x, l) )$.
  #strong[Skizze:] $N$ springt bei $x=a$ von $-F$ auf 0, $Q$ springt von $A_z$ auf $-B$ (Sprung = $F$), $M$ ist ein Dreieck mit $M_(max)=M_I (a)=M_("II")(a)=F(1- frac(a, l) )a$.
Kontrolle: $M_("II")(l)=0$ ✓, Sprung in $Q$: $A_z -(-B)=F$ ✓.], fill: pale)
#bild("tm1k7_bsp1_verlauf", [Skript TM1 S. 222 (untere Folie 16): $N$-, $Q$- und $M$-Verlauf zu Beispiel 1. Die waagerechte Komponente erzeugt Druck nur im Feld I.], height: 45mm)
#heading(level: 4, outlined: false)[Beispiel 2: Lager nicht am Balkenende, Lager mit Moment (Folien 17–19)]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k7_bsp2", [Skript TM1 S. 223 (obere Folie 17): Bei $A$ ein Lager mit Reaktionsmoment (überträgt $A$ waagerecht und $M_A$, keine Vertikalkraft – eine Parallelführung), $B$ bei $x=a$, $F$ am Kragende.], height: 50mm)],
 [#bild("tm1k7_bsp2_verlauf", [Skript TM1 S. 224 (obere Folie 19): $N=0$; $Q=0$ in Feld I, $Q=F$ in Feld II; $M$ konstant $-F(l-a)$ in I, linear auf 0 in II.], height: 50mm)])
#note([Beispiel 2], [Lager zwischen $x=0$ und $x=l$ → Feldgrenze an der Lagerstelle; Lager mit Reaktionsmoment → $M != 0$ an der Lagerstelle.
+ $sum F_x colon -A=0 => A=0$; $sum M_((B)) colon -F(l-a)-M_A =0 => M_A =-F(l-a)$; $sum F_z colon B-F=0 => B=F$.
+ Feld I ($0 <= x <= a$, links): $N=0$, $Q=0$, $-M_A +M=0 => M=M_A =-F(l-a)$.
+ Feld II ($a < x <= l$, rechts): $N = 0$, $Q = F$, $M = -F(l - x)$.
Negatives $M$: Der Kragarm biegt sich nach oben gewölbt, #strong[Zug oben].], fill: pale)
#heading(level: 4, outlined: false)[Balken mit Streckenlast: Teilresultierende ★]
Eine Streckenlast lässt sich oft auf eine Einzellast zurückführen (Alternative zur Integration in 7.2.2–7.2.5). Zwei Fälle:
- #strong[Gesamtresultierende $F_R$] (Fläche der Last, Angriff im Flächenschwerpunkt): nur für Lagerreaktionen und für Felder, in denen die #strong[ganze] Last auf einer Seite des Schnitts liegt.
- #strong[Teilresultierende $F_R '$]: In einem Feld #strong[mit] Streckenlast erst schneiden, dann nur den Teil der Last auf dem betrachteten Teilbalken zusammenfassen.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k7_streckenlast", [Skript TM1 S. 224 (untere Folie 20): Dreieckslast von $a$ bis $2a$; $F_R = frac(1, 2) q_0 a$, $x_R =a+ frac(2, 3) a= frac(5, 3) a$.], height: 50mm)],
 [#bild("tm1k7_teilres", [Skript TM1 S. 225 (obere Folie 21): Teilresultierende $F_R '$ im Feld II mit Höhe $q'=q_0 frac(x-a, a)$ und Lage $x_R '$.], height: 50mm)])
#form[$ F_R '= frac(q_0, 2) frac((x-a)^2, a), quad x_R '=a+ frac(2, 3) (x-a) quad => quad Q(x)=A- frac(q_0, 2) frac((x-a)^2, a), wide M(x)=A x- frac(q_0, 6a) (x-a)^3 $]
Folie 21, Feld II (Gleichgewicht links). Hebelarm von $F_R '$ zum Schnitt: $x-x_R '= frac(x-a, 3)$.
#note([Fehler vermeiden], [Die Streckenlast #strong[vor] dem Schnitt zur Gesamtresultierenden zusammenfassen und dann im Feld der Last schneiden. Das liefert falsche $Q$ und $M$. Erst schneiden, dann nur den Lastanteil auf dem Teilbalken ersetzen (so auch #text(fill: muted)[\[TM1-Buch S. 185\]]).], fill: sand)
#heading(level: 4, outlined: false)[Beispiel 3: Gleichstreckenlast $q_0$ auf Einfeldbalken (Folien 22–24) ★]
#note([Beispiel 3], [Geg.: $q_0, l$. Ges.: $Q(x), M(x)$.
+ Lager: $sum M_((A)) colon -q_0 l frac(l, 2) +B l=0 => B= frac(1, 2) q_0 l$; $A=q_0 l-B= frac(1, 2) q_0 l$; $A_x =0$.
+ Ein Feld: $0 <= x <= l$.
+ Schnitt bei $x$, links: Teilresultierende $F_R '=q_0 x$ bei $frac(x, 2)$. \
  
  $sum F_z colon -A+q_0 x+Q=0 => Q(x)=q_0 l[ frac(1, 2) - frac(x, l) ]$ \
  
  $sum M_((S)) colon M+q_0 x dot frac(x, 2) -x A=0 => M(x)= frac(q_0 l^2, 2) [ frac(x, l) - frac(x^2, l^2) ]$
+ $Q$ linear von $+ frac(q_0 l, 2)$ auf $- frac(q_0 l, 2)$; $M$ quadratische Parabel, Maximum bei $Q=0$, also $x= frac(l, 2)$: $#box(stroke: 0.6pt, inset: 3pt, $M_(max)= frac(q_0 l^2, 8) $)$.], fill: pale)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k7_bsp3_verlauf", [Skript TM1 S. 228 (untere Folie 24): Q-Linie linear, M-Parabel mit $M_(max)=q_0 l^2 /8$ in Balkenmitte; RB: $M=0$ an beiden Lagern.], height: 50mm)],
 [#bild("tm1k7_mitschrift_bsp3", [Deine Mitschrift (Skript TM1 S. 227): Skizze von Q- und M-Verlauf mit eingeklebter Rechnung $Q=0 => x=l/2$, $M(l/2)=q_0 l^2 /8$; Notiz „Parabel 2. Ordnung“.], height: 50mm)])
#note([Fehler vermeiden – Vorzeichenfehler in deiner Mitschrift (Skript TM1 S. 226)], [Bei den Lagerreaktionen steht „$B=- frac(q dot L, 2)$“. Richtig ist $B=+ frac(1, 2) q_0 l$ (nach oben, Folie 22). Später in deiner Rechnung ($Q(l)=- frac(q l, 2) =-B$) stimmt es wieder.], fill: sand)
#heading(level: 4, outlined: false)[Beispiel 4: Zahlenbeispiel mit N, Q, M (Folien 25–26)]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k7_bsp4", [Skript TM1 S. 229 (obere Folie 25): $K_1 =150$ kN waagerecht an einem Hebel $l/2$ unter der Achse bei $x=l$, $K_2 =300$ kN unter 60° bei $2l$, $K_3 =100$ kN bei $3","5l$; $l=3$ m.], height: 50mm)],
 [#bild("tm1k7_bsp4_verlauf", [Skript TM1 S. 229 (untere Folie 26): N-, Q- und M-Verlauf. Der Hebel von $K_1$ erzeugt ein Moment und damit einen Sprung in der M-Linie.], height: 50mm)])
#note([Beispiel 4 nachgerechnet], [(Folie gibt nur die Lösungsskizze):
+ Zerlegen: $K_(2,V)=300 sin 60 degree=259","81$ kN (nach unten), $K_(2,H)=300 cos 60 degree=150$ kN (nach rechts). $K_1$ (150 kN nach links) wirkt $l/2=1","5$ m unter der Achse → Moment $150 dot 1","5=225$ kNm im Uhrzeigersinn bei $x=3$ m.
+ Lager: $A_x -150+150=0 => A_x =0$. $sum M_((A))$: $9B=225+259","81 dot 6+100 dot 10","5 => B=314","87$ kN; $A=259","81+100-314","87=44","94$ kN.
+ $N$: 0 bis $x=l$; zwischen $l$ und $2l$: $N=+150$ kN (Zug); danach 0.
+ $Q$: $44","94$ kN bis $2l$; $44","94-259","81=-214","87$ kN bis $3l$; $+100$ kN auf dem Kragarm.
+ $M$: $M(l^(-))=44","94 dot 3=134","8$ kNm; Sprung um $+225$ (Uhrzeigersinn) auf $359","8$ kNm; $M(2l)=359","8+44","94 dot 3=494","6$ kNm; $M(3l)=494","6-214","87 dot 3=-150$ kNm; Kragende: $-150+100 dot 1","5=0$ ✓.
Die Werte stimmen mit der Folie überein (Rundung in der 2. Nachkommastelle).], fill: pale)
#note([Eigenes Beispiel – Lagerregal-Boden], [#text(fill: muted)[(eigene Ergänzung)]: Ein Regalboden (Einfeldbalken, $l=4$ m) trägt Kartons als Gleichstreckenlast $q_0 =2$ kN/m und eine Palette als Einzellast $F=6$ kN bei $x=1$ m. Wo muss der Boden am stärksten sein?
+ $sum M_((B))$: $4A=2 dot 4 dot 2+6 dot 3=34 => A=8","5$ kN; $B=8+6-8","5=5","5$ kN.
+ $Q(0)=8","5$ kN; $Q(1^(-))=8","5-2 dot 1=6","5$ kN; Sprung um $-6$: $Q(1^(+))=0","5$ kN; $Q(4)=0","5-2 dot 3=-5","5$ kN $=-B$ ✓.
+ $Q=0$ bei $x=1+ frac(0","5, 2) =1","25$ m → dort $M_(max)=8","5 dot 1","25-6 dot 0","25-2 dot frac(1","25^2, 2) =7","56$ kNm. Kontrolle von rechts: $5","5 dot 2","75-2 dot frac(2","75^2, 2) =7","56$ kNm ✓.
Praxis: Das maximale Moment liegt fast unter der Palette, nicht in der Mitte. Wer Paletten verschiebt, verschiebt die kritische Stelle – Thema der Kranbrücke in Übung 11.3.], fill: pale)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Nicht genau an der Kraft schneiden:] An Kraftangriffsstellen springen $N$ und $Q$; deshalb dort keinen Schnitt legen, sondern im Bereich zwischen den Kräften. #text(fill: muted)[\[TM1-Buch S. 173\]]
- #strong[Seite wählen:] Man verwendet zweckmäßig den Balkenteil, an dem #strong[weniger Lasten] angreifen. #text(fill: muted)[\[TM1-Buch S. 175\]]
- #strong[Beispiel 7.1] (drei Einzelkräfte, $A= frac(3, 2) F$, $B= frac(1, 2) F$) = deine Übung 9.2; Kontrolle am rechten Rand: $Q$ springt durch $B$ auf null, $M=0$. #text(fill: muted)[\[TM1-Buch S. 175–177\]]
- #strong[Eingeprägtes Moment:] Sein Angriffspunkt geht nicht in die Lagerreaktionen ein, wohl aber in den Momentenverlauf (Sprung der Größe $M_0$, gleiche Steigung links und rechts). #text(fill: muted)[\[TM1-Buch S. 180\]]])
#src[Skript TM1 S. 214–229 (Folien 6–26) mit deiner Mitschrift S. 219–221 und 226–227; FS TM1 S. 37; Übung 9 (Aufg. 9.2–9.4); TM1-Buch S. 173–180, 185.]
=== 7.2.2 Zusammenhang zwischen Belastung und Schnittgrößen <a-tm1-7-2-2>
Aus 7.2.1 kennst du schon $frac(d M, d x) =Q$ für Einzellasten. Jetzt betrachtest du ein Balkenstück mit stetiger Streckenlast $q(x)$ (definiert von $x=a$ bis $x=b$) und schneidest daraus ein winziges Element der Länge $d x$ heraus. Links wirken $Q, M$ (negatives Ufer des Elements), rechts $Q+d Q, med M+d M$ (positives Ufer), oben die Last $q thin d x$.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k7_balkenstueck", [Skript TM1 S. 230 (obere Folie 27): Balkenstück mit Streckenlast $q(x)$ zwischen $a$ und $b$; an den Enden können $Q_A, M_A, Q_B, M_B != 0$ wirken (Tafelskizze).], height: 50mm)],
 [#bild("tm1k7_element", [Skript TM1 S. 230 (untere Folie 28): Gleichgewicht am differentiellen Balkenstück $d x$.], height: 50mm)])
#form[$ sum F_z =0 colon med -Q+q thin d x+Q+d Q=0 med => med frac(d Q, d x) =-q(x) $


$ sum M_((S))=0 colon med -M-Q thin d x+q frac((d x)^2, 2) +M+d M=0 med => med frac(d M, d x) =Q(x) $]
Folie 28. Das Glied $q frac((d x)^2, 2)$ ist „von höherer Ordnung“ klein und fällt für $d x -> 0$ weg.
#form[$ #box(stroke: 0.6pt, inset: 3pt, $ frac(d Q(x), d x) =-q(x) wide frac(d M(x), d x) =Q(x)$) wide => wide frac(d^2 M, d x^2) =-q(x) $]
Folie 29, FS TM1 S. 37 Gl. (7.4) ★; die zweite Ableitung steht im Buch (7.8). $q$ in N/m, $Q$ in N, $M$ in Nm.
#note([In eigenen Worten], [Denk an einen Lagerbestand. $M$ ist der Bestand, $Q$ der Nettozufluss pro Tag, $q$ sagt, wie schnell der Zufluss abnimmt. Ist der Zufluss $Q$ positiv, steigt der Bestand; bei $Q=0$ ist der Bestand am höchsten (Maximum); ist $Q$ negativ, sinkt er. Eine konstante Last $q$ lässt den Zufluss gleichmäßig sinken – der Bestand verläuft dann als Parabel. #text(fill: muted)[(eigene Ergänzung)]])
#heading(level: 4, outlined: false)[Folgerungen]
- Sonderfall 7.2.1 ($q=0$, nur Einzellasten): $frac(d Q, d x) =0$ → $Q$ abschnittsweise #strong[konstant]\; $frac(d M, d x) =$konst. → $M$ #strong[linear] (Folie 29).
- $Q$ ist die #strong[Steigung] der M-Linie; $-q$ ist die Steigung der Q-Linie.
- #strong[Flächenregel:] Integriert man $M'=Q$ von $x_1$ bis $x_2$, folgt $M(x_2 )-M(x_1 )= integral_(x_1)^(x_2)Q thin d x$ = Fläche unter der Q-Linie (ohne Einzelmomente dazwischen). Ebenso $Q(x_2 )-Q(x_1 )=-$(Lastfläche) ohne Einzelkräfte dazwischen. Schnelle Kontrolle für Skizzen! #text(fill: muted)[(eigene Ergänzung)]
#tab(columns: 3,
 th([$q(x)$], [$Q(x)$], [$M(x)$]),
 [0], [konstant], [linear ($x$)],
 [konstant], [linear ($x$)], [quadratische Parabel ($x^2$)],
 [linear ($x$)], [quadratische Parabel ($x^2$)], [kubische Parabel ($x^3$)],
)
Tabelle: Skript TM1 S. 232 (obere Folie 31), FS TM1 S. 38, TM1-Buch Tab. 7.1. Merkregel: jede Stufe von $q$ über $Q$ zu $M$ erhöht den Grad um 1.
#note([Merke – Extremwerte (Folie 31–32, FS TM1 S. 38 Gl. 7.6/7.7) ★], [- #strong[Ort:] $frac(d M, d x) =Q(x)=0$ bzw. $frac(d Q, d x) =-q(x)=0$, nach $x$ auflösen.
- #strong[Wert:] diesen Ort in $M(x)$ bzw. $Q(x)$ einsetzen → $M_(max / min)$, $Q_(max / min)$.
- Rechnerische Suche lohnt sich nur bei quadratischen und höheren Gliedern; bei linearen Verläufen liest du das Extremum aus der Skizze ab (am Feldrand).])
#note([Fehler vermeiden], [„$M_(max)$ liegt immer bei $Q=0$“ – nur für lokale Extrema in einem Feld! Das #strong[absolute] Maximum kann auch an einem Balken- oder Feldende liegen, wo $Q$ oder $M$ springt, z. B. an der Einspannung eines Kragarms (dort $Q != 0$) #text(fill: muted)[\[TM1-Buch S. 182\]]. Also immer auch die Randwerte vergleichen und auf den #strong[Betrag] achten.], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Herleitung im Buch:] Die Last auf dem Element wird durch eine Einzelkraft $d F=q thin d x$ ersetzt; „die Änderung der Querkraft ist durch die negative Streckenlast gegeben“. #text(fill: muted)[\[TM1-Buch S. 181\]]
- #strong[Zweite Ableitung] $M''=-q$ (7.8); die Beziehungen dienen zur qualitativen Bestimmung von Verläufen und für Kontrollen. #text(fill: muted)[\[TM1-Buch S. 182\]]])
#src[Skript TM1 S. 230–232 (Folien 27–31); FS TM1 S. 37–38; TM1-Buch S. 181–182.]
=== 7.2.3 Integration und Randbedingungen (RB) beim Einfeldbalken <a-tm1-7-2-3>
Statt zu schneiden, kannst du die beiden Differentialbeziehungen einfach #strong[integrieren]. Du bekommst die Verläufe direkt aus $q(x)$ – mit zwei unbekannten Konstanten, die du aus dem Wissen an den Rändern (Lager, freies Ende) bestimmst. Ein Einfeldbalken heißt hier: $q(x)$ stetig von $x=0$ bis $x=l$, Lager nur bei $x=0$ und/oder $x=l$.
#form[$ Q(x)=- integral q(x) thin d x+C_1, wide M(x)= integral Q(x) thin d x+C_2 $]
Folie 30, FS TM1 S. 37 Gl. (7.5). $C_1$ hat die Einheit einer Kraft (N), $C_2$ die eines Moments (Nm).
#heading(level: 4, outlined: false)[Randbedingungen ★]
#bild("tm1k7_fs_rb", [FS TM1 S. 38: Welche Schnittgröße ist am Lager null? Nur die roten „= 0“ sind als RB verwendbar.], height: 45mm)
#tab(columns: 4,
 th([Lager bzw. Rand], [$Q(x_("RB"))$], [$M(x_("RB"))$], [Merkhilfe #text(fill: muted)[(eigene Ergänzung)]]),
 [Fest-/Loslager (gelenkig)], [$!= 0$], [#strong[\= 0]], [Gelenk dreht frei → kein Moment],
 [Parallelführung], [#strong[\= 0]], [$!= 0$], [quer verschieblich → keine Querkraft],
 [Schiebehülse], [$!= 0$], [$!= 0$], [keine RB für $Q$, $M$],
 [feste Einspannung], [$!= 0$], [$!= 0$], [keine RB für $Q$, $M$],
 [freies Ende], [#strong[\= 0]], [#strong[\= 0]], [nichts hält → beide null],
)
- Nur „= 0“ ist als RB verwendbar; „$!= 0$“ heißt nur „unbekannt“ (Folie 32).
- Ort der RB (meist $x=0$ und/oder $x=l$) einsetzen → 2 Gleichungen für $C_1, C_2$. Statisch bestimmte Lagerung: #strong[genau 2 RB].
- Greift am Ort der RB eine äußere Kraft oder ein Moment an (z. B. $F$ am freien Ende), schneidest du unmittelbar daneben und machst lokales Gleichgewicht: dann gilt z. B. $Q=F$ bzw. $M=-M_0$ statt null (FS TM1 S. 39; „nicht alle Fälle abgedeckt!“).
#heading(level: 4, outlined: false)[Lagerreaktionen als Nebenprodukt]
Die Lagerreaktionen fallen bei der Integration nebenbei ab. Normales Gleichgewicht ist nicht nötig, aber als #strong[Kontrolle] möglich. Du schneidest unmittelbar neben dem Lager ($Delta x -> 0$, also $q thin Delta x=0$ und alle Hebelarme = 0) und machst lokales Gleichgewicht, z. B. $A=Q(0)$, $B=-Q(l)$, $M_A$ aus $M(0)$.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k7_lager_lokal", [Skript TM1 S. 233 (obere Folie 33): Lagerreaktionen einer Einspannung aus $Q(0)$, $M(0)$ per lokalem Gleichgewicht (Tafelskizze).], height: 50mm)],
 [#bild("tm1k7_bsp3_lager", [Skript TM1 S. 235 (obere Folie 37): $A=Q(x=0)$ und $B=-Q(x=l)$ für Beispiel 3.], height: 50mm)])
#note([Beispiel 3 per Integration (Folien 34–37), Vorgehen nach FS TM1 S. 40], [Einfeldbalken, $q(x)=q_0$.
+ #strong[Integration:] $Q(x)=-q_0 x+C_1$; $M(x)=- frac(1, 2) q_0 x^2 +C_1 x+C_2$.
+ #strong[RB:] RB1 $M(0)=0$ (Festlager) $=> C_2 =0$; RB2 $M(l)=0$ (Loslager) $=> - frac(1, 2) q_0 l^2 +C_1 l=0 => C_1 = frac(q_0 l, 2)$.
+ #strong[Einsetzen:] $Q(x)=q_0 l[ frac(1, 2) - frac(x, l) ]$, $M(x)= frac(q_0 l^2, 2) [ frac(x, l) - frac(x^2, l^2) ]$ – identisch mit dem Schnittverfahren.
+ #strong[Extremwerte:] $Q$ linear → aus der Skizze: $Q_(max)= frac(q_0 l, 2)$ bei $x=0$, $Q_(min)=- frac(q_0 l, 2)$ bei $x=l$. $M$ quadratisch → $Q=0 => x= frac(l, 2)$, $M_(max)= frac(q_0 l^2, 8)$.
+ #strong[Skizze] (wie Folie 24).
+ #strong[Lagerreaktionen:] $-A+Q(0)=0 => A= frac(q_0 l, 2)$; $-B-Q(l)=0 => B= frac(q_0 l, 2)$ ✓.], fill: pale)
#note([Eigenes Beispiel – Kragarm mit Gleichstreckenlast], [#text(fill: muted)[(eigene Ergänzung)]: Ein Vordach (Kragarm, links eingespannt, $l=3$ m) trägt Schnee $q_0 =2$ kN/m.
+ $Q=-q_0 x+C_1$, $M=- frac(1, 2) q_0 x^2 +C_1 x+C_2$.
+ Freies Ende $x=l$: $Q(l)=0 => C_1 =q_0 l=6$ kN; $M(l)=0 => - frac(1, 2) q_0 l^2 +q_0 l^2 +C_2 =0 => C_2 =- frac(1, 2) q_0 l^2 =-9$ kNm.
+ $Q(x)=q_0 (l-x)$, $M(x)=- frac(q_0, 2) (l-x)^2$. An der Einspannung: $Q(0)=6$ kN, $M(0)=-9$ kNm (größter Betrag, Zug oben). Hier ist $Q != 0$ am Ort von $|M|_(max)$ – das Maximum liegt am Rand!], fill: pale)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[RB-Tabelle (7.11)] mit gelenkigem Lager, Parallelführung, Schiebehülse, Einspannung, freiem Ende – gleiche Aussage wie FS TM1 S. 38. #text(fill: muted)[\[TM1-Buch S. 183\]]
- #strong[Gleiche Last, drei Lagerungen] (beidseitig gelenkig, Einspannung rechts/links): andere RB → andere $C_1, C_2$ → ganz andere Verläufe; Lagerreaktionen werden an $Q$ und $M$ am Rand abgelesen. #text(fill: muted)[\[TM1-Buch S. 184–185\]]
- #strong[Dreieckslast am Kragträger] (Bsp. 7.4): Mit $x$ nach links wird $q=q_0 x/l$ einfacher, aber $Q$ wechselt das Vorzeichen. #text(fill: muted)[\[TM1-Buch S. 186–187\]]])
#src[Skript TM1 S. 231–235 (Folien 30–38, Folie 38 leer); FS TM1 S. 37–40; Übung 10 (Aufg. 10.1, 10.2); TM1-Buch S. 183–187.]

=== 7.2.4 Übergangsbedingungen (ÜB) bei mehreren Feldern <a-tm1-7-2-4>
Bisher war $q(x)$ über den ganzen Balken #strong[eine] Formel, und zwei Randbedingungen reichten. Sobald der Balken mehrere Felder hat, bekommt #strong[jedes Feld] seine eigenen Funktionen $Q(x)$ und $M(x)$ mit je zwei Konstanten. Die zusätzlichen Gleichungen liefern die #strong[Übergangsbedingungen]: Sie sagen, wie $Q$ und $M$ an einer Feldgrenze vom einen Feld ins nächste „weitergereicht“ werden.
#note([In eigenen Worten], [Stell dir einen Staffellauf vor. Jedes Feld ist ein Läufer mit eigener Strecke. An der Übergabe muss der Stab (also $Q$ und $M$) sauber weitergegeben werden. Liegt an der Übergabe eine Einzelkraft, „springt“ $Q$ um genau diese Kraft; sonst wird der Wert unverändert übergeben. #text(fill: muted)[(eigene Ergänzung)]])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k7_ueb_felder", [Skript TM1 S. 236 (obere Folie 39): Felder entstehen durch a) bereichsweise definierte Streckenlast und b) Einzelkräfte/-momente einschließlich Lagerreaktionen.], height: 50mm)],
 [#bild("tm1k7_ueb_mehrteilig", [Skript TM1 S. 236 (untere Folie 40): c) Mehrteiligkeit (Gelenk). In jedem Feld gelten die Integrale aus 7.2.2; Anzahl der Konstanten = Felder · 2.], height: 50mm)])
Felder entstehen durch drei Arten von Unstetigkeit (Folie 39–40):
- a) Streckenlast nur #strong[bereichsweise] definiert (auch $q=0$ ist ein „Bereich“!),
- b) #strong[Einzelkräfte und Einzelmomente], auch Lagerreaktionen in der Balkenmitte,
- c) #strong[Mehrteiligkeit] des Balkens, also Gelenke oder Querkraftgelenke.
#form[$ Q_i (x) = - integral q_i (x) thin d x + C_i, wide M_i (x) = integral Q_i (x) thin d x + C_j $
$ sum "ÜB" + sum "RB" = 2 dot "Anzahl der Felder" $]
FS TM1 S. 40 Gl. (7.8)–(7.10). Die ÜB werden immer zwischen #strong[Ende Feld $i$] und #strong[Anfang Feld $i+1$] angesetzt. Dazu schneidest du unmittelbar vor und nach der Übergangsstelle ($Delta x -> 0$, Hebelarme und $q thin Delta x$ werden null) und machst lokales Gleichgewicht.
#heading(level: 4, outlined: false)[Die Übergangsbedingungen im Überblick ★]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k7_ueb_fall_a", [Skript TM1 S. 237 (obere Folie 41): Zählregel $sum "ÜB" + sum "RB" = 2 dot$Felder und Fall a): $q(x)$ bereichsweise, Balken durchgehend.], height: 50mm)],
 [#bild("tm1k7_ueb_fall_b", [Skript TM1 S. 237 (untere Folie 42): Fall b) Einzelkraft und Einzelmoment am durchgehenden Balken.], height: 50mm)])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k7_ueb_fall_b2", [Skript TM1 S. 238 (obere Folie 43): Fall b) Lagerreaktionen als Einzelkraft (Fest-/Loslager) bzw. Einzelmoment (Momentstütze); ihre Größe ist beim reinen Integrationsverfahren unbekannt.], height: 50mm)],
 [#bild("tm1k7_ueb_fall_c", [Skript TM1 S. 238 (untere Folie 44): Fall c) mehrteiliger Balken: Gelenk und Parallelführung (Querkraftgelenk).], height: 50mm)])
#tab(columns: 4,
 th([Übergangsstelle], [$Q$], [$M$], [Wie viele ÜB?]),
 [a) Streckenlast beginnt/endet], [$Q_"II" = Q_I$ (Knick)], [$M_"II" = M_I$], [2],
 [b) Einzelkraft $F$], [$Q_"II" = Q_I - F$ (Sprung)], [$M_"II" = M_I$ (Knick)], [2],
 [b) Einzelmoment $M_0$], [$Q_"II" = Q_I$], [$M_"II" = M_I - M_0$ (Sprung)], [2],
 [b) Fest-/Loslager], [$Q_"II" = Q_I - ?$ (unbekannt)], [$M_"II" = M_I$], [1],
 [b) Momentstütze], [$Q_"II" = Q_I$], [$M_"II" = M_I - ?$ (unbekannt)], [1],
 [c) Gelenk], [$Q_"II" = Q_I$], [$M_I = M_"II" = 0$], [3],
 [c) Parallelführung], [$Q_I = Q_"II" = 0$], [$M_"II" = M_I$], [3],
)
Folien 41–44, FS TM1 S. 41–42. Die Vorzeichen bei $F$ und $M_0$ gelten für die Pfeilrichtung in der Folienskizze ($F$ nach unten). Die Spalte „Wie viele ÜB?“ ist #text(fill: muted)[(eigene Ergänzung)], abgeleitet aus Beispiel 1 der Folien.
#note([Merke ★], [- An einem #strong[Lager] in der Balkenmitte ist die Lagerkraft beim reinen Integrieren unbekannt. Dort gibt es also für $Q$ #strong[keine] ÜB, nur $M_"II" = M_I$.
- An einem #strong[Gelenk] ist $M = 0$ auf beiden Seiten. Das sind zwei Gleichungen, dazu kommt $Q_"II" = Q_I$ (bzw. $Q_I - F$, wenn eine Kraft am Gelenk angreift).
- Hast du die Lagerreaktionen vorab mit dem normalen Gleichgewicht berechnet, kannst du sie als #strong[zusätzliche, überzählige ÜB] verwenden, z. B. als Kontrolle (Folie 43).])
#heading(level: 4, outlined: false)[Kombination der Fälle (Folien 45–46)]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k7_ueb_kombi", [Skript TM1 S. 239 (obere Folie 45): Balken $2l$ mit $q_0$ auf der ersten Hälfte und $F$ bei $x=l$. RB: $M(0)=0$, $M(2l)=0$ (FS S. 38).], height: 50mm)],
 [#bild("tm1k7_ueb_kombi2", [Skript TM1 S. 239 (untere Folie 46): oben das lokale Gleichgewicht an der ÜB-Stelle; unten Fall a)+b)+c): Einspannung, Gelenk mit $F$ bei $l$, $q_0$ im Feld II.], height: 50mm)])
Folie 46 zeigt zwei Fälle zum Selberrechnen:
- #strong[Fall a)+b)] (Folie 45): RB ① $M(0)=0$, ② $M(2l)=0$; ÜB ③ $Q_"II"(l) = Q_I (l) - F$, ④ $M_"II"(l) = M_I (l)$. Vier Gleichungen für vier Konstanten.
- #strong[Fall a)+b)+c)] (Folie 46): Einspannung links, Gelenk mit $F$ bei $x=l$, Loslager rechts. RB ① $M(2l)=0$; ÜB ② $M_I (l)=0$, ③ $M_"II"(l)=0$, ④ $Q_"II"(l) = Q_I (l) - F$. An der Einspannung gibt es keine RB.
#heading(level: 4, outlined: false)[Beispiel aus deiner Mitschrift (Skript TM1 S. 241–245)]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k7_mit_ueb_lager", [Deine Mitschrift (Skript TM1 S. 241): Aufgabenstellung (Balken $2L$, $q_0$ auf $[0; L]$, $F$ bei $L$) und Freikörperbild mit Feldern I und II.], height: 62mm)],
 [#bild("tm1k7_mit_ueb_int", [Deine Mitschrift (Skript TM1 S. 242): Integration in beiden Feldern, RB aus der Formelsammlung S. 38 und Skizze der ÜB-Stelle.], height: 95mm)])
#note([Beispiel – Balken mit $q_0$ und $F$ (deine Mitschrift)], [Geg.: $q_0, L, F$. Festlager $A$ bei $x=0$, Loslager $B$ bei $x=2L$.
+ #strong[Integration:] Feld I: $Q_I = -q_0 x + C_1$, $M_I = -q_0 frac(x^2, 2) + C_1 x + C_2$. Feld II ($q=0$): $Q_"II" = C_3$, $M_"II" = C_3 x + C_4$.
+ #strong[RB:] ① $M_I (0) = 0 => C_2 = 0$; ② $M_"II"(2L) = 0 => 2L C_3 + C_4 = 0$.
+ #strong[ÜB:] ③ $M_"II"(L) = M_I (L) => C_3 L + C_4 = -q_0 frac(L^2, 2) + C_1 L$; ④ $Q_"II"(L) = Q_I (L) - F => C_3 = -q_0 L + C_1 - F$.
+ #strong[Lösen:] $C_1 = frac(3, 4) q_0 L + frac(F, 2)$, $C_3 = -(frac(F, 2) + frac(q_0 L, 4))$, $C_4 = F L + frac(q_0 L^2, 2)$.
+ #strong[Ergebnis:] $Q_I = -q_0 x + frac(F, 2) + frac(3, 4) q_0 L$; $M_I = -q_0 frac(x^2, 2) + (frac(F, 2) + frac(3, 4) q_0 L) x$; $Q_"II" = -(frac(F, 2) + frac(q_0 L, 4))$; $M_"II" = -(frac(F, 2) + frac(q_0 L, 4)) x + F L + frac(q_0 L^2, 2)$.
+ #strong[Lager] aus lokalem GGW: $A_z = Q_I (0) = frac(F, 2) + frac(3, 4) q_0 L$; $B = -Q_"II"(2L) = frac(F, 2) + frac(q_0 L, 4)$.
+ #strong[Werte:] $M_I (L) = M_"II"(L) = frac(q_0 L^2, 4) + frac(F L, 2)$; $M(2L) = 0$ ✓.], fill: pale)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k7_mit_ueb_rb", [Deine Mitschrift (Skript TM1 S. 243): ÜB aus lokalem GGW und Gleichungen ①–④.], height: 62mm)],
 [#bild("tm1k7_mit_ueb_c", [Deine Mitschrift (Skript TM1 S. 244): Lösung des Gleichungssystems, Ergebnis und Lagerreaktionen.], height: 95mm)])
#bild("tm1k7_mit_ueb_skizze", [Deine Mitschrift (Skript TM1 S. 245): Skizze von $Q$ und $M$.], height: 95mm)
#note([Achtung – Annahme in deiner Skizze (S. 245)], [Dort steht $Q_I (L) = -frac(q L, 4) + frac(F, 2) > 0$. Das stimmt nur, wenn $F > frac(q_0 L, 2)$ ist. Dann liegt das größte Moment unter der Kraft bei $x = L$. Ist $F < frac(q_0 L, 2)$, wird $Q_I$ schon vorher null, und $M_(max)$ liegt bei $x = frac(3, 4) L + frac(F, 2 q_0) < L$. #text(fill: muted)[(eigene Ergänzung)]], fill: sand)
#heading(level: 4, outlined: false)[Allgemeines Vorgehen ★]
#note([Rezept für mehrere Felder (FS TM1 S. 40–41)], [0) Lager- und Gelenkreaktionen bestimmen (wenn gewünscht).
- a) Balken in $n$ Felder einteilen.
- b) $q(x)$ für jedes Feld integrieren.
- c) RB und ÜB aufstellen.
- d) RB und ÜB nach den Konstanten $C_1 dots C_m$ auflösen.
- e) $C_1 dots C_m$ einsetzen.
- f) Lager- und Gelenkreaktionen durch Schnitt und örtliches GGW aus $Q(x)$ und $M(x)$ bestimmen.
- g) Werte an markanten Stellen berechnen.
- h) Plausibilitätskontrolle.])
#heading(level: 4, outlined: false)[Beispiel 1: Gelenkbalken mit Streckenlast $q_0$ und Einzelkraft $F$ (Folien 49–60)]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k7_gb1", [Skript TM1 S. 246 (obere Folie 49): Gelenkbalken $A$–$G$–$B$–$C$; $q_0$ auf Feld I (Länge $l$), $F$ am Gelenk $G$, Felder I ($l$), II ($l/2$), III ($l$).], height: 50mm)],
 [#bild("tm1k7_gb1_rbueb", [Skript TM1 S. 247 (obere Folie 51): RB ①, ② und ÜB ③–⑥ mit Skizzen am Gelenk und am Lager $B$.], height: 50mm)])
Drei Felder → sechs Konstanten. RB: ① $M_I (0) = 0$, ② $M_"III"(frac(5, 2) l) = 0$. ÜB: ③ $M_I (l) = 0$, ④ $M_"II"(l) = 0$, ⑤ $Q_"II"(l) = Q_I (l) - F$, ⑥ $M_"III"(frac(3, 2) l) = M_"II"(frac(3, 2) l)$. Die Gleichung $Q_"III" = Q_"II" + B$ ist #strong[keine] ÜB, weil $B$ unbekannt ist.
#note([Ergebnisse (Folien 49–60)], [- $Q_I = -q_0 x + frac(q_0 l, 2)$, $M_I = -frac(q_0 x^2, 2) + frac(q_0 l, 2) x$.
- $Q_"II" = -frac(q_0 l, 2) - F$; $Q_"III" = frac(q_0 l, 4) + frac(F, 2)$.
- Lager und Gelenk: $A = frac(q_0 l, 2)$, $B = frac(3, 4) q_0 l + frac(3, 2) F$, $C = -frac(1, 4) q_0 l - frac(1, 2) F$, $G = -frac(1, 2) q_0 l - F$ (Wahl: $F$ wirkt links von $G$).
- $M_(I,max) = frac(q_0 l^2, 8)$ bei $x = frac(l, 2)$; $M(frac(3, 2) l) = -frac(1, 4) q_0 l^2 - frac(1, 2) F l$ (über $B$, größter Betrag).
- $M = 0$ bei $x = 0$, $x = l$ (Gelenk) und $x = frac(5, 2) l$.], fill: pale)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k7_gb1_lager", [Skript TM1 S. 249 (untere Folie 56): Lagerkräfte aus lokalem GGW: $A = Q(0)$, $B = Q_"III" - Q_"II"$ bei $3l/2$, $C = -Q_"III"(5l/2)$.], height: 50mm)],
 [#bild("tm1k7_gb1_gelenk", [Skript TM1 S. 250 (obere Folie 57): Gelenkkraft $G$; $F$ wird dem linken Teil zugeschlagen.], height: 50mm)])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k7_gb1_werte", [Skript TM1 S. 250 (untere Folie 58): Werte an markanten Stellen und $M_(I,max)$.], height: 50mm)],
 [#bild("tm1k7_gb1_verlauf", [Skript TM1 S. 251 (obere Folie 59): $Q$- und $M$-Verlauf zu Beispiel 1 mit Kontrollpunkten ①–⑥.], height: 50mm)])
#note([Plausibilitätskontrolle], [$Q$ springt an $A$, $G$ ($-F$), $B$ ($+B$) und $C$ genau um die jeweilige Kraft. $M$ ist an $A$, $G$ und $C$ null. In Feld I mit $q_0$ ist $M$ eine Parabel, in II und III ohne Last eine Gerade. Die Steigung von $M$ ist überall gleich $Q$.])
#heading(level: 4, outlined: false)[Beispiel 2: $q_0$ stetig über das Gelenk (Folien 61–68)]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k7_gb2", [Skript TM1 S. 252 (untere Folie 62): Gelenkbalken aus Beispiel 1, jetzt $q_0$ stetig über das Gelenk bis $B$, ohne $F$. Lokale Koordinaten $x_1$ (Feld I) und $x_2$ (Feld II).], height: 50mm)],
 [#bild("tm1k7_gb2_verlauf", [Skript TM1 S. 255 (untere Folie 68): $Q$- und $M$-Verlauf zu Beispiel 2 mit $A$, $B$, $C$ und $M_(max)$.], height: 50mm)])
#note([Merke – Abkürzung bei Gelenken (Folie 61, FS TM1 S. 41 Gl. 7.11) ★], [Ist $q(x)$ #strong[stetig über das Gelenk] und greift dort #strong[keine Einzelkraft] an, brauchst du am Gelenk #strong[keine Feldgrenze]. Du nutzt dann nur die besondere ÜB $M(x_G) = 0$ (bzw. $Q(x_G) = 0$ bei einer Parallelführung). Zweiter Trick: Lass $x$ #strong[bereichsweise] laufen (lokale Koordinaten $x_1, x_2$). Dann werden RB und ÜB einfacher.])
Ergebnisse (Folien 62–68): $A = frac(q_0 l, 2)$, $B = frac(11, 8) q_0 l$, $C = -frac(3, 8) q_0 l$; $M_(I,max) = frac(q_0 l^2, 8)$; $M(frac(3, 2) l) = -frac(3, 8) q_0 l^2$ über $B$. Kontrolle: $A + B + C = frac(3, 2) q_0 l$ = Gesamtlast ✓.
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Tabelle 7.2] fasst die Übergangsbedingungen zusammen; Gl. (7.17) gibt die besonderen Bedingungen an Gelenk ($M = 0$) und Parallelführung ($Q = 0$). #text(fill: muted)[\[TM1-Buch S. 187–190\]]
- #strong[Beispiel 7.6] ist genau Beispiel 2 der Folien (Gerberträger, $q_0$ über das Gelenk): Das Buch erhält ebenfalls $C = -frac(3, 8) q_0 l$ und prüft, dass die Summe der Lagerkräfte der Gesamtlast $frac(3, 2) q_0 l$ das Gleichgewicht hält. #text(fill: muted)[\[TM1-Buch S. 192–193\]]])
#src[Skript TM1 S. 236–255 (Folien 39–68) mit deiner Mitschrift S. 241–245; FS TM1 S. 40–42; Übung 11 (11.1, 11.2), Übung 12 (12.1); TM1-Buch S. 187–193.]

=== 7.2.5 Föppl-Symbol #sym.chevron.l #sym.chevron.r <a-tm1-7-2-5>
#bild("tm1k7_vielefelder", [Skript TM1 S. 256 (untere Folie 70): Balken mit fünf Feldern ($F$, $q_0$, $M_0$). Die Integration nach 7.2.2–7.2.4 wird hier sehr aufwendig.], height: 45mm)
Bei vielen Feldern hast du viele ÜB und viele Konstanten. Das #strong[Föppl-Symbol] schreibt eine bereichsweise definierte Belastung als #strong[eine] Formel. Dann integrierst du in einem Zug über den ganzen Balken, und alle ÜB sind automatisch erfüllt. Du brauchst nur noch die 2 RB.
#form[$ chevron.l x - a chevron.r^n = cases(0 & "für" x < a, (x - a)^n & "für" x > a), wide chevron.l x - a chevron.r^0 = cases(0 & "für" x < a, 1 & "für" x > a) $
$ frac(d, d x) chevron.l x - a chevron.r^n = n chevron.l x - a chevron.r^(n-1), wide integral chevron.l x - a chevron.r^n thin d x = frac(1, n+1) chevron.l x - a chevron.r^(n+1) + C $]
Folie 72, FS TM1 S. 43 Gl. (7.12)–(7.14). Das Symbol ist ein „Schalter“: links von $a$ ist es aus (0), rechts davon wie eine normale Klammer.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k7_foeppl_def", [Skript TM1 S. 257 (untere Folie 72): Definition des Föppl-Symbols und Rechenregeln.], height: 50mm)],
 [#bild("tm1k7_foeppl_bsp", [Skript TM1 S. 258 (obere Folie 73): $q_0$ auf dem mittleren Drittel als Differenz zweier Lasten: $q = q_0 chevron.l x-a chevron.r^0 - q_0 chevron.l x-2a chevron.r^0$.], height: 50mm)])
#note([Beispiel zum Föppl-Symbol (Folien 73–75)], [Balken $3a$, beidseitig gelenkig, $q_0$ von $a$ bis $2a$.
+ $q(x) = q_0 chevron.l x - a chevron.r^0 - q_0 chevron.l x - 2a chevron.r^0$.
+ $Q(x) = -q_0 chevron.l x - a chevron.r^1 + q_0 chevron.l x - 2a chevron.r^1 + C_1$.
+ $M(x) = -frac(q_0, 2) chevron.l x - a chevron.r^2 + frac(q_0, 2) chevron.l x - 2a chevron.r^2 + C_1 x + C_2$.
+ RB: $M(0) = 0 => C_2 = 0$; $M(3a) = 0 => -2 q_0 a^2 + frac(1, 2) q_0 a^2 + 3a C_1 = 0 => C_1 = frac(q_0 a, 2)$.
Probe: Das ist derselbe Balken wie in deiner Mitschrift zu 7.2.6. Bei $x = frac(3, 2) a$: $M = -frac(q_0 a^2, 8) + frac(3, 4) q_0 a^2 = frac(5, 8) q_0 a^2$ ✓. #text(fill: muted)[(Probe: eigene Ergänzung)]], fill: pale)
#note([Nachteile laut Folie], [- $q(x)$ aufzustellen kann aufwendig sein (Lasten „abziehen“, damit sie wieder enden).
- Einzelkräfte und Einzelmomente stecken nicht in $q(x)$. Ihre Sprünge musst du zusätzlich in $Q$ bzw. $M$ einbauen.
- Meist einfacher: abschnittsweise schneiden (7.2.1) oder punktweise (7.2.6).], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- Im englischen Sprachraum heißt das Symbol meist nach #strong[Macaulay]. Bei Integration und Differentiation behandelt man es wie eine runde Klammer (7.18)–(7.20). #text(fill: muted)[\[TM1-Buch S. 193–194\]]
- Eine linear ab $x = a$ wachsende Last ist $q = frac(q_b, b) chevron.l x - a chevron.r^1$ (7.22). Einzelkraft und Einzelmoment: $Q = -F chevron.l x - a chevron.r^0$ (7.23) und $M = -M_0 chevron.l x - a chevron.r^0$ (7.24). #text(fill: muted)[\[TM1-Buch S. 194–195\]]
- Beispiel 7.7: Einzelmoment und Dreieckslast; die Dreieckslast endet durch Abziehen eines konstanten und eines linearen Anteils. #text(fill: muted)[\[TM1-Buch S. 195–197\]]])
#src[Skript TM1 S. 256–258 (Folien 70–75); FS TM1 S. 43; TM1-Buch S. 193–197.]

=== 7.2.6 Punktweise Ermittlung der Schnittgrößen ★ <a-tm1-7-2-6>
#note([Von dir markiert – klausurrelevant ★], [Im Inhaltsverzeichnis hast du neben 7.2.6 „→ Klausur“ notiert. Auf Folie 76 steht deine Notiz: #strong[„Für Prüfung wichtig! In der Prüfung Lager + Gelenkreaktionen bereits bestimmt. Schnittgrößen nur an markanten Stellen bestimmen.“] Neben deinem Mitschrift-Beispiel steht „Sowie Prüfungsaufgabe“.], fill: sand)
#bild("tm1k7_inhalt", [Skript TM1 S. 212 (untere Folie 2): Inhaltsverzeichnis mit deinen Markierungen: „2.6 Punktweise … → Klausur“; „4 Schnittgrößen bei räumlichen Tragwerken“ durchgestrichen.], height: 45mm)
Oft musst du gar keine Funktionen $Q(x)$, $M(x)$ aufstellen. Es reicht, die Werte an wenigen #strong[markanten Stellen] zu berechnen und dazwischen den Verlauf aus der Tabelle (Last → $Q$ → $M$) zu zeichnen.
#note([Das Verfahren (Folien 76–78, FS TM1 S. 43–44) ★], [+ a) Lager- und Gelenkreaktionen bestimmen.
- b) Schnittgrößen #strong[nur an markanten Stellen] ermitteln: Angriffspunkte äußerer Lasten und Lagerreaktionen; Anfang und Ende von Streckenlasten; Gelenke (auch wenn $q$ stetig darüber läuft); Extremwerte (siehe d).
- c) Skizze von $M$, $Q$, $N$: Werte eintragen, Verlauf dazwischen qualitativ nach der Tabelle.
- d) In Bereichen mit $q(x)$ genau rechnen: Integration oder Schnitt mit Teilresultierender; $M_(max)$ bei $Q = 0$.])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k7_punkt_vorgehen", [Skript TM1 S. 259 (untere Folie 76): Vorgehen a)–c) mit deiner roten Notiz „Für Prüfung wichtig! …“.], height: 50mm)],
 [#bild("tm1k7_punkt_tabelle", [Skript TM1 S. 260 (untere Folie 78): Tabelle für Einzelkraft, Einzelmoment und Streckenlast; deine Notiz „Formelsammlung S. 43“.], height: 50mm)])
#tab(columns: 3,
 th([Last an der Stelle], [$Q(x)$], [$M(x)$]),
 [Einzelkraft $F$], [konstant – Sprung um $-F$ – konstant], [linear – Knick – linear],
 [Einzelmoment $M$], [konstant (kein Sprung)], [linear – Sprung um $-M$ – linear],
 [Streckenlast $q(x)$ von $A$ bis $E$], [konstant – Knick bei $A$ – $integral -q thin d x$ – Knick bei $E$ – konstant], [linear – $integral Q thin d x$ – linear],
)
Tabelle: Folie 78, FS TM1 S. 44 (dein Hinweis: „Formelsammlung S. 43“). Vorzeichen für die Pfeilrichtungen der Skizze.
#heading(level: 4, outlined: false)[Deine Mitschrift: „Sowie Prüfungsaufgabe“ (Skript TM1 S. 261–263)]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k7_mit_punkt1", [Deine Mitschrift (Skript TM1 S. 261): Balken $3a$ mit $q_0$ im mittleren Drittel; Lager und Schnittgrößen bei $x = a$ und $x = 2a$.], height: 95mm)],
 [#bild("tm1k7_mit_punkt2", [Deine Mitschrift (Skript TM1 S. 262): Skizze von $Q$ und $M$ und genauer Verlauf im Bereich der Streckenlast mit lokaler Koordinate $x_2$.], height: 95mm)])
#bild("tm1k7_mit_mmax", [Deine Mitschrift (Skript TM1 S. 263): $M_(max)$ aus $Q(x_2) = 0$.], height: 40mm)
#note([Beispiel – $q_0$ im mittleren Drittel], [Geg.: $q_0, a$; Festlager $A$ bei 0, Loslager $B$ bei $3a$, $q_0$ von $a$ bis $2a$.
- a) Symmetrie: $A_x = 0$, $A_z = B_z = frac(q_0 a, 2)$.
- b) $x = a$ (vor $q_0$, linker Teil): $N = 0$, $Q = A_z = frac(q_0 a, 2)$, $M = A_z a = frac(q_0 a^2, 2)$. \
  $x = 2a$ (nach $q_0$, rechter Teil): $N = 0$, $Q = -B = -frac(q_0 a, 2)$, $M = B a = frac(q_0 a^2, 2)$.
- c) Skizze: $Q$ konstant $frac(q_0 a, 2)$, dann linear auf $-frac(q_0 a, 2)$, dann konstant. $M$ linear, Parabel, linear.
- d) Mit $x_2$ ab $x = a$: $Q(x_2) = frac(q_0 a, 2) - q_0 x_2$, $M(x_2) = frac(q_0 a, 2)(a + x_2) - frac(q_0 x_2^2, 2)$. $Q = 0$ bei $x_2 = frac(a, 2)$: #box(stroke: 0.6pt, inset: 3pt, $M_(max) = frac(5, 8) q_0 a^2$).], fill: pale)
#heading(level: 4, outlined: false)[Beispiel der Folien (Folien 79–84)]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k7_punkt_bsp", [Skript TM1 S. 264 (unten): Lagerkraft $B$ aus $sum M_((A))$ und Schnitt ① bei $x = a$ vor $F$.], height: 50mm)],
 [#bild("tm1k7_punkt_23", [Skript TM1 S. 265 (obere Folie 81): Schnitte ② bei $x = 2a$ (vor $q_0$), ③ bei $x = 4a$ (nach $q_0$) und ④ am rechten Teil.], height: 50mm)])
Balken $6a$: $F$ bei $a$, $q_0$ von $2a$ bis $4a$ (Resultierende $F_R = 2 q_0 a$ bei $3a$), Einzelmoment $M_0$ bei $5a$, Loslager $B$ bei $6a$.
#form[$ B = frac(1, 6) (F + 6 q_0 a - frac(M_0, a)), wide A_z = frac(1, 6) (5F + 6 q_0 a + frac(M_0, a)) $]
#tab(columns: 3,
 th([Stelle], [$Q$], [$M$]),
 [① $x = a$, vor $F$], [$A_z$], [$a A_z$],
 [② $x = 2a$, vor $q_0$], [$A_z - F$], [$2a A_z - a F$],
 [③ $x = 4a$, nach $q_0$], [$A_z - F - F_R$], [$4a A_z - 3a F - 2 q_0 a^2$],
 [④ rechter Teil ab $x = 4a$], [$-B$], [$M_0 + 2 B a$],
)
Probe: Setzt du $A_z$ und $B$ ein, sind ③ und ④ gleich: beide $frac(1, 6)(2 F a + 12 q_0 a^2 + 4 M_0)$ ✓ #text(fill: muted)[(eigene Ergänzung)]. Genauer Verlauf im Bereich der Streckenlast mit $x_3$ ab $x = 2a$: $Q = -q_0 x_3 + (A - F)$. $Q = 0$ bei $x_3 = frac(A - F, q_0)$, also
#form[$ M_(max) = frac((A - F)^2, 2 q_0) + (2 A a - F a) $]
#bild("tm1k7_punkt_skizze", [Skript TM1 S. 266 (obere Folie 83): Skizze zum Folienbeispiel: $Q$ mit Sprüngen an $A$, $F$, $B$; $M$ linear – quadratisch ($M_(max)$) – linear, Sprung um $M_0$.], height: 50mm)
#heading(level: 4, outlined: false)[WZF: Vom Querkraftplan zum Momentenverlauf (15.12.25 und 18.12.25)]
Im WZF (Sosnowsky) wurde dasselbe Prinzip geübt: Erst den #strong[Querkraftplan] zeichnen, dann daraus den Momentenverlauf konstruieren.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k7_qkp_voll", [WZF „Querkraftplan“ S. 9: Balken mit schräger Kraft $F$ in der Mitte ($a = L/2$); vollständiger Querkraftplan $Q = A_V$, Sprung um $F_V$, $-Q = B$.], height: 45mm)],
 [#bild("tm1k7_qkp_verlaeufe", [WZF „Querkraftplan“ S. 18: $Q$ konstant → $M$ linear; Dreieck mit $M = 0$ an beiden Lagern.], height: 45mm)])
#grid(columns: 3, gutter: 4mm,
 [#bild("tm1k7_qkp_konst", [WZF S. 15: $Q$ konstant → $M$ linear.], height: 40mm)],
 [#bild("tm1k7_qkp_steigend", [WZF S. 16: $Q$ linear steigend → $M$ nach oben offene Parabel.], height: 40mm)],
 [#bild("tm1k7_qkp_fallend", [WZF S. 17: $Q$ linear fallend → $M$ nach unten offene Parabel.], height: 40mm)])
#note([Fehler in den WZF-Folien], [- #strong[S. 15:] Dort steht „$M = frac(d Q, d x)$“. Richtig ist $Q = frac(d M, d x)$ (FS TM1 S. 37 Gl. 7.4). Den Momentenverlauf konstruierst du also aus dem Querkraftverlauf, weil $Q$ die #strong[Steigung] von $M$ ist.
- #strong[S. 17:] Die Überschrift heißt wie auf S. 16 „Q positiv linear steigend“. Gezeigt wird aber $Q$ #strong[linear fallend] (der Text sagt „entgegengesetzt zum Fall des steigenden Querkraftverlaufs“). Dann ist $M$ eine nach unten offene Parabel.], fill: sand)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k7_wzf_93", [Deine WZF-Mitschrift 18.12.25 („09 Mechanik Übung.pdf“ S. 2): abgewandelte Aufgabe 9.3 mit qualitativem Querkraft- und Momentenplan.], height: 40mm)],
 [#bild("tm1k7_wzf_71", [Deine WZF-Mitschrift 18.12.25 (S. 3): „Einschub Querkraftplan zu 7.1“ mit $F_1 = 4$ kN, $F_2 = 2$ kN, $F_3 = 3$ kN, $M_0 = 4$ kNm, $q_0 = 5$ kN/m, $a = 1$ m, $alpha = 45 degree$; Schnitte an ausgezeichneten Stellen.], height: 52mm)])
#note([Achtung – deine WZF-Mitschrift S. 2], [Bei der abgewandelten Aufgabe 9.3 sind die Gleichungen „$F_x$: $A_y - 2F + B - F = 0$“ und „$F_y$: $A_x = 0$“ vertauscht beschriftet. Die senkrechte Summe ist $sum F_y$, die waagerechte $sum F_x$. Die Ergebnisse $B = frac(2 F a + F(a+b+c), a+b)$ und $A_y = 3F - B$ stimmen.], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [„Oft ist es ausreichend, die Schnittgrößen nur an ausgezeichneten Stellen des Tragwerks zu berechnen.“ Dazwischen legt die Belastung den Verlauf fest; die Beziehungen zwischen $q$, $Q$ und $M$ beachten. #text(fill: muted)[\[TM1-Buch S. 211\]]])
#src[Skript TM1 S. 212, 259–266 (Folien 2, 76–84) mit deiner Mitschrift S. 261–263; WZF „Querkraftplan“ (15.12.25) S. 9, 15–18; WZF-Mitschrift 18.12.25 („09 Mechanik Übung.pdf“ S. 2–3); FS TM1 S. 43–44; Übung 9.3, 10.3, 10.4; TM1-Buch S. 211.]

== 7.3 Schnittgrößen bei Rahmen und Bogen <a-tm1-7-3>
Ein #strong[Rahmen] besteht aus geraden, biegesteif verbundenen Balkenstücken, die Ecken bilden. Ein #strong[Bogen] ist gekrümmt. Beide sind in der Vorlesung nur gezeigt; gerechnet wird der Rahmen. Das Problem: Ein einziges $x$-$z$-System passt nicht mehr für alle Teile. Deshalb bekommt jeder Schnitt ein #strong[örtliches] Koordinatensystem, festgelegt durch die #strong[gestrichelte Faser].
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k7_rahmen_bogen", [Skript TM1 S. 268 (obere Folie 87): Rahmen und Bogen; bisher eindeutiges KS, jetzt örtliches KS über die „gestrichelte Faser“ = „unten“ (freie Wahl).], height: 50mm)],
 [#bild("tm1k7_faser", [Skript TM1 S. 268 (untere Folie 88): Rahmen mit gestrichelter Faser; an Stütze und Riegel jeweils $N$, $Q$, $M$ am positiven (+) und negativen (−) Schnittufer.], height: 50mm)])
#note([Merke – gestrichelte Faser (Folie 88, FS TM1 S. 44–45 Gl. 7.15/7.16) ★], [- Die gestrichelte Faser markiert „unten“. Du wählst sie frei, meist innen.
- $z$ zeigt #strong[zur Faser hin], $x$ läuft #strong[parallel zur Faser], $y$ senkrecht zur Papierebene.
- Schnittufer und Ansatz von $N$, $Q$, $M$ wie beim Balken.
- #strong[Normalkraft immer mitrechnen]: An Ecken wird $N$ zu $Q$ und umgekehrt ($N <=> Q$).
- Positives $M$ zieht die Seite der gestrichelten Faser.])
#note([In eigenen Worten], [Die gestrichelte Faser ist wie ein Klebeband, das du auf die Innenseite des Rahmens klebst. Wo auch immer du schneidest, schaust du so, dass das Klebeband „unten“ liegt. Dann gelten alle Vorzeichenregeln vom Balken einfach weiter. #text(fill: muted)[(eigene Ergänzung)]])
#heading(level: 4, outlined: false)[Vorgehen beim Rahmen (Folie 89, FS TM1 S. 45)]
- a) Ecken bezeichnen ($A$, $B$, $C$, $G$ …).
- b) Abschnitte nummerieren (1, 2, 3 …).
- c) Gestrichelte Faser wählen und eintragen.
- d) Lager- und Gelenkreaktionen ermitteln: im globalen KS (H–V, besser nicht $x$-$y$-$z$), GGW an Teilkörpern, zusätzlich am „eingefrorenen“ Gesamtsystem möglich.
- e) Punktweise Ermittlung der Schnittgrößen (vor/nach jeder Ecke).
- f) Verlauf von $N$, $Q$, $M$ skizzieren.
- g) $Q(x)$, $M(x)$ in Bereichen mit Streckenlast bestimmen.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k7_rahmen_vorgehen", [Skript TM1 S. 269 (obere Folie 89): Beispielrahmen: Stütze 1 ($A$–$C$, $b = frac(3, 4) a$), Riegel 2 ($C$–$G$, $q_0 = F/a$), Schräge 3 ($G$–$B$, 45°); $F$ waagerecht bei $C$; Gelenk $G$.], height: 50mm)],
 [#bild("tm1k7_rahmen_lager", [Skript TM1 S. 269 (untere Folie 90): Freischnitt der Teilkörper und Ergebnisse der Lager- und Gelenkreaktionen (= Kapitel 5).], height: 50mm)])
#note([Beispielrahmen (Folien 89–100)], [Lager- und Gelenkreaktionen (bekannt aus Kapitel 5): $A_H = A_V = "0,286" F$; $G_H = -"0,714" F$; $G_V = B_H = B_V = "0,714" F$.
+ #strong[Ecke $C$, vor $C$ (C,1), linker Teil:] $N_(C,1) = -A_V = -"0,286" F$, $Q_(C,1) = A_H = "0,286" F$, $M_(C,1) = A_H b = "0,214" a F$.
+ #strong[Nach $C$ (C,2):] $N_(C,2) = -F + A_H = -"0,714" F$, $Q_(C,2) = A_V = "0,286" F$, $M_(C,2) = "0,214" a F$.
+ #strong[Vor $G$ (G,2), rechter Teil:] $N_(G,2) = -B_H = -"0,714" F$, $Q_(G,2) = -B_V = -"0,714" F$, $M_(G,2) = -B_H a + B_V a = 0$ (Gelenk!).
+ #strong[Nach $G$ (G,3), Schräge 45°:] $N_(G,3) = -(B_H + B_V) frac(sqrt(2), 2) = -"1,01" F$, $Q_(G,3) = (B_H - B_V) frac(sqrt(2), 2) = 0$, $M_(G,3) = 0$. Die Schräge ist ein Pendelstab: nur Druck.], fill: pale)
#grid(columns: 3, gutter: 4mm,
 [#bild("tm1k7_rahmen_c", [Skript TM1 S. 270 (untere Folie 92): Schnittgrößen vor und nach Ecke $C$.], height: 48mm)],
 [#bild("tm1k7_rahmen_g2", [Skript TM1 S. 271 (obere Folie 93): vor $G$ (G,2), rechter Teil.], height: 48mm)],
 [#bild("tm1k7_rahmen_g3", [Skript TM1 S. 271 (untere Folie 94): nach $G$ (G,3), Schräge unter 45°.], height: 48mm)])
#note([Merke – Ecken ohne äußere Last (Folie 95) ★], [- $|M_"vor Ecke"| = |M_"nach Ecke"|$.
- An 90°-Ecken zusätzlich: $|N_"vor"| = |Q_"nach"|$ und $|Q_"vor"| = |N_"nach"|$.
- Greift an der Ecke eine äußere Last an (wie $F$ bei $C$), machst du örtliches GGW an der Ecke im globalen KS. Alle Hebelarme sind null, auch $q_0 dot 0 = 0$. Bei $C$: $N_(C,2) = Q_(C,1) - F$, $Q_(C,2) = -N_(C,1)$, $M_(C,2) = M_(C,1)$.])
#bild("tm1k7_rahmen_ecke", [Skript TM1 S. 272 (obere Folie 95): Regeln für Ecken und örtliches GGW an Ecke $C$ mit $F$.], height: 48mm)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k7_rahmen_n", [Skript TM1 S. 273 (obere Folie 97): Normalkraftverlauf, überall Druck: $-"0,286" F$ in 1, $-"0,714" F$ in 2, $-"1,01" F$ in 3. Maßstab 5 mm = 0,2 F.], height: 50mm)],
 [#bild("tm1k7_rahmen_qm", [Skript TM1 S. 273 (untere Folie 98): $Q$ und $M$; im Riegel $Q$ linear mit Nullstelle, $M$ Parabel mit $M_(max)$; $M = 0$ am Gelenk und in der Schräge („Stab!“).], height: 50mm)])
#heading(level: 4, outlined: false)[Bereich 2 mit Streckenlast (Folien 99–100)]
#bild("tm1k7_rahmen_bereich2", [Skript TM1 S. 274 (obere Folie 99): lokale Koordinate $x_2$ im Riegel; Integration und RB aus den Werten an Ecke $C$.], height: 50mm)
#form[$ q_2 = frac(F, a), wide Q_2 (x_2) = -frac(F, a) x_2 + "0,286" F, wide M_2 (x_2) = -frac(F, 2a) x_2^2 + "0,286" F x_2 + "0,214" F a $]
Die RB kommen aus der punktweisen Rechnung: $Q_2 (0) = Q_(C,2)$, $M_2 (0) = M_(C,2)$ (2 von 4 möglichen). $Q_2 = 0$ bei $x_2 = "0,286" a$: $M_(max) = "0,255" F a$. Kontrolle: $M_2 (a) = -"0,5" F a + "0,286" F a + "0,214" F a = 0$ am Gelenk ✓.
#note([Fehler vermeiden], [- $N$ vergessen: Beim Rahmen tritt fast immer Normalkraft auf, auch bei reiner Querbelastung.
- Lagerreaktionen im örtlichen KS rechnen: Lager- und Gelenkkräfte immer im #strong[globalen] H–V-System.
- An einer schrägen Ecke $N$ und $Q$ einfach tauschen: Das gilt nur bei 90°. Bei schiefen Winkeln die Kräfte zerlegen (wie bei G,3).], fill: sand)
#note([Nicht behandelt], [Die Folien zum #strong[Bogen] zeigen ihn nur (Folie 87); gerechnet wird kein Bogen. Abschnitt #strong[7.4 „Schnittgrößen bei räumlichen Tragwerken“] hast du im Inhaltsverzeichnis durchgestrichen. Er ist nicht Teil der Vorlesung und fehlt deshalb hier.])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- Die Beziehungen $Q' = -q$, $M' = Q$ gelten nur für #strong[gerade] Rahmenteile, nicht für Bögen. Bei Rahmen berechnet man stets alle drei Schnittgrößen. #text(fill: muted)[\[TM1-Buch S. 201\]]
- An einer unbelasteten rechtwinkligen Ecke gilt (7.25): $N_(C 1) = -Q_(C 2)$, $Q_(C 1) = N_(C 2)$, $M_(C 1) = M_(C 2)$. Das Moment wird unverändert übertragen; Querkraft und Normalkraft tauschen. #text(fill: muted)[\[TM1-Buch S. 201\]]
- Beispiel 7.9: Rahmen mit $q_0 = F/a$, punktweise mit gestrichelter Faser gelöst. #text(fill: muted)[\[TM1-Buch S. 202–203\]]])
#src[Skript TM1 S. 268–274 (Folien 87–100); FS TM1 S. 44–45; Übung 12 (12.2, 12.3); TM1-Buch S. 201–203, 211.]

#grid(columns: 2, gutter: 5mm,
 [#bild("map-t1k7a", [Mindmap: Schnittgrößen am geraden Balken. Eigene Darstellung nach Skript TM1 S. 212–235.], height: 44mm)],
 [#bild("map-t1k7b", [Mindmap: Mehrere Felder, Rahmen und punktweise Ermittlung. Eigene Darstellung nach Skript TM1 S. 236–274.], height: 44mm)])

*Der Zusammenhang in Kapitel 7.* Alles beginnt mit dem Schnitt: An jeder Stelle wirken $N$, $Q$ und $M$, und mit der festen Vorzeichenregel kannst du sie aus dem Gleichgewicht am linken oder rechten Teil berechnen. Das Balkenelement liefert $Q' = -q$ und $M' = Q$. Daraus folgen zwei Wege. Beim ersten integrierst du und bestimmst die Konstanten aus Randbedingungen, bei mehreren Feldern zusätzlich aus Übergangsbedingungen; das Föppl-Symbol fasst die Felder zusammen. Beim zweiten rechnest du nur an markanten Stellen und zeichnest den Rest aus der Tabelle. Diesen zweiten Weg brauchst du in der Klausur am häufigsten. Der Rahmen ist dann nur ein Balken mit Ecken: Mit der gestrichelten Faser gelten dieselben Regeln, an jeder Ecke tauschen $N$ und $Q$.

#pagebreak()
== Verständnisfragen und Rechenaufgaben · Kapitel 7
#set enum(spacing: 0.85em)
Erkläre erst selbst. Bei Rechenaufgaben: Lagerreaktionen, Felder, Schnitt (oder punktweise), Skizze, Kontrolle. Die Lösungen folgen getrennt.

+ Was sind $N$, $Q$ und $M$? Wie lautet die Vorzeichenregel am positiven und am negativen Schnittufer?
+ Warum zeichnest du Schnittgrößen am Freikörperbild immer in positiver Richtung ein?
+ Wo legst du Feldgrenzen? Warum ist ein Einzelmoment beim Schnitt nicht frei verschiebbar?
+ Erkläre $Q' = -q$ und $M' = Q$ in eigenen Worten. Welche Verlaufsform haben $Q$ und $M$ bei $q = 0$, $q$ konstant und $q$ linear?
+ Wo liegt das maximale Moment? Warum musst du trotzdem die Feldränder prüfen?
+ Welche Randbedingungen liefern gelenkiges Lager, Parallelführung, Einspannung und freies Ende?
+ Wie bekommst du Lagerreaktionen aus $Q(x)$ und $M(x)$?
+ Wie lautet die Zählregel für RB und ÜB? Warum gibt es an einem Lager in der Balkenmitte für $Q$ keine Übergangsbedingung?
+ Welche Übergangsbedingungen gelten an einem Gelenk und an einer Parallelführung?
+ Wann brauchst du am Gelenk keine Feldgrenze?
+ Was bedeutet $chevron.l x - a chevron.r^0$? Nenne Vorteil und Nachteile des Föppl-Symbols.
+ Nenne die Schritte der punktweisen Ermittlung. Welche Stellen sind „markant“?
+ Was legt die gestrichelte Faser beim Rahmen fest? Was gilt an einer unbelasteten 90°-Ecke?
+ Warum musst du beim Rahmen die Normalkraft immer mitrechnen?
+ Kragarm, links eingespannt, $l = 2$ m, Kraft $F = 5$ kN nach unten am freien Ende. Bestimme $Q(x)$, $M(x)$ und die Einspannreaktionen. #text(fill: muted)[(eigene Aufgabe)]
+ Einfeldbalken $l = 6$ m mit $q_0 = 4$ kN/m. Bestimme $A$, $B$ und $M_(max)$ punktweise. #text(fill: muted)[(eigene Aufgabe)]
+ Balken aus deiner Mitschrift zu 7.2.4 mit Zahlen: $L = 2$ m, $q_0 = 3$ kN/m, $F = 4$ kN. Berechne $A_z$, $B$, $Q_I (L)$ und das größte Moment. Wo liegt es? #text(fill: muted)[(eigene Aufgabe)]
+ Balken $2a$, beidseitig gelenkig, $q_0$ nur von $0$ bis $a$. Schreibe $q(x)$ mit dem Föppl-Symbol, integriere und bestimme $C_1$, $C_2$. #text(fill: muted)[(eigene Aufgabe)]

#heading(level: 3, outlined: false)[Vertiefende Verständnisfragen und Rechenaufgaben]
#block[
#set enum(start: 19)
+ *Übung 9, Aufg. 9.2:* Balken (4 Felder der Länge $a$) mit $F_1 = F$, $F_2 = 2F$, $F_3 = -F$ bei $a$, $2a$, $3a$. Gesucht: $Q(x)$ und $M(x)$.
  #bild("tm1k7_ue92", [Übung 9 (Aufgabenblatt): Balken zu Aufgabe 9.2.], height: 22mm)
+ *Übung 9, Aufg. 9.3:* Träger mit 30 kN bei 6 m, Loslager bei 11 m und 20 kN am Kragende bei 14 m. Berechne und skizziere $Q(x)$ und $M(x)$ (Werte an markanten Stellen).
  #bild("tm1k7_ue93", [Übung 9 (Aufgabenblatt): Träger zu Aufgabe 9.3.], height: 24mm)
+ *Übung 9, Aufg. 9.4:* Einfeldbalken mit Dreieckslast (0 bis $q_0$). a) $Q(x)$, $M(x)$ mit Teilresultierender, b) Skizze, c) Nullstelle von $Q$, d) Ort und Größe von $M_(max)$.
  #bild("tm1k7_ue94", [Übung 9 (Aufgabenblatt): Balken zu Aufgabe 9.4.], height: 26mm)
+ *Übung 10, Aufg. 10.1:* Einfeldbalken mit Trapezlast von $q_0$ auf $q_1 = 2 q_0$. a) $Q(x)$, $M(x)$, b) Ort und Größe von $M_(max)$, c) Skizze, d) Lagerreaktionen aus $Q$ und $M$.
  #bild("tm1k7_ue101", [Übung 10 (Aufgabenblatt): Balken zu Aufgabe 10.1.], height: 26mm)
+ *Übung 10, Aufg. 10.2:* Balken mit gelenkigem Lager $A$ (dort Einzelmoment $M_0$), Parallelführung $B$ (dort Einzelkraft $F$) und konstanter Last $q_0$. a) $Q(x)$, $M(x)$, b) Extremwerte für $F > 0$ und $F < 0$, c) Skizze, d) Lagerreaktionen.
  #bild("tm1k7_ue102", [Übung 10 (Aufgabenblatt): Balken zu Aufgabe 10.2.], height: 28mm)
+ *Übung 10, Aufg. 10.3:* Mehrfeldträger ($F$ bei $2a$, $q_0 = F\/a$ von $3a$ bis $6a$, $2F$ bei $8a$, Länge $10a$). Berechne und skizziere $Q$ und $M$; wie groß ist $M_(max)$?
  #bild("tm1k7_ue103", [Übung 10 (Aufgabenblatt): Mehrfeldträger zu Aufgabe 10.3.], height: 20mm)
+ *Übung 10, Aufg. 10.4:* Gegeben ist ein Balken und seine (positive) Momentenlinie. Gesucht: die Belastung und der Querkraftverlauf mit Zahlen.
  #bild("tm1k7_ue104", [Übung 10 (Aufgabenblatt): Balken und Momentenlinie zu Aufgabe 10.4 („Gleiche Steigung!“).], height: 26mm)
+ *Übung 11, Aufg. 11.1:* Gelenkbalken: Einspannung $A$, Gelenk $G$ bei $a = l\/2$, Loslager $B$, Dreieckslast $q = q_0 x\/l$ stetig über das Gelenk. Bestimme $Q(x)$, $M(x)$, $M_(max)$ und die Lagerreaktionen. (Skizze aus der Lösung.)
  #bild("tm1k7_ue111", [Übung 11 (Lösung): Gelenkbalken zu Aufgabe 11.1.], height: 30mm)
+ *Übung 11, Aufg. 11.2:* Gelenkbalken: Einspannung $A$, $F = 700$ kN bei $a = 8$ m, Gelenk $G$ bei $a + b$ ($b = 4$ m), $q_0 = 150$ kN/m auf $c = 6$ m, Einzelmoment $M_0 = 800$ kNm am Loslager $B$. Bestimme Lager- und Gelenkkräfte, $Q$, $M$ und die Extremwerte. (Skizze aus der Lösung.)
  #bild("tm1k7_ue112", [Übung 11 (Lösung): Gelenkbalken zu Aufgabe 11.2.], height: 22mm)
+ *Übung 11, Aufg. 11.3:* Kran auf einer Brücke (Einfeldbalken $l$). Radlasten $H = G\/4$ (Hinterachse, bei $x - l\/20$) und $V = 3G\/4$ (Vorderachse, bei $x$). Bei welcher Stellung $x$ wird das Biegemoment am größten, und wie groß ist es? (Skizze aus der Lösung.)
  #bild("tm1k7_ue113", [Übung 11 (Lösung): Kranbrücke zu Aufgabe 11.3 mit Ersatzsystem.], height: 36mm)
+ *Übung 12, Aufg. 12.1:* Gerberträger: Festlager $A$, Loslager $B$ bei $a$, Gelenk $G$ bei $2a$, $q_0$ von $B$ bis $G$, $F$ unter 30° bei $2a + b$, Loslager $C$ bei $2a + 2b$. Bestimme Lager- und Gelenkkräfte und $N$, $Q$, $M$ punktweise.
  #bild("tm1k7_ue121", [Übung 12: Gerberträger zu Aufgabe 12.1.], height: 20mm)
+ *Übung 12, Aufg. 12.2:* Rahmen: Loslager $A$ unter Stütze 1 (Höhe $b$), Riegel 2 ($C$–$D$, Länge $a$, $q_0 = F\/a$), Stütze 3 ($D$–$B$, Höhe $a$), Festlager $B$, $F$ waagerecht bei $C$. Bestimme Lagerkräfte und $N$, $Q$, $M$ an den Ecken. (Skizze aus der Lösung.)
  #bild("tm1k7_ue122", [Übung 12 (Lösung): Rahmen zu Aufgabe 12.2 mit gestrichelter Faser.], height: 44mm)
+ *Übung 12, Aufg. 12.3:* Rahmen wie 12.2, aber mit Gelenk $G$ an der rechten oberen Ecke und Festlagern in $A$ und $B$; $q_0 = F\/a$, $b = 3\/4 a$. Bestimme Lager- und Gelenkkräfte, $N$, $Q$, $M$ an den Ecken und $M(x_2)$ im Riegel. (Skizze aus der Lösung.)
  #bild("tm1k7_ue123", [Übung 12 (Lösung): Rahmen mit Gelenk zu Aufgabe 12.3.], height: 44mm)
+ *Buch:* Welche Schnittgröße ändert ihr Vorzeichen, wenn die $x$-Achse nach links statt nach rechts zeigt? (TM1-Buch S. 171)
+ *Buch:* Warum muss man beim Föppl-Symbol die Übergangsbedingungen nicht aufstellen? (TM1-Buch S. 195)
+ *Buch:* Für welche Tragwerksteile gelten $Q' = -q$ und $M' = Q$ nicht? (TM1-Buch S. 201)
+ *Altklausur SS 2018 (TM_Prüfung_2018.pdf S. 3–4):* Rahmen aus TM1 Kap. 5 (Bild dort, erste Altklausur-Aufgabe) mit den Lagerreaktionen aus der Tabelle ($a = 2$ m, $q_0 = 2$ kN/m, $F = 2$ kN, $M_0 = 2$ kNm). a) Gib die Resultierenden der Streckenlast links und rechts vom Gelenk $G$ mit Angriffspunkt an. b) Bestimme $N$, $Q$ und $M$: Stab $A B$ unterhalb von $M_0$, rechts von $B$, rechts von $G$, links von $C$, Stab $C D$ über $D$, Stab $D E$ links von $F$. Gestrichelte Faser innen.
+ *Altklausur SS 2016, Musterlösung (PrüfungenTM2.pdf S. 18–20):* Rahmen aus TM1 Kap. 5 (Bild dort, zweite Altklausur-Aufgabe) mit Festlager $A$ und $C$, Querkraftgelenk $G$; $q_0 = F = M_0 = 1$ (kN, kNm), $a = 2$ m, $A_H = C_H = "0,5"$ kN, $A_V = C_V = 1$ kN. Bestimme $N$, $Q$, $M$: in $A B$ unter $M_0$, unter $B$, rechts von $B$, rechts von $F$, rechts von $G$ und in der Mitte zwischen $G$ und $C$.
]

#pagebreak()
== Lösungen Kapitel 7
#set enum(spacing: 0.65em)
+ $N$ in Balkenrichtung, $Q$ quer dazu in der Schnittfläche, $M$ dreht um $y$. Positive Schnittgrößen zeigen am positiven Schnittufer (linker Teil) in positive, am negativen Ufer (rechter Teil) in negative Koordinatenrichtung. #nachschlagen[Lernskript, #stelle(<a-tm1-7-1>)\; FS TM1 S. 37]
+ Dann liefert die Rechnung automatisch das richtige Vorzeichen. Wer „nach Gefühl“ einzeichnet, verwechselt die Vorzeichen. #nachschlagen[Lernskript, #stelle(<a-tm1-7-1>)]
+ An jeder Einzelkraft, jedem Einzelmoment, jedem Lager, Anfang und Ende jeder Streckenlast (und an Gelenken). Das Einzelmoment zählt im Momentengleichgewicht nur auf der Seite, auf der es sitzt; sein Ort ist eine Feldgrenze. #nachschlagen[Lernskript, #stelle(<a-tm1-7-2-1>)]
+ Die Last lässt $Q$ abnehmen, $Q$ ist die Steigung von $M$. $q = 0$: $Q$ konstant, $M$ linear; $q$ konstant: $Q$ linear, $M$ quadratisch; $q$ linear: $Q$ quadratisch, $M$ kubisch. #nachschlagen[Lernskript, #stelle(<a-tm1-7-2-2>)\; FS TM1 S. 38]
+ Lokal bei $Q = 0$. Das absolute Maximum kann aber am Rand liegen, wo $Q$ springt (Einspannung, Lager, Einzelkraft). Deshalb Randwerte vergleichen. #nachschlagen[Lernskript, #stelle(<a-tm1-7-2-2>)]
+ Gelenkiges Lager: $M = 0$. Parallelführung: $Q = 0$. Einspannung: keine. Freies Ende: $Q = 0$ und $M = 0$. #nachschlagen[Lernskript, #stelle(<a-tm1-7-2-3>)\; FS TM1 S. 38]
+ Unmittelbar neben dem Lager schneiden und lokales Gleichgewicht: z. B. $A = Q(0)$, $B = -Q(l)$, $M_A$ aus $M(0)$. #nachschlagen[Lernskript, #stelle(<a-tm1-7-2-3>)]
+ $sum "ÜB" + sum "RB" = 2 dot$Felder. Die Lagerkraft ist beim reinen Integrieren unbekannt, also ist $Q_"II" = Q_I + B$ keine verwertbare Gleichung (nur $M_"II" = M_I$). #nachschlagen[Lernskript, #stelle(<a-tm1-7-2-4>)]
+ Gelenk: $M_I = M_"II" = 0$ und $Q_"II" = Q_I$ (minus $F$, falls dort eine Kraft angreift). Parallelführung: $Q_I = Q_"II" = 0$ und $M_"II" = M_I$. #nachschlagen[Lernskript, #stelle(<a-tm1-7-2-4>)\; FS TM1 S. 41–42]
+ Wenn $q(x)$ stetig über das Gelenk läuft und dort keine Einzelkraft angreift. Dann nur die besondere ÜB $M(x_G) = 0$. #nachschlagen[Lernskript, #stelle(<a-tm1-7-2-4>)\; FS TM1 S. 41]
+ Ein Schalter: 0 für $x < a$, 1 für $x > a$. Vorteil: eine Formel, Integration in einem Zug, ÜB automatisch erfüllt. Nachteile: $q(x)$ aufstellen ist mühsam; Einzellasten muss man zusätzlich einbauen. #nachschlagen[Lernskript, #stelle(<a-tm1-7-2-5>)]
+ a) Lager- und Gelenkreaktionen, b) Werte an markanten Stellen, c) Skizze nach Tabelle, d) genauer Verlauf und $M_(max)$ in Bereichen mit $q$. Markant: Lastangriffspunkte, Lager, Anfang/Ende von Streckenlasten, Gelenke, Extremwerte. #nachschlagen[Lernskript, #stelle(<a-tm1-7-2-6>)\; FS TM1 S. 43]
+ Sie legt das örtliche „unten“ fest: $z$ zeigt zur Faser, $x$ läuft parallel dazu. An einer unbelasteten 90°-Ecke: $|M|$ bleibt gleich, $|N_"vor"| = |Q_"nach"|$, $|Q_"vor"| = |N_"nach"|$. #nachschlagen[Lernskript, #stelle(<a-tm1-7-3>)]
+ Weil an den Ecken Querkraft in Normalkraft übergeht. Auch bei reiner Querbelastung entsteht so in Stützen und Riegeln eine Normalkraft. #nachschlagen[Lernskript, #stelle(<a-tm1-7-3>)\; TM1-Buch S. 201]
+ Rechter Teil: $-Q + F = 0 => Q = 5$ kN (konstant); $-M - F(l - x) = 0 => M = -5(2 - x)$ kNm. Einspannung: $A_z = 5$ kN nach oben, $M_A = 10$ kNm; $M(0) = -10$ kNm (Zug oben). #nachschlagen[Lernskript, #stelle(<a-tm1-7-2-1>)]
+ $A = B = frac(q_0 l, 2) = 12$ kN. $Q = 0$ in der Mitte: $M_(max) = frac(q_0 l^2, 8) = 18$ kNm. Probe: $12 dot 3 - 4 dot frac(3^2, 2) = 18$ ✓. #nachschlagen[Lernskript, #stelle(<a-tm1-7-2-1>)]
+ $A_z = frac(F, 2) + frac(3, 4) q_0 L = 6","5$ kN, $B = frac(F, 2) + frac(q_0 L, 4) = 3","5$ kN. $Q_I (L) = 6","5 - 6 = 0","5$ kN $> 0$ (weil $F > frac(q_0 L, 2) = 3$ kN). Also wächst $M$ bis zur Kraft: $M_(max) = M(L) = frac(q_0 L^2, 4) + frac(F L, 2) = 7$ kNm bei $x = L$. #nachschlagen[Lernskript, #stelle(<a-tm1-7-2-4>)]
+ $q = q_0 - q_0 chevron.l x - a chevron.r^0$; $Q = -q_0 x + q_0 chevron.l x - a chevron.r^1 + C_1$; $M = -frac(q_0 x^2, 2) + frac(q_0, 2) chevron.l x - a chevron.r^2 + C_1 x + C_2$. $M(0) = 0 => C_2 = 0$; $M(2a) = 0 => C_1 = frac(3, 4) q_0 a$ (= $A$, Probe mit Hebelgesetz ✓). #nachschlagen[Lernskript, #stelle(<a-tm1-7-2-5>)]
+ $A = frac(3, 2) F$, $B = frac(1, 2) F$. $Q$ in den Feldern: $frac(3, 2) F$, $frac(1, 2) F$, $-frac(3, 2) F$, $-frac(1, 2) F$. $M$: $frac(3, 2) x F$; $(a + frac(1, 2) x) F$; $(5a - frac(3, 2) x) F$; $(2a - frac(1, 2) x) F$. Gleich dem Buchbeispiel 7.1. #nachschlagen[Lernskript, #stelle(<a-tm1-7-2-1>)\; Übung 9 Kurzlösung; TM1-Buch S. 175–177]
+ $A = "8,18"$ kN, $B = "4"1,8"2"$ kN. $Q$: $"8,18"$ kN (0–6 m), $-"21,8"$ kN (6–11 m), $20$ kN (11–14 m). $M_(max) = "49,1"$ kNm bei 6 m, $M_(min) = -60$ kNm über $B$; $M = 0$ bei $x = "8,25"$ m. #nachschlagen[Lernskript, #stelle(<a-tm1-7-2-6>)\; Lösung Übung 9]
+ $A = frac(q_0 l, 6)$, $B = frac(q_0 l, 3)$. $Q = frac(q_0 l, 6) - frac(q_0 x^2, 2l)$, $M = frac(q_0 l x, 6) - frac(q_0 x^3, 6l)$. $Q = 0$ bei $x = frac(l, sqrt(3))$; $M_(max) = frac(q_0 l^2, 9 sqrt(3))$. #nachschlagen[Lernskript, #stelle(<a-tm1-7-2-1>)\; Lösung Übung 9]
+ $Q = -frac(q_0 x^2, 2l) - q_0 x + frac(2, 3) q_0 l$; $M = -frac(q_0 x^3, 6l) - frac(1, 2) q_0 x^2 + frac(2, 3) q_0 l x$. $M_(max) approx "0,19" q_0 l^2$ bei $x approx "0,53" l$. $A = frac(2, 3) q_0 l$, $B = frac(5, 6) q_0 l$. #nachschlagen[Lernskript, #stelle(<a-tm1-7-2-3>)\; Übung 10 Kurzlösung]
+ $Q = -q_0 x + F + q_0 l$, $M = -frac(1, 2) q_0 x^2 + (F + q_0 l) x - M_0$. $Q_(max) = F + q_0 l$ bei 0, $Q_(min) = F$ bei $l$ (RB Parallelführung: $Q(l) = F$). $M$-Extremum bei $x = frac(F, q_0) + l$: liegt nur für $F < 0$ im Balken, $M_(max) = frac(q_0, 2)(frac(F, q_0) + l)^2 - M_0$. $A = F + q_0 l$, $M_B = F l + frac(q_0 l^2, 2) - M_0$. #nachschlagen[Lernskript, #stelle(<a-tm1-7-2-3>)\; Übung 10 Kurzlösung]
+ $B = "3,15" F$, $A = "2,85" F$. $Q$: $"2,85" F$ (0–2a), $"1,85" F$ (2a–3a), linear bis $-"1,15" F$ (6a), dann bis 8a konstant, $-"3,15" F$ (8a–10a). $Q = 0$ bei $x = "4,85" a$: $M_(max) = "9,26" a F$. #nachschlagen[Lernskript, #stelle(<a-tm1-7-2-6>)\; Lösung Übung 10]
+ Aus den Steigungen und Sprüngen der $M$-Linie: $A = 6$ kN; Einzelmoment $M_0 = 6$ kNm bei 2 m ($M$ springt von 12 auf 6 kNm); $F = 10$ kN bei 4 m; Lager $B = 9$ kN bei 6 m; $q_0 = 5$ kN/m von 6 bis 8 m (Parabel); $P = 5$ kN nach oben bei 10 m. $Q$: 6 kN (0–4 m), $-4$ kN (4–6 m), linear 5 bis $-5$ kN (6–8 m), $-5$ kN (8–10 m). #nachschlagen[Lernskript, #stelle(<a-tm1-7-2-6>)\; Lösung Übung 10]
+ Ein Feld (Last stetig über $G$). RB $M(l) = 0$, ÜB $M(l\/2) = 0$. $Q = -frac(q_0 x^2, 2l) + frac(7, 24) q_0 l$, $M = -frac(q_0 x^3, 6l) + frac(7, 24) q_0 l x - frac(1, 8) q_0 l^2$. $M_(max) = "0,0235" q_0 l^2$ bei $x = "0,764" l$. $A_z = frac(7, 24) q_0 l$, $M_A = frac(1, 8) q_0 l^2$, $B_z = frac(5, 24) q_0 l$. #nachschlagen[Lernskript, #stelle(<a-tm1-7-2-4>)\; Lösung Übung 11]
+ $A = 1017$ kN, $M_A = 9400$ kNm ($M_(min) = -9400$ kNm), $B = 583$ kN, $G = -317$ kN, $M(a) = -1267$ kNm, $M(B) = -800$ kNm. $Q_"III" = 0$ bei $x_3 = "2,11"$ m: $M_(max) = frac(317^2, 2 dot 150) approx 335$ kNm. *Achtung Lösungsblatt:* Dort steht „3,34 kNm“; richtig ist etwa 335 kNm (Probe: $M_"III"(6) = 317 dot 6 - 75 dot 36 approx -800$ kNm ✓). In der Skizze steht außerdem „1077“ statt $A = 1017$ kN. #nachschlagen[Lernskript, #stelle(<a-tm1-7-2-4>)\; Lösung Übung 11 S. 7–8]
+ $A = frac(G, l)(frac(81, 80) l - x)$, $B = frac(G, l)(x - frac(l, 80))$. Das größte Moment liegt unter der Vorderachse: $M_(V,max) = "0,2438" G l$ bei $x = frac(81, 160) l$ (unter der Hinterachse höchstens $"0,2316" G l$). #nachschlagen[Lernskript, #stelle(<a-tm1-7-2-6>)\; Lösung Übung 11]
+ $G_H = frac(sqrt(3), 2) F$, $A_H = -frac(sqrt(3), 2) F$, $C = G_V = frac(F, 4)$, $B = frac(3, 2) q_0 a + frac(F, 2)$, $A_V = -frac(1, 2) q_0 a - frac(1, 4) F$. $N = frac(sqrt(3), 2) F$ von $A$ bis zur Kraft, danach 0. $Q$: $A_V$ bis $B$; nach $B$ $q_0 a + frac(F, 4)$, linear fallend auf $frac(F, 4)$ bei $G$; nach der Kraft $-frac(F, 4)$. *Achtung Lösungsblatt:* In der Zeile „Aus (II)“ steht als Zwischenschritt $-F sin 30 degree$; richtig ist $-frac(1, 2) F sin 30 degree$. Das Endergebnis $-frac(1, 4) F$ wird danach richtig verwendet. #nachschlagen[Lernskript, #stelle(<a-tm1-7-2-6>)\; Lösung Übung 12 S. 1–2]
+ $B_H = F$, $A = -frac(F, 2)$, $B_V = frac(3, 2) F$. A,1 bis C,1: $N = frac(F, 2)$, $Q = 0$, $M = 0$. C,2: $N = -F$, $Q = -frac(F, 2)$, $M = 0$. D,2: $N = -F$, $Q = -frac(3, 2) F$, $M = -F a$. D,3: $N = -frac(3, 2) F$, $Q = F$, $M = -F a$. B,3: $M = 0$. #nachschlagen[Lernskript, #stelle(<a-tm1-7-3>)\; Lösung Übung 12]
+ $A_H = -F$, $G_H = B_H = 0$, $G_V = B_V = frac(5, 4) F$, $A_V = -frac(1, 4) F$. C,1: $N = frac(F, 4)$, $Q = F$, $M = frac(3, 4) F a$. C,2: $N = 0$, $Q = -frac(F, 4)$, $M = frac(3, 4) F a$. Bei $G$: $Q = -frac(5, 4) F$, $M = 0$. Riegel: $Q = -frac(F, a) x_2 - frac(F, 4)$, $M = -frac(F x_2^2, 2a) - frac(F x_2, 4) + frac(3, 4) F a$; Probe $M(a) = 0$ ✓. #nachschlagen[Lernskript, #stelle(<a-tm1-7-3>)\; Lösung Übung 12]
+ Nur die Querkraft $Q$; $N$ und $M$ bleiben gleich. #nachschlagen[Lernskript, #stelle(<a-tm1-7-1>)\; TM1-Buch S. 171]
+ Weil das Föppl-Symbol die Sprünge und Knicke schon enthält. Die Übergangsbedingungen sind automatisch erfüllt; man braucht nur die zwei Randbedingungen. #nachschlagen[Lernskript, #stelle(<a-tm1-7-2-5>)\; TM1-Buch S. 195]
+ Für gekrümmte Teile (Bögen); sie gelten nur für gerade Balken- und Rahmenteile. #nachschlagen[Lernskript, #stelle(<a-tm1-7-3>)\; TM1-Buch S. 201]
+ a) Je $F_R = 2$ kN, Angriffspunkt $"0,5"$ m rechts von $B$ bzw. $"0,5"$ m rechts von $G$. b) $A B$: $N = -3$, $Q = -2$, $M = -2$ kNm (Zug außen). Rechts von $B$: $N = -2$, $Q = 3$, $M = -2$. Rechts von $G$: $N = -2$, $Q = 1$, $M = 0$. Links von $C$: $N = -2$, $Q = -1$, $M = 0$. $C D$ über $D$: $N = -1$, $Q = 2$, $M = 4$. $D E$ links von $F$: $N = -2$, $Q = -1$, $M = 3$ (kN, kNm). Im Riegel $M(x) = -2 + 3x - x^2$, größter Wert $"0,25"$ kNm bei $x = "1,5"$ m. #nachschlagen[Lernskript, #stelle(<a-tm1-7-3>)\; Altklausur SS 2018 (TM_Prüfung_2018.pdf S. 3–4), eigene Lösung, keine Musterlösung vorhanden]
+ $A B$ unter $M_0$: $N = -1$, $Q = "0,5"$, $M = "0,5"$. Unter $B$: $N = -1$, $Q = "0,5"$, $M = 0$. Rechts von $B$: $N = "0,5"$, $Q = 1$, $M = 0$. Rechts von $F$: $N = "0,5"$, $Q = 0$, $M = 1$. Rechts von $G$: $N = "0,5"$, $Q = 0$, $M = 1$ (das Querkraftgelenk überträgt kein $Q$). Mitte $G$–$C$: $N = "0,5"$, $Q = -"0,5"$, $M = 5\/6$. #nachschlagen[Lernskript, #stelle(<a-tm1-7-3>)\; Altklausur SS 2016, Musterlösung (PrüfungenTM2.pdf S. 18–20)]

#pagebreak()
= TM1 Kapitel 9 · Haftung und Reibung <k-tm1-9>
#tab(columns: 2,
 [Vorlesungen], [Im Skript TM1 gibt es zu Reibung #strong[keine Folien]: Das Inhaltsverzeichnis (Folie 2) nennt „9 Reibung“, das Skript endet aber auf S. 274 mit Abschnitt 7.3. Badge #strong[TM1 WS 25/26 (nur Übung)].],
 [Quellen], [FS TM1 S. 48–49; Übung 13 (nur Lösungsblatt vorhanden); Übung 0, Aufg. 0.3; TM1-Buch Kap. 9 (S. 247–263).],
 [Passende Übungen], [Übung 0: 0.3 · Übung 13: 13.1 (schiefe Ebene), 13.2 (Walze), 13.3 (Leiter); dazu Altklausur-Aufgaben am Ende der vertiefenden Fragen],
)
#note([Hinweis – Grundlage dieses Kapitels], [Weil die Folien fehlen, stützt sich dieses Kapitel auf die Formelsammlung und die Übungen. Ob Reibung in der Vorlesung selbst drankam, geht aus deinen Unterlagen nicht hervor. Seilhaftung (9.3) steht nur in der Formelsammlung und wurde in keiner Übung gerechnet. #strong[Kapitel 8 „Arbeit“] steht ebenfalls nur im Inhaltsverzeichnis, ohne Folien und ohne Übung; es fehlt deshalb ganz.], fill: sand)
Bisher waren Berührflächen immer glatt: Eine Wand oder ein Boden konnte nur #strong[senkrecht] drücken ($N$). Echte Flächen sind rau. Sie können auch eine Kraft #strong[entlang] der Fläche übertragen. Solange der Körper ruht, heißt diese Kraft #strong[Haftungskraft $H$]\; gleitet er, heißt sie #strong[Reibungskraft $R$].
#note([Dein Feynman-Schritt: die 5 Kernideen von Kapitel 9. Erst ohne Skript aufzählen und erklären, dann vergleichen.], [+ #strong[Haftung:] Der Körper ruht. $H$ ist eine Reaktionskraft und folgt aus dem Gleichgewicht; es muss $|H| <= mu_0 N$ gelten.
+ #strong[Grenzhaftung:] $|H| = mu_0 N$. Der Körper ist gerade noch in Ruhe; die kleinste Störung setzt ihn in Bewegung.
+ #strong[Reibung:] Der Körper gleitet. $R = mu N$, immer gegen die Relativbewegung. Meist ist $mu < mu_0$.
+ #strong[Haftungswinkel:] $tan rho_0 = mu_0$. Solange die Resultierende aus $N$ und $H$ im Haftungskeil liegt, bleibt der Körper in Ruhe.
+ #strong[Seil um Walze:] $S_2 = S_1 e^(mu_0 alpha)$ – die Seilkraft wächst exponentiell mit dem Umschlingungswinkel.])
== 9.1 Grundlagen: Haftung <a-tm1-9-1>
#tab(columns: 2,
 th([Zeichen], [Bedeutung]),
 [$H$], [Haftungskraft (tangential, Körper ruht)],
 [$mu_0$], [Haftungskoeffizient],
 [$N$], [Normalkraft (senkrecht zur Berührfläche, immer drückend)],
 [$R$], [Reibungskraft (tangential, Körper gleitet)],
 [$mu$], [Reibungskoeffizient],
)
#form[$ "Haftung:" quad |H| < mu_0 N wide "Grenzhaftung:" quad |H| = mu_0 N $]
FS TM1 S. 48 Gl. (9.1), (9.2). $mu_0$ ist ohne Einheit.
#note([In eigenen Worten], [Schieb einen schweren Schrank an. Erst bewegt er sich nicht: Der Boden hält mit genau so viel Kraft dagegen, wie du drückst ($H$ = deine Kraft). Drückst du stärker, hält der Boden stärker dagegen – aber nur bis zu einer Grenze $mu_0 N$. Darüber rutscht der Schrank. Ein schwererer Schrank (größeres $N$) hat eine höhere Grenze. #text(fill: muted)[(eigene Ergänzung)]])
#note([Vorgehen bei Haftung (FS TM1 S. 48) ★], [- a) Freischnitt, Reaktionen ansetzen (auch $N$ und $H$): $N$ #strong[drückend], $H$ in #strong[beliebiger] Richtung.
- b) Gleichgewicht aufstellen und nach $N$, $H$ auflösen.
- c) Prüfen: Ist $N > 0$? Ist $|H| < mu_0 N$? Nur dann haftet der Körper.])
#note([Fehler vermeiden], [- $H = mu_0 N$ einfach einsetzen, obwohl der Körper normal ruht. Das gilt #strong[nur] im Grenzfall. Sonst ist $H$ eine ganz normale Reaktionskraft aus dem Gleichgewicht.
- $N$ als Zugkraft ansetzen: Eine Fläche kann nur drücken. Ergibt sich $N < 0$, hebt der Körper ab.], fill: sand)
#note([Eigenes Beispiel – Kiste auf einer Rampe], [#text(fill: muted)[(eigene Ergänzung)]: Eine Kiste ($m = 50$ kg, $G = 490","5$ N) steht auf einer Laderampe mit $alpha = 20 degree$, $mu_0 = "0,4"$. Rutscht sie?
+ Hangabwärts: $H = G sin alpha = "167,8"$ N (nach oben gerichtet). Senkrecht: $N = G cos alpha = "460,9"$ N.
+ Grenze: $mu_0 N = "184,4"$ N $> H$ → die Kiste haftet.
+ Kurz: Ohne weitere Kräfte haftet ein Körper auf der schiefen Ebene, solange $tan alpha <= mu_0$ ist ($tan 20 degree = "0,36" < "0,4"$ ✓). Praxis: Rampenwinkel in der Logistik so wählen, dass Ware nicht von selbst rutscht.], fill: pale)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- $mu_0$ hängt nur von der Rauigkeit der Flächen ab, #strong[nicht von ihrer Größe]. Tab. 9.1 nennt Richtwerte, z. B. Holz auf Holz $mu_0 = "0,5"$, $mu = "0,3"$; Autoreifen auf Straße $mu_0 = "0,7" dots "0,9"$. #text(fill: muted)[\[TM1-Buch S. 249\]]
- Der Richtungssinn von $H$ ist stets so, dass die Bewegung verhindert wird. Kennt man ihn nicht, nimmt man ihn beliebig an; das Vorzeichen zeigt, ob die Annahme stimmt. Allgemein gilt $|H| <= H_0 = mu_0 N$ (9.4b). #text(fill: muted)[\[TM1-Buch S. 249\]]])
#src[FS TM1 S. 48; Übung 13; TM1-Buch S. 247–249.]
== 9.2 Die Coulombschen Reibungsgesetze <a-tm1-9-2>
#form[$ "Reibung (Körper gleitet):" quad R = mu dot N $]
FS TM1 S. 48 Gl. (9.3). In TM1 nur für gleichförmiges Gleiten ($v$ = konst., Beschleunigung 0), damit weiter $sum F = 0$ und $sum M = 0$ gelten.
#note([Vorgehen bei Grenzhaftung und Reibung (FS TM1 S. 49) ★], [+ Freischnitt, Reaktionen ansetzen: $N$ drückend; $H_0$ bzw. $R$ #strong[muss jetzt richtig zeigen], nämlich entgegen der (drohenden) Relativbewegung. Eventuell mehrere Fälle (rauf/runter) rechnen.
+ Gleichgewicht plus zusätzlich $H_0 = mu_0 N$ bzw. $R = mu N$; auflösen nach $N$, $H_0$ bzw. $R$.
+ Prüfen: $N > 0$? $H_0 > 0$ bzw. $R > 0$?])
#note([Merke – Haftungswinkel ★], [Fasst man $N$ und $H$ zu einer Resultierenden zusammen, liegt diese im Grenzfall unter dem Winkel $rho_0$ zur Normalen: $tan rho_0 = mu_0$. Trägt man $rho_0$ zu beiden Seiten der Normalen an, entsteht der #strong[Haftungskeil]. Liegt die Resultierende darin, haftet der Körper. #text(fill: muted)[\[TM1-Buch S. 250, Gl. (9.5)\]] Übung 13.1 nutzt das für die grafische Lösung (in der Lösung heißt der Winkel $phi_0$).])
#heading(level: 4, outlined: false)[Beispiel: Klotz auf der schiefen Ebene mit waagerechter Kraft (Übung 13.1)]
#bild("tm1k9_ue131", [Lösung Übung 13 S. 1: Klotz ($G$) auf schiefer Ebene (Winkel $alpha$, $mu_0$), waagerechte Kraft $F$. Links: $H$ zeigt hangabwärts (Aufwärtsbewegung verhindern); rechts: $H$ zeigt hangaufwärts (Abwärtsbewegung verhindern).], height: 34mm)
#note([Übung 13.1 a) – zwei Fälle], [Achsen: $x$ hangaufwärts, $y$ senkrecht zur Ebene. In beiden Fällen $N = F sin alpha + G cos alpha$.
+ #strong[Nicht hochrutschen] ($H$ hangabwärts): $H = F cos alpha - G sin alpha <= mu_0 N$ ⇒ $F <= G frac(sin alpha + mu_0 cos alpha, cos alpha - mu_0 sin alpha)$.
+ #strong[Nicht runterrutschen] ($H$ hangaufwärts): $H = G sin alpha - F cos alpha <= mu_0 N$ ⇒ $F >= G frac(sin alpha - mu_0 cos alpha, cos alpha + mu_0 sin alpha)$.
+ Mit $mu_0 = tan rho_0$ und den Additionstheoremen (Teil b): #box(stroke: 0.6pt, inset: 3pt, $G tan(alpha - rho_0) <= F <= G tan(alpha + rho_0)$).], fill: pale)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm1k9_ue131c", [Lösung Übung 13 S. 3: grafische Lösung. Die Resultierende $R_I$ bzw. $R_"II"$ liegt um $rho_0$ (hier $phi_0$) neben der Normalen; zusammen mit $G$ und $F$ ergibt sich ein geschlossenes Krafteck.], height: 55mm)],
 [#note([So liest du die grafische Lösung], [$G$ senkrecht nach unten, $F$ waagerecht. Die Kontaktkraft muss das Dreieck schließen. Im Grenzfall ist sie um $alpha plus.minus rho_0$ gegen die Senkrechte geneigt. Daraus folgt direkt $F = G tan(alpha plus.minus rho_0)$.])])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- Bei Grenzhaftung gilt $H_0 = mu_0 N$; dieser Zusammenhang gilt #strong[nur] im Grenzfall. #text(fill: muted)[\[TM1-Buch S. 249\]]
- Der Neigungswinkel einer schiefen Ebene, bei dem ein Körper gerade zu rutschen beginnt, ist unmittelbar ein Maß für den Haftungskoeffizienten. #text(fill: muted)[\[TM1-Buch S. 253\]]])
#src[FS TM1 S. 48–49; Übung 13 (Aufg. 13.1–13.3); Übung 0 (Aufg. 0.3); TM1-Buch S. 249–253.]
== 9.3 Seilhaftung und Seilreibung <a-tm1-9-3>
#note([Nur Formelsammlung], [Dieser Abschnitt steht in der Formelsammlung, wurde aber in keiner Übung gerechnet. Kurz zum Einordnen.], fill: sand)
#bild("tm1k9_fs_seil", [FS TM1 S. 49: Seil um eine Walze (Umschlingungswinkel $alpha$, auch mehrere Windungen $alpha = alpha_1 + n dot 2 pi$); Euler-Eytelwein-Formel für Grenzhaftung und Reibung.], height: 55mm)
#form[$ "Grenzhaftung:" quad S_2 = S_1 e^(mu_0 alpha) wide "Reibung:" quad S_2 = S_1 e^(mu alpha) $]
FS TM1 S. 49 Gl. (9.4). $alpha$ im Bogenmaß; das Seil bewegt sich relativ zur Walze in Richtung $S_2$ (größere Kraft).
#note([Eigenes Beispiel – Schiff am Poller], [#text(fill: muted)[(eigene Ergänzung)]: Ein Seil ist zweimal um einen Poller gewickelt ($alpha = 4 pi$), $mu_0 = "0,3"$. Ein Arbeiter hält mit $S_1 = 100$ N. Welche Kraft $S_2$ kann das Schiff höchstens ziehen? $S_2 = 100 dot e^("0,3" dot 4 pi) = 100 dot e^("3,77") approx "4,3"$ kN. Jede weitere Windung vervielfacht die Haltekraft – darum reichen wenige Windungen.], fill: pale)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [Die Formel heißt nach Euler und Johann Albert Eytelwein (1764–1848). Für Seilreibung ersetzt man $mu_0$ einfach durch $mu$. #text(fill: muted)[\[TM1-Buch S. 260\]]])
#src[FS TM1 S. 49; TM1-Buch S. 259–260.]

#bild("map-t1k9", [Mindmap: Haftung und Reibung. Eigene Darstellung nach FS TM1 S. 48–49.], height: 44mm)

*Der Zusammenhang in Kapitel 9.* Rauheit bedeutet: Eine Fläche kann auch tangential eine Kraft übertragen. Solange der Körper ruht, ist das eine normale Reaktionskraft aus dem Gleichgewicht, und du prüfst am Ende nur, ob sie unter der Grenze $mu_0 N$ bleibt. Willst du wissen, wann der Körper gerade zu rutschen beginnt, setzt du $H = mu_0 N$ als zusätzliche Gleichung ein und musst die Richtung richtig wählen. Gleitet er schon, gilt $R = mu N$. Beim Seil um eine Walze führt dieselbe Idee zur Exponentialformel.

#pagebreak()
== Verständnisfragen und Rechenaufgaben · Kapitel 9
#set enum(spacing: 0.85em)
Erkläre erst selbst. Bei Rechenaufgaben: Freischnitt ($N$ drückend), Richtung von $H$ festlegen, Gleichgewicht, Grenzbedingung, Prüfung. Die Lösungen folgen getrennt.

+ Was ist der Unterschied zwischen Haftung und Reibung?
+ Wann darfst du $H = mu_0 N$ einsetzen und wann nicht?
+ In welche Richtung zeigt $H$ bei Haftung, und in welche bei Grenzhaftung?
+ Warum musst du bei Grenzhaftung manchmal zwei Fälle rechnen?
+ Was prüfst du am Ende einer Haftungsaufgabe?
+ Was ist der Haftungswinkel, und wie hängt er mit $mu_0$ zusammen?
+ Wie hängt die Seilkraft beim Umschlingen vom Winkel ab?
+ Ein Klotz ($G = 200$ N) liegt auf waagerechtem Boden, $mu_0 = "0,5"$. Er wird mit $F = 60$ N waagerecht gezogen. Wie groß ist $H$? Haftet er? Ab welcher Kraft rutscht er? #text(fill: muted)[(eigene Aufgabe)]
+ Bei welchem Neigungswinkel beginnt ein Körper auf einer schiefen Ebene mit $mu_0 = "0,4"$ von selbst zu rutschen? #text(fill: muted)[(eigene Aufgabe)]

#heading(level: 3, outlined: false)[Vertiefende Verständnisfragen und Rechenaufgaben]
#block[
#set enum(start: 10)
+ *Übung 0, Aufg. 0.3:* Ein Klotz ($m_1 = 1$ kg) liegt auf einer rauen Fläche ($mu = "0,10194"$). Ein Seil führt über eine Rolle zu einer hängenden Masse $m_2$ (Seil und Rolle gewichtslos). Welche Masse $m_2$ braucht man, damit der Klotz zu rutschen beginnt?
  #bild("tm1k9_ue03", [Übung 0 (Aufgabenblatt S. 2): Klotz $m_1$, Seil über Rolle, Masse $m_2$.], height: 30mm)
+ *Übung 13, Aufg. 13.1:* Klotz (Gewicht $G$) auf einer schiefen Ebene (Winkel $alpha$, $mu_0$), waagerechte Kraft $F$ (Skizze in 9.2). a) In welchen Grenzen muss $F$ liegen, damit der Körper in Ruhe bleibt? b) Forme mit $mu_0 = tan rho_0$ um. c) Löse grafisch.
+ *Übung 13, Aufg. 13.2:* Eine Walze (Gewicht $G$, Radius $r$) liegt in einer Ecke an Wand und Boden (beide rau, $mu_0$). Am Rand greift die Kraft $F$ senkrecht nach oben an. Wie groß muss $F$ sein, damit die Walze gerade zu drehen beginnt? (Skizze aus der Lösung.)
  #bild("tm1k9_ue132", [Lösung Übung 13 S. 4: Walze mit $N_1$, $H_1$ an der Wand, $N_2$, $H_2$ am Boden, $G$ und $F$.], height: 36mm)
+ *Übung 13, Aufg. 13.3:* Eine Leiter ($L = 5$ m, Winkel $alpha = 30 degree$ zur Wand) lehnt an einer glatten Wand und steht auf rauem Boden ($mu_0 = "0,28"$). Bis zu welcher Höhe $h$ kann eine Person (Gewicht $G$) steigen, ohne dass die Leiter rutscht? Eigengewicht der Leiter vernachlässigt. (Skizze und Zahlen aus der Lösung.)
  #bild("tm1k9_ue133", [Lösung Übung 13 S. 5: Leiter mit $N_W$ an der Wand, $N_B$ und $H_B$ am Boden, Person $G$ in Höhe $h$.], height: 45mm)
+ *Buch:* Hängt der Haftungskoeffizient von der Größe der Berührfläche ab? (TM1-Buch S. 249)
+ *Buch:* Was gilt für die Seilkräfte bei Seilreibung im Vergleich zur Seilhaftung? (TM1-Buch S. 260)
+ *Altklausur SS 2016, Musterlösung (PrüfungenTM2.pdf S. 23):* Klotz $G_1$ auf rauer Unterlage (Haftzahl $mu_0$), über ein Seil unter dem Winkel $alpha$ und eine Rolle mit dem Gewicht $G_2$ verbunden; nach links zieht $F$. Schneide den Klotz frei, stelle die nötigen Gleichgewichte auf und bestimme die größte zulässige Kraft $F$.
  #bild("ak_ss16_klotz", [Altklausur SS 2016, Aufg. 1 h), Musterlösung: links das System mit Seil und Rolle, rechts der freigeschnittene Klotz mit $F$, $G_1$, $G_2$ unter $alpha$, $N$ und $H_0$.], height: 40mm)
]

#pagebreak()
== Lösungen Kapitel 9
#set enum(spacing: 0.65em)
+ Haftung: Der Körper ruht, $H$ ist eine Reaktionskraft. Reibung: Der Körper gleitet, $R = mu N$ wirkt gegen die Bewegung. #nachschlagen[Lernskript, #stelle(<a-tm1-9-1>)\; FS TM1 S. 48]
+ Nur im Grenzfall (Körper gerade noch in Ruhe). Sonst folgt $H$ aus dem Gleichgewicht und muss nur $|H| < mu_0 N$ erfüllen. #nachschlagen[Lernskript, #stelle(<a-tm1-9-1>)]
+ Bei Haftung beliebig ansetzen, das Vorzeichen zeigt die Richtung. Bei Grenzhaftung muss sie stimmen: entgegen der drohenden Bewegung. #nachschlagen[Lernskript, #stelle(<a-tm1-9-2>)\; FS TM1 S. 48–49]
+ Weil der Körper in zwei Richtungen rutschen kann (z. B. hoch und runter). Jeder Fall hat eine andere Richtung von $H$ und liefert eine Grenze. #nachschlagen[Lernskript, #stelle(<a-tm1-9-2>)\; Übung 13.1]
+ $N > 0$ (kein Abheben) und $|H| < mu_0 N$ (Haftung); bei Grenzhaftung/Reibung $H_0 > 0$ bzw. $R > 0$. #nachschlagen[Lernskript, #stelle(<a-tm1-9-1>)]
+ Der Winkel $rho_0$ zwischen Normale und Resultierender aus $N$ und $H_0$ im Grenzfall: $tan rho_0 = mu_0$. #nachschlagen[Lernskript, #stelle(<a-tm1-9-2>)\; TM1-Buch S. 250]
+ Exponentiell: $S_2 = S_1 e^(mu_0 alpha)$. #nachschlagen[Lernskript, #stelle(<a-tm1-9-3>)\; FS TM1 S. 49]
+ $N = 200$ N, $H = F = 60$ N $< mu_0 N = 100$ N → haftet. Rutschen ab $F = 100$ N. #nachschlagen[Lernskript, #stelle(<a-tm1-9-1>)]
+ $tan alpha = mu_0 = "0,4"$ → $alpha approx "21,8" degree$. #nachschlagen[Lernskript, #stelle(<a-tm1-9-1>)]
+ $G_1 = "9,81"$ N; $F_r = mu G_1 = "1,0"$ N; $m_2 g = F_r$ → $m_2 = "0,10194"$ kg. Achtung: Für den #strong[Beginn] des Rutschens ist streng genommen der Haftungskoeffizient $mu_0$ gemeint; die Aufgabe nennt ihn „Reibungsbeiwert $mu$“. #nachschlagen[Lernskript, #stelle(<a-tm1-9-2>)\; Übung 0 Kurzlösung]
+ $G frac(sin alpha - mu_0 cos alpha, cos alpha + mu_0 sin alpha) <= F <= G frac(sin alpha + mu_0 cos alpha, cos alpha - mu_0 sin alpha)$, also $G tan(alpha - rho_0) <= F <= G tan(alpha + rho_0)$. #nachschlagen[Lernskript, #stelle(<a-tm1-9-2>)\; Lösung Übung 13 S. 1–3]
+ Gleichgewicht: $N_1 - H_2 = 0$; $N_2 + H_1 - G + F = 0$; $-H_1 r - H_2 r + F r = 0$; Grenzhaftung $H_1 = mu_0 N_1$, $H_2 = mu_0 N_2$. Ergebnis: $N_2 = frac(G, 2 mu_0^2 + mu_0 + 1)$, $N_1 = mu_0 N_2$, $F = G frac(mu_0^2 + mu_0, 2 mu_0^2 + mu_0 + 1)$. #nachschlagen[Lernskript, #stelle(<a-tm1-9-2>)\; Lösung Übung 13 S. 4–5]
+ $N_W = H_B = mu_0 N_B = mu_0 G$. Moment um $B$: $-N_W L cos alpha + G h tan alpha = 0$ → $h = frac(mu_0 L cos alpha, tan alpha) = frac("0,28" dot 5 dot cos 30 degree, tan 30 degree) = "2,1"$ m, unabhängig von $G$. #nachschlagen[Lernskript, #stelle(<a-tm1-9-2>)\; Lösung Übung 13 S. 5–6]
+ Nein, nur von der Rauigkeit der Flächen. #nachschlagen[Lernskript, #stelle(<a-tm1-9-1>)\; TM1-Buch S. 249]
+ Gleiche Formel, nur $mu_0$ durch $mu$ ersetzt: $S_2 = S_1 e^(mu alpha)$. #nachschlagen[Lernskript, #stelle(<a-tm1-9-3>)\; TM1-Buch S. 260]
+ $arrow.t: N = G_1 - G_2 sin alpha$. $arrow.r$ im Grenzfall (der Klotz will nach links rutschen, $H_0 = mu_0 N$ zeigt nach rechts): $-F + G_2 cos alpha + mu_0 N = 0$. Also $F_("max") = mu_0 G_1 + G_2 (cos alpha - mu_0 sin alpha)$. Ein Momentengleichgewicht ist nicht nötig. #nachschlagen[Lernskript, #stelle(<a-tm1-9-2>)\; Altklausur SS 2016, Musterlösung (PrüfungenTM2.pdf S. 23)]

#pagebreak()
= TM2 Kapitel 0 · Wiederholung TM1 und Einführung in TM2 <k-tm2-0>
#tab(columns: 2,
 [Vorlesungen], [VL 16.3.26 → Abschnitte TM2 0.1–0.3 (Skript TM2 S. 5–37; dein Vermerk „/\/ 16.3.26“ auf S. 37); VL 23.3.26 → Abschnitt TM2 0.4 (S. 38–51)],
 [Quellen], [Skript TM2 S. 5–51 (Wiederholung TM I, Schnittgrößen-Aufgaben, DGL der Schnittgrößen Q, M, N); Vorbereitung auf TM2 S. 1–13 (Testat Schnittgrößen am Rahmen und am Balken); FS TM2 S. 4; TM1-Buch S. 181–182; TM2-Buch S. 13–14],
 [Passende Übungen], [Testat „Schnittgrößen an Rahmenstruktur“ und „Schnittgrößen an Balkenstruktur“ (Vorbereitung auf TM2 S. 2–4 und S. 8–11). Die TM2-Übungsblätter 1–4 setzen das Kapitel voraus (Normalkraft N(x) bestimmen). Vertiefung: Übungen zu → TM1 Kapitel 7.],
)
TM2 (Elastostatik) beginnt dort, wo TM1 aufgehört hat: Du schneidest ein Bauteil auf und bestimmst die #strong[Schnittgrößen N, Q, M]. Neu ist, dass du sie in TM2 #strong[auf die Fläche verteilst] (Spannungen) und daraus Verformungen berechnest. Ohne sichere Schnittgrößen geht in TM2 nichts. Dieses Kapitel wiederholt deshalb kompakt, was TM2 aus TM1 braucht. Die ausführliche Behandlung steht in → TM1 Kapitel 7.
#note([Dein Feynman-Schritt: die 4 Kernideen von Kapitel 0. Erst ohne Skript aufzählen und erklären, dann vergleichen.], [+ #strong[Schneiden – Freikörperbild – Gleichgewicht:] Jede Schnittgröße kommt aus einem Gleichgewicht an einem freigeschnittenen Teil.
+ #strong[Vorzeichen über das Schnittufer:] Am positiven Schnittufer zeigen N und Q in Richtung der positiven Koordinatenachsen (x bzw. z), am negativen entgegengesetzt.
+ #strong[Zwei Wege, ein Ergebnis:] Schnittgrößen punktweise (Schnitt an einer Stelle) oder bereichsweise mit der DGL bzw. Föppl-Klammern.
+ #strong[Belastung → Schnittgröße per Ableitung:] $Q' = -q$, $M' = Q$, $N' = -n$. Das ist die Brücke zur Spannungs-Dehnungs-DGL in Kapitel 1.
Zusammenfassung der Abschnitte TM2 0.1–0.4; Quellen stehen dort.])
== TM2 0.1 Was TM2 aus TM1 braucht <a-tm2-0-1>
In TM1 hast du ein Bauteil gedanklich zerschnitten und die inneren Kräfte als drei Ersatzgrößen zusammengefasst: #strong[Normalkraft N] (längs der Achse), #strong[Querkraft Q] (quer zur Achse) und #strong[Biegemoment M]. In TM2 fragst du: Wie verteilen sich diese inneren Kräfte über den Querschnitt? Das Ergebnis sind #strong[Spannungen]. Die Folie fasst das so zusammen: Spannungen entstehen durch den Vergleich der Schnittgrößen mit den Eigenschaften des Bauteils (Werkstoff und Querschnittsform) (Skript TM2 S. 53).
#note([In eigenen Worten], [Die Schnittgröße ist wie der #strong[Gesamtumsatz] einer Filialkette, die Spannung wie der #strong[Umsatz pro Quadratmeter Verkaufsfläche]. Erst die „pro Fläche“-Zahl sagt dir, ob eine Filiale überlastet ist. #text(fill: muted)[(eigene Ergänzung)]])
#bild("tm2k0_tm1wdh", [Skript TM2 S. 6: Wiederholung Schnittgrößen – lokal an ausgezeichneten Stellen oder bereichsweise mit DGL. Oben rot markiert deine Notiz „TM1 wiederholen“.], height: 45mm)
#note([Von dir markiert „TM1 wiederholen“ (rot hinterlegt, Skript TM2 S. 6)], [Du hast dir notiert, die TM1-Schnittgrößen zu wiederholen. Das ist berechtigt: Fast jede TM2-Aufgabe beginnt mit „Normalkraft / Biegemoment bestimmen“. Schnittgrößen in voller Breite: → TM1 Kapitel 7.], fill: sand)
#heading(level: 3, outlined: false)[Vorzeichenregel (Schnittufer)]
- #strong[Positives Schnittufer:] Die äußere Normale zeigt in +x-Richtung. Dort zeigen positive N in +x und positive Q in +z (z nach unten). Ein positives M dreht so, dass die Unterseite (+z) gezogen wird.
- #strong[Negatives Schnittufer:] Alle Schnittgrößen zeigen genau entgegengesetzt (actio = reactio).
- #strong[N \> 0] heißt Zug, #strong[N \< 0] heißt Druck. Das Vorzeichen von N wird in TM2 direkt zum Vorzeichen der Normalspannung σ.
#bild("tm2k1_schnittufer", [Skript TM2 S. 61: Vom Balken zu den Schnittgrößen am positiven (links) und negativen Schnittufer (rechts), lokales und globales Koordinatensystem.], height: 45mm)
#heading(level: 3, outlined: false)[Was TM2 daraus macht]
#tab(columns: 4,
 th([Schnittgröße], [Belastungsart], [Spannung in TM2], [Kapitel]),
 [Normalkraft N], [Zug/Druck], [$sigma = N/A$], [TM2 Kap. 1],
 [Querkraft Q], [Scherung (Schub)], [$tau_S = Q/A_S$ (mittlere Schubspannung)], [TM2 Kap. 1, Kap. 4],
 [Biegemoment M], [Biegung], [$sigma_B = M_B /W_B$], [TM2 Kap. 4],
 [Torsionsmoment M#sub[T]], [Torsion], [$tau_T = M_T /W_T$], [TM2 Kap. 5],
)
Tabelle nach Skript TM2 S. 62–69 (Folien „Spannungen und Schnittgrößen“).
#note([Merke], [In TM2 brauchst du die Schnittgrößen nicht nur an einer Stelle, sondern meist als #strong[Verlauf N(x), Q(x), M(x)], weil Querschnitt, Last und Spannung sich mit x ändern können.])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Statik → Elastostatik:] In der Statik starrer Körper hast du nur die Resultierende der inneren Kräfte (Stabkraft) benutzt; in der Elastostatik musst du dich mit den verteilten inneren Kräften, den Spannungen, selbst befassen. #text(fill: muted)[\[TM2-Buch S. 3\]]
- #strong[Drei Gleichungsarten:] Neben dem Gleichgewicht brauchst du in TM2 die Kinematik (Geometrie der Verformung) und das Elastizitätsgesetz (Materialverhalten). #text(fill: muted)[\[TM2-Buch S. 2\]]])
#src[Skript TM2 S. 5–6, 53, 61–69; TM2-Buch S. 2–3; → TM1 Kapitel 7.]
== TM2 0.2 Schnittgrößen am Rahmen mit Gelenk (Testat) <a-tm2-0-2>
Ein #strong[Rahmen] ist ein abgewinkelter Balken. Hier: Festlager A, Einzelmoment M#sub[0], Gelenk G, dreieckförmige Streckenlast bis q#sub[0] über 3l, Rahmenecke B, Horizontalkraft F an der Stütze, Festlager C. Wegen des Gelenks zerlegst du den Rahmen in #strong[zwei Teilsysteme]. Für jedes gibt es drei Gleichgewichtsbedingungen. Das ergibt 6 Gleichungen für 6 Unbekannte (A#sub[H], A#sub[V], G#sub[H], G#sub[V], C#sub[H], C#sub[V]).
#note([In eigenen Worten], [Ein Gelenk ist wie ein Scharnier an einer Tür: Es überträgt Kräfte, aber kein Moment. Darum ist das Moment im Gelenk immer null. #text(fill: muted)[(eigene Ergänzung)]])
#bild("tm2k0_rahmen", [Skript TM2 S. 8: Rahmenstruktur mit Gelenk G; gegeben l, q#sub[0], F, M#sub[0] (identisch mit dem Testat, Vorbereitung auf TM2 S. 4).], height: 45mm)
#heading(level: 3, outlined: false)[Vorgehen (Testat-Gliederung)]
+ #strong[Freikörperbild] zeichnen, Streckenlast durch ihre Resultierende ersetzen: Dreieck → $F_("res") = frac(1, 2) q_0 dot 3l = frac(3, 2) q_0 l$, Angriffspunkt bei 2/3 der Länge, also 2l rechts von G.
+ #strong[Statische Bestimmtheit] prüfen (weder kinematisch noch statisch unbestimmt).
+ #strong[Lager- und Gelenkreaktionen] aus dem Gleichgewicht.
+ #strong[Schnittgrößen] an ausgezeichneten Stellen: an A, vor/nach M#sub[0], vor/nach G, vor/nach der Rahmenecke, vor/nach F, an C.
+ #strong[Verläufe] zeichnen (mit Tabellenkalkulation, Vorbereitung auf TM2 S. 3).
#bild("tm2k0_rahmen_fkb", [Skript TM2 S. 9: Freikörperbild und Gleichgewicht für Teilsystem I (A–G) und Teilsystem II (G–B–C).], height: 45mm)
#heading(level: 3, outlined: false)[Gleichgewicht (Folie) und Lösung]
#form[$ "I:" quad A_V -G_V =0, wide A_H +G_H =0, wide attach(A, t: arrow.ccw) colon med M_0 -G_V thin l=0 $


$ "II:" quad G_V - frac(3, 2) q_0 l+C_V =0, wide -G_H -F+C_H =0, wide attach(G, t: arrow.ccw) colon med - frac(3, 2) q_0 l dot 2l+C_V dot 3l+C_H thin l-F thin frac(l, 2) =0 $



$ A_V =G_V = frac(M_0, l), quad C_V = frac(3, 2) q_0 l- frac(M_0, l), quad C_H = frac(F, 2) + frac(3M_0, l) - frac(3, 2) q_0 l, quad G_H =C_H -F, quad A_H =-G_H $]
Skript TM2 S. 9. Auflösen (selbst nachgerechnet, Richtungen wie im Freikörperbild der Folie):
#note([Beispiel (Folien S. 10–19): Schnittgrößen an ausgezeichneten Stellen.], [An jeder Stelle stellt die Folie das Gleichgewicht am #strong[positiven] Schnittufer (linkes Teil) und zur Kontrolle am #strong[negativen] Schnittufer (rechtes Teil) auf, z. B. direkt an A:
+ $arrow.b colon med Q-A_V =0 => Q=A_V$; $-> colon med N+A_H =0 => N=-A_H$; $M=0$ (an A greift kein Moment an).
+ Nach M#sub[0] (S. 12): $M-A_V frac(l, 2) +M_0 =0$. M springt an der Stelle von M#sub[0] um M#sub[0].
+ Nach der Rahmenecke (S. 16): Jetzt liegt die Stütze senkrecht. Aus der „alten“ Querkraft wird die Normalkraft und umgekehrt: $N=A_V - frac(3, 2) q_0 l$, $Q=A_H$.
+ An C (S. 19): Am negativen Ufer ist nur noch das Lager: $-M=0$. Das Moment am Gelenklager ist null – gute Kontrolle.], fill: pale)
#bild("tm2k0_rahmen_ecke", [Skript TM2 S. 16: Schnitt nach der Rahmenecke – in der Stütze tauschen N und Q die Rolle.], height: 45mm)
#note([Fehler vermeiden], [An der Rahmenecke drehst du das lokale Koordinatensystem mit. Wer in der Stütze weiter „horizontal = N“ rechnet, vertauscht N und Q. Ohne äußeres Moment an der Ecke ist M vor und nach der Ecke gleich.], fill: sand)
#bild("tm2k0_rahmen_verlauf", [Skript TM2 S. 20: Schnittgrößenverläufe N, Q, M über der „abgewickelten“ Struktur (Tabellenkalkulation, auf der Folie als „untypisch“ bezeichnet).], height: 45mm)
#note([Hinweise zum Testat (Vorbereitung auf TM2 S. 5 und 12)], [Abgabe als pdf; Gliederung mit Titelseite (Aufgabe mit Bild, Name, Matrikelnummer, Datum) und Ausarbeitung nach der Aufgabenstellung; Ausarbeitung in Druckform oder Handschrift, Handy-Fotos werden nicht akzeptiert.])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Gelenk als Kontrolle:] Am Gelenk muss das Biegemoment verschwinden – eine schnelle Probe deiner Lagerreaktionen. Ausführlich in TM1-Buch Kap. 7 (Balken, Rahmen, Bogen), siehe → TM1 Kapitel 7.])
#src[Skript TM2 S. 7–20; Vorbereitung auf TM2 S. 1–6; TM1-Buch Kap. 7.]
== TM2 0.3 Schnittgrößen am Balken: punktweise und mit Föppl <a-tm2-0-3>
Beim #strong[punktweisen] Weg schneidest du an jeder interessanten Stelle und rechnest mit dem Gleichgewicht. Beim #strong[bereichsweisen] Weg schreibst du die Belastung q(x) als eine einzige Formel über den ganzen Balken. Dafür nutzt du die #strong[Föppl-Klammer] (Bereichsoperator):
#form[$ chevron.l x-a chevron.r^n = cases(0 & x < a, (x-a)^n & x >= a), wide integral chevron.l x-a chevron.r^n d x= frac(chevron.l x-a chevron.r^(n+1), n+1) $]
$chevron.l x-a chevron.r^0$ ist ein „Schalter“: ab x = a wirkt die Größe. Einzelkräfte erscheinen in Q mit Exponent 0, in M mit Exponent 1.
#note([In eigenen Worten], [Die Föppl-Klammer ist wie eine Zeitschaltuhr: Vor 18 Uhr ist das Licht aus (0), ab 18 Uhr an. Mit mehreren Schaltuhren kannst du einen ganzen Tagesablauf in einer Zeile beschreiben. #text(fill: muted)[(eigene Ergänzung)]])
#bild("tm2k0_balken", [Skript TM2 S. 24: Balken mit Festlager A (x = 0), Loslager B (x = 2l), freiem Ende C (x = 3l); Streckenlast q#sub[0] auf 0 ≤ x ≤ l, Einzelkraft F in C.], height: 45mm)
#note([Beispiel (Folien S. 23–36): Balken mit Kragarm.], [Geg.: l = 1 m, q#sub[0] = 4 kN/m, F = q#sub[0]l = 4 kN. Ges.: Lagerreaktionen, Q(x), M(x).
+ #strong[Gleichgewicht] (S. 25): $arrow.t colon A-q_0 l+B_V -F=0$; $B_H =0$; $attach(B, t: arrow.ccw) colon -A dot 2l+q_0 l dot frac(3, 2) l-F thin l=0$. \
  
  $A= frac(1","5 thin q_0 l^2 -F l, 2l) = frac(6-4, 2) thin "kN" =1 thin "kN"$, $B_V =q_0 l+F-A=7 thin "kN"$.
+ #strong[Punktweise] (S. 27–31): an A: Q = 1 kN, M = 0; nach Streckenlast (x = l): Q = 1 − 4 = −3 kN, $M=A thin l- frac(1, 2) q_0 l^2 =-1 thin "kNm"$; vor B (x = 2l): Q = −3 kN, M = −4 kNm; nach B: Q = −3 + 7 = +4 kN; am Ende: Q = 4 kN, M = 0.
+ #strong[Föppl] (eigene, korrigierte Schreibweise, Lagerkräfte als bekannt eingesetzt): \
  
  $Q(x)=A-q_0 x+q_0 chevron.l x-l chevron.r +B_V chevron.l x-2l chevron.r^0 -F chevron.l x-3l chevron.r^0$ \
  
  $M(x)=A thin x- frac(1, 2) q_0 x^2 + frac(1, 2) q_0 chevron.l x-l chevron.r^2 +B_V chevron.l x-2l chevron.r -F chevron.l x-3l chevron.r$ \
  
  Probe: $M(3l)=3-18+8+7=0$ ✓. Extremum im ersten Feld bei Q = 0: x = 0,25 m, M = 0,125 kNm.], fill: pale)
#bild("tm2k0_foeppl", [Skript TM2 S. 32: allgemeine DGL mit Föppl-Klammern. Deine Notizen: Korrektur $q(x)=q_0 x^0 -q_0 chevron.l x-l chevron.r^0$, gelb markiert „+B#sub[V]“ und „−F“ mit der Überlegung zum Vorzeichen der Sprünge aus dem Freikörperbild.], height: 45mm)
#note([Von dir markiert (gelb, Skript TM2 S. 32)], [Die Vorzeichen der Sprünge im Q-Verlauf. Eine Kraft nach #strong[oben] (Lager B#sub[V]) lässt Q um +B#sub[V] springen, eine Kraft nach #strong[unten] (F) um −F. Außerdem hast du q(x) korrigiert: Die Streckenlast wirkt von 0 bis l, also $q(x)=q_0 chevron.l x chevron.r^0 -q_0 chevron.l x-l chevron.r^0$. Deine Notiz auf S. 27 „An A: (vor Streckenlast)“ heißt: der Schnitt liegt direkt an A, noch bevor Streckenlast mitgenommen wird.], fill: sand)
#note([Fehler auf der Folie (S. 25, 28, 32–33)], [- S. 25: „$A= frac(1, 2) F= frac(4, 2) thin "kN" =1 thin "kN"$“ – die Zwischenschritte stimmen nicht (4/2 = 2). Richtig: $A= frac(1, 4) F=1 thin "kN"$ (aus der Momentengleichung oben). Das Endergebnis 1 kN ist richtig.
- S. 28: „nach Streckenlast M = 0 kNm“ – falsch. Aus der eigenen Gleichung der Folie $M-A thin l+q_0 l dot frac(1, 2) l=0$ folgt $M=1-2=-1 thin "kNm"$. Die Wertetabelle der Folie (S. 36) zeigt bei x = 1 m ebenfalls M = −1.
- S. 32–33: Die Lagerkraft B#sub[V] steht mit $chevron.l x-l chevron.r$. B liegt aber bei x = 2l, richtig ist $B_V chevron.l x-2l chevron.r^0$ in Q und $B_V chevron.l x-2l chevron.r$ in M (so auch die Momentengleichung „vor B“ auf S. 29).], fill: sand)
#bild("tm2k0_balken_plot", [Skript TM2 S. 35: Tabellenkalkulation mit Föppl – Werte und Verläufe von N, Q, M über x.], height: 45mm)
#note([Merke], [Q springt an Einzelkräften und Lagern, M springt an Einzelmomenten. Wo Q = 0 ist, hat M ein Extremum. An einem freien Ende und an einem Gelenk ist M = 0.])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Zusammenhänge q – Q – M:] q = 0 → Q konstant, M linear; q konstant → Q linear, M quadratische Parabel; q linear → Q Parabel, M kubische Parabel (Tab. 7.1). #text(fill: muted)[\[TM1-Buch S. 182\]]
- #strong[Maximum des Moments:] Das absolute Maximum von M kann auch an einem Balken- oder Feldende liegen, nicht nur bei Q = 0. #text(fill: muted)[\[TM1-Buch S. 182\]]])
#src[Skript TM2 S. 21–37; Vorbereitung auf TM2 S. 7–13; TM1-Buch S. 181–182; → TM1 Kapitel 7.]
== TM2 0.4 DGL der Schnittgrößen Q, M und N <a-tm2-0-4>
Du schneidest aus dem Balken ein winziges Stück der Länge dx heraus. Auf dieser kurzen Länge darfst du die Streckenlast als konstant ansehen. Links greifen N, Q, M an, rechts N + dN, Q + dQ, M + dM. Gleichgewicht an diesem Element liefert, wie sich die Schnittgrößen #strong[pro Längeneinheit ändern].
#note([In eigenen Worten], [Wie beim Kontostand: Die Änderung pro Tag (Ableitung) ist gleich Einzahlung minus Auszahlung pro Tag (Streckenlast). Kennst du den Startwert (Randbedingung), kennst du den ganzen Verlauf. #text(fill: muted)[(eigene Ergänzung)]])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k0_dgl_q", [Skript TM2 S. 42: Gleichgewicht für Q.], height: 50mm)],
 [#bild("tm2k0_dgl_m", [Skript TM2 S. 43: Gleichgewicht für M.], height: 50mm)])
#heading(level: 3, outlined: false)[Herleitung]
+ #strong[Kräfte in z:] $-Q+q thin d x+(Q+d Q)=0 => d Q=-q thin d x$.
+ #strong[Momente um den rechten Schnittpunkt:] $-M+(M+d M)-Q thin d x+q thin d x thin frac(d x, 2) =0$. Das Glied mit $d x^2$ ist „klein von höherer Ordnung“ und fällt weg: $d M=Q thin d x$.
+ #strong[Kräfte in x] (Längslast n(x)): $-N+n thin d x+(N+d N)=0 => d N=-n thin d x$.
#form[$ frac(d Q, d x) =-q(x), wide frac(d M, d x) =Q(x), wide frac(d^2 M, d x^2) =-q(x), wide frac(d N, d x) =-n(x) $]
Einheiten: q, n in N/m; Q, N in N; M in Nm. Gleichungen (1)–(3) der Folien S. 42, 43, 49 in korrigierter Form.
#bild("tm2k0_dgl_n", [Skript TM2 S. 49: Gleichgewicht am Element für die Normalkraft unter Längslast n(x).], height: 45mm)
#note([Fehler auf der Folie (S. 42, 43, 49)], [- Die Ergebnisse stehen dort als „$frac(d Q, d x) =-q(x) dot d x$“, „$frac(d M, d x) =Q(x) dot d x$“, „$frac(d N, d x) =-n(x) dot d x$“. Das „· dx“ ist zu viel: links steht eine Ableitung, rechts dann eine unendlich kleine Größe – die Einheiten passen nicht. Richtig ist $d Q = -q thin d x$ #emph[oder] $frac(d Q, d x) =-q$ (ebenso für M und N).
- S. 43: In der Momentengleichung steht $+(Q+d Q) thin d x$. Mit diesem Vorzeichen käme $d M/d x=-Q$ heraus, nicht das angegebene $+Q$. Konsistent ist das Momentengleichgewicht um den rechten Schnittpunkt wie oben (Querkraft Q am linken Ufer mit Hebelarm dx, Vorzeichen minus); so steht es auch im Buch, Gl. (7.5). Das Ergebnis $d M/d x = Q$ ist richtig.
- S. 49: Die Streckenlast heißt n(x) = n#sub[0], in der Gleichung steht aber „q#sub[0]·dx“ – nur ein Schreibfehler, gemeint ist n#sub[0].], fill: sand)
#note([Merke ★], [$N' = -n$ ist der Startpunkt von Kapitel 1. Zusammen mit $sigma = N/A$, $epsilon = d u/d x$ und $sigma = E epsilon$ entsteht daraus die Stab-DGL $E A thin u''=-n$ (Skript TM2 S. 248).])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Herleitung im Buch:] $Q-q thin d x-(Q+d Q)=0$ (Kräfte nach oben positiv) und Momentengleichgewicht um den rechten Rand liefern $d Q/d x=-q$ (7.6) und $d M/d x=Q$ (7.7), daraus $M''=-q$ (7.8). #text(fill: muted)[\[TM1-Buch S. 181–182\]]
- #strong[Normalkraft:] Gleichgewicht am Stabelement $N+d N+n thin d x-N=0$ ergibt $frac(d N, d x) +n=0$ (1.13). Ohne Längslast ist N konstant. #text(fill: muted)[\[TM2-Buch S. 13–14\]]])
#src[Skript TM2 S. 37–51; TM1-Buch S. 181–182; TM2-Buch S. 13–14.]

#bild("map-t2k0", [Mindmap: Schnittgrößen als Grundlage von TM2. Eigene Darstellung nach Skript TM2 S. 5–51.], height: 44mm)

*Der Zusammenhang in TM2 Kapitel 0.* TM2 setzt auf TM1 auf: Ohne Schnittgrößen keine Spannungen. Du schneidest, zeichnest die Schnittgrößen positiv ein und rechnest das Gleichgewicht, entweder an einzelnen Stellen oder für den ganzen Balken mit Föppl-Klammern. Die drei Ableitungen $Q' = -q$, $M' = Q$ und $N' = -n$ verbinden Belastung und Schnittgrößen. Die letzte davon ist der Startpunkt für Kapitel 1, wo aus der Normalkraft Spannung und Dehnung werden.

#pagebreak()
== Verständnisfragen und Rechenaufgaben · TM2 Kapitel 0
#set enum(spacing: 0.85em)
Erkläre erst selbst. Bei Rechenaufgaben: Freikörperbild, Gleichgewicht, Schnitt, Kontrolle. Die Lösungen folgen getrennt.

+ Was ist der Unterschied zwischen einer Schnittgröße und einer Spannung?
+ Wie sind positive N und Q am positiven Schnittufer definiert?
+ Warum zerlegt man den Rahmen aus TM2 0.2 in zwei Teilsysteme? Wie viele Gleichungen und Unbekannte gibt es?
+ Was passiert mit N und Q, wenn du um eine 90°-Rahmenecke herumgehst?
+ Welche Aufgabe hat die Föppl-Klammer $chevron.l x-a chevron.r^0$?
+ An welchen Stellen springt Q, an welchen M?
+ Wo kannst du zur Kontrolle sicher M = 0 erwarten?
+ Warum darf bei der Herleitung der DGL das Glied $q thin d x dot d x/2$ vernachlässigt werden?
+ Beim Balken aus TM2 0.3 sei F = 6 kN (sonst gleich: l = 1 m, q#sub[0] = 4 kN/m). Berechne A und B#sub[V]. #text(fill: muted)[(eigene Aufgabe)]
+ Bestimme für den Balken aus TM2 0.3 (F = 4 kN) das größte positive Moment im ersten Feld und seine Lage. #text(fill: muted)[(eigene Aufgabe)]
+ Ein Kragträger (eingespannt bei x = 0, Länge 2 m) trägt eine konstante Streckenlast q = 3 kN/m. Gib Q(x) und M(x) an (freies Ende bei x = 2 m). #text(fill: muted)[(eigene Aufgabe)]
+ Rahmen aus TM2 0.2 mit l = 1 m, q#sub[0] = 2 kN/m, F = 4 kN, M#sub[0] = 3 kNm: Berechne A#sub[V], C#sub[V], C#sub[H]. #text(fill: muted)[(eigene Aufgabe)]

#heading(level: 3, outlined: false)[Vertiefende Verständnisfragen und Rechenaufgaben]
#block[
#set enum(start: 13)
+ *Testat „Schnittgrößen an Rahmenstruktur“* (Vorbereitung auf TM2 S. 2–4): Rahmen aus 0.2. Prüfe die statische Bestimmtheit, bestimme Lager- und Gelenkreaktionen und die Schnittgrößen an allen ausgezeichneten Stellen.
+ *Testat „Schnittgrößen an Balkenstruktur“* (Vorbereitung auf TM2 S. 8–11): Balken aus 0.3 mit $l = 1$ m, $q_0 = 4$ kN/m, $F = 4$ kN. Bestimme Lagerreaktionen, $Q(x)$ und $M(x)$ punktweise und mit Föppl-Klammern.
+ *Buch:* Welche Form hat M, wenn q linear verläuft? (TM1-Buch S. 182)
+ *Buch:* Was folgt aus $d N/d x + n = 0$, wenn keine Längslast wirkt? (TM2-Buch S. 14)
+ *Buch:* Welche drei Arten von Gleichungen braucht man in der Elastostatik? (TM2-Buch S. 2)
]

#pagebreak()
== Lösungen TM2 Kapitel 0
#set enum(spacing: 0.65em)
+ Schnittgröße = Resultierende der inneren Kräfte (N, Q, M in N bzw. Nm); Spannung = innere Kraft pro Fläche (N/mm²), z. B. σ = N/A. #nachschlagen[Lernskript, #stelle(<a-tm2-0-1>)]
+ Positives Ufer: äußere Normale in +x; N zeigt in +x (Zug positiv), Q zeigt in +z (nach unten). #nachschlagen[Lernskript, #stelle(<a-tm2-0-1>)]
+ Wegen des Gelenks ist das Gesamtsystem allein mit 3 Gleichungen nicht lösbar. Zwei Teilsysteme liefern 2 × 3 = 6 Gleichungen für 6 Unbekannte (A#sub[H], A#sub[V], G#sub[H], G#sub[V], C#sub[H], C#sub[V]). #nachschlagen[Lernskript, #stelle(<a-tm2-0-2>)]
+ Das lokale Koordinatensystem dreht mit: Die Kraft, die im Riegel Querkraft war, wird in der Stütze Normalkraft (und umgekehrt). M bleibt ohne äußeres Eckmoment gleich. #nachschlagen[Lernskript, #stelle(<a-tm2-0-2>)]
+ Sie schaltet einen Term erst ab x = a ein; so lässt sich die Belastung über alle Bereiche in einer Formel schreiben. #nachschlagen[Lernskript, #stelle(<a-tm2-0-3>)]
+ Q springt an Einzelkräften und Lagerkräften; M springt an Einzelmomenten. #nachschlagen[Lernskript, #stelle(<a-tm2-0-3>)]
+ An freien Enden, an Gelenken und an gelenkigen Endlagern (ohne äußeres Moment dort). #nachschlagen[Lernskript, #stelle(<a-tm2-0-3>)]
+ Es ist von der Größenordnung dx², also klein gegenüber den Gliedern mit dx bzw. dM („klein von höherer Ordnung“). #nachschlagen[Lernskript, #stelle(<a-tm2-0-4>)]
+ $A=(1","5 dot 4 dot 1^2 -6 dot 1)/2=0 thin "kN"$; $B_V =q_0 l+F-A=4+6-0=10 thin "kN"$. #nachschlagen[Lernskript, #stelle(<a-tm2-0-3>)]
+ Q(x) = 1 − 4x = 0 → x = 0,25 m; $M=0","25-2 dot 0","25^2 =0","125 thin "kNm"$. #nachschlagen[Lernskript, #stelle(<a-tm2-0-3>)]
+ Vom freien Ende her: $Q(x)=q(2-x)=3(2-x) thin "kN"$; $M(x)=- frac(q, 2) (2-x)^2 =-1","5(2-x)^2 thin "kNm"$. Probe: $M'=3(2-x)=Q$ ✓; Einspannmoment M(0) = −6 kNm. #nachschlagen[Lernskript, #stelle(<a-tm2-0-4>)]
+ $A_V =M_0 /l=3 thin "kN"$; $C_V =1","5 dot 2 dot 1-3=0 thin "kN"$; $C_H =4/2+3 dot 3-1","5 dot 2=2+9-3=8 thin "kN"$. #nachschlagen[Lernskript, #stelle(<a-tm2-0-2>)]
+ Siehe 0.2: $A_V = G_V = M_0\/l$, $C_V = frac(3, 2) q_0 l - M_0\/l$, $C_H = F\/2 + 3 M_0\/l - frac(3, 2) q_0 l$, $G_H = C_H - F$, $A_H = -G_H$. Kontrolle: $M = 0$ am Gelenk und an $C$. #nachschlagen[Lernskript, #stelle(<a-tm2-0-2>)\; Skript TM2 S. 9–19]
+ $A = 1$ kN, $B_V = 7$ kN; $Q$: 1 kN bei A, −3 kN nach der Streckenlast und vor B, +4 kN nach B; $M$: 0, −1 kNm bei $x = l$, −4 kNm bei B, 0 am Ende; $M_(max) = "0,125"$ kNm bei $x = "0,25"$ m. #nachschlagen[Lernskript, #stelle(<a-tm2-0-3>)\; Skript TM2 S. 23–36]
+ Kubische Parabel (Q ist dann eine quadratische Parabel). #nachschlagen[Lernskript, #stelle(<a-tm2-0-3>)\; TM1-Buch S. 182]
+ N ist konstant. #nachschlagen[Lernskript, #stelle(<a-tm2-0-4>)\; TM2-Buch S. 14]
+ Gleichgewichtsbedingungen, kinematische Beziehungen, Elastizitätsgesetz. #nachschlagen[Lernskript, #stelle(<a-tm2-0-1>)\; TM2-Buch S. 2]

#pagebreak()
= TM2 Kapitel 1 · Zug und Druck in Stäben <k-tm2-1>
#tab(columns: 2,
 [Vorlesungen], [VL 23.3.26 → Abschnitte TM2 1.1–1.3 (Skript TM2 S. 52–226; dein Vermerk „/\/ 23.3.26“ auf S. 226); danach Spannungs-Dehnungs-DGL und statisch unbestimmter Stab (S. 227–270, ohne Datumsvermerk) → TM2 1.4. Mitschriften: WZF 23.3.26 (1. Übung, Normalspannung), 30.3.26 (Dehnung und Verschiebung), 13.4.26 (statisch unbestimmt), 20.4.26 (Schraube, Verschiebungsplan)],
 [Quellen], [Skript TM2 S. 52–106 (Spannungen, schräger Schnitt, Aufgaben Wasserturm, Pyramidenstumpf, hängender Balken) und S. 214–270 (DGL der Normalkraft, Dehnung, Werkstoffgesetz, Festigkeitsberechnung, Spannungs-Dehnungs-DGL, statisch unbestimmtes System); FS TM2 S. 4–10; TM2-Buch S. 3–33. Hinweis: Skript S. 133–213 ist eine Kopie von S. 52–132.],
 [Passende Übungen], [Übung TM2 Nr. 1 (Spannung), Nr. 2 (Dehnung und Verschiebung), Nr. 3 (statisch unbestimmt, Wärme), Nr. 4 (Schraube, Stabsysteme); Lösungen zu Nr. 1, 2, 4 vorhanden, zu Nr. 3 fehlt die Lösung (hier vollständig vorgerechnet).; dazu Altklausur-Aufgaben am Ende der vertiefenden Fragen],
)
In TM1 war ein Stab starr: Er hat nur Kraft weitergeleitet. Jetzt fragst du zwei neue Dinge. #strong[Hält der Stab?] Das sagt die Spannung $sigma = N\/A$. #strong[Wie stark verformt er sich?] Das sagen Dehnung und Verschiebung. Beides verbindet das Stoffgesetz (Hooke). Mit diesen drei Bausteinen (Gleichgewicht, Kinematik, Stoffgesetz) löst du auch Systeme, bei denen das Gleichgewicht allein nicht reicht: die #strong[statisch unbestimmten] Systeme.
#note([Dein Feynman-Schritt: die 5 Kernideen von Kapitel 1. Erst ohne Skript aufzählen und erklären, dann vergleichen.], [+ #strong[Spannung = Kraft pro Fläche:] $sigma = N\/A$. Zug positiv, Druck negativ. Bemessung: $A_("erf") = |N|\/sigma_("zul")$.
+ #strong[Die Schnittrichtung zählt:] Im schrägen Schnitt treten $sigma$ und $tau$ auf; $tau$ ist unter 45° am größten ($sigma_0\/2$).
+ #strong[Dehnung = Ableitung der Verschiebung:] $epsilon = d u\/d x$, umgekehrt $u = integral epsilon d x$, $Delta l = integral_0^l epsilon d x$.
+ #strong[Stoffgesetz:] $epsilon = sigma\/E + alpha_T Delta T$ (mechanisch plus thermisch). Für $E A$, $N$ konstant: $Delta l = F l\/(E A) + alpha_T Delta T l$.
+ #strong[Statisch unbestimmt:] Lager lösen, Unbekannte $X$ einführen, Verformungen rechnen und eine #strong[Kompatibilitätsbedingung] (Verträglichkeit) aufstellen.
Zusammenfassung der Abschnitte TM2 1.1–1.6; Quellen stehen dort.])

== TM2 1.1 Spannung <a-tm2-1-1>
Die Normalkraft $N$ ist die Summe aller inneren Kräfte im Querschnitt. Bei einem Stab mit konstantem Querschnitt verteilt sie sich #strong[gleichmäßig] über die Fläche $A$. Die Kraft pro Fläche heißt #strong[Normalspannung] $sigma$ (sie steht senkrecht, „normal“, auf der Schnittfläche).
#form[$ sigma = N/A quad ["N/mm"^2 = "MPa"] wide sigma(x) = (N(x))/(A(x)) quad "(allgemein, wenn sich N oder A ändern)" $]
#note([In eigenen Worten], [Eine Menschenmenge drückt gegen eine Tür. Ob die Tür bricht, hängt nicht nur von der Gesamtkraft ab, sondern davon, auf wie viel Türfläche sie sich verteilt. Die Spannung ist dieser „Druck pro Fläche“. #text(fill: muted)[(eigene Ergänzung)]])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k1_normal", [Skript TM2 S. 63: Normalspannung beim Zug- oder Druckstab, $sigma_(Z\/D) = F\/A = N\/A$.], height: 52mm)],
 [#bild("tm2k1_scher", [Skript TM2 S. 65: Scherspannung unter Querkraft, $tau_S = F\/A_S = Q\/A_S$.], height: 52mm)])
Die Folien S. 62–69 ordnen jeder Schnittgröße eine Spannung zu: Normalkraft → $sigma = N\/A$, Querkraft → $tau_S = Q\/A_S$ (Scherfläche $A_S$, bei symmetrischen Querschnitten $= A$), Biegemoment → $sigma_B = M_B\/W_B$ (→ TM2 Kapitel 4), Torsionsmoment → $tau_T = M_T\/W_T$ (→ TM2 Kapitel 5). In diesem Kapitel geht es nur um $N$.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k1_biege", [Skript TM2 S. 67: Biegespannung, außen am größten (Druck oben, Zug unten).], height: 40mm)],
 [#bild("tm2k1_torsion", [Skript TM2 S. 69: Torsionsspannung an der Welle, außen am größten.], height: 40mm)])
#heading(level: 3, outlined: false)[Vorzeichen und Bemessung]
- #strong[Zug:] $N > 0$, also $sigma > 0$. #strong[Druck:] $N < 0$, also $sigma < 0$.
- Ein Bauteil hält, wenn $|sigma| <= sigma_("zul")$. Daraus folgt der #strong[erforderliche Querschnitt] (FS TM2 S. 4, Gl. 1.3):
#form[$ A_("erf") = (|N|)/sigma_("zul") wide "bzw." wide F_("zul") = sigma_("zul") dot A $]
#note([Achtung: Einheiten], [Rechne Spannungen in N/mm². In den Mitschriften steht oft N/cm²: $1 thin "N/cm"^2 = "0,01" thin "N/mm"^2$. Ein Stab mit $A = 1 thin "cm"^2 = 100 thin "mm"^2$ und $F = 10 thin "kN"$ hat $sigma = 100 thin "N/mm"^2$. #text(fill: muted)[(eigene Ergänzung)]], fill: sand)

#heading(level: 3, outlined: false)[Schräger Schnitt: σ und τ hängen von der Schnittrichtung ab]
Schneidet man den Zugstab nicht senkrecht, sondern unter dem Winkel $phi$, ist die Schnittfläche größer ($A^* = A\/cos phi$) und die Schnittkraft zerfällt in einen Anteil senkrecht (Normalspannung $sigma$) und einen Anteil in der Fläche (Schubspannung $tau$). Aus dem Gleichgewicht in zwei Richtungen (Skript TM2 S. 77–83) folgt mit $sigma_0 = F\/A$:
#form[$ sigma = frac(1, 2) sigma_0 (1 + cos 2 phi), wide tau = frac(1, 2) sigma_0 sin 2 phi $]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k1_schraeg", [Skript TM2 S. 77: Gleichgewicht am schräg geschnittenen Stab (Winkel $phi$, Fläche $A^*$).], height: 50mm)],
 [#bild("tm2k1_trafo_kreis", [Skript TM2 S. 84: Transformationsregeln und ihr Bild als Kreis (Vorgriff auf den Mohrschen Kreis).], height: 50mm)])
- $phi = 0$ (gerader Schnitt): $sigma = sigma_0$, $tau = 0$ (Skript S. 85).
- $phi = 45°$: $sigma = sigma_0\/2$ und $tau = tau_(max) = sigma_0\/2$ (Skript S. 86).
#note([Merke], [Ein Zugstab trägt auch Schub, nur eben in schrägen Schnitten. Werkstoffe mit geringer Schubfestigkeit können deshalb unter 45° versagen. Der Kreis auf S. 84 ist der Mohrsche Kreis aus → TM2 Kapitel 2 im Sonderfall einachsiger Zug.])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- Herleitung der Formeln über das Gleichgewicht am schräg geschnittenen Stab, Gl. (1.3); größte Normalspannung $sigma_0$ bei $phi = 0$, größte Schubspannung $sigma_0\/2$ bei $phi = plus.minus pi\/4$. #text(fill: muted)[\[TM2-Buch S. 4–5\]]
- Nahe am Krafteinleitungspunkt und an Kerben ist $sigma$ nicht gleichförmig (Spannungskonzentration); $sigma = N\/A$ gilt mit genügendem Abstand. #text(fill: muted)[\[TM2-Buch S. 5\]]
- Bemessung mit $|sigma| <= sigma_("zul")$ und $A_("erf")$. #text(fill: muted)[\[TM2-Buch S. 6\]]])

#heading(level: 3, outlined: false)[Beispiel aus der 1. Übung (WZF 23.3.26): Masse an zwei Seilen]
Eine Masse ($G = 10$ N) hängt an zwei Seilen (60° und 30° zur Decke), die über Klebestellen mit der Decke verbunden sind. Gesucht: $sigma_1, sigma_2$ in den Seilen und $sigma, tau$ in den Klebestellen 3 und 4.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k1_w233_1", [WZF 23.3.26 S. 1: Formeln, Aufgabe und Freikörperbild am Knoten.], height: 95mm)],
 [#bild("tm2k1_w233_2", [WZF 23.3.26 S. 2: Seilkräfte, Spannungen in den Seilen und in den Klebestellen.], height: 95mm)])
#note([Beispiel 1 (WZF 23.3.26)], [+ Gleichgewicht am Knoten: $S_1 = G cos 30° = "8,66" thin "N"$, $S_2 = G sin 30° = 5 thin "N"$.
+ Seile: $sigma_1 = S_1\/A_1 = "8,66"\/"0,02" = 433 thin "N/cm"^2$, $sigma_2 = 5\/"0,01" = 500 thin "N/cm"^2$.
+ Klebestelle 3 ($A_3 = "0,75" thin "cm"^2$): $S_1$ zerlegen in $N_3 = S_1 sin 60° = "7,5" thin "N"$ (senkrecht zur Fläche) und $T_3 = S_1 cos 60° = "4,33" thin "N"$ (in der Fläche) → $sigma_3 = 10 thin "N/cm"^2$, $tau_3 = "5,8" thin "N/cm"^2$.
+ Klebestelle 4 ($A_4 = "0,5" thin "cm"^2$): $N_4 = S_2 sin 30° = "2,5" thin "N"$, $T_4 = S_2 cos 30° = "4,33" thin "N"$ → $sigma_4 = 5 thin "N/cm"^2$, $tau_4 = "8,66" thin "N/cm"^2$.], fill: pale)
#heading(level: 3, outlined: false)[Beispiel 2 (WZF 23.3.26): Hängender Stab, schräge Schnitte]
Ein Stab ($gamma = "0,08" thin "N/cm"^3$, $A = 10 thin "cm"^2$, $L = 80 thin "m"$) hängt an der Decke und trägt unten $G = 3600$ N. Größte Längskraft oben: $L = G + gamma A L = 3600 + 6400 = 10000 thin "N"$. Unter dem Winkel $alpha$ zur Stabachse geschnitten gilt $sigma = (L\/A) sin^2 alpha$, $tau = (L\/A) sin alpha cos alpha$.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k1_w233_3", [WZF 23.3.26 S. 3: Hängender Stab, Schnitt im Punkt C unter 30°, 60°, 90°.], height: 95mm)],
 [#bild("tm2k1_w233_4", [WZF 23.3.26 S. 4: Zahlenwerte und Mindestquerschnitt $A_(min)$.], height: 45mm)])
#note([Fehler in der Mitschrift (WZF 23.3.26 S. 4)], [Dort steht $sigma_1 = 10.000 thin "N/cm"^2$. Richtig ist für den senkrechten Schnitt ($alpha = 90°$): $sigma_1 = L\/A = 10000 thin "N" \/ 10 thin "cm"^2 = 1000 thin "N/cm"^2$, $tau_1 = 0$. Die übrigen Werte passen: $sigma_2 = 750$, $tau_2 = 433$ ($alpha = 60°$), $sigma_3 = 250$, $tau_3 = 433 thin "N/cm"^2$ ($alpha = 30°$). Für $A_(min) = G\/(sigma_("zul") - gamma L) = "4,16" thin "cm"^2$ fehlt in der Mitschrift der Wert von $sigma_("zul")$; die Formel selbst stimmt.], fill: sand)

#heading(level: 3, outlined: false)[Veränderlicher Querschnitt: Aufgaben aus dem Skript]
Ändern sich $N$ oder $A$ entlang $x$, rechnest du $sigma(x) = N(x)\/A(x)$ punktweise. Das Skript zeigt drei Fälle:
- #strong[Konischer Rundstab] (S. 87, handschriftlich): Radius linear $r(x) = r_0 (1 + x\/L)$, also $sigma(x) = F \/ (pi r_0^2 (1 + x\/L)^2)$. Die Spannung fällt zum dicken Ende hin quadratisch ab.
- #strong[Wasserturm] (S. 91–94): Wie muss die Stütze geformt sein, damit unter Behälterlast $G_0$ und Eigengewicht überall dieselbe Spannung $sigma_0$ herrscht? Gleichgewicht am Scheibchen $d x$ liefert $sigma_0 d A = rho g A d x$, also $A(x) = A_0 e^(rho g x \/ sigma_0)$ und $r(x) = sqrt(r_i^2 + G_0\/(pi sigma_0) e^(rho g x\/sigma_0))$.
- #strong[Pyramidenstumpf] (S. 96–102): quadratischer Querschnitt mit linear wachsender Seitenlänge $y(x) = (b-a)\/h dot x + a$, also $A(x) = y(x)^2$.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k1_konisch", [Skript TM2 S. 87: Anwendungsfall konischer Rundstab (handschriftliche Folie).], height: 80mm)],
 [#bild("tm2k1_wasserturm", [Skript TM2 S. 91: Aufgabe Wasserturm.], height: 38mm)
  #bild("tm2k1_wasserturm_lsg", [Skript TM2 S. 94: Lösung durch Trennung der Variablen.], height: 38mm)])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k1_pyramide", [Skript TM2 S. 96: Aufgabe Pyramidenstumpf unter Druckkraft F.], height: 42mm)],
 [#bild("tm2k1_pyramide_lsg", [Skript TM2 S. 101: angegebene Spannung $sigma(x) = (rho A(x) x g - F)\/A(x)$.], height: 42mm)])
#note([Fehler auf der Folie (Skript TM2 S. 100–102)], [Auf S. 100 wird das Volumen bis zur Stelle $x$ als $V(x) = A(x) dot x$ angesetzt. Das gilt nur für ein Prisma mit konstantem Querschnitt. Beim Pyramidenstumpf ist der Querschnitt oben kleiner, also ist $A(x) dot x$ zu groß. Richtig ist die „alternative Berechnung“ auf S. 102: $V(x) = integral_0^x A(xi) d xi = ((b-a)\/h)^2 x^3\/3 + (a(b-a)\/h) x^2 + a^2 x$. Die Folie behauptet, beides ergebe dasselbe; das stimmt nicht. Für die Spannung nimm $sigma(x) = -(F + rho g V(x))\/A(x)$ (Druck negativ). Die Folie schreibt außerdem $rho g V - F$ im Zähler; Eigengewicht und $F$ drücken aber beide, haben also dasselbe Vorzeichen.], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [Turm mit überall gleicher Druckspannung $sigma_0$ unter Eigengewicht: dieselbe Idee wie der Wasserturm, Lösung mit der e-Funktion. #text(fill: muted)[\[TM2-Buch S. 7\]]])
#src[Skript TM2 S. 53, 61–106; FS TM2 S. 4; WZF 23.3.26 S. 1–4; TM2-Buch S. 3–7.]

== TM2 1.2 Verschiebung und Dehnung <a-tm2-1-2>
Unter Last verschiebt sich jeder Punkt des Stabs ein Stück: die #strong[Verschiebung] $u(x)$. Wie stark ein kleines Stück $d x$ dabei gestreckt wird, sagt die #strong[Dehnung]:
#form[$ epsilon = (Delta l)/l_0 quad "(global)" wide epsilon(x) = (d u)/(d x) quad "(lokal)" wide u(x) = integral epsilon(x) thin d x + C wide Delta l = u(l) - u(0) = integral_0^l epsilon(x) thin d x $]
Die Dehnung hat keine Einheit (mm/mm), oft in % oder ‰ angegeben. Bei konstanter Dehnung ist die lokale gleich der globalen Dehnung. Ändert sich $epsilon$ entlang $x$, musst du integrieren (FS TM2 S. 4–6, Gl. 1.4–1.11).
#bild("tm2k1_dehnung", [Skript TM2 S. 224: Ein Band wird gezogen; die Markierung der Länge $d x$ wird um $d u$ länger, daraus $epsilon = d u\/d x$.], height: 50mm)
#note([In eigenen Worten], [Ein Gummiband mit aufgemalten Strichen: Ziehst du daran, wandern die Striche (Verschiebung $u$) und ihr Abstand wird größer (Dehnung $epsilon$). Wo das Band dünner ist, wächst der Abstand stärker. #text(fill: muted)[(eigene Ergänzung)]])
#note([Achtung: typischer Fehler], [$u$ ist eine Länge (mm), $epsilon$ ist dimensionslos. $Delta l$ ist die Verschiebung des Stabendes gegenüber dem Anfang, also $u(l) - u(0)$, nicht $epsilon$ selbst.], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [Dehnung als Verhältnis von Längenänderung zu Ausgangslänge; lokale Dehnung $epsilon = d u\/d x$, Gl. (1.6). #text(fill: muted)[\[TM2-Buch S. 8–10\]]])
#src[Skript TM2 S. 222–224; FS TM2 S. 4–6; TM2-Buch S. 8–10.]

== TM2 1.3 Stoffgesetz <a-tm2-1-3>
Spannung (Kraftgröße) und Dehnung (Weggröße) verbindet das #strong[Stoffgesetz]. Im elastischen Bereich gilt das #strong[Hookesche Gesetz]: Spannung und Dehnung sind proportional. Dazu kommt die Wärmedehnung.
#form[$ sigma = E dot epsilon wide epsilon_T = alpha_T Delta T wide epsilon = sigma/E + alpha_T Delta T wide sigma = E (epsilon - alpha_T Delta T) $]
- $E$: Elastizitätsmodul in N/mm² (Stahl $E approx 2","1 dot 10^5 thin "N/mm"^2$, Aluminium $approx 0","7 dot 10^5$).
- $alpha_T$: Wärmeausdehnungskoeffizient in 1/K (Stahl $approx 1","2 dot 10^(-5)$, Aluminium $approx 2","3 dot 10^(-5)$).
- $E A$ heißt #strong[Dehnsteifigkeit]: Je größer, desto weniger dehnt sich der Stab unter derselben Kraft.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k1_werkstoff", [Skript TM2 S. 228: mechanische und thermische Einwirkung; $epsilon = sigma\/E + alpha_T Delta T$.], height: 48mm)],
 [#bild("tm2k1_zugversuch", [Skript TM2 S. 236: Zugversuch, duktiler Werkstoff (Streckgrenze $R_e$, Zugfestigkeit $R_m$) und spröder Werkstoff ($R_(p 0","2)$).], height: 48mm)])
#bild("tm2k1_w303_1", [WZF 30.3.26 S. 1: Formeln zu Dehnung und Verschiebung, unten gelb markiert „E·A ≙ Dehnsteifigkeit“.], height: 70mm)
#note([Von dir markiert (gelb, WZF 30.3.26 S. 1)], [„$E dot A$ ≙ Dehnsteifigkeit“. Merke dir: Kraft geteilt durch Dehnsteifigkeit ergibt die Dehnung, $epsilon = N\/(E A)$. In fast jeder Formel dieses Kapitels steht $E A$ im Nenner.], fill: sand)
#note([In eigenen Worten], [$E$ ist die „Härte der Feder“ des Werkstoffs, $A$ die Zahl der parallel geschalteten Federn. Erst beides zusammen ($E A$) sagt, wie steif der ganze Stab ist. #text(fill: muted)[(eigene Ergänzung)]])
#note([Merke], [Wärme allein erzeugt #strong[keine] Spannung, solange sich der Stab frei ausdehnen kann. Spannung entsteht erst, wenn Lager die Ausdehnung behindern (statisch unbestimmt, → 1.4 und 1.6).])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- Spannungs-Dehnungs-Diagramm aus dem Zugversuch: Proportionalitätsgrenze, Fließgrenze, Zugfestigkeit. #text(fill: muted)[\[TM2-Buch S. 10–11\]]
- Hookesches Gesetz $sigma = E epsilon$, Wärmedehnung $epsilon_T = alpha_T Delta T$, Überlagerung zu $epsilon = sigma\/E + alpha_T Delta T$. #text(fill: muted)[\[TM2-Buch S. 11–12\]]])
#src[Skript TM2 S. 226–242; FS TM2 S. 6–7; WZF 30.3.26 S. 1; TM2-Buch S. 10–12.]

== TM2 1.4 Berechnung von Stäben <a-tm2-1-4>
#heading(level: 3, outlined: false)[Statisch bestimmter Einzelstab: der Lösungsweg]
Beim statisch bestimmten Stab läuft die Rechnung immer gleich (FS TM2 S. 7, Gl. 1.19):
#form[$ N(x) arrow.r^(1\/A) sigma(x) arrow.r^(1\/E thin + thin alpha_T Delta T) epsilon(x) arrow.r^(integral d x) u(x), Delta l $]
Sonderfälle (FS S. 8, Gl. 1.24–1.26): Ist $E$, $A$ und $N = F$ konstant, gilt
#form[$ Delta l = (F l)/(E A) + alpha_T Delta T l wide "(ohne Wärme:" Delta l = (F l)/(E A) ")" $]
#heading(level: 3, outlined: false)[Die Differentialgleichungen]
Am kleinen Stabstück mit Längslast $n(x)$ (Kraft pro Länge, z. B. Eigengewicht) liefert das Gleichgewicht $N' = -n$ (Skript S. 220). Mit Kinematik und Stoffgesetz entsteht die #strong[Spannungs-Dehnungs-DGL] (Skript S. 246–248):
#form[$ (d N)/(d x) = -n(x) wide E A (d u)/(d x) = N + E A alpha_T Delta T wide E A thin u'' = -n(x) quad "(E A, " alpha_T Delta T " konstant)" $]
Die zwei Integrationskonstanten bestimmst du aus den Randbedingungen: Am festen Lager ist $u = 0$, am freien Ende ist $N = 0$, also $u' = 0$ (ohne Wärme).
#bild("tm2k1_dgl_n", [Skript TM2 S. 220: Gleichgewicht am Element, $-N + n d x + (N + d N) = 0$ → $d N\/d x = -n(x)$.], height: 45mm)
#heading(level: 3, outlined: false)[Beispiel: Hängender Stab unter Eigengewicht]
Ein Stab (Länge $L$, Querschnitt $A$, Dichte $rho$) hängt an der Decke, $x$ zeigt nach unten. Unter der Stelle $x$ hängt das Stück $L - x$.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k1_w303_3", [WZF 30.3.26 S. 3: Spannung $sigma(x) = rho g (L-x)$ und Dehnung.], height: 92mm)],
 [#bild("tm2k1_w303_4", [WZF 30.3.26 S. 4: Verschiebung $u(x)$ und Längenänderung $Delta L$.], height: 70mm)
  #bild("tm2k1_w303_5", [WZF 30.3.26 S. 5: alternativ $Delta L = integral_0^L epsilon d x$.], height: 30mm)])
#note([Beispiel (WZF 30.3.26, Skript S. 251–259)], [+ Normalkraft: $N(x) = rho g A (L - x)$; Spannung $sigma(x) = rho g (L - x)$, oben am größten.
+ Dehnung: $epsilon(x) = rho g (L-x)\/E$.
+ Verschiebung mit $u(0) = 0$: $u(x) = (rho g L^2)/E [x/L - frac(1, 2) (x/L)^2]$.
+ Längenänderung: $Delta L = u(L) = (rho g L^2)/(2 E)$. Mit dem Gewicht $G = rho g A L$ ist das $Delta L = frac(1, 2) (G L)/(E A)$ (Skript S. 254 und 259).
Merke: Das Eigengewicht dehnt den Stab nur halb so stark wie dieselbe Kraft $G$ am unteren Ende.], fill: pale)
#note([Hinweis zur Mitschrift (WZF 30.3.26 S. 3–5)], [In der Mitschrift steht teils „$rho dot G$“ statt „$rho dot g$“. Gemeint ist die Erdbeschleunigung $g$, nicht das Gewicht $G$. Sonst stimmt die Rechnung; „FS 1.22/1.23“ verweist auf die Formelsammlung TM2 S. 7.], fill: sand)
#bild("tm2k1_haengend", [Skript TM2 S. 256: Derselbe Stab über die DGL $E A u'' = -n = -G\/L$, zweimal integriert.], height: 50mm)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- Einzelstab: Grundgleichungen $N' = -n$, $epsilon = u'$, $epsilon = N\/(E A) + alpha_T Delta T$; Dehnsteifigkeit $E A$. #text(fill: muted)[\[TM2-Buch S. 13–15\]]
- Stab unter Eigengewicht mit Randbedingungen. #text(fill: muted)[\[TM2-Buch S. 16\]]])

#heading(level: 3, outlined: false)[Statisch unbestimmter Einzelstab]
Ist ein Stab an beiden Enden festgehalten, kannst du $N$ nicht mehr aus dem Gleichgewicht allein bestimmen. Du brauchst eine zusätzliche Gleichung aus der Geometrie: die #strong[Kompatibilitätsbedingung]. Die Lösungsschritte (FS TM2 S. 8; WZF 13.4.26 S. 1):
+ Lager (oder innere Bindung) lösen, statisch Unbestimmte $X$ einführen.
+ Aus Kräften und $X$ die Normalkraft $N(x)$ und Spannung $sigma(x)$ berechnen.
+ Aus Spannung und Temperatur Dehnung, Verschiebung und $Delta l$ berechnen.
+ Die Verformung muss die Kompatibilitätsbedingung erfüllen → $X$.
+ $X$ einsetzen → $N$, $sigma$, $epsilon$, $u$, $Delta l$.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k1_unbestimmt", [Skript TM2 S. 261: Zwei Balken passgenau zwischen festen Lagern A und C, der rechte wird um $Delta T$ erwärmt.], height: 45mm)],
 [#bild("tm2k1_superpos", [Skript TM2 S. 267: Superposition, System = System 0 (frei, nur Wärme) + System 1 (nur Kraft X).], height: 45mm)])
#note([Beispiel (Skript TM2 S. 261–270)], [+ Kinematik: Die Lager halten die Gesamtlänge fest, $Delta L_("ges") = Delta L_1 + Delta L_2 = 0$.
+ Stoffgesetz: $Delta L_1 = N L_1\/(E_1 A_1)$, $Delta L_2 = N L_2\/(E_2 A_2) + alpha_T Delta T L_2$.
+ Einsetzen und nach $N$ auflösen: $N = -(alpha_T Delta T L_2 E_1 A_1 E_2 A_2)/(E_2 A_2 L_1 + E_1 A_1 L_2)$ (Druck).
+ Lagerkräfte: $A = C = -N$. Verschiebung bei B: $u_B = Delta L_1 = N L_1\/(E_1 A_1)$ (nach links).
Superposition liefert dasselbe: System 0 dehnt sich frei um $alpha_T Delta T L_2$; die Kraft $X$ muss das in System 1 wieder zurückdrücken.], fill: pale)
#heading(level: 3, outlined: false)[Beispiel aus der 3. Übung (WZF 13.4.26): Zwei Stäbe in einer Hülse]
Stab 1 und Stab 2 (Länge je $L$, Stab 2 um $Delta T_2$ erwärmt) liegen in einer Hülse 3 (Länge $2L$). Rechts verbindet eine starre Platte alles, an ihr zieht $F$. Gesucht: Längenänderung der Hülse.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k1_w134_2", [WZF 13.4.26 S. 2: System, Freischneiden mit $X$, Gleichgewicht an der Platte ($N_3 = F - X$).], height: 95mm)],
 [#bild("tm2k1_w134_3", [WZF 13.4.26 S. 3: Längenänderungen, Kompatibilität $Delta L_(12) = Delta L_3$, Lösung für $X$.], height: 95mm)])
#note([Beispiel (WZF 13.4.26)], [+ $N_1 = N_2 = X$, $N_3 = F - X$ (Gleichgewicht an der Platte).
+ $Delta L_(12) = X L\/(E A_1) + X L\/(E A_2) + alpha_T Delta T_2 L$, $Delta L_3 = (F - X) 2 L\/(E A_3)$.
+ Kompatibilität $Delta L_(12) = Delta L_3$ → $X = (2F\/(E A_3) - alpha_T Delta T_2)\/(1\/(E A_1) + 1\/(E A_2) + 2\/(E A_3))$.
+ $Delta L = (F - X) dot 2L\/(E A_3)$.
In der Mitschrift S. 4 wird das zu $Delta L = (F\/(E A_1) + F\/(E A_2) + alpha_T Delta T_2) dot 2L\/(A_3\/A_1 + A_3\/A_2 + 2)$ vereinfacht. Das gilt nur, wenn alle drei Teile denselben E-Modul haben.], fill: pale)
#note([Von dir markiert (gelb, WZF 13.4.26)], [Du hast die Ergebnisse $N_1 = N_2 = X$, $N_3 = F - X$ und in Beispiel 2 $X = frac(4, 5) F$, $sigma_2 = 4F\/(5A)$, $sigma_1 = 2F\/(5A)$ hervorgehoben. Diese Zwischenergebnisse sind genau die Stellen, an denen die Rechnung entschieden wird.], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- Statisch unbestimmter Stab mit Wärme: Lager lösen, Lastfälle überlagern, Verträglichkeitsbedingung. #text(fill: muted)[\[TM2-Buch S. 18–19\]]
- Bolzen in Hülse (Kupfer und Stahl): Parallelschaltung mit gleicher Längenänderung. #text(fill: muted)[\[TM2-Buch S. 20–21\]]])
#src[Skript TM2 S. 214–270; FS TM2 S. 7–8; WZF 30.3.26 S. 1–5; WZF 13.4.26 S. 1–4; TM2-Buch S. 13–22.]

== TM2 1.5 Statisch bestimmte Stabsysteme <a-tm2-1-5>
Mehrere Stäbe treffen sich in einem Knoten. Ist das System statisch bestimmt, gehst du so vor (FS TM2 S. 10):
+ Stabkräfte $S_i$ aus dem Gleichgewicht am Knoten.
+ Verlängerung jedes Stabs: $Delta l_i = S_i l_i\/(E_i A_i) + alpha_(T i) Delta T_i l_i$.
+ Verschiebung des Knotens aus der Geometrie: #strong[Verschiebungsplan]. Jeder Stab verlängert sich in seiner Richtung; senkrecht dazu darf er sich (für kleine Verformungen) drehen. Der neue Knoten liegt im Schnittpunkt der Senkrechten.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k1_fs_stabsystem", [FS TM2 S. 10: Vorgehen und Verschiebungsplan für einen Zweistab.], height: 48mm)],
 [#bild("tm2k1_w204_4", [WZF 20.4.26 S. 4: Verschiebungsplan der Seilaufhängung aus 1.1.], height: 95mm)])
#note([Beispiel (WZF 20.4.26 und 30.3.26)], [Die Seile aus 1.1 ($S_1 = "8,66"$ N, $S_2 = 5$ N, $l_1 = 1$ m, $l_2 = sqrt(3)$ m, $A_1 = "0,02" thin "cm"^2$, $A_2 = "0,01" thin "cm"^2$, $E = "2,1" dot 10^5 thin "N/mm"^2$):
+ $Delta l_1 = S_1 l_1\/(E A_1) = "2,06" dot 10^(-2) thin "mm"$, $Delta l_2 = "4,12" dot 10^(-2) thin "mm"$ (WZF 30.3.26 S. 2).
+ Verschiebungsplan: senkrecht $v = Delta l_2 sin 30° + Delta l_1 cos 30° = "3,84" dot 10^(-2) thin "mm"$, waagerecht $u = Delta l_2 cos 30° - Delta l_1 sin 30° = "2,54" dot 10^(-2) thin "mm"$.], fill: pale)
#note([In eigenen Worten], [Zwei Personen halten einen Ball an zwei Seilen. Gibt jedes Seil ein Stück nach, wandert der Ball dorthin, wo beide Seile mit ihrer neuen Länge wieder zusammenpassen. Der Verschiebungsplan ist die Zeichnung dieser Suche. #text(fill: muted)[(eigene Ergänzung)]])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [Verschiebungsplan: Stabverlängerungen abtragen, Senkrechte errichten, Schnittpunkt = neue Knotenlage. #text(fill: muted)[\[TM2-Buch S. 22–24\]]])
#src[FS TM2 S. 10; WZF 30.3.26 S. 2; WZF 20.4.26 S. 4; TM2-Buch S. 22–27.]

== TM2 1.6 Statisch unbestimmte Stabsysteme <a-tm2-1-6>
Gibt es mehr Stäbe (oder Lager) als Gleichgewichtsbedingungen, brauchst du für jede überzählige Unbekannte eine Kompatibilitätsbedingung (FS TM2 S. 10): Gleichgewicht mit $X$ → Stabkräfte $S_i$ → $Delta l_i$ → Kinematik (Kompatibilität) → $X$ → einsetzen.
#heading(level: 3, outlined: false)[Beispiel 2 aus der 3. Übung (WZF 13.4.26): Starrer Balken an zwei Stäben]
Ein starrer Balken ist links gelenkig gelagert und hängt an zwei gleichen Stäben (bei $a$ und $2a$). Am Ende ($2a$) zieht $F$ nach unten. Lager (3 Unbekannte) plus 2 Stäbe ergeben 4 Unbekannte bei 3 Gleichungen: einfach statisch unbestimmt.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k1_w134_5", [WZF 13.4.26 S. 5: System, Abzählkriterium, Momentengleichgewicht um 0.], height: 95mm)],
 [#bild("tm2k1_w134_6", [WZF 13.4.26 S. 6: Kompatibilität aus der Drehung des starren Balkens, Ergebnis.], height: 95mm)])
#note([Beispiel (WZF 13.4.26)], [+ $S_2 = X$; Moment um das Lager: $S_1 a + 2 a X - 2 a F = 0$ → $S_1 = 2F - 2X$.
+ $Delta l_1 = 2(F - X) l\/(E A)$, $Delta l_2 = X l\/(E A)$.
+ Der starre Balken dreht sich um das Lager: $Delta l_1\/a = Delta l_2\/(2a)$ → $Delta l_1 = Delta l_2\/2$.
+ $2(F - X) = X\/2$ → $X = frac(4, 5) F$; damit $sigma_2 = 4F\/(5A)$, $S_1 = frac(2, 5) F$, $sigma_1 = 2F\/(5A)$.], fill: pale)
#heading(level: 3, outlined: false)[Parallelschaltung: die vorgespannte Schraube (4. Übung, WZF 20.4.26)]
Schraube (1) und Hülse (2) werden durch Anziehen der Mutter um $n$ Umdrehungen (Gewindesteigung $h$) gegeneinander verspannt. Die Schraube wird länger, die Hülse kürzer; zusammen müssen sie den Weg $n h$ aufnehmen:
#form[$ Delta l_1 + |Delta l_2| = n h wide => wide F_V = X = (n h - Delta T l (alpha_(T 1) - alpha_(T 2)))/(l (1/(E_1 A_1) + 1/(E_2 A_2))) $]
Kommt eine Betriebskraft $F_B$ dazu (an Mutter und Kopf), wird die Schraube nur um einen Teil von $F_B$ stärker belastet; der Rest entlastet die Hülse. Das zeigt das #strong[Verspannungsschaubild] (FS S. 9): V = Vorspannpunkt, B = Betriebspunkt, K = kritischer Punkt (Klaffen der Fuge).
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k1_w204_1", [WZF 20.4.26 S. 1: Aufgabe 4.1, Schraube und Hülse, Längenänderungen, Kompatibilität.], height: 95mm)],
 [#bild("tm2k1_fs_schraube", [FS TM2 S. 9: Parallelschaltung Schraube und Verspannungsschaubild.], height: 95mm)])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k1_w204_2", [WZF 20.4.26 S. 2: Auflösen nach $X = F_V$, Vereinfachung $l_1 approx l_2 = l$, Betriebskraft.], height: 95mm)],
 [#bild("tm2k1_w204_3", [WZF 20.4.26 S. 3: Schraubenkraft im Betrieb und die vier Schritte zum Verspannungsschaubild.], height: 95mm)])
#note([Achtung: Vorzeichen bei der Hülse], [In WZF 20.4.26 S. 1 steht rot: „Stauchung, wird hier positiv!“. Die Hülse wird gedrückt; ihre Verkürzung $Delta l_2$ wird als positiver Betrag in die Kompatibilität $Delta l_1 + Delta l_2 = n h$ eingesetzt. Wer hier mit Vorzeichen rechnet, muss $Delta l_1 - Delta l_2 = n h$ schreiben.], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [Statisch unbestimmte Stabsysteme: zu den Gleichgewichtsbedingungen kommen $n$ Verträglichkeitsbedingungen aus dem Verschiebungsplan. #text(fill: muted)[\[TM2-Buch S. 27–30\]]])
#src[FS TM2 S. 9–10; WZF 13.4.26 S. 5–6; WZF 20.4.26 S. 1–3; Übung TM2 Nr. 3 und 4; TM2-Buch S. 27–33.]

#bild("map-t2k1", [Mindmap zu TM2 Kapitel 1 (eigene Darstellung nach Skript TM2 S. 52–270 und FS TM2 S. 4–10).], height: 70mm)
*Der Zusammenhang in TM2 Kapitel 1.* Alles beginnt mit der Normalkraft aus → TM2 Kapitel 0. Geteilt durch die Fläche wird sie zur Spannung (1.1); damit prüfst du, ob der Stab hält. Das Stoffgesetz (1.3) macht aus der Spannung eine Dehnung, und die Dehnung integriert ergibt Verschiebung und Längenänderung (1.2, 1.4). Bei statisch bestimmten Systemen ist das eine Einbahnstraße von $N$ zu $Delta l$. Bei statisch unbestimmten Systemen (1.4, 1.6) läuft die Rechnung im Kreis: Die Verformung muss zur Geometrie passen, und erst diese Bedingung liefert die fehlende Kraft. Genau dieses Muster (Gleichgewicht, Kinematik, Stoffgesetz) kehrt in Biegung und Torsion wieder.

#pagebreak()
== Verständnisfragen und Rechenaufgaben · TM2 Kapitel 1
#set enum(spacing: 0.85em)
Erkläre erst selbst. Bei Rechenaufgaben: Skizze, Normalkraft, Spannung, Dehnung, Verschiebung, Einheiten prüfen. Die Lösungen folgen getrennt.

+ Warum ist bei einem Stab mit konstantem Querschnitt $sigma = N\/A$ über den Querschnitt konstant? Wo gilt das nicht?
+ Unter welchem Schnittwinkel ist die Schubspannung im Zugstab am größten, und wie groß ist sie?
+ Was ist der Unterschied zwischen Verschiebung $u$ und Dehnung $epsilon$? Wie hängen sie zusammen?
+ Was bedeutet die Dehnsteifigkeit $E A$ anschaulich?
+ Ein Stab wird frei gelagert erwärmt. Entsteht eine Spannung? Und wenn er zwischen zwei festen Wänden sitzt?
+ Woran erkennst du, dass ein Stabproblem statisch unbestimmt ist, und welche Gleichung brauchst du zusätzlich?
+ Warum dehnt das Eigengewicht $G$ einen hängenden Stab nur halb so stark wie die gleiche Kraft $G$ am Stabende?
+ Was zeigt das Verspannungsschaubild einer Schraube, und was bedeutet der Punkt K?
+ Ein Stahlstab ($d = 12$ mm) trägt $F = 20$ kN Zug. Berechne $sigma$. #text(fill: muted)[(eigene Aufgabe)]
+ Welchen Querschnitt braucht ein Zugstab für $N = 50$ kN bei $sigma_("zul") = 160 thin "N/mm"^2$? #text(fill: muted)[(eigene Aufgabe)]
+ Ein Stab ($l = 2$ m, $A = 200 thin "mm"^2$, $E = "2,1" dot 10^5 thin "N/mm"^2$) wird mit $F = 30$ kN gezogen. Berechne $Delta l$. #text(fill: muted)[(eigene Aufgabe)]
+ Ein Stahlstab ($l = 2$ m, $alpha_T = "1,2" dot 10^(-5) thin "1/K"$) wird um 40 K erwärmt. a) $Delta l$ bei freier Lagerung? b) $sigma$, wenn er zwischen starren Wänden sitzt? #text(fill: muted)[(eigene Aufgabe)]
+ Zugstab mit $sigma_0 = 100 thin "N/mm"^2$: Berechne $sigma$ und $tau$ im Schnitt unter $phi = 30°$. #text(fill: muted)[(eigene Aufgabe)]

#heading(level: 3, outlined: false)[Vertiefende Verständnisfragen und Rechenaufgaben]
#block[
#set enum(start: 14)
+ *Übung 1, Aufg. 1.1:* Mit welcher Kraft dürfen die drei Stäbe belastet werden (Zugfestigkeit $100 thin "N/mm"^2$)? a) Kreis $D = 20$ mm, b) Kreisring $D_a = 20$ mm, $D_i = 10$ mm, c) Quadrat $H = 20$ mm.
  #bild("tm2k1_ue11", [Übung TM2 Nr. 1, Aufg. 1.1: die drei Querschnitte.], height: 22mm)
+ *Übung 1, Aufg. 1.2:* Senkrechter Mast (Kreiszylinder) unter Eigengewicht, $rho = "2,5" thin "kg/dm"^3$, $D = 30$ cm, $L = 10$ m, $x$ vom Boden nach oben. Gib $sigma(x)$ in N/mm² an.
  #bild("tm2k1_ue12", [Übung TM2 Nr. 1, Aufg. 1.2: Mast, $x$ vom Boden.], height: 32mm)
+ *Übung 1, Aufg. 1.3:* Maschinenteil (Dicke $t = d$, Breite von $a$ oben bis $2a$ unten) unter Eigengewicht und $F$. Bestimme $sigma(x)$ und die Werte bei $x = 4000$ mm für a) nur Eigengewicht, b) nur $F$, c) beides. ($F = 150$ kN, $gamma = "0,077" thin "N/cm"^3$, $a = 250$ mm, $h = 4000$ mm, $d = 160$ mm)
  #bild("tm2k1_ue13", [Übung TM2 Nr. 1, Aufg. 1.3 (und 2.2): Maschinenteil mit veränderlicher Breite $b(x)$.], height: 45mm)
+ *Übung 2, Aufg. 2.1:* Stahlförderseil ($l = 1150$ m) mit Last $F = 110$ kN am Ende. 1) Querschnitt für $sigma_("zul") = 200 thin "N/mm"^2$; 2) Verschiebung des Seilendes; 3) Reißlänge für $R_m = 1600 thin "N/mm"^2$ ohne $F$; wo reißt das Seil? ($rho = 7850 thin "kg/m"^3$, $E = 21 dot 10^4 thin "N/mm"^2$)
  #bild("tm2k1_ue21", [Übung TM2 Nr. 2, Aufg. 2.1: Förderseil im Schacht.], height: 45mm)
+ *Übung 2, Aufg. 2.2:* Maschinenteil aus 1.3 ohne Eigengewicht: 1) $u(x)$ und $Delta l$ infolge $F$; 2) zusätzlich Erwärmung um 50 °C ($alpha_T = "1,2" dot 10^(-5)$). Hinweis auf dem Blatt: $integral 1\/(a x + b) d x = (1\/a) ln|a x + b| + C$.
+ *Übung 2, Aufg. 2.3:* Probestab ($L = 100$ mm, $d = 10$ mm). 1) Prüfkraft bis $1000 thin "N/mm"^2$ mit 50 % Zuschlag; 2) $Delta l$ bei $F = 50$ kN; 3) Maschine blockiert bei 50 kN, Stab wird um 100 °C erwärmt: $Delta l_("ges")$, $epsilon_("ges")$, $sigma_("ges")$?
  #bild("tm2k1_ue23", [Übung TM2 Nr. 2, Aufg. 2.3: Probestab.], height: 30mm)
+ *Übung 3, Aufg. 3.1:* Abgesetzter Stahlzylinder zwischen festen Lagern A und B, erwärmt um 50 K ($A_1 = 400$, $A_2 = 600 thin "mm"^2$, $l_1 = 300$, $l_2 = 350$ mm). Lagerkräfte und Verschiebung von C?
  #bild("tm2k1_ue31", [Übung TM2 Nr. 3, Aufg. 3.1: abgesetzter Zylinder zwischen zwei Festlagern.], height: 28mm)
+ *Übung 3, Aufg. 3.2:* Betonsäule (30 × 30 cm) mit vier Rundstählen Ø 20 mm unter $F = 500$ kN. Kraftaufteilung und Spannungen? Dann zusätzlich Erwärmung um 50 °C. ($E_("St") = 21 dot 10^6$, $E_B = 3 dot 10^6 thin "N/cm"^2$; $alpha_("St") = "1,2" dot 10^(-5)$, $alpha_B = "1,0" dot 10^(-5) thin "1/°C"$)
  #bild("tm2k1_ue32", [Übung TM2 Nr. 3, Aufg. 3.2: Stahlbetonsäule mit Schnitt R–S.], height: 45mm)
+ *Übung 3, Aufg. 3.3:* Konischer Stab (Durchmesser $D$ bis $d$, Länge $l$) mit Federn (Gesamtsteifigkeit $c$) verbunden, Stab um $Delta T$ erhitzt. Wie verschiebt sich der rechte Querschnitt?
  #bild("tm2k1_ue33", [Übung TM2 Nr. 3, Aufg. 3.3: konischer Stab parallel zu Federn.], height: 38mm)
+ *Übung 4, Aufg. 4.1:* Kolbenschraube (Stahl, $d_s = 10$ mm, $l = 100$ mm) und Al-Hülse ($d_i = 13$, $d_a = 30$ mm), M12×1, Mutter um 120° angezogen. a) $F_V$, $Delta l_1$, $Delta l_2$; b) Schraubenkraft bei 10 kN Betriebskraft je Schraube; c) Spannungen im Kernquerschnitt ($d_k = "10,5"$ mm), zulässig 640 und ±40 N/mm²; d) Vorspannkraft, wenn die Hülse 80 °C und die Schraube 120 °C warm wird.
  #bild("tm2k1_ue41", [Übung TM2 Nr. 4, Aufg. 4.1: Kolben mit Stiftschraube und Hülse.], height: 40mm)
+ *Übung 4, Aufg. 4.2:* Starrer Balken (Gewicht $G$) auf drei Stäben gleicher Dehnsteifigkeit $E A$ (Stäbe 1, 2 unter $2 alpha$ zueinander, Stab 3 senkrecht, Länge $l$). Welchen Neigungswinkel $beta$ hat der Balken nach der Montage?
  #bild("tm2k1_ue42", [Übung TM2 Nr. 4, Aufg. 4.2: starrer Balken auf drei Stäben.], height: 38mm)
+ *Übung 4, Aufg. 4.3:* Stab 3 ist um $delta$ zu kurz. a) Kraft $F$ am Knoten C, b) Zugkraft $Z$ am Stabende, c) nötige Erwärmung von Stab 1, d) Verschiebung von C und Stabkräfte nach der Montage.
  #bild("tm2k1_ue43", [Übung TM2 Nr. 4, Aufg. 4.3: Stab 3 zu kurz, Montagevarianten a und b.], height: 38mm)
+ *Skript TM2 S. 96 (Pyramidenstumpf):* Gib $sigma(x)$ für den Pyramidenstumpf unter Druckkraft $F$ und Eigengewicht an. Achte auf das richtige Volumen.
+ *Skript TM2 S. 261:* Zwei Balken zwischen festen Lagern, der rechte wird um $Delta T$ erwärmt. Bestimme $N$, die Lagerkräfte und die Verschiebung bei B.
+ *Buch:* Bei welchem Schnittwinkel ist im Zugstab die Normalspannung am größten, bei welchem die Schubspannung? (TM2-Buch S. 4–5)
+ *Buch:* Welche Bedingung ergänzt bei statisch unbestimmten Systemen das Gleichgewicht, und woraus liest man sie ab? (TM2-Buch S. 19 und 27)
+ *Altklausur SS 2016, Musterlösung (PrüfungenTM2.pdf S. 12):* Stab mit $A(x) = A_0 frac(2l, l + x)$, Länge $l$, links eingespannt, rechts mit der Druckkraft $F$ belastet. Bestimme $sigma(x)$, $epsilon(x)$ und $Delta l$ (Vorzeichen!). Welche Gefahr besteht außer zu hoher Spannung?
  #bild("ak_stab_ax", [Altklausur SS 2016, Aufg. 1 i), Abb. 3: kegeliger Stab, links breit, rechts $A_0$, Druckkraft $F$ am rechten Ende.], height: 40mm)
]

#pagebreak()
== Lösungen TM2 Kapitel 1
#set enum(spacing: 0.65em)
+ Bei konstantem $A$ und Krafteinleitung weit weg verteilt sich $N$ gleichmäßig. Nicht gültig nahe an der Krafteinleitung und an Kerben (Spannungsspitzen). #nachschlagen[Lernskript, #stelle(<a-tm2-1-1>)\; TM2-Buch S. 5]
+ Bei $phi = 45°$; $tau_(max) = sigma_0\/2$. #nachschlagen[Lernskript, #stelle(<a-tm2-1-1>)\; Skript TM2 S. 86]
+ $u$ ist der Weg eines Punktes (mm), $epsilon$ die relative Längenänderung eines Stücks (ohne Einheit). $epsilon = d u\/d x$, $u = integral epsilon d x$. #nachschlagen[Lernskript, #stelle(<a-tm2-1-2>)]
+ Wie viel Kraft man braucht, um den Stab um die Dehnung 1 zu strecken: $epsilon = N\/(E A)$. Großes $E A$ = steifer Stab. #nachschlagen[Lernskript, #stelle(<a-tm2-1-3>)]
+ Frei: keine Spannung, nur $Delta l = alpha_T Delta T l$. Zwischen festen Wänden: $epsilon = 0$ → $sigma = -E alpha_T Delta T$ (Druck). #nachschlagen[Lernskript, #stelle(<a-tm2-1-3>)]
+ Mehr Unbekannte (Lager- und Stabkräfte) als Gleichgewichtsbedingungen. Zusätzlich je eine Kompatibilitätsbedingung (Verformungen passen zur Geometrie). #nachschlagen[Lernskript, #stelle(<a-tm2-1-4>)]
+ Die Normalkraft fällt linear von $G$ (oben) auf 0 (unten); im Mittel wirkt nur $G\/2$. Also $Delta l = G l\/(2 E A)$. #nachschlagen[Lernskript, #stelle(<a-tm2-1-4>)]
+ Kraft über Längenänderung von Schraube und Hülse; V = Vorspannung, B = Betrieb, K = die Hülse wird kraftfrei, die Fuge klafft. #nachschlagen[Lernskript, #stelle(<a-tm2-1-6>)]
+ $A = pi dot 12^2\/4 = "113,1" thin "mm"^2$; $sigma = 20000\/"113,1" = "176,8" thin "N/mm"^2$. #nachschlagen[Lernskript, #stelle(<a-tm2-1-1>)]
+ $A_("erf") = 50000\/160 = "312,5" thin "mm"^2$. #nachschlagen[Lernskript, #stelle(<a-tm2-1-1>)]
+ $Delta l = 30000 dot 2000\/("2,1" dot 10^5 dot 200) = "1,43" thin "mm"$. #nachschlagen[Lernskript, #stelle(<a-tm2-1-4>)]
+ a) $Delta l = "1,2" dot 10^(-5) dot 40 dot 2000 = "0,96" thin "mm"$; b) $sigma = -E alpha_T Delta T = -"2,1" dot 10^5 dot "4,8" dot 10^(-4) = -"100,8" thin "N/mm"^2$. #nachschlagen[Lernskript, #stelle(<a-tm2-1-3>)]
+ $sigma = 50 (1 + cos 60°) = 75 thin "N/mm"^2$; $tau = 50 sin 60° = "43,3" thin "N/mm"^2$. #nachschlagen[Lernskript, #stelle(<a-tm2-1-1>)]
+ $F = sigma A$: a) $A = 100 pi = "314,2" thin "mm"^2$ → $"31,4"$ kN; b) $A = 75 pi = "235,6" thin "mm"^2$ → $"23,6"$ kN; c) $A = 400 thin "mm"^2$ → 40 kN. #nachschlagen[Lernskript, #stelle(<a-tm2-1-1>)\; Lösung Übung 1]
+ Über der Stelle $x$ liegt das Stück $L - x$: $N = -rho g A (L - x)$, also $sigma(x) = -rho g (L - x) = -"0,00002453" thin "N/mm"^3 dot (10000 thin "mm" - x)$; am Boden $-"0,245" thin "N/mm"^2$. #nachschlagen[Lernskript, #stelle(<a-tm2-1-1>)\; Lösung Übung 1]
+ $sigma(x) = -F\/(a d (1 + x\/h)) - gamma (x + x^2\/(2h))\/(1 + x\/h)$. Bei $x = 4$ m: a) $-"0,231"$, b) $-"1,875"$, c) $-"2,106" thin "N/mm"^2$. #nachschlagen[Lernskript, #stelle(<a-tm2-1-1>)\; Lösung Übung 1]
+ 1) Oben ist $N$ am größten: $sigma_("zul") = F\/A + rho g l$ → $A_("erf") = F\/(sigma_("zul") - rho g l) = 110000\/(200 - "88,6") = "987,1" thin "mm"^2$. 2) $u(l) = F l\/(E A) + rho g l^2\/(2E) = "610,3" + "242,5" = "852,8" thin "mm"$. 3) $l_("Reiß") = R_m\/(rho g) = "20,78" thin "km"$; das Seil reißt oben an der Aufhängung. #nachschlagen[Lernskript, #stelle(<a-tm2-1-4>)\; Lösung Übung 2]
+ 1) $N = -F$, $A(x) = a d (1 + x\/h)$: $u(x) = F h\/(E a d) (ln 2 - ln|x\/h + 1|)$; $Delta l = -F h ln 2\/(E a d) = -"0,0495" thin "mm"$. 2) $u(x)$ zusätzlich $- alpha_T Delta T (h - x)$; $Delta l = -"0,0495" + "2,4" = +"2,3505" thin "mm"$. #nachschlagen[Lernskript, #stelle(<a-tm2-1-4>)\; Lösung Übung 2]
+ 1) $F_(max) = "1,5" dot 1000 dot "78,54" = "117,8" thin "kN"$. 2) $Delta l = 50000 dot 100\/("2,1" dot 10^5 dot "78,54") = "0,303" thin "mm"$. 3) Länge bleibt fest: a) $Delta l_("ges") = "0,303"$ mm; b) $epsilon_("ges") = "3,03" dot 10^(-3)$; c) $sigma_("ges") = E (epsilon_("ges") - alpha_T Delta T) approx 384 thin "N/mm"^2$ (Vorspannung 636,6 minus Wärmeanteil 252). #nachschlagen[Lernskript, #stelle(<a-tm2-1-4>)\; Lösung Übung 2]
+ $Delta l_1 + Delta l_2 = 0$ mit $Delta l_i = N l_i\/(E A_i) + alpha Delta T l_i$ → $N = -alpha Delta T (l_1 + l_2)\/(l_1\/(E A_1) + l_2\/(E A_2)) = -"61,4" thin "kN"$ (Druck), $F_A = F_B = "61,4"$ kN. $u_C = Delta l_1 = -"0,219" + "0,180" = -"0,0394" thin "mm"$ (nach links). #nachschlagen[Lernskript, #stelle(<a-tm2-1-4>)\; Kurzlösung Übung 3 (ausführliche Lösung fehlt)]
+ $A_("St") = 4 pi = "12,57" thin "cm"^2$, $A_B = 900 - "12,57" = "887,43" thin "cm"^2$. Gleiche Stauchung: $F_("St")\/(E A)_("St") = F_B\/(E A)_B$, $F_("St") + F_B = F$. Mit $(E A)_("St") = "263,9" dot 10^6$ N und $(E A)_B = "2662,3" dot 10^6$ N: $F_("St") = "45,1"$ kN (9 %), $F_B = "454,9"$ kN; $sigma_("St") = -"35,9"$, $sigma_B = -"5,13" thin "N/mm"^2$. Mit Wärme (Druckkräfte als positive Beträge, Stauchung negativ): $-F_("St")\/(E A)_("St") + alpha_("St") Delta T = -F_B\/(E A)_B + alpha_B Delta T$ → $F_("St") (1\/(E A)_("St") + 1\/(E A)_B) = (alpha_("St") - alpha_B) Delta T + F\/(E A)_B = "1,0" dot 10^(-4) + "1,878" dot 10^(-4)$ → $F_("St") = "69,1"$ kN, $F_B = "430,9"$ kN. #nachschlagen[Lernskript, #stelle(<a-tm2-1-4>)\; Kurzlösung Übung 3; TM2-Buch S. 20–21]
  #note([Zu deiner Rechnung (Übung 3, Aufg. 3.2, Aufgabenblatt S. 5–6)], [Dein „(Lsg 45,1 ??)“: Du hast $F_B$ auf 455 kN gerundet, deshalb kam $F_("St") = 45$ kN heraus. Ungerundet ist $F_("St") = "45,09"$ kN; beides ist richtig. Beim Wärmeteil (S. 6) ist dir ein Vorzeichen verrutscht: $-(500000 - F_("St"))\/(E A)_B = -500000\/(E A)_B #strong[+] F_("St")\/(E A)_B$. Du hast „$- F_("St")\/(E A)_B$“ geschrieben. Mit dem richtigen Vorzeichen steht da $"2,878" dot 10^(-4) = F_("St") (1\/(E A)_("St") + 1\/(E A)_B)$, und es folgt $F_("St") = "69,1"$ kN ohne Widerspruch.], fill: sand)
+ Stab und Federn sind parallel: Stabverlängerung = Federweg. Mit $l\/(E A)_("Kegel") = 4 l\/(E pi d D)$ folgt $Delta l = (alpha_T Delta T l)\/(1 + 4 c l\/(E pi d D))$ nach rechts. #nachschlagen[Lernskript, #stelle(<a-tm2-1-6>)\; Kurzlösung Übung 3]
+ a) $n h = frac(1, 3)$ mm, $E_1 A_1 = "1,649" dot 10^7$ N, $E_2 A_2 = "4,019" dot 10^7$ N → $F_V = "38,98"$ kN, $Delta l_1 = "0,2363"$ mm, $Delta l_2 = "0,0970"$ mm. b) Anteil der Schraube $c_1\/(c_1 + c_2) = "0,291"$ → $F_("Schraube") = "41,89"$ kN, $F_("Hülse") = "31,89"$ kN. c) $A_k = "86,6" thin "mm"^2$: $sigma_V = "450,1"$, $sigma_B = "483,7"$, $sigma_("dyn") = plus.minus "16,8" thin "N/mm"^2$; beides zulässig. d) $X = (n h - alpha_1 Delta T_1 l + alpha_2 Delta T_2 l)\/(l(dots)) = ("0,3333" - "0,12" + "0,138")\/("8,55" dot 10^(-6)) = "41,09"$ kN. #nachschlagen[Lernskript, #stelle(<a-tm2-1-6>)\; Lösung Übung 4; WZF 20.4.26]
+ Symmetrie: $B_A = B_B = G\/2$; $S_1 = S_2 = G\/(4 cos alpha)$, $S_3 = G\/2$. Senkung bei A: $w_A = Delta l_1\/cos alpha = G l\/(4 E A cos^3 alpha)$, bei B: $w_B = G l\/(2 E A)$. $beta approx (w_B - w_A)\/a = (G l)\/(a E A) dot (2 cos^3 alpha - 1)\/(4 cos^3 alpha)$. #nachschlagen[Lernskript, #stelle(<a-tm2-1-5>)\; Lösung Übung 4]
+ a) $F = "0,2612" thin delta E A\/l$; b) $Z = delta E A\/l$; c) $Delta T = delta\/(2 l alpha_T)$; d) $v = "0,793" thin delta$, $S_3 = "0,2071" thin delta E A\/l$, $S_1 = sqrt(2) S_3$, $S_2 = -S_3$. #nachschlagen[Lernskript, #stelle(<a-tm2-1-6>)\; Lösung Übung 4]
+ $sigma(x) = -(F + rho g V(x))\/A(x)$ mit $A(x) = ((b-a) x\/h + a)^2$ und $V(x) = ((b-a)\/h)^2 x^3\/3 + a (b-a) x^2\/h + a^2 x$. Nicht $V = A(x) dot x$ (Folienfehler). #nachschlagen[Lernskript, #stelle(<a-tm2-1-1>)\; Skript TM2 S. 100–102]
+ $N = -(alpha_T Delta T L_2 E_1 A_1 E_2 A_2)\/(E_2 A_2 L_1 + E_1 A_1 L_2)$; $A = C = -N$; $u_B = N L_1\/(E_1 A_1)$ (nach links). #nachschlagen[Lernskript, #stelle(<a-tm2-1-4>)\; Skript TM2 S. 261–270]
+ $sigma$ maximal bei $phi = 0$ (senkrechter Schnitt), $tau$ maximal bei $phi = 45°$ mit $sigma_0\/2$. #nachschlagen[Lernskript, #stelle(<a-tm2-1-1>)\; TM2-Buch S. 4–5]
+ Die Verträglichkeits- oder Kompatibilitätsbedingung; man liest sie aus der Geometrie der Verformung (Verschiebungsplan) ab. #nachschlagen[Lernskript, #stelle(<a-tm2-1-6>)\; TM2-Buch S. 19, 27]
+ $N = -F$, $sigma(x) = -frac(F (l + x), 2 l A_0)$, $epsilon = sigma\/E$. $Delta l = integral_0^l epsilon thin d x = -frac(F, 2 l E A_0) dot frac(3 l^2, 2) = -frac(3 F l, 4 E A_0)$. Gefahr: Knicken. In der Musterlösung steht im Integral $(l - x)$ statt $(l + x)$; das ist ein Schreibfehler. #nachschlagen[Lernskript, #stelle(<a-tm2-1-4>)\; Altklausur SS 2016, Musterlösung (PrüfungenTM2.pdf S. 12)]

#pagebreak()
= TM2 Kapitel 2 · Spannungszustand <k-tm2-2>
#tab(columns: 2,
 [Vorlesungen], [Skript-Teil 04 „Mehrachsiale Belastung (σ und τ)“ (Sosnowsky; auf den Folien steht nur der Foliensatz-Stand 12.03.26, kein handschriftliches VL-Datum) → 2.1–2.2. WZF 27.04.26 (5. Übung: homogener ebener Spannungszustand, Schnittebenendrehung) → 2.1, 2.2 Transformation. WZF 04.05.26 (6. Übung: Hauptspannungen, Hauptschubspannungen, Mohrscher Kreis) → 2.2. WZF 11.05.26 (7. Übung: zweiachsiger Spannungszustand, Anwendungen, Vergleichsspannungen) → 2.2 Anwendung, 2.3.],
 [Quellen], [Skript TM2 S. 280–337 (Spannungsvektor, Spannungszustand, Spannungstransformation, Ableitungen, Mohrscher Spannungskreis A01–A08); Bongmba-Folie „2.2 Ebener Spannungszustand – Spannungskreis“ (Bildschirmfoto); FS TM2 S. 11–16; WZF-Mitschriften 27.04.26, 04.05.26, 11.05.26; Übung 5–7 mit Lösungen; TM2-Buch Kap. 2 (S. 36–61) und Abschn. 3.3 (S. 76–78)],
 [Passende Übungen], [Übung 5: 5.1, 5.2 · Übung 6: 6.1, 6.2 · Übung 7: 7.1, 7.2 · Skript-Beispiele Mohrscher Spannungskreis A01–A08 (Skript TM2 S. 310–335)],
)
Ein Bauteil hat in einem Punkt nicht „die“ Spannung: Je nachdem, #strong[in welcher Richtung du schneidest], siehst du andere Normal- und Schubspannungen. Kapitel 2 zeigt, wie man aus drei Werten $sigma_x, sigma_y, tau_("xy")$ die Spannungen in #strong[jedem] Schnitt berechnet, die größten Spannungen (Hauptspannungen) findet und alles im #strong[Mohrschen Spannungskreis] zeichnet. Am Ende fasst eine #strong[Vergleichsspannung] den Spannungszustand zu einer Zahl zusammen, die man mit dem Zugversuch vergleichen kann.
#note([Dein Feynman-Schritt: die 5 Kernideen von Kapitel 2. Erst ohne Skript aufzählen und erklären, dann vergleichen.], [+ #strong[Spannung hängt vom Schnitt ab:] Ein Punkt hat einen Spannungs#emph[zustand], beschrieben durch den symmetrischen Spannungstensor $S$.
+ #strong[Transformationsgleichungen:] Drehst du den Schnitt um $phi$, ändern sich $sigma$ und $tau$ mit $2 phi$ (doppelter Winkel!).
+ #strong[Hauptspannungen] sind die extremen Normalspannungen; in diesen Schnitten ist $tau = 0$. Die maximale Schubspannung liegt 45° daneben.
+ #strong[Mohrscher Kreis] = Bild der Transformationsgleichungen: Mittelpunkt $sigma_M$, Radius $r = tau_("max")$; Drehung $phi$ im Bauteil ↔ $2 phi$ im Kreis, Gegenrichtung.
+ #strong[Vergleichsspannung] $sigma_V$: ein Ersatzwert für den zweiachsigen Zustand; Nachweis $sigma_V <= sigma_("zul")$. Ergebnis hängt von der Hypothese ab.
Zusammenfassung der Abschnitte 2.1–2.3; Quellen stehen dort.])
== TM2 2.1 Spannungsvektor und Spannungstensor <a-tm2-2-1>
Du schneidest einen beliebig belasteten Körper (die „mechanische Kartoffel“) gedanklich auf. An der Schnittfläche wirken innere Kräfte. Auf ein kleines Flächenstück $Delta A$ wirkt die Kraft $Delta arrow(F)$. Lässt man $Delta A$ gegen null gehen, erhält man den #strong[Spannungsvektor] $arrow(t)$ = Kraft pro Fläche in diesem Punkt.
- Komponente #strong[senkrecht] zur Schnittfläche = #strong[Normalspannung] $sigma$
- Komponente #strong[in] der Schnittfläche = #strong[Schubspannung] $tau$
Wichtig: $arrow(t)$ hängt nicht nur vom Ort ab, sondern auch von der #strong[Schnittrichtung] (Normalenvektor $arrow(n)$). Deshalb schneidet man in einem Punkt drei zueinander senkrechte Flächen frei – die Seiten eines infinitesimalen Würfels. Die Spannungen an diesen Flächen beschreiben den #strong[Spannungszustand] vollständig.
#note([In eigenen Worten], [Stell dir einen Stapel Papier vor, den du schräg zusammendrückst. Schaust du auf die Oberseite, drückt die Hand senkrecht (σ). Schaust du auf eine schräge Fläche im Stapel, rutschen die Blätter gegeneinander (τ). Gleiche Belastung, anderer „Blickwinkel“ – andere Spannungen. #text(fill: muted)[(eigene Ergänzung)]])
#bild("tm2k2_kartoffel", [Skript TM2 S. 286: „Mechanische Kartoffel“ – Schnitt s–s, Kraft dF auf dA, Zerlegung von $arrow(t)$ in $sigma$ (normal, Richtung $arrow(n)$) und $tau$ (in der Schnittebene). Spannungsvektor $arrow(t) = lim_(Delta A -> 0) Delta arrow(F)/ Delta A = d arrow(F)/d A$.], height: 45mm)
#heading(level: 3, outlined: false)[Formeln]
#form[$ arrow(t) = lim_(Delta A -> 0) frac(Delta arrow(F), Delta A) = frac(d arrow(F), d A) quad [ frac("N", "mm"^2) ], wide "z. B. Fläche mit Normale " y colon arrow(t) = tau_("yx") thin arrow(e)_x + sigma_y thin arrow(e)_y + tau_("yz") thin arrow(e)_z $]
Spannungsvektor als Grenzwert; die Komponenten sind die Spannungen in dieser Schnittfläche (TM2-Buch Gl. 2.1, 2.2).
#heading(level: 3, outlined: false)[Doppelindizes und Vorzeichen]
- #strong[1. Index] = Richtung der #strong[Flächennormale], #strong[2. Index] = Richtung der Spannung. $tau_("xy")$: Fläche mit Normale $x$, Spannung zeigt in $y$-Richtung (FS TM2 S. 11).
- Normalspannungen: Normale und Spannung haben dieselbe Richtung → kurz $sigma_("xx") = sigma_x$.
- #strong[Vorzeichenkonvention] (wie bei Schnittgrößen in TM1): Positive Spannungen zeigen am #strong[positiven] Schnittufer (Normale zeigt in +Koordinatenrichtung) in #strong[positive] Koordinatenrichtung, am negativen Schnittufer in negative Richtung. → $sigma > 0$ = Zug, $sigma < 0$ = Druck.
#bild("tm2k2_element3d", [Skript TM2 S. 291: infinitesimales Element (3D) mit allen Spannungen. Rot: Spannungen am positiven Schnittufer, gestrichelt: am negativen Schnittufer (nur Pfeile). Links: $sigma_("xx") = sigma_x$, Index-Bedeutung bei $tau_("xy")$.], height: 45mm)
#heading(level: 3, outlined: false)[Zugeordnete Schubspannungen]
Momentengleichgewicht am kleinen Element um seinen Mittelpunkt liefert: Schubspannungen in zwei senkrechten Schnitten sind gleich groß.
#form[$ tau_("xy") = tau_("yx"), wide tau_("xz") = tau_("zx"), wide tau_("yz") = tau_("zy") $]
Sie zeigen entweder beide auf die gemeinsame Kante zu oder beide von ihr weg. Deshalb nur 6 unabhängige Spannungen statt 9.
#bild("tm2k2_zugeordnet", [Skript TM2 S. 292: Freikörperbild des Elements (2D) und Gleichgewicht; aus $sum M = 0$ folgt $tau_("yz") = tau_("zy")$, „analog für alle anderen Schubspannungen“.], height: 45mm)
#heading(level: 3, outlined: false)[Spannungstensor ★]
#form[$ S = mat(delim: "(", sigma_x, tau_("xy"), tau_("xz") ; tau_("xy"), sigma_y, tau_("yz") ; tau_("xz"), tau_("yz"), sigma_z ) wide stretch(->)^( "eben" ) wide S = mat(delim: "(", sigma_x, tau_("xy") ; tau_("xy"), sigma_y ) $]
Hauptdiagonale = Normalspannungen, Rest = Schubspannungen; symmetrisch (FS TM2 Gl. 2.2, 2.3). Beim ebenen Spannungszustand (ESZ, dünne Scheibe, nur in ihrer Ebene belastet) gilt $sigma_z = tau_("xz") = tau_("yz") = 0$.
#bild("tm2k2_invarianten", [Skript TM2 S. 294: Spannungstensor „mehr als nur eine Matrix: es gelten die Invarianten (→ Koordinatentransformation)“. Rechts: 1) $sigma_(xi) + sigma_(eta) = sigma_x + sigma_y$ – die Summe der Normalspannungen ist in jedem Koordinatensystem gleich; 2) die Determinante bleibt bei der Drehung gleich: $sigma_x sigma_y - tau_("xy")^2 = sigma_(xi) sigma_(eta) - tau_(xi eta)^2$.], height: 45mm)
#note([Aus deiner Mitschrift (WZF 27.04.26, Beispiel 1)], [Quader $2a times a$, Dicke $t$, außen $2F$ in $x$-Richtung (Zug) und $F$ in $y$-Richtung (Druck).
+ 1. Schnitt senkrecht zu $x$: $sum F_x = 0 => F_("Sx") = 2F$, $F_("Sy") = 0$. Mit $A = a thin t$: $arrow(t) = frac(F, a t) binom(2, 0)$ → $sigma_x = frac(2F, a t)$, $tau_("xy") = 0$.
+ 2. Schnitt senkrecht zu $y$ (Fläche $2a dot t$): $F_("Sy") = -F$ → $sigma_y = - frac(F, 2 a t)$.
+ Ergebnis: $S = frac(F, a t) mat(delim: "(", 2, 0 ; 0, - frac(1, 2) )$.
Merksatz daraus: #strong[Spannungsvektor = Schnittkraft / Schnittfläche]\; seine Komponenten sind direkt die Einträge einer Zeile von $S$.])
#bild("tm2k2_wzf_bsp1", [WZF-Mitschrift 27.04.26 S. 1: Aufgabenskizze Beispiel 1 und positives Element (Vorzeichen der Spannungen am positiven/negativen Schnittufer).], height: 45mm)
#note([Fehler vermeiden], [Beim zweiten Schnitt ist die Fläche $2a dot t$, nicht $a dot t$. Jede Schnittfläche hat ihre eigene Fläche – und jede Spannung bezieht sich nur auf „ihre“ Fläche.], fill: sand)
#note([Merke], [3D: 3 Normal- + 3 unabhängige Schubspannungen. Eben: $sigma_x, sigma_y, tau_("xy")$ – #strong[drei Zahlen] beschreiben den Zustand vollständig.])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Spannungsvektor:] $arrow(t)$ ist ortsabhängig #emph[und] schnittrichtungsabhängig; drei senkrechte Schnitte legen den Zustand fest. #text(fill: muted)[\[TM2-Buch S. 37–38\]]
- #strong[Vorzeichenkonvention] „positive Spannungen zeigen am positiven Schnittufer in positive Koordinatenrichtung“. #text(fill: muted)[\[TM2-Buch S. 39\]]
- #strong[Ebener Spannungszustand:] Scheibe, Dicke klein, nur in ihrer Ebene belastet; Spannungen über die Dicke konstant. Hängen sie nicht vom Ort ab: #strong[homogener] Spannungszustand. #text(fill: muted)[\[TM2-Buch S. 40–41\]]
- #strong[Gleichgewichtsbedingungen] am Element: $partial sigma_x / partial x + partial tau_("yx")/ partial y + f_x = 0$ usw.; ein homogener Spannungszustand ist mit Volumenkräften nicht möglich. #text(fill: muted)[\[TM2-Buch S. 58–60\]]])
#src[Skript TM2 S. 283–294; FS TM2 S. 11–12; WZF-Mitschrift 27.04.26 S. 1–3; Übung 5, Aufg. 5.1; TM2-Buch S. 37–41, 58–60.]
== TM2 2.2 Ebener Spannungszustand: Transformationsgleichungen <a-tm2-2-2>
Gegeben ist der Spannungszustand im $x,y$-System ($sigma_x, sigma_y, tau_("xy")$). Gesucht sind die Spannungen in einem #strong[schrägen Schnitt], z. B. in einer Schweißnaht. Dazu dreht man ein neues $xi, eta$-System um den Winkel $phi$ (positiv #strong[gegen den Uhrzeigersinn]); die $xi$-Achse steht senkrecht auf dem schrägen Schnitt.
Herleitung (Skript): Man schneidet ein kleines #strong[Dreieck] heraus und stellt das Kräftegleichgewicht in $xi$- und $eta$-Richtung auf. Wichtig: Gleichgewicht gilt für #strong[Kräfte], also Spannung × Fläche ($d A$, $d A cos phi$, $d A sin phi$). Mit den Doppelwinkelformeln entstehen die drei Transformationsgleichungen.
#note([In eigenen Worten], [Ein Foto vom selben Haus aus verschiedenen Blickwinkeln: Das Haus (der Spannungszustand) ist dasselbe, nur die „Ansicht“ (die Zahlen $sigma_(xi), tau_(xi eta)$) ändert sich. Die Transformationsgleichungen sind die Umrechnungsregel zwischen den Ansichten. #text(fill: muted)[(eigene Ergänzung)]])
#bild("tm2k2_dreieck", [Skript TM2 S. 298: Modell zur Herleitung von $sigma_(xi)$ und $tau_(xi eta)$ – Dreieckselement mit den Flächen $d A$, $d A cos phi$, $d A sin phi$ und Gleichgewicht in $xi$- und $eta$-Richtung.], height: 45mm)
#heading(level: 3, outlined: false)[Formeln ★]
#form[$ sigma_(xi) & = frac(1, 2) ( sigma_x + sigma_y ) + frac(1, 2) ( sigma_x - sigma_y ) cos 2 phi + tau_("xy") sin 2 phi \
 sigma_(eta) & = frac(1, 2) ( sigma_x + sigma_y ) - frac(1, 2) ( sigma_x - sigma_y ) cos 2 phi - tau_("xy") sin 2 phi \
 tau_(xi eta) & = - frac(1, 2) ( sigma_x - sigma_y ) sin 2 phi + tau_("xy") cos 2 phi $]
FS TM2 Gl. 2.4–2.6; alle Spannungen in N/mm². $phi$ = Drehwinkel von $x$ nach $xi$, positiv gegen den Uhrzeigersinn.
#form[$ "Invariante:" quad sigma_(xi) + sigma_(eta) = sigma_x + sigma_y, wide sigma_(xi) sigma_(eta) - tau_(xi eta)^2 = sigma_x sigma_y - tau_("xy")^2 $]
FS TM2 Gl. 2.7; Skript TM2 S. 304. Ideal als #strong[Rechenkontrolle].
#bild("tm2k2_transformation", [Skript TM2 S. 302: die Transformationsgleichungen (rot umrahmt) – identisch mit FS TM2 Gl. 2.4–2.6. Umformung mit $cos^2 phi = frac(1, 2) (1+ cos 2 phi )$, $sin^2 phi = frac(1, 2) (1- cos 2 phi )$, $2 sin phi cos phi = sin 2 phi$ (Skript TM2 S. 301).], height: 45mm)
#note([Merke], [$sigma_(eta)$ bekommst du aus $sigma_(xi)$, indem du $phi$ durch $phi + 90°$ ersetzt – deshalb drehen sich in der zweiten Zeile die Vorzeichen von $cos 2 phi$- und $sin 2 phi$-Term um. Alle Größen hängen vom #strong[doppelten Winkel] $2 phi$ ab.])
#note([Beispiel (WZF 27.04.26, Beispiel 1, Teil 2)], [Geg.: $sigma_x = frac(2F, a t)$, $sigma_y = - frac(F, 2a t)$, $tau_("xy") = 0$. Ges.: $sigma$, $tau$ im 45°-Schnitt.
+ $phi = 45°$: $cos 2 phi = cos 90° = 0$, $sin 2 phi = 1$.
+ $sigma_(xi) = frac(1, 2) ( sigma_x + sigma_y ) = frac(1, 2) ( frac(2F, a t) - frac(F, 2a t) ) = frac(3, 4) thin frac(F, a t) = 0","75 thin frac(F, a t)$
+ $tau_(xi eta) = - frac(1, 2) ( sigma_x - sigma_y ) = - frac(1, 2) ( frac(2F, a t) + frac(F, 2a t) ) = - frac(5, 4) thin frac(F, a t) = -1","25 thin frac(F, a t)$
+ Kontrolle in der Mitschrift: gleiches Ergebnis über „Schnitt + Gleichgewicht“ am schrägen Schnitt (Fläche $sqrt(2) thin a t$).], fill: pale)
#bild("tm2k2_wzf_trafo45", [WZF-Mitschrift 27.04.26 S. 4: Transformationsgleichungen für den 45°-Schnitt, gedrehtes $xi, eta$-Element.], height: 45mm)
#note([Fehler vermeiden (in deiner Mitschrift)], [Auf S. 5 steht $tau = - frac(1, 2) ( sigma_x - sigma_y ) sin phi + tau_(xi eta) cos 2 phi$. Richtig ist $sin 2 phi$ und $tau_("xy") cos 2 phi$ (FS Gl. 2.6). Am Ergebnis ändert das hier nichts, weil $tau_("xy") = 0$ und $sin 90° = 1$.], fill: sand)
#note([Beispiel (Übung 5, Aufg. 5.2 – Schweißnaht)], [Nur $sigma_x = 50$ N/mm², Naht unter $phi = 30°$.
+ $sigma ( phi ) = sigma_x cos^2 phi = frac(sigma_x, 2) (1+ cos 2 phi ) = 25 thin (1+0","5) = 37","5$ N/mm²
+ $tau ( phi ) = - sigma_x sin phi cos phi = - frac(sigma_x, 2) sin 2 phi = -25 dot 0","866 = -21","65$ N/mm²
Das sind genau die Transformationsgleichungen mit $sigma_y = tau_("xy") = 0$ (Übung 5, Kurzlösung).], fill: pale)
#note([Fehler vermeiden (typische Fehler)], [- $phi$ statt $2 phi$ in cos/sin einsetzen.
- Vorzeichen von $phi$ falsch: Drehung im Uhrzeigersinn ist #strong[negativ] (z. B. $phi = -30°$).
- Taschenrechner im Bogenmaß (RAD) statt Grad (DEG).
- Gleichgewicht mit Spannungen statt mit Kräften (Spannung × Fläche) aufgestellt.], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Herleitung] am Dreieck der Dicke $t$ mit $sigma_(xi) = sigma_x cos^2 phi + sigma_y sin^2 phi + 2 tau_("xy") sin phi cos phi$ (Form vor dem Doppelwinkel). #text(fill: muted)[\[TM2-Buch S. 41–43\]]
- #strong[Tensor 2. Stufe:] Größe mit zwei Indizes, die beim Drehen nach einer festen Vorschrift (hier Gl. 2.6) transformiert wird; Vektoren sind Tensoren 1. Stufe. #text(fill: muted)[\[TM2-Buch S. 43\]]
- #strong[Hydrostatischer Spannungszustand:] $sigma_x = sigma_y$, $tau_("xy") = 0$ → in jedem Schnitt gleiche Normalspannung, nie Schub (wie Druck in ruhender Flüssigkeit). #text(fill: muted)[\[TM2-Buch S. 44\]]
- #strong[Beispiel 2.1] (Blech, $sigma_x = -64$, $sigma_y = 32$, $tau_("xy") = -20$ MPa, Schnitt unter 60° zur x-Achse → $phi = -30°$): $sigma_(xi) = -22","7$ MPa, $tau_(xi eta) = -51","6$ MPa. #text(fill: muted)[\[TM2-Buch S. 47–48\]]])
#src[Skript TM2 S. 296–304; FS TM2 S. 12; WZF-Mitschrift 27.04.26 S. 3–5; Übung 5, Aufg. 5.1 c, 5.2 und Kurzlösungen; TM2-Buch S. 41–44, 47–48.]
== TM2 2.2.2 Hauptspannungen und Hauptschubspannungen <a-tm2-2-2-2>
Dreht man den Schnitt, ändert sich $sigma_(xi)$ periodisch. Es gibt einen Winkel $phi^(*)$, bei dem $sigma_(xi)$ #strong[maximal] wird, und senkrecht dazu ($phi^(*) + 90°$) ist sie #strong[minimal]. Diese Extremwerte heißen #strong[Hauptspannungen] $sigma_1$ (die größere) und $sigma_2$ (die kleinere), die Richtungen #strong[Hauptrichtungen]. In den Hauptschnitten ist die Schubspannung #strong[null].
Die größte Schubspannung $tau_("max")$ tritt in Schnitten auf, die um #strong[45°] zu den Hauptrichtungen gedreht sind. Dort wirkt zusätzlich die mittlere Normalspannung $sigma_M$ (meist ≠ 0!).
#note([In eigenen Worten], [Ein Holzbrett hat Fasern. Ziehst du in Faserrichtung, ist der Widerstand am größten – das ist wie die Hauptrichtung: eine „ausgezeichnete“ Richtung, in der nur gezogen bzw. gedrückt wird und nichts schert. #text(fill: muted)[(eigene Ergänzung)]])
#heading(level: 3, outlined: false)[Formeln ★]
#form[$ tan 2 phi^(*) = frac(2 tau_("xy"), sigma_x - sigma_y), wide sigma_(1,2) = frac(sigma_x + sigma_y, 2) plus.minus sqrt(( frac(sigma_x - sigma_y, 2) )^2 + tau_("xy")^2) $]
Hauptnormalspannungen (FS TM2 Gl. 2.8, 2.9). $sigma_1$ mit „+“, $sigma_2$ mit „−“. Zweite Hauptrichtung $phi^(*) plus.minus 90°$.
#form[$ tan 2 phi^(**) = - frac(sigma_x - sigma_y, 2 tau_("xy")), quad phi^(**) = phi^(*) + 45°, wide tau_("max") = sqrt(( frac(sigma_x - sigma_y, 2) )^2 + tau_("xy")^2) = frac(1, 2) ( sigma_1 - sigma_2 ), wide sigma_M = frac(1, 2) ( sigma_x + sigma_y ) $]
Hauptschubspannungen (FS TM2 Gl. 2.10, 2.11, 2.13): $tau_(xi eta)^(**) = plus.minus tau_("max")$; in diesen Schnitten $sigma_(xi)^(**) = sigma_(eta)^(**) = sigma_M$.
#heading(level: 3, outlined: false)[Welcher Winkel gehört zu $sigma_1$? ★]
Der Taschenrechner liefert aus $arctan$ nur einen Winkel. Ob der zu $sigma_1$ oder zu $sigma_2$ gehört, prüfst du so (FS-/Übungsweg):
+ $phi^(*)$ in die Gleichung für $sigma_(xi)$ (FS 2.4) einsetzen.
+ Kommt $sigma_1$ heraus → $xi$-Richtung = 1. Hauptrichtung. Kommt $sigma_2$ heraus → $sigma_1$ wirkt senkrecht dazu ($eta$-Richtung, $phi^(*) + 90°$).
+ Kontrolle: $tau_(xi eta)( phi^(*)) = 0$ und $sigma_(xi) + sigma_(eta) = sigma_x + sigma_y$.
#note([Faustregel], [Mit $phi^(*) = frac(1, 2) arctan frac(2 tau_("xy"), sigma_x - sigma_y)$ (Rechner liefert $-45° < phi^(*) < 45°$) gilt: Ist $sigma_x > sigma_y$, gehört $phi^(*)$ zu $sigma_1$; ist $sigma_x < sigma_y$, gehört $phi^(*)$ zu $sigma_2$. Grund: Dann ist $cos 2 phi^(*) > 0$ und $sigma_(xi) - sigma_M$ hat dasselbe Vorzeichen wie $sigma_x - sigma_y$. Trotzdem in der Klausur durch Einsetzen zeigen. #text(fill: muted)[(eigene Ergänzung, an allen Übungsbeispielen geprüft)]])
#note([Beispiel (WZF 27.04.26, Beispiel 2; gleiche Zahlen wie TM2-Buch Beispiel 2.2)], [$S = mat(delim: "(", 50, 30 ; 30, -20 )$ N/mm².
+ $sigma_(1,2) = frac(1, 2) (50-20) plus.minus sqrt(35^2 + 30^2) = 15 plus.minus 46","1$ → $sigma_1 = 61","1$ N/mm², $sigma_2 = -31","1$ N/mm²
+ $tau_("max") = frac(1, 2) ( sigma_1 - sigma_2 ) = 46","1$ N/mm², $sigma_M = 15$ N/mm²
+ $tan 2 phi^(*) = frac(60, 70)$ → $phi^(*) = 20","3°$. Da $sigma_x > sigma_y$: gehört zu $sigma_1$ (Einsetzen: $sigma_(xi)(20","3°) = 61","1$ ✓).
+ $phi^(**) = 20","3° + 45° = 65","3°$
Diese Zahlen werden unten im Mohrschen Kreis grafisch bestätigt.], fill: pale)
#note([Beispiel (WZF 04.05.26 – „mögliche Klausuraufgabe“)], [$sigma_x = -100$, $sigma_y = 100$, $tau_("xy") = -100$ N/mm².
+ $sigma_(1,2) = 0 plus.minus sqrt((-100)^2 + (-100)^2) = plus.minus 141","4$ N/mm²; $tau_("max") = 141","4$ N/mm²; $sigma_M = 0$
+ $tan 2 phi^(*) = frac(2 dot (-100), -100-100) = 1$ → $phi^(*) = 22","5°$ (und $112","5°$)
+ $sigma_(xi)^(*) = 0 + frac(1, 2) (-200) cos 45° + (-100) sin 45° = -141","4 = sigma_2$; $sigma_(eta)^(*) = +141","4 = sigma_1$; Kontrolle $tau_(xi eta)^(*) = 0$ ✓
+ $phi^(**) = 67","5°$: $tau_(xi eta)^(**) = - frac(1, 2) (-200) sin 135° + (-100) cos 135° = +141","4 = + tau_("max")$; $sigma^(**) = sigma_M = 0$
+ Tensoren: $phi = 22","5°$: $S = mat(delim: "(", -141","4, 0 ; 0, 141","4 )$; $phi = 67","5°$: $S = mat(delim: "(", 0, 141","4 ; 141","4, 0 )$], fill: pale)
#note([Von dir markiert (WZF 04.05.26, rot) ★], [„#strong[Mögliche Klausuraufgabe → auch Aufgabe 6.2]“. Und blau: „$sigma_1$ ist immer das Größere“. → Übe Übung 6.2 ($sigma_x = 77","5$, $sigma_y = -22","5$, $tau_("xy") = -37","5$ N/mm²) komplett: $sigma_1 = 90$, $sigma_2 = -35$, $phi^(*) = -18","43°$ (gehört zu $sigma_1$), $tau_("max") = 62","5$, $sigma_M = 27","5$ N/mm², $phi^(**) = 26","57°$ (Übung 6, Kurzlösung).], fill: sand)
#bild("tm2k2_wzf_bsp6", [WZF-Mitschrift 04.05.26 S. 1: Aufgabe mit deiner roten Markierung „Mögliche Klausuraufgabe → auch Aufgabe 6.2“.], height: 45mm)
#note([Fehler auf der Folie (Skript TM2 S. 305 und S. 306)], [- S. 305: $tan (2 phi^(*)) = frac(2 tau_("xy"), sigma_y - sigma_x)$ – der Nenner ist vertauscht. Aus $d sigma_(xi)/d phi = -( sigma_x - sigma_y ) sin 2 phi + 2 tau_("xy") cos 2 phi = 0$ folgt $tan 2 phi^(*) = frac(2 tau_("xy"), sigma_x - sigma_y)$ (so in FS Gl. 2.8, TM2-Buch Gl. 2.8, Übungslösungen).
- S. 305 und S. 306: unter der Wurzel steht $( frac(sigma_x - sigma_y, 2) )^2 bold(-) tau_("xy")^2$. Richtig ist #strong[$+ thin tau_("xy")^2$] – sonst wäre bei reinem Schub ($sigma_x = sigma_y = 0$) die Wurzel negativ. Die Folie S. 307 (Mohrscher Kreis) hat es richtig: $r^2 = ( frac(sigma_x - sigma_y, 2) )^2 + tau_("xy")^2$.
- S. 306: $tan (2 phi^(**)) = frac(sigma_y - sigma_x, tau_("xy"))$ – es fehlt der Faktor 2 im Nenner: richtig $tan 2 phi^(**) = - frac(sigma_x - sigma_y, 2 tau_("xy"))$ (FS Gl. 2.10). Außerdem muss die Extremwertbedingung $d tau_(xi eta)/d phi = 0$ heißen (Folie: „$tau_("xy")/d phi$“).
→ In der Klausur #strong[immer die Formelsammlung] verwenden.], fill: sand)
#bild("tm2k2_folie_hns", [Skript TM2 S. 305: Herleitung der Hauptnormalspannungen – mit den beiden Vorzeichenfehlern (Nenner $sigma_y - sigma_x$, „$- tau_("xy")^2$“ unter der Wurzel).], height: 45mm)
#note([Fehler vermeiden (typische Fehler)], [- $tau_("max")$ mit $frac(1, 2) ( sigma_1 + sigma_2 )$ rechnen – das ist $sigma_M$!
- Vergessen, dass in den Schnitten von $tau_("max")$ auch noch $sigma_M$ wirkt.
- $phi^(*)$ einfach als Richtung von $sigma_1$ annehmen, ohne zu prüfen.], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Hauptachsensystem] (Achsen 1 und 2) und Bild der Spannungen im $x,y$-, Haupt- und $tau_("max")$-System (Abb. 2.6). #text(fill: muted)[\[TM2-Buch S. 46\]]
- #strong[Herleitung] von $sigma_(1,2)$ über $cos 2 phi^(*) = 1/ sqrt(1+ tan^2 2 phi^(*))$ (Gl. 2.9, 2.10); „Wenn in einem Schnitt keine Schubspannung auftritt, ist die Normalspannung dort eine Hauptspannung.“ #text(fill: muted)[\[TM2-Buch S. 45\]]
- #strong[$2 phi^(**)$ und $2 phi^(*)$ stehen senkrecht] aufeinander, weil $tan 2 phi^(**) = -1/ tan 2 phi^(*)$ → 45° im Bauteil. #text(fill: muted)[\[TM2-Buch S. 46\]]
- #strong[Beispiel 2.1 b, c:] $sigma_1 = 36$, $sigma_2 = -68$ MPa; $phi^(*) = 11","3°$ gehört zu $sigma_2$ (weil $sigma_x < sigma_y$); $tau_("max") = 52$ MPa, $sigma_M = -16$ MPa. #text(fill: muted)[\[TM2-Buch S. 49\]]])
#src[Skript TM2 S. 296–297, 303–306; FS TM2 S. 13; WZF-Mitschrift 27.04.26 S. 6–7; WZF-Mitschrift 04.05.26 S. 1–4; Übung 6, Aufg. 6.1, 6.2 und Lösung Übung 6 S. 1–4; TM2-Buch S. 44–49.]

== TM2 2.2.3 Der Mohrsche Spannungskreis <a-tm2-2-2-3>
Quadriert man die Transformationsgleichungen für $sigma_(xi)$ und $tau_(xi eta)$ und addiert sie, fällt der Winkel heraus (Skript TM2 S. 307, FS TM2 S. 13):
#form[$ (sigma_(xi) - sigma_M)^2 + tau_(xi eta)^2 = r^2 wide sigma_M = frac(1, 2) (sigma_x + sigma_y), wide r = sqrt(((sigma_x - sigma_y)/2)^2 + tau_("xy")^2) $]
Das ist die Gleichung eines Kreises im $sigma$-$tau$-Diagramm. Jeder Punkt auf dem Kreis gehört zu einer Schnittrichtung. So liest du alle Spannungen eines Punktes aus einer Zeichnung ab.
#note([In eigenen Worten], [Der Kreis ist wie ein Zifferblatt: Jede Schnittrichtung ist eine Uhrzeit. Drehst du den Schnitt im Bauteil um $phi$, wandert der Zeiger im Kreis um $2 phi$, und zwar andersherum. #text(fill: muted)[(eigene Ergänzung)]])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k2_mohr_herleitung", [Skript TM2 S. 307: Herleitung des Kreises aus den Transformationsgleichungen (handschriftliche Folie).], height: 52mm)],
 [#bild("tm2k2_fs_kreis", [FS TM2 S. 15: Spannungskreis mit $P = (sigma_x, tau_("xy"))$, $P' = (sigma_y, -tau_("xy"))$, Mittelpunkt $sigma_M$, Radius $r$, Winkel $2 phi$.], height: 52mm)])
#heading(level: 3, outlined: false)[Konstruktion in fünf Schritten (FS TM2 S. 14)]
+ $sigma$-Achse waagerecht, $tau$-Achse senkrecht; #strong[gleicher Maßstab] für beide (z. B. 20 N/mm² ≙ 1 cm).
+ Punkt $P = (sigma_x, tau_("xy"))$ und Punkt $P' = (sigma_y, -tau_("xy"))$ eintragen (Vorzeichen beachten!).
+ Linie $P P'$ ziehen: Sie schneidet die $sigma$-Achse im Mittelpunkt $sigma_M$; die halbe Länge ist der Radius $r$. Kreis zeichnen.
+ Ablesen: $sigma_1$, $sigma_2$ = Schnittpunkte mit der $sigma$-Achse; $plus.minus tau_(max)$ = oberster und unterster Punkt.
+ Richtungen: Von der Linie $overline(sigma_M P)$ aus den Winkel $2 phi^*$ bzw. $2 phi^(**)$ messen. Eine Drehung um $phi$ im Bauteil (gegen den Uhrzeigersinn) ist im Kreis $2 phi$ #strong[in entgegengesetzter Richtung]. Ein beliebiger Schnitt $phi$ liefert die Punkte $Q = (sigma_(xi), tau_(xi eta))$ und $Q' = (sigma_(eta), -tau_(xi eta))$.
#note([Von dir markiert (rot, WZF 04.05.26 S. 5)], [„Kommt i. d. Prüfung dran!“ steht neben dem Mohrschen Kreis. Übe deshalb die Konstruktion mit Lineal und Zirkel auf Karopapier, nicht nur die Rechnung.], fill: sand)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k2_w45_5", [WZF 04.05.26 S. 5: Mohrscher Kreis zum Beispiel $sigma_x = -100$, $sigma_y = 100$, $tau_("xy") = -100$ N/mm², Maßstab 20 N/mm² ≙ 1 cm.], height: 95mm)],
 [#bild("tm2k2_w45_6", [WZF 04.05.26 S. 6: abgelesene Werte.], height: 35mm)
  #bild("tm2k2_mohr_bongmba", [Folie Bongmba „2.2 Ebener Spannungszustand – Spannungskreis“ (dein Bildschirmfoto).], height: 50mm)])
#note([Beispiel (WZF 04.05.26 S. 5–6)], [$P = (-100; -100)$, $P' = (100; 100)$ → Mittelpunkt $sigma_M = 0$, Radius $r = sqrt(100^2 + 100^2) = "141,4" thin "N/mm"^2$.
+ Abgelesen: $sigma_1 = 141$, $sigma_2 = -141 thin "N/mm"^2$, $tau_(max) = 141 thin "N/mm"^2$.
+ Winkel zwischen $overline(sigma_M P)$ und $sigma$-Achse: $2 phi^* = 45°$ → $phi^* = "22,5"°$; $phi^(**) = "67,5"°$.
+ Gleiche Werte wie die Rechnung in 2.2.2 – der Kreis ist die zeichnerische Kontrolle.], fill: pale)
#heading(level: 3, outlined: false)[Die acht Kreise A01–A08 aus dem Skript]
Das Skript zeigt acht Kreise, bei denen nur die Vorzeichen von $sigma_x$, $sigma_y$, $tau_("xy")$ wechseln (S. 310–335). Ein gutes Training: Erst skizzieren, dann mit der Folie vergleichen.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k2_mohr_tabelle", [Skript TM2 S. 310: Werte der acht Aufgaben A01–A08.], height: 50mm)],
 [#bild("tm2k2_mohr_a01", [Skript TM2 S. 311: Kreis A01 ($sigma_x = 50$, $sigma_y = 20$, $tau_("xy") = 30$ N/mm²).], height: 50mm)])
#bild("tm2k2_mohr_a01_zust", [Skript TM2 S. 312: zu A01 Ausgangslage, Hauptnormalspannungszustand ($phi^*$) und Hauptschubspannungszustand ($phi^(**)$).], height: 42mm)
#note([Merke], [Alle acht Kreise haben denselben Radius $r = "33,5" thin "N/mm"^2$, weil $|sigma_x - sigma_y| = 30$ und $|tau_("xy")| = 30$ gleich bleiben. Nur der Mittelpunkt ($sigma_M$) und die Lage von $P$ ändern sich. Das Vorzeichen von $tau_("xy")$ entscheidet, ob $P$ über oder unter der $sigma$-Achse liegt, also in welche Richtung $phi^*$ zeigt. #text(fill: muted)[(eigene Ergänzung)]])
#note([Achtung: typische Fehler], [- Unterschiedlicher Maßstab auf $sigma$- und $tau$-Achse: Dann ist es kein Kreis mehr.
- $P'$ mit $+tau_("xy")$ statt $-tau_("xy")$ eingetragen.
- Den Winkel im Kreis ($2 phi$) direkt als Bauteilwinkel nehmen; immer halbieren.
- Drehsinn: Im Kreis entgegengesetzt zur Drehung im Bauteil.], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- Herleitung des Kreises, Konstruktion aus $sigma_x$, $sigma_y$, $tau_("xy")$, Sonderfälle einachsiger Zug, reiner Schub und hydrostatischer Zustand (Kreis wird zum Punkt). #text(fill: muted)[\[TM2-Buch S. 50–52\]]
- Zwei durchgerechnete Beispiele zum Mohrschen Kreis. #text(fill: muted)[\[TM2-Buch S. 53–55\]]])
#src[Skript TM2 S. 307–335; FS TM2 S. 13–15; Folie Bongmba „Spannungskreis“ (Bildschirmfoto); WZF 04.05.26 S. 5–6; Übung 6 und Lösung; TM2-Buch S. 50–55.]

== TM2 2.3 Anwendung und Festigkeitshypothesen <a-tm2-2-3>
#heading(level: 3, outlined: false)[Anwendung: dünnwandiges Rohr und Kessel]
Das wichtigste Anwendungsbeispiel für den ebenen Spannungszustand ist ein dünnwandiges Rohr (Radius $r_m$, Wanddicke $t$). An einem kleinen Wandstück wirken (FS TM2 S. 15):
#form[$ "Längskraft:" sigma_L = F_x/(2 pi r_m t) wide "Torsion:" tau = M_t/(2 pi r_m^2 t) wide "Innendruck (Kessel):" sigma_x = (p r_m)/(2t), quad sigma_y = (p r_m)/t $]
Längs ($x$) ist die Spannung im Kessel nur halb so groß wie in Umfangsrichtung ($y$). Deshalb platzen Würstchen und Rohre der Länge nach auf. #text(fill: muted)[(eigene Ergänzung)]
#heading(level: 3, outlined: false)[Warum eine Vergleichsspannung?]
Der Zugversuch liefert nur einen Grenzwert für #strong[einachsigen] Zug ($R_e$, $R_m$, $sigma_("zul")$). Im Bauteil wirken aber $sigma_x$, $sigma_y$ und $tau_("xy")$ gleichzeitig. Eine #strong[Festigkeitshypothese] rechnet den ebenen Zustand in eine einzige Zahl $sigma_V$ um, die so „gefährlich“ ist wie ein Zugstab mit $sigma = sigma_V$. Nachweis: $sigma_V <= sigma_("zul")$.
#form[$ "Normalspannungshypothese:" quad sigma_V = sigma_1 quad (2.21) $]
#form[$ "Schubspannungshypothese (Tresca):" quad sigma_V = sigma_1 - sigma_2 = 2 tau_(max) = sqrt((sigma_x - sigma_y)^2 + 4 tau_("xy")^2) quad (2.22) \ sigma_V = max(|sigma_1|, |sigma_2|) quad "bei gleichem Vorzeichen von" sigma_1, sigma_2 quad (2.23) $]
#form[$ "Gestaltänderungsenergiehypothese (von Mises, GEH):" \ sigma_V = sqrt(sigma_1^2 + sigma_2^2 - sigma_1 sigma_2) = sqrt(sigma_x^2 + sigma_y^2 - sigma_x sigma_y + 3 tau_("xy")^2) quad (2.24) $]
#tab(columns: 3,
 th([Hypothese], [passt zu], [Grundidee]),
 [Normalspannung], [spröden Werkstoffen (Grauguss, Glas)], [Bruch, wenn die größte Zugspannung die Grenze erreicht],
 [Schubspannung], [zähen Werkstoffen, auf der sicheren Seite], [Fließen, wenn $tau_(max)$ die Grenze erreicht],
 [GEH (von Mises)], [zähen Werkstoffen (Stahl), am häufigsten], [Fließen, wenn die Energie der Gestaltänderung die Grenze erreicht],
)
Die Zuordnung zu Werkstoffen #text(fill: muted)[(eigene Ergänzung)]. Folien und Formelsammlung nennen nur die Formeln.
#note([In eigenen Worten], [Drei Schiedsrichter bewerten dasselbe Foul. Der eine schaut nur auf den Stoß (Normalspannung), der zweite auf das Wegrutschen (Schub), der dritte auf die gesamte Verformung (von Mises). Für zähe Werkstoffe trifft der dritte meist am besten. #text(fill: muted)[(eigene Ergänzung)]])
#heading(level: 3, outlined: false)[Beispiel aus der 7. Übung (WZF 11.05.26): Behälter mit Innendruck und Torsion]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k2_w115_1", [WZF 11.05.26 S. 1: dünnwandiger Behälter mit Innendruck $p$ und Torsionsmoment $M_t$; Aufgabenstellung, Spannungszustand.], height: 95mm)],
 [#bild("tm2k2_w115_2", [WZF 11.05.26 S. 2: Kesselformeln, Schubspannung, Tensor; Hauptspannungsrichtung.], height: 95mm)])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k2_w115_3", [WZF 11.05.26 S. 3: Hauptspannungen mit Kontrolle über die Invariante, Hauptschubspannung.], height: 95mm)],
 [#bild("tm2k2_w115_4", [WZF 11.05.26 S. 4: Schweißnahtrichtung und die drei Vergleichsspannungen.], height: 95mm)])
#note([Beispiel (WZF 11.05.26)], [$r = 10$ mm, $t = 1$ mm, $p = 10 thin "N/mm"^2$, $M_t = 31420 thin "Nmm"$.
+ $sigma_x = p r\/(2t) = 50$, $sigma_y = p r\/t = 100$, $tau_("xy") = -M_t\/(2 pi r^2 t) = -50 thin "N/mm"^2$.
+ $tan 2 phi^* = 2(-50)\/(50 - 100) = 2$ → $phi^* = "31,7"°$; Einsetzen: $sigma_(xi)^* = "19,1" = sigma_2$, $sigma_(eta)^* = "130,9" = sigma_1$. Kontrolle: $19","1 + 130","9 = 150 = sigma_x + sigma_y$ ✓.
+ $phi^(**) = "76,7"°$, $tau_(max) = "55,9" thin "N/mm"^2$, $sigma_M = 75 thin "N/mm"^2$.
+ Vergleichsspannungen: Normalspannung $sigma_V = 130$; Schubspannung (gleiche Vorzeichen) $sigma_V = max(|sigma_1|, |sigma_2|) = 130$; von Mises $sigma_V = sqrt(50^2 + 100^2 - 50 dot 100 + 3 dot 50^2) = "122,5" thin "N/mm"^2$.], fill: pale)
#note([Hinweise zur Mitschrift (WZF 11.05.26)], [- Beim Torsionsmoment steht die Einheit „N/mm²“. Ein Moment hat die Einheit Nmm: $M_t = 31420 thin "Nmm"$.
- Für die Vergleichsspannungen wurde auf $sigma_1 = 130$, $sigma_2 = 20$ gerundet. Mit diesen Werten ergibt von Mises nur $"121,2"$; die notierten $"122,5" thin "N/mm"^2$ kommen aus den ungerundeten Werten bzw. aus der Formel mit $sigma_x$, $sigma_y$, $tau_("xy")$. Rechne lieber mit der $x$-$y$-Form, dann brauchst du keine gerundeten Hauptspannungen.], fill: sand)
#note([Achtung], [Die Schubspannungshypothese hat zwei Formeln. $sigma_1 - sigma_2$ gilt, wenn $sigma_1$ und $sigma_2$ verschiedene Vorzeichen haben. Haben beide dasselbe Vorzeichen, ist $sigma_V = max(|sigma_1|, |sigma_2|)$ (FS 2.23), weil dann die größte Schubspannung in einer Ebene außerhalb der Blechebene liegt.], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- Dünnwandiger Kessel unter Innendruck: Kesselformeln aus dem Gleichgewicht am geschnittenen Kessel; dünnwandig, wenn $r > 5t$. #text(fill: muted)[\[TM2-Buch S. 55–57\]]
- Festigkeitshypothesen und Vergleichsspannung (Normal-, Schubspannungs-, Gestaltänderungsenergiehypothese). #text(fill: muted)[\[TM2-Buch S. 76–78\]]])
#src[FS TM2 S. 15–16; WZF 11.05.26 S. 1–4; Übung 7 und Kurzlösung; TM2-Buch S. 55–57, 76–78.]

#bild("map-t2k2", [Mindmap zu TM2 Kapitel 2 (eigene Darstellung nach Skript TM2 S. 280–337 und FS TM2 S. 11–16).], height: 70mm)
*Der Zusammenhang in TM2 Kapitel 2.* In Kapitel 1 gab es nur eine Spannung $sigma = N\/A$ und den schrägen Schnitt als Nebenbemerkung. Jetzt wirken in einem Punkt mehrere Spannungen gleichzeitig, und welche Zahlen du siehst, hängt vom Schnitt ab (2.1). Die Transformationsgleichungen rechnen von einem Schnitt auf jeden anderen um (2.2); ihre Extremwerte sind die Hauptspannungen und $tau_(max)$ (2.2.2). Der Mohrsche Kreis zeigt dasselbe als Bild und dient als Kontrolle (2.2.3). Am Ende fasst die Vergleichsspannung alles zu einer Zahl zusammen, die du mit dem Zugversuch vergleichen kannst (2.3). Die Schubspannungen aus Torsion (→ TM2 Kapitel 5) und Biegung (→ TM2 Kapitel 4) landen später genau in diesem Werkzeug.

#pagebreak()
== Verständnisfragen und Rechenaufgaben · TM2 Kapitel 2
#set enum(spacing: 0.85em)
Erkläre erst selbst. Bei Rechenaufgaben: Element mit Spannungen skizzieren, Vorzeichen prüfen, mit der Invariante kontrollieren. Die Lösungen folgen getrennt.

+ Was bedeuten die zwei Indizes bei $tau_("xy")$?
+ Warum ist $tau_("xy") = tau_("yx")$?
+ Warum stehen in den Transformationsgleichungen Winkel $2 phi$ und nicht $phi$?
+ Was gilt in den Hauptschnitten für die Schubspannung?
+ Wie liegen die Schnitte mit $tau_(max)$ zu den Hauptrichtungen, und welche Normalspannung wirkt dort?
+ Wie findest du Mittelpunkt und Radius des Mohrschen Kreises?
+ Warum braucht man eine Vergleichsspannung, und wann nimmst du welche Hypothese?
+ Ebener Spannungszustand $sigma_x = 60$, $sigma_y = 0$, $tau_("xy") = 0$ N/mm². Berechne $sigma_(xi)$ und $tau_(xi eta)$ für $phi = 60°$. #text(fill: muted)[(eigene Aufgabe)]
+ Reiner Schub $tau_("xy") = 40$ N/mm² ($sigma_x = sigma_y = 0$). Bestimme $sigma_1$, $sigma_2$, $phi^*$ und $tau_(max)$. #text(fill: muted)[(eigene Aufgabe)]
+ Berechne für $sigma_x = 80$, $sigma_y = 20$, $tau_("xy") = 40$ N/mm² die Hauptspannungen und die Vergleichsspannung nach von Mises. #text(fill: muted)[(eigene Aufgabe)]

#heading(level: 3, outlined: false)[Vertiefende Verständnisfragen und Rechenaufgaben]
#block[
#set enum(start: 11)
+ *Übung 5, Aufg. 5.1 a, c:* Blechstreifen ($t = 1$ mm, $b = 100$ mm, $l = 1$ m) unter $F = 10$ kN. a) $sigma_x$, $sigma_y$, $tau_("xy")$ und Tensor $S$; c) Spannungsvektoren und $sigma$, $tau$ für Schnitte senkrecht zu $x$, senkrecht zu $y$ und unter 45° (Gleichgewicht und Transformation). (Teil b gehört zu → TM2 Kapitel 3.)
  #bild("tm2k2_ue51", [Übung TM2 Nr. 5, Aufg. 5.1: Blechstreifen mit 45°-Schnitt.], height: 30mm)
+ *Übung 5, Aufg. 5.2:* Geschweißter Streifen mit $sigma_x = 50$ N/mm², Naht unter $phi = 30°$. $sigma(phi)$, $tau(phi)$ allgemein und als Zahl.
  #bild("tm2k2_ue52", [Übung TM2 Nr. 5, Aufg. 5.2: Schweißnaht unter $phi$.], height: 28mm)
+ *Übung 6, Aufg. 6.1:* Streifen aus 5.2: Hauptspannungen, Richtungen, $tau_(max)$, $sigma_M$ rechnerisch und mit dem Mohrschen Kreis; Naht unter 30° aus dem Kreis.
+ *Übung 6, Aufg. 6.2:* $sigma_x = "77,5"$, $sigma_y = -"22,5"$, $tau_("xy") = -"37,5"$ N/mm²: Hauptspannungen, $tau_(max)$, $sigma_M$, beide Richtungen; dazu der Mohrsche Kreis. (Von dir als mögliche Klausuraufgabe markiert.)
+ *Übung 7, Aufg. 7.1:* Kernlochbohrer als dünnwandiges Rohr ($d_m = 100$ mm, $t = 2$ mm), $F_x = "12,57"$ kN Druck, $M_t = "0,943"$ kNm. a) $sigma_x$, b) $tau_("xy")$, c) Hauptspannungen und Richtungen, d) Mohr-Kontrolle, e) drei Vergleichsspannungen.
  #bild("tm2k2_ue71", [Übung TM2 Nr. 7, Aufg. 7.1: Bohrkrone mit $F_x$ und $M_t$.], height: 40mm)
+ *Übung 7, Aufg. 7.2:* Spannungszustand aus 6.2: Vergleichsspannungen nach allen drei Hypothesen; ist das zulässig, wenn der Werkstoff im Zugversuch $100 thin "N/mm"^2$ erträgt?
+ *WZF 04.05.26 („mögliche Klausuraufgabe“):* $sigma_x = -100$, $sigma_y = 100$, $tau_("xy") = -100$ N/mm²: Hauptspannungen, Richtungen, $tau_(max)$, $sigma_M$, Tensoren im gedrehten System und Mohrscher Kreis.
+ *Skript TM2 S. 310 (A01–A08):* Zeichne die Mohrschen Kreise für A03 ($sigma_x = 10$, $sigma_y = -20$, $tau_("xy") = 30$) und A08 ($-50$, $-20$, $-30$ N/mm²) und lies $sigma_1$, $sigma_2$, $phi^*$ ab.
+ *Buch:* Was ist ein hydrostatischer Spannungszustand, und wie sieht sein Mohrscher Kreis aus? (TM2-Buch S. 44 und 52)
+ *Buch:* Warum platzt ein dünnwandiger Kessel bevorzugt in Längsrichtung auf? (TM2-Buch S. 55–57)
]

#pagebreak()
== Lösungen TM2 Kapitel 2
#set enum(spacing: 0.65em)
+ 1. Index: Richtung der Flächennormale; 2. Index: Richtung der Spannung. #nachschlagen[Lernskript, #stelle(<a-tm2-2-1>)]
+ Momentengleichgewicht am kleinen Element um seinen Mittelpunkt (zugeordnete Schubspannungen). #nachschlagen[Lernskript, #stelle(<a-tm2-2-1>)]
+ Beim Gleichgewicht am Dreieck entstehen $cos^2 phi$, $sin^2 phi$ und $sin phi cos phi$; mit den Doppelwinkelformeln werden daraus Terme in $2 phi$. #nachschlagen[Lernskript, #stelle(<a-tm2-2-2>)]
+ $tau_(xi eta) = 0$; die Normalspannungen sind dort extremal ($sigma_1$, $sigma_2$). #nachschlagen[Lernskript, #stelle(<a-tm2-2-2-2>)]
+ Um 45° gedreht; dort wirkt $sigma_M = frac(1, 2)(sigma_x + sigma_y)$. #nachschlagen[Lernskript, #stelle(<a-tm2-2-2-2>)]
+ $P = (sigma_x, tau_("xy"))$ und $P' = (sigma_y, -tau_("xy"))$ verbinden; Schnitt mit der $sigma$-Achse = $sigma_M$, halbe Länge $P P'$ = $r$. #nachschlagen[Lernskript, #stelle(<a-tm2-2-2-3>)]
+ Der Zugversuch kennt nur einachsigen Zug; $sigma_V$ macht den ebenen Zustand vergleichbar. Spröde: Normalspannungshypothese; zäh: von Mises (oder Schubspannungshypothese als sichere Seite). #nachschlagen[Lernskript, #stelle(<a-tm2-2-3>)]
+ $sigma_(xi) = 30 + 30 cos 120° = 15$; $tau_(xi eta) = -30 sin 120° = -"26,0" thin "N/mm"^2$. #nachschlagen[Lernskript, #stelle(<a-tm2-2-2>)]
+ $sigma_(1,2) = plus.minus 40$ N/mm²; $tan 2 phi^* -> infinity$ → $phi^* = 45°$ (gehört zu $sigma_1$, Einsetzen: $sigma_(xi) = 40$); $tau_(max) = 40$ N/mm² bei $phi^(**) = 90°$ bzw. 0°. #nachschlagen[Lernskript, #stelle(<a-tm2-2-2-2>)]
+ $sigma_M = 50$, $r = sqrt(30^2 + 40^2) = 50$ → $sigma_1 = 100$, $sigma_2 = 0$; $sigma_V = sqrt(80^2 + 20^2 - 80 dot 20 + 3 dot 40^2) = 100 thin "N/mm"^2$. #nachschlagen[Lernskript, #stelle(<a-tm2-2-3>)]
+ a) $sigma_x = 10000\/100 = 100$, $sigma_y = tau_("xy") = 0$, $S = mat(100, 0; 0, 0)$ N/mm². c) $x$-Schnitt: $arrow(t) = (100; 0)$, $sigma = 100$, $tau = 0$; $y$-Schnitt: $arrow(t) = (0; 0)$; 45°: $arrow(t) = ("70,71"; 0)$, $sigma = 50$, $tau = 50$ (Betrag; mit Vorzeichen $tau_(xi eta) = -50$). #nachschlagen[Lernskript, #stelle(<a-tm2-2-2>)\; Kurzlösung Übung 5]
+ $sigma(phi) = sigma_x cos^2 phi = "37,5"$; $tau(phi) = -sigma_x sin phi cos phi = -"21,65" thin "N/mm"^2$. #nachschlagen[Lernskript, #stelle(<a-tm2-2-2>)\; Kurzlösung Übung 5]
+ $sigma_1 = 50$, $sigma_2 = 0$, $phi^* = 0°$ (und 90°); $tau_(max) = 25$, $sigma_M = 25$ N/mm², $phi^(**) = 45°$; Kreis mit Mittelpunkt 25, Radius 25; bei 30°: $sigma = "37,5"$, $tau = -"21,65"$ wie in 5.2. #nachschlagen[Lernskript, #stelle(<a-tm2-2-2-3>)\; Kurzlösung Übung 6]
+ $sigma_M = "27,5"$, $r = sqrt(50^2 + "37,5"^2) = "62,5"$ → $sigma_1 = 90$, $sigma_2 = -35$; $phi^* = -"18,43"°$ (gehört zu $sigma_1$); $tau_(max) = "62,5"$; $phi^(**) = "26,57"°$. #nachschlagen[Lernskript, #stelle(<a-tm2-2-2-2>)\; Kurzlösung Übung 6]
+ $A = pi d_m t = "628,3" thin "mm"^2$: $sigma_x = -12570\/"628,3" = -20$; $tau_("xy") = M_t\/(2 A_m t) = 943000\/(2 dot 7854 dot 2) = 30 thin "N/mm"^2$; $sigma_M = -10$, $r = "31,62"$ → $sigma_1 = "21,62"$, $sigma_2 = -"41,62"$, $phi^* = -"35,78"°$ (gehört zu $sigma_2$), $phi^(**) = "9,22"°$, $tau_(max) = "31,62"$; $sigma_V$: Normalsp. 21,62, Schubsp. 63,24, GEH 55,68 N/mm². #nachschlagen[Lernskript, #stelle(<a-tm2-2-3>)\; Kurzlösung Übung 7]
+ Normalsp. $sigma_V = 90$ (zulässig), Schubsp. $sigma_V = 125$ (nicht zulässig), GEH $sigma_V = "111,7"$ (nicht zulässig). #nachschlagen[Lernskript, #stelle(<a-tm2-2-3>)\; Kurzlösung Übung 7]
+ $sigma_(1,2) = plus.minus "141,4"$, $phi^* = "22,5"°$ gehört zu $sigma_2$; $tau_(max) = "141,4"$, $sigma_M = 0$, $phi^(**) = "67,5"°$; Tensoren siehe 2.2.2. #nachschlagen[Lernskript, #stelle(<a-tm2-2-2-2>)\; WZF 04.05.26]
+ A03: $sigma_M = -5$, $r = "33,5"$ → $sigma_1 = "28,5"$, $sigma_2 = -"38,5"$, $phi^* = "31,7"°$ (gehört zu $sigma_1$). A08: $sigma_M = -35$ → $sigma_1 = -"1,5"$, $sigma_2 = -"68,5"$, $phi^* = "31,7"°$ (gehört zu $sigma_2$). #nachschlagen[Lernskript, #stelle(<a-tm2-2-2-3>)\; Skript TM2 S. 317, 332]
+ $sigma_x = sigma_y$, $tau_("xy") = 0$: in jedem Schnitt gleiche Normalspannung, kein Schub; der Kreis schrumpft zu einem Punkt. #nachschlagen[Lernskript, #stelle(<a-tm2-2-2>)\; TM2-Buch S. 44]
+ Die Umfangsspannung $sigma_y = p r\/t$ ist doppelt so groß wie die Längsspannung; sie öffnet einen Riss entlang der Längsachse. #nachschlagen[Lernskript, #stelle(<a-tm2-2-3>)\; TM2-Buch S. 57]

#pagebreak()
= TM2 Kapitel 3 · Verzerrungszustand und Elastizitätsgesetz <k-tm2-3>
#tab(columns: 2,
 [Vorlesungen], [Skript-Teil 06 „Dehnungskreis“ (Sosnowsky, Skript TM2 S. 448–488; kein handschriftliches VL-Datum). WZF 18.05.26 (8. Übung: Spannung, Verzerrung, Stoffgesetz) → 3.1, 3.2 und DMS-Beispiel.],
 [Quellen], [Skript TM2 S. 448–488 (mehrdimensionale Dehnung, Verzerrungsgesetze, Elastizitätsgesetz, Dehnmessstreifen); FS TM2 S. 17–21; WZF 18.05.26 S. 1–6; Übung 8 (Kurzlösungen), Übung 9 Aufg. 9.3, Übung 5 Aufg. 5.1 b; TM2-Buch S. 65–75.],
 [Passende Übungen], [Übung 8: 8.1, 8.2, 8.3 · Übung 9: 9.3 · Übung 5: 5.1 b; dazu Altklausur-Aufgaben am Ende der vertiefenden Fragen],
)
In Kapitel 2 ging es um die Kräfte im Inneren (Spannungen). Kapitel 3 beschreibt, wie sich das Material dabei #strong[verformt]: Es wird länger oder kürzer (Dehnung $epsilon$) und ein rechter Winkel wird schief (Gleitung $gamma$). Das Elastizitätsgesetz verbindet beides mit den Spannungen. Das ist die Grundlage für die Messung mit Dehnmessstreifen: Man misst Dehnungen und rechnet daraus die Spannungen aus.
#note([Dein Feynman-Schritt: die 4 Kernideen von Kapitel 3. Erst ohne Skript aufzählen und erklären, dann vergleichen.], [+ #strong[Zwei Arten der Verformung:] Dehnung $epsilon$ (Längenänderung pro Länge) und Gleitung $gamma$ (Änderung eines rechten Winkels).
+ #strong[Gleiche Mathematik wie bei Spannungen:] Transformation, Hauptdehnungen und Mohrscher Kreis funktionieren genauso; statt $tau_("xy")$ steht $frac(1, 2) gamma_("xy")$.
+ #strong[Hookesches Gesetz mit Querkontraktion:] Zug in $x$ macht den Stab in $y$ und $z$ dünner: $epsilon_x = (sigma_x - nu sigma_y)\/E$. Schub: $gamma = tau\/G$ mit $G = E\/(2(1+nu))$.
+ #strong[Dehnmessstreifen (DMS):] Drei gemessene Dehnungen reichen, um $epsilon_x$, $epsilon_y$, $gamma_("xy")$ und daraus die Hauptspannungen zu bestimmen.
Zusammenfassung der Abschnitte 3.1–3.3; Quellen stehen dort.])

== TM2 3.1 Verschiebungsfeld und Verzerrungszustand <a-tm2-3-1>
Jeder Punkt eines Bauteils verschiebt sich unter Last um $arrow(u) = (u, v, w)$. Wie in Kapitel 1 ist die #strong[Dehnung] die Ableitung der Verschiebung, jetzt in jeder Richtung. Neu ist die #strong[Gleitung] $gamma$: Sie misst, um wie viel ein ursprünglich rechter Winkel kleiner wird (im Bogenmaß).
#form[$ epsilon_x = (partial u)/(partial x), quad epsilon_y = (partial v)/(partial y), quad epsilon_z = (partial w)/(partial z), wide gamma_("xy") = (partial u)/(partial y) + (partial v)/(partial x) = alpha + beta $]
FS TM2 S. 17, Gl. 3.3–3.4; Skript TM2 S. 458–461.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k3_verformung", [Skript TM2 S. 455: Rechteck $P Q R S$ wird zum schiefen Viereck $P' Q' R' S'$ (Verschiebung, Dehnung und Winkeländerung).], height: 60mm)],
 [#bild("tm2k3_reine", [Skript TM2 S. 456: reine Verzerrung, der rechte Winkel wird zu $90° - gamma$ (Anteile $alpha$ und $beta$).], height: 60mm)])
#note([In eigenen Worten], [Schiebst du einen Stapel Spielkarten oben seitlich weg, wird aus dem Rechteck ein Parallelogramm. Die Karten werden nicht länger, aber die Ecke ist nicht mehr rechtwinklig. Das ist reine Gleitung. #text(fill: muted)[(eigene Ergänzung)]])
#heading(level: 3, outlined: false)[Verzerrungstensor und Transformation]
Im ebenen Fall fasst man die Verformung im #strong[Verzerrungstensor] zusammen. Auf der Nebendiagonale steht die #strong[halbe] Gleitung:
#form[$ V = mat(delim: "(", epsilon_x, frac(1, 2) gamma_("xy"); frac(1, 2) gamma_("xy"), epsilon_y) $]
Alle Formeln aus Kapitel 2 gelten weiter, wenn du ersetzt: $sigma_x -> epsilon_x$, $sigma_y -> epsilon_y$, $tau_("xy") -> frac(1, 2) gamma_("xy")$ (FS TM2 S. 18, Gl. 3.7–3.13).
#form[$ epsilon_(xi) = frac(1, 2)(epsilon_x + epsilon_y) + frac(1, 2)(epsilon_x - epsilon_y) cos 2 phi + frac(1, 2) gamma_("xy") sin 2 phi wide frac(1, 2) gamma_(xi eta) = -frac(1, 2)(epsilon_x - epsilon_y) sin 2 phi + frac(1, 2) gamma_("xy") cos 2 phi $]
#form[$ tan 2 phi^* = (gamma_("xy"))/(epsilon_x - epsilon_y) wide epsilon_(1,2) = frac(1, 2)(epsilon_x + epsilon_y) plus.minus sqrt(((epsilon_x - epsilon_y)/2)^2 + (frac(1, 2) gamma_("xy"))^2) wide epsilon_x + epsilon_y = epsilon_(xi) + epsilon_(eta) $]
#note([Achtung: der Faktor ½], [Der häufigste Fehler in diesem Kapitel: $gamma_("xy")$ statt $frac(1, 2) gamma_("xy")$ in die Formeln aus Kapitel 2 einsetzen. Im Tensor, im Mohrschen Kreis und unter der Wurzel steht immer die #strong[halbe] Gleitung.], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- Dehnungen und Gleitung als Ableitungen der Verschiebungen; Verzerrungstensor mit den halben Gleitungen. #text(fill: muted)[\[TM2-Buch S. 65–68\]]
- Transformation, Hauptdehnungen und Mohrscher Verzerrungskreis wie beim Spannungszustand. #text(fill: muted)[\[TM2-Buch S. 68–69\]]])
#src[Skript TM2 S. 450–462; FS TM2 S. 17–18; TM2-Buch S. 65–69.]

== TM2 3.2 Elastizitätsgesetz <a-tm2-3-2>
Ziehst du einen Stab in $x$-Richtung, wird er nicht nur länger, sondern auch #strong[dünner]. Diese Querdehnung ist proportional zur Längsdehnung; der Faktor ist die #strong[Querkontraktionszahl] $nu$ (Stahl $nu approx "0,3"$). Für Schub gibt es den #strong[Schubmodul] $G$, der aus $E$ und $nu$ folgt.
#form[$ epsilon_x = 1/E (sigma_x - nu (sigma_y + sigma_z)) + alpha_T Delta T, quad epsilon_y = 1/E (sigma_y - nu (sigma_z + sigma_x)) + alpha_T Delta T, quad epsilon_z = 1/E (sigma_z - nu (sigma_x + sigma_y)) + alpha_T Delta T $]
#form[$ gamma_("xy") = tau_("xy")/G, quad gamma_("xz") = tau_("xz")/G, quad gamma_("yz") = tau_("yz")/G wide G = E/(2(1 + nu)) $]
FS TM2 S. 19–21, Gl. 3.14–3.35; Skript TM2 S. 463. Im ebenen Spannungszustand ($sigma_z = 0$) umgekehrt:
#form[$ sigma_x = E/(1 - nu^2)(epsilon_x + nu epsilon_y), quad sigma_y = E/(1 - nu^2)(epsilon_y + nu epsilon_x), quad tau_("xy") = G gamma_("xy") $]
#note([Merke], [Bei isotropem Werkstoff (in allen Richtungen gleich) fallen #strong[Hauptspannungsrichtungen und Hauptdehnungsrichtungen zusammen] (FS S. 20). Auch $epsilon_z != 0$, obwohl $sigma_z = 0$: Das Blech wird dünner oder dicker.])
#note([In eigenen Worten], [Ein Gummiband, das du in die Länge ziehst, wird schmaler. $nu$ sagt, wie stark. Bei $nu = "0,5"$ bliebe das Volumen gleich (Gummi), Stahl liegt bei 0,3. #text(fill: muted)[(eigene Ergänzung)]])
#heading(level: 3, outlined: false)[Beispiel aus der 8. Übung (WZF 18.05.26): Blech mit Zug und Schub]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k3_w185_1", [WZF 18.05.26 S. 1: Blech ($L = 1$ m, $B = 100$ mm, $t = 1$ mm) mit $F_x = "10,5"$ kN und Schubkräften $F_(t 1) = "8,08"$ kN, $F_(t 2) = "80,8"$ kN; gesucht $S$, $V$ und die Hauptdehnungen.], height: 95mm)],
 [#bild("tm2k3_w185_2", [WZF 18.05.26 S. 2: Spannungstensor und Dehnungen mit dem Hookeschen Gesetz.], height: 95mm)])
#note([Beispiel (WZF 18.05.26, Beispiel 1)], [+ Spannungen: $sigma_x = 10500\/100 = 105$, $sigma_y = 0$, $tau_("xy") = 8080\/100 = "80,8" thin "N/mm"^2$.
+ Dehnungen: $epsilon_x = 105\/("2,1" dot 10^5) = "0,5" dot 10^(-3)$, $epsilon_y = -"0,3" dot 105\/("2,1" dot 10^5) = -"0,15" dot 10^(-3)$.
+ Gleitung: $G = E\/(2(1+nu)) = "0,808" dot 10^5 thin "N/mm"^2$, $gamma_("xy") = "80,8"\/80800 = "1,0" dot 10^(-3)$ rad. Also $V = mat(delim: "(", "0,5", "0,5"; "0,5", -"0,15") dot 10^(-3)$.
+ Hauptdehnungen: $tan 2 phi^* = "1,0"\/"0,65"$ → $phi^* = "28,5"°$; $epsilon_1 = "0,77" dot 10^(-3)$, $epsilon_2 = -"0,42" dot 10^(-3)$. Kontrolle: $epsilon_1 + epsilon_2 = "0,35" dot 10^(-3) = epsilon_x + epsilon_y$ ✓.], fill: pale)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k3_w185_3", [WZF 18.05.26 S. 3: Gleitung, Verzerrungstensor, Skizze unverformt und verformt.], height: 55mm)
  #bild("tm2k3_w185_4", [WZF 18.05.26 S. 4: Hauptdehnungen mit Kontrolle über die Invariante.], height: 60mm)],
 [#bild("tm2k3_w185_5", [WZF 18.05.26 S. 5: Mohrscher Dehnungskreis (1 cm ≙ 0,1 · 10#super[−3]) und Vergleich Rechnung/Zeichnung.], height: 118mm)])
#note([Hinweise zur Mitschrift (WZF 18.05.26)], [- S. 1: Dort steht $G = F\/(2(1+nu))$. Gemeint ist $G = E\/(2(1+nu))$; der Zahlenwert $"0,808" dot 10^5$ stimmt.
- S. 5: Der Kreis ist als Ellipse gezeichnet. Das passiert, wenn $epsilon$- und $frac(1, 2) gamma$-Achse nicht denselben Maßstab haben. Mit gleichem Maßstab ist es ein Kreis; die abgelesenen Werte (28°, 0,78 und −0,42 · 10#super[−3]) passen trotzdem gut.
- S. 4–5: Dort steht $phi^* = "28,15"°$. Aus $tan 2 phi^* = "1,0"\/"0,65"$ folgt $phi^* = "28,5"°$. Die Ergebnisse $epsilon_1 = "0,77"$ und $epsilon_2 = -"0,42"$ (mal $10^(-3)$) stimmen.], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- Querkontraktion und Querkontraktionszahl $nu$, Schubmodul $G$, Zusammenhang $G = E\/(2(1+nu))$. #text(fill: muted)[\[TM2-Buch S. 70–71\]]
- Verallgemeinertes Hookesches Gesetz mit Wärmedehnung; Hauptrichtungen von Spannungs- und Verzerrungstensor fallen bei isotropem Werkstoff zusammen. #text(fill: muted)[\[TM2-Buch S. 71–72\]]])
#src[Skript TM2 S. 462–463; FS TM2 S. 19–21; WZF 18.05.26 S. 1–5; TM2-Buch S. 70–72.]

== TM2 3.3 Anwendung: Dehnmessstreifen (DMS) <a-tm2-3-3>
Spannungen kann man nicht direkt messen, Dehnungen schon. Ein DMS ist ein dünner Draht auf einer Folie, der auf das Bauteil geklebt wird; dehnt sich das Bauteil, ändert sich sein elektrischer Widerstand. Ein DMS misst nur die Dehnung #strong[in seiner Richtung]. Mit drei DMS in verschiedenen Richtungen (#strong[Rosette]) erhält man drei Gleichungen für die drei Unbekannten $epsilon_x$, $epsilon_y$, $gamma_("xy")$. Die Erklärung zur Messtechnik ist eine #text(fill: muted)[(eigene Ergänzung)].
#heading(level: 3, outlined: false)[Vorgehen]
+ Für jeden DMS die Transformationsgleichung für $epsilon_(xi)$ mit seinem Winkel aufschreiben.
+ Das Gleichungssystem nach $epsilon_x$, $epsilon_y$, $gamma_("xy")$ auflösen.
+ Hauptdehnungen $epsilon_(1,2)$ und Richtung $phi^*$ berechnen.
+ Mit dem Elastizitätsgesetz (ebener Spannungszustand) die Hauptspannungen $sigma_(1,2)$ berechnen.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k3_dms_aufgabe", [Skript TM2 S. 466: Aufgabe, gemessen $epsilon_a = 12$, $epsilon_b = 2$, $epsilon_c = -2$ (je $10^(-4)$); $E = "2,1" dot 10^5 thin "N/mm"^2$, $nu = "0,3"$.], height: 48mm)],
 [#bild("tm2k3_dms_anordnung", [Skript TM2 S. 467: DMS b in $x$-Richtung, a unter −45°, c unter +45°.], height: 60mm)])
#bild("tm2k3_dms_winkel", [Skript TM2 S. 470: Winkel eingesetzt, $epsilon_a = frac(1, 2)(epsilon_x + epsilon_y) - frac(1, 2) gamma_("xy")$ und $epsilon_c = frac(1, 2)(epsilon_x + epsilon_y) + frac(1, 2) gamma_("xy")$.], height: 48mm)
#note([Beispiel (Skript TM2 S. 466–480)], [+ $epsilon_x = epsilon_b = 2 dot 10^(-4)$; Addition: $epsilon_a + epsilon_c = epsilon_x + epsilon_y$ → $epsilon_y = 12 - 2 - 2 = 8 dot 10^(-4)$; Subtraktion: $gamma_("xy") = epsilon_c - epsilon_a = -14 dot 10^(-4)$.
+ $epsilon_(1,2) = 5 plus.minus sqrt(9 + 49) = 5 plus.minus "7,62"$ → $epsilon_1 = "12,6" dot 10^(-4)$, $epsilon_2 = -"2,6" dot 10^(-4)$.
+ $tan 2 phi^* = -14\/(-6) = "2,33"$ → $2 phi^* = "66,8"°$, $phi^* = "33,4"°$.
+ $sigma_1 = E\/(1 - nu^2)(epsilon_1 + nu epsilon_2) = 273 thin "N/mm"^2$, $sigma_2 = E\/(1 - nu^2)(epsilon_2 + nu epsilon_1) = 27 thin "N/mm"^2$.
+ $tau_(max) = frac(1, 2)(sigma_1 - sigma_2) = 123 thin "N/mm"^2$.], fill: pale)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k3_dms_sigma", [Skript TM2 S. 476: Spannungen aus den Hauptdehnungen (mit Vorzeichenfehler in der Formel, siehe Kasten).], height: 45mm)],
 [#bild("tm2k3_dms_richtung", [Skript TM2 S. 480: Hauptspannungsrichtungen in der Rosette.], height: 55mm)])
#note([Fehler auf den Folien (Skript TM2 S. 475–477)], [- S. 475: $phi^* = arctan(gamma_("xy")\/(epsilon_x - epsilon_y))$. Richtig ist $tan 2 phi^* = gamma_("xy")\/(epsilon_x - epsilon_y)$ (FS 3.11), also $phi^* = frac(1, 2) arctan("2,33") = "33,4"°$. Das Ergebnis auf der Folie stimmt, nur die Formel nicht.
- S. 476: Dort steht $sigma_1 = E\/(1 - nu^2)(epsilon_1 #strong[−] nu epsilon_2)$. Richtig ist $+ nu epsilon_2$ (FS 3.23). Die Zahlen 273 und 27 N/mm² wurden mit $+$ gerechnet und stimmen.
- S. 477: $tau_(max) = plus.minus 150 thin "N/mm"^2$ ist falsch. Mit $sigma_1 = 273$ und $sigma_2 = +27$ ist $tau_(max) = frac(1, 2)(273 - 27) = 123 thin "N/mm"^2$. Die 150 entstehen, wenn man $sigma_2 = -27$ einsetzt.], fill: sand)
#heading(level: 3, outlined: false)[Beispiel 2 aus der 8. Übung (WZF 18.05.26): 45°-Rosette]
#bild("tm2k3_w185_6", [WZF 18.05.26 S. 6: DMS-Rosette a (0°), b (45°), c (90°), oben rot „pot. Klausuraufgabe“.], height: 110mm)
#note([Von dir markiert (rot, WZF 18.05.26 S. 6)], [„pot. Klausuraufgabe“ steht neben der DMS-Rosette. Übe deshalb den Weg von drei Messwerten bis zu den Hauptspannungen, auch mit der 0°/45°/90°-Anordnung aus Übung 8.3.], fill: sand)
#note([Hinweis zur Mitschrift (WZF 18.05.26 S. 6)], [In der Mitschrift steht $epsilon_b = "0,1675"$ ‰. Damit käme $gamma_("xy") = 2 dot "0,1675" - "0,35" = -"0,015"$ ‰ heraus, nicht $"1,0" dot 10^(-3)$. Zum Ergebnis $gamma_("xy") = "1,0" dot 10^(-3)$ (und zu Beispiel 1) passt nur $epsilon_b = "0,675"$ ‰. Wahrscheinlich ein Schreibfehler; im Beispiel unten steht der passende Wert.], fill: sand)
#note([Beispiel (WZF 18.05.26, Beispiel 2)], [Gemessen $epsilon_a = "0,5"$ ‰ (0°), $epsilon_b = "0,675"$ ‰ (45°), $epsilon_c = -"0,15"$ ‰ (90°).
+ $epsilon_x = epsilon_a$, $epsilon_y = epsilon_c$.
+ Für $phi = 45°$: $epsilon_b = frac(1, 2)(epsilon_a + epsilon_c) + frac(1, 2) gamma_("xy")$ → $gamma_("xy") = 2 epsilon_b - (epsilon_a + epsilon_c) = "1,0" dot 10^(-3)$.
+ Damit $V = mat(delim: "(", "0,5", "0,5"; "0,5", -"0,15") dot 10^(-3)$, derselbe Zustand wie in Beispiel 1.], fill: pale)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [Beispiel 3.1: DMS-Rosette auf einem Stahlblech, Hauptdehnungen, Hauptspannungen und Hauptrichtungen. #text(fill: muted)[\[TM2-Buch S. 73–75\]]])
#src[Skript TM2 S. 464–480; WZF 18.05.26 S. 6; Übung 8 Aufg. 8.3; TM2-Buch S. 73–75.]

#bild("map-t2k3", [Mindmap zu TM2 Kapitel 3 (eigene Darstellung nach Skript TM2 S. 448–488 und FS TM2 S. 17–21).], height: 70mm)
*Der Zusammenhang in TM2 Kapitel 3.* Kapitel 1 kannte nur eine Dehnung in Stabrichtung. Jetzt verformt sich ein Flächenelement in zwei Richtungen und wird zusätzlich schief (3.1). Mathematisch ist das ein Spiegelbild von Kapitel 2: gleiche Transformation, gleiche Hauptachsen, gleicher Kreis, nur mit $frac(1, 2) gamma$ statt $tau$. Das Elastizitätsgesetz mit $E$, $nu$ und $G$ verbindet die beiden Welten (3.2). Weil man Dehnungen messen kann, schließt der DMS den Kreis: Messen, umrechnen, Hauptspannungen bestimmen und mit einer Festigkeitshypothese aus Kapitel 2.3 bewerten (3.3).

#pagebreak()
== Verständnisfragen und Rechenaufgaben · TM2 Kapitel 3
#set enum(spacing: 0.85em)
Erkläre erst selbst. Bei Rechenaufgaben: Faktor ½ bei $gamma$ beachten, mit der Invariante kontrollieren. Die Lösungen folgen getrennt.

+ Was ist der Unterschied zwischen Dehnung und Gleitung?
+ Warum steht im Verzerrungstensor $frac(1, 2) gamma_("xy")$ und nicht $gamma_("xy")$?
+ Was beschreibt die Querkontraktionszahl $nu$?
+ Wie hängen $E$, $G$ und $nu$ zusammen?
+ Warum ist im ebenen Spannungszustand $epsilon_z != 0$?
+ Warum braucht eine DMS-Rosette drei Streifen?
+ Stahlblech ($E = "2,1" dot 10^5 thin "N/mm"^2$, $nu = "0,3"$) mit $sigma_x = 100$, $sigma_y = 50 thin "N/mm"^2$, $tau_("xy") = 0$. Berechne $epsilon_x$, $epsilon_y$, $epsilon_z$. #text(fill: muted)[(eigene Aufgabe)]
+ Berechne $G$ für Aluminium mit $E = 70000 thin "N/mm"^2$ und $nu = "0,33"$. #text(fill: muted)[(eigene Aufgabe)]

#heading(level: 3, outlined: false)[Vertiefende Verständnisfragen und Rechenaufgaben]
#block[
#set enum(start: 9)
+ *Übung 5, Aufg. 5.1 b:* Blechstreifen ($t = 1$ mm, $b = 100$ mm, $l = 1$ m) unter $F = 10$ kN: Änderung von Länge, Breite und Dicke ($E = "2,1" dot 10^5 thin "N/mm"^2$, $nu = "0,3"$).
+ *Übung 8, Aufg. 8.1:* Derselbe Streifen: a) $epsilon_x$, $epsilon_y$, $epsilon_z$, Gleitungen und Tensor $V$; b) Längen-, Breiten-, Dickenänderung; c) $epsilon_(xi)$ und $gamma_(xi eta)$ für $xi$ in $x$-Richtung, in $y$-Richtung und 45° nach unten geneigt.
  #bild("tm2k3_ue81", [Übung TM2 Nr. 8, Aufg. 8.1: Blechstreifen, gestrichelt die 45°-Richtung.], height: 30mm)
+ *Übung 8, Aufg. 8.2:* Spannungszustand aus 6.2 ($sigma_x = "77,5"$, $sigma_y = -"22,5"$, $tau_("xy") = -"37,5" thin "N/mm"^2$): Dehnungen und Gleitungen, Hauptdehnungen, Winkel, Mohrscher Verzerrungskreis; Vergleich mit der Hauptspannungsrichtung.
+ *Übung 8, Aufg. 8.3:* DMS-Rosette a (0°), b (45°), c (90°) misst $epsilon_a = -"0,048"$ %, $epsilon_b = "0,133"$ %, $epsilon_c = "0,120"$ %. Hauptdehnungen und Hauptspannungen mit Richtung.
  #bild("tm2k3_ue83", [Übung TM2 Nr. 8, Aufg. 8.3: Rosette mit a, b, c.], height: 35mm)
+ *Übung 9, Aufg. 9.3:* Stahlquader ($h = 60$ mm, $40 times 40$ mm) passt genau in einen Hohlraum mit starren, reibungsfreien Wänden; Erwärmung um 100 °C. Wie groß muss $F$ auf der Deckfläche sein, damit sich der Quader in $z$-Richtung nicht ausdehnt? ($alpha_T = "1,2" dot 10^(-5)$ 1/°C)
  #bild("tm2k3_ue93", [Übung TM2 Nr. 9, Aufg. 9.3: Quader im Hohlraum (a) und Spannungen am Element (b).], height: 32mm)
+ *Skript TM2 S. 466:* Rechne das DMS-Beispiel ($epsilon_a = 12$, $epsilon_b = 2$, $epsilon_c = -2$ · $10^(-4)$) selbst durch und prüfe $tau_(max)$.
+ *Buch:* Welchen Wertebereich hat $nu$, und was bedeutet $nu = "0,5"$? (TM2-Buch S. 70–71)
+ *Altklausur SS 2018 (TM_Prüfung_2018.pdf S. 11):* Gemessen: $epsilon_x = -"0,10"$ ‰, $epsilon_y = "0,30"$ ‰, $gamma_(x y) = -"0,80"$ ‰. Bestimme die Hauptdehnungen und ihre Richtungen.
+ *Altklausur SS 2018 (TM_Prüfung_2018.pdf S. 11):* Hauptspannungen $sigma_1 = 70 thin "N/mm"^2$, $sigma_2 = -30 thin "N/mm"^2$ (ebener Spannungszustand), $E = "2,1" dot 10^5 thin "N/mm"^2$, $nu = "0,3"$. Berechne $epsilon_1$, $epsilon_2$, $epsilon_3$. Warum ist $epsilon_3 eq.not 0$?
+ *Altklausur mit Musterlösung (PrüfungenTM2.pdf S. 11):* DMS-Messung: $epsilon_x = -"0,25"$ ‰, $epsilon_y = "0,075"$ ‰, $gamma_(x y) = -1$ ‰. Hauptdehnungen und Hauptrichtung?
+ *Altklausur SS 2016, Musterlösung (PrüfungenTM2.pdf S. 13):* a) $epsilon_x = -"0,15"$ ‰, $epsilon_y = "0,35"$ ‰, $gamma_(x y) = -"0,9"$ ‰: Hauptdehnungen und Richtung. b) Mit $epsilon_1 = "0,6"$ ‰, $epsilon_2 = -"0,4"$ ‰, $E = "2,1" dot 10^5 thin "N/mm"^2$, $nu = "0,3"$: Hauptspannungen und $epsilon_3$.
]

#pagebreak()
== Lösungen TM2 Kapitel 3
#set enum(spacing: 0.65em)
+ Dehnung: relative Längenänderung in einer Richtung; Gleitung: Abnahme eines ursprünglich rechten Winkels (rad). #nachschlagen[Lernskript, #stelle(<a-tm2-3-1>)]
+ Damit der Tensor sich genau wie der Spannungstensor transformiert; dann gelten alle Formeln aus Kapitel 2 mit $tau -> frac(1, 2) gamma$. #nachschlagen[Lernskript, #stelle(<a-tm2-3-1>)]
+ Das Verhältnis von Querdehnung zu Längsdehnung bei einachsigem Zug: $epsilon_y = -nu epsilon_x$. #nachschlagen[Lernskript, #stelle(<a-tm2-3-2>)]
+ $G = E\/(2(1 + nu))$. #nachschlagen[Lernskript, #stelle(<a-tm2-3-2>)]
+ Wegen der Querkontraktion: $epsilon_z = -nu(sigma_x + sigma_y)\/E$. #nachschlagen[Lernskript, #stelle(<a-tm2-3-2>)]
+ Es gibt drei Unbekannte ($epsilon_x$, $epsilon_y$, $gamma_("xy")$), jeder DMS liefert eine Gleichung. #nachschlagen[Lernskript, #stelle(<a-tm2-3-3>)]
+ $epsilon_x = (100 - 15)\/210000 = "0,405" dot 10^(-3)$, $epsilon_y = (50 - 30)\/210000 = "0,095" dot 10^(-3)$, $epsilon_z = -"0,3" dot 150\/210000 = -"0,214" dot 10^(-3)$. #nachschlagen[Lernskript, #stelle(<a-tm2-3-2>)]
+ $G = 70000\/(2 dot "1,33") = 26316 thin "N/mm"^2$. #nachschlagen[Lernskript, #stelle(<a-tm2-3-2>)]
+ $sigma_x = 100 thin "N/mm"^2$: $Delta l = "0,476"$ mm, $Delta b = -"0,0143"$ mm, $Delta t = -"0,000143"$ mm. #nachschlagen[Lernskript, #stelle(<a-tm2-3-2>)\; Kurzlösung Übung 5]
+ a) $epsilon_x = "0,476" dot 10^(-3)$, $epsilon_y = epsilon_z = -"0,143" dot 10^(-3)$, alle $gamma = 0$. b) wie 5.1 b. c) $x$: $epsilon_(xi) = "0,476" dot 10^(-3)$, $gamma_(xi eta) = 0$; $y$: $-"0,143" dot 10^(-3)$, 0; 45°: $epsilon_(xi) = "0,1665" dot 10^(-3)$, $gamma_(xi eta) = "0,619" dot 10^(-3)$ rad. #nachschlagen[Lernskript, #stelle(<a-tm2-3-1>)\; Kurzlösung Übung 8]
+ $epsilon_x = "0,401" dot 10^(-3)$, $epsilon_y = -"0,218" dot 10^(-3)$, $epsilon_z = -"0,079" dot 10^(-3)$, $gamma_("xy") = -"0,464" dot 10^(-3)$; $epsilon_1 = "0,478" dot 10^(-3)$ bei $-"18,43"°$, $epsilon_2 = -"0,295" dot 10^(-3)$ bei $"71,57"°$; gleiche Richtung wie die Hauptspannungen aus 6.2. #nachschlagen[Lernskript, #stelle(<a-tm2-3-2>)\; Kurzlösung Übung 8]
+ $epsilon_x = -"0,48"$, $epsilon_y = "1,20"$, $gamma_("xy") = 2 epsilon_b - epsilon_a - epsilon_c = "1,94"$ (je $10^(-3)$); $epsilon_1 = "1,643" dot 10^(-3)$, $sigma_1 = "315,3" thin "N/mm"^2$ (65,45°); $epsilon_2 = -"0,923" dot 10^(-3)$, $sigma_2 = -"99,2" thin "N/mm"^2$ (−24,55°). #nachschlagen[Lernskript, #stelle(<a-tm2-3-3>)\; Kurzlösung Übung 8]
+ Wände: $epsilon_x = epsilon_y = 0$, gesucht $epsilon_z = 0$; mit $sigma_x = sigma_y$ und $E alpha_T Delta T = 252 thin "N/mm"^2$: $sigma_x (1 - nu) - nu sigma_z = -252$ und $sigma_z - 2 nu sigma_x = -252$ → $sigma_z = -630 thin "N/mm"^2$, $F = 630 dot 1600 = 1008 thin "kN"$. #nachschlagen[Lernskript, #stelle(<a-tm2-3-2>)\; Kurzlösung Übung 9]
+ $epsilon_y = 8$, $gamma_("xy") = -14$ (je $10^(-4)$); $epsilon_1 = "12,6"$, $epsilon_2 = -"2,6"$; $phi^* = "33,4"°$; $sigma_1 = 273$, $sigma_2 = 27$, $tau_(max) = 123 thin "N/mm"^2$ (nicht 150). #nachschlagen[Lernskript, #stelle(<a-tm2-3-3>)\; Skript TM2 S. 466–477]
+ $0 <= nu <= "0,5"$; bei $nu = "0,5"$ ändert sich das Volumen nicht (inkompressibel). #nachschlagen[Lernskript, #stelle(<a-tm2-3-2>)\; TM2-Buch S. 70–71]
+ $epsilon_(1,2) = frac(epsilon_x + epsilon_y, 2) plus.minus sqrt((frac(epsilon_x - epsilon_y, 2))^2 + (frac(gamma, 2))^2) = "0,1" plus.minus "0,447"$, also $epsilon_1 = "0,547"$ ‰, $epsilon_2 = -"0,347"$ ‰. $tan 2 phi^* = gamma\/(epsilon_x - epsilon_y) = 2$, $phi^* = "31,7"°$. Einsetzen zeigt: bei $"31,7"°$ liegt $epsilon_2$, $epsilon_1$ liegt bei $"121,7"°$. #nachschlagen[Lernskript, #stelle(<a-tm2-3-1>)\; Altklausur SS 2018 (TM_Prüfung_2018.pdf S. 11), eigene Lösung]
+ $epsilon_1 = (sigma_1 - nu sigma_2)\/E = "0,376"$ ‰, $epsilon_2 = (sigma_2 - nu sigma_1)\/E = -"0,243"$ ‰, $epsilon_3 = -nu (sigma_1 + sigma_2)\/E = -"0,057"$ ‰. Wegen der Querkontraktion wird das Blech dünner, obwohl $sigma_3 = 0$ ist. #nachschlagen[Lernskript, #stelle(<a-tm2-3-2>)\; Altklausur SS 2018 (TM_Prüfung_2018.pdf S. 11), eigene Lösung]
+ $epsilon_1 approx "0,44"$ ‰, $epsilon_2 approx -"0,61"$ ‰. $tan 2 phi^* = "3,08"$, $phi^* approx 36°$; dort liegt $epsilon_2$, $epsilon_1$ bei $-54°$. #nachschlagen[Lernskript, #stelle(<a-tm2-3-1>)\; Altklausur mit Musterlösung (PrüfungenTM2.pdf S. 11)]
+ a) $epsilon_1 = "0,615"$ ‰, $epsilon_2 = -"0,415"$ ‰, $phi^* = "30,5"°$ (Richtung von $epsilon_2$). b) $sigma_1 = frac(E, 1 - nu^2) (epsilon_1 + nu epsilon_2) = "110,8" thin "N/mm"^2$, $sigma_2 = frac(E, 1 - nu^2) (epsilon_2 + nu epsilon_1) = -"50,8" thin "N/mm"^2$, $epsilon_3 = -frac(nu, 1 - nu) (epsilon_1 + epsilon_2) = -"0,086"$ ‰. #nachschlagen[Lernskript, #stelle(<a-tm2-3-1>), #stelle(<a-tm2-3-2>)\; Altklausur SS 2016, Musterlösung (PrüfungenTM2.pdf S. 13)]

#pagebreak()
= TM2 Kapitel 4 · Balkenbiegung <k-tm2-4>
#tab(columns: 2,
 [Vorlesungen], [Vorlesungsfolien Sosnowsky (TM2 SS 26, ohne handschriftliches Datum) → Abschnitte 4.1–4.4; WZF 01.06.26 (9. Übung „Biegespannungen“) → 4.2; WZF 08.06.26 (10. Übung „FTM, Steiner, KS-Drehung, Hauptachsen“) → 4.3; WZF 15.06.26 (11. Übung „Biegelinie“) → 4.4],
 [Quellen], [Skript TM2 S. 386–442 (Biegung, Einfeldbalken, Mehrfeldbalken, Föppl, Biegelinientafel), S. 493–599 (Flächenträgheitsmomente II. Ordnung, weitere Aufgaben, Vertiefungsteil 8/9); FS TM2 S. 22–36 (Kap. 4) und S. 46–49 (Tabelle 4.3 Biegelinien); WZF-Mitschriften 01.06.26, 08.06.26, 15.06.26; TM2-Buch S. 83–134],
 [Passende Übungen], [Übung 9: 9.1, 9.2 (9.3 gehört zu Kap. 3); Übung 10: 10.1–10.4 (Aufgaben im PDF „WZF TM2 8.6.26“); Übung 11: 11.1–11.4; Skript-Vertiefungsteil 9 (= Übung 9) und „Weitere Aufgaben FTM“ (Skript TM2 S. 572–585); dazu Altklausur-Aufgaben am Ende der vertiefenden Fragen],
)
Balkenbiegung heißt: #strong[Ein Biegemoment $M$ erzeugt im Querschnitt linear verteilte Normalspannungen $sigma = frac(M, I) thin z$ und verbiegt die Balkenachse zur Biegelinie $w(x)$ mit $E I thin w'' = -M$.] Alles andere in diesem Kapitel sind Werkzeuge, um $I$ (Flächenträgheitsmoment) und $w(x)$ auszurechnen.
#note([Dein Feynman-Schritt: die 5 Kernideen von Kapitel 4. Erst ohne Skript aufzählen und erklären, dann vergleichen.], [+ #strong[Bernoulli:] Querschnitte bleiben eben (und senkrecht zur Balkenachse) → Dehnung und Spannung sind linear in $z$.
+ #strong[Spannung:] $sigma = frac(M, I) z$, Maximum am Rand: $sigma_(max) = M/W$. Die Nulllinie geht durch den Schwerpunkt.
+ #strong[Flächenträgheitsmoment:] $I_y = integral z^2 thin d A$ misst, wie weit die Fläche von der Achse weg liegt. Fläche weit außen = steif („wo viel Spannung, da viel Material“).
+ #strong[Steiner + Tabelle:] Querschnitt zerlegen, Eigenanteil + $overline(z)_s^2 A$ addieren, Aussparungen abziehen; bei Unsymmetrie Hauptachsen bestimmen.
+ #strong[Biegelinie:] $E I w'' = -M$ bzw. $E I w^("IV") = q$ integrieren; die Integrationskonstanten kommen #strong[nur] aus Rand- und Übergangsbedingungen (in der Klausur ist das Aufstellen der Bedingungen das Wichtigste).
Zusammenfassung der Abschnitte 4.1–4.4; Quellen stehen dort.])
#note([Hinweis zum Umfang], [Die FS TM2 enthält auch 4.5 „Schiefe Biegung“ und 4.6 „Schubeinfluss bei Biegung“ (FS S. 31–36). In den Vorlesungsfolien und in den Übungen 9–11 kamen davon nur die Hauptachsen (→ 4.3) und die mittlere Schubspannung $overline( tau ) = Q/A$ (→ 4.2) vor. Deshalb gibt es hier keine eigenen Abschnitte 4.5/4.6.])
== TM2 4.1 Einführung: Was ist Biegung? <a-tm2-4-1>
Ein #strong[Balken] ist ein stabförmiges Bauteil: lang im Vergleich zum Querschnitt, aber – anders als ein Zugstab – #strong[quer] zu seiner Achse belastet. Biegung entsteht durch ein #strong[Schnittmoment $M_B$] (Biegemoment) um die „schwachen“ Achsen $y$ oder $z$ des Querschnitts. Ursachen (Skript TM2 S. 387):
- eine #strong[Querkraft mit Hebelarm]: Eine Kraft $F$ wirkt im Abstand von der Schnittstelle → Moment;
- ein #strong[äußeres Moment] $M_0$. Merke: Ein Moment wirkt unabhängig davon, wo es angreift.
Bei #strong[reiner Biegung] (nur $M$, keine Querkraft) entsteht ein #strong[linearer] Spannungsverlauf über die Höhe $z$: oben Druck, unten Zug (oder umgekehrt). Genau im Schwerpunkt ist die Spannung null – das ist der Ursprung des lokalen Koordinatensystems (Skript TM2 S. 388).
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k4_biegung_m0", [Skript TM2 S. 386: Moment $M_0$ am Kragarm → im Schnitt lineare Spannung von $sigma_(D max)$ (Druck) bis $sigma_(Z max)$ (Zug).], height: 50mm)],
 [#bild("tm2k4_ursache", [Skript TM2 S. 387: Biegung durch Einzelkraft $F$ und äußeres Moment $M_0$ am Einfeldträger.], height: 50mm)])
#note([In eigenen Worten], [Biege ein dickes Radiergummi: Die Oberseite wird gestaucht (Druck), die Unterseite gedehnt (Zug), und irgendwo in der Mitte gibt es eine Linie, die ihre Länge behält – die #strong[neutrale Faser]. Je weiter eine Faser von dieser Linie weg ist, desto stärker wird sie gedehnt. #text(fill: muted)[(eigene Ergänzung)]])
#note([Begriffe (FS S. 22, Buch S. 83–84)], [#strong[Balken]: stabförmig, Querschnitt konstant oder leicht veränderlich, Querschnittsmaße ≪ Länge. #strong[Biegemoment $M$] → reine Normalspannung $sigma$, Dehnung $epsilon$ → Krümmung, kein Schub. #strong[Querkraft $Q$] → Schubspannung $tau$, Gleitung $gamma$ → Schubverformung. #strong[Gerade (einachsige) Biegung:] $y,z$ sind Hauptachsen ($I_("yz")=0$), Last nur in $z$-Richtung.])
#heading(level: 3, outlined: false)[Herleitung in drei Bausteinen (Folien S. 390–395)]
Wie bei statisch unbestimmten Systemen braucht man drei Gleichungsgruppen. Der Dozent hat sie handschriftlich hergeleitet:
#tab(columns: 3,
 th([Baustein], [Gleichungen], [Bedeutung]),
 [1) Gleichgewicht], [$frac(d Q, d x) = -q, quad frac(d M, d x) = Q$; $med N= integral sigma thin d A, med Q= integral tau thin d A, med M= integral z thin sigma thin d A$], [Schnittgrößen am Balkenelement $d x$ = Resultierende der Spannungen],
 [2) Kinematik], [$epsilon = frac(partial u, partial x), quad gamma = frac(partial w, partial x) + frac(partial u, partial z)$], [Dehnung und Gleitung eines Elements $d x times d z$],
 [3) Werkstoffgesetz], [$sigma = E epsilon, quad tau = G gamma$], [Hooke; Querkontraktion vernachlässigt, weil $sigma_x >> sigma_y, sigma_z$],
)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k4_gg_element", [Skript TM2 S. 390: Gleichgewicht am Balkenelement – Schnittgrößen $N, Q, M$ und Spannungen am Flächenelement $d A$.], height: 75mm)],
 [#bild("tm2k4_kinematik", [Skript TM2 S. 391: Gleichgewichts­beziehungen, Kinematik ($epsilon$, $gamma$) und Werkstoffgesetz.], height: 75mm)])
Diese Gleichungen reichen allein nicht aus. Es braucht #strong[zwei zusätzliche Annahmen] (Skript TM2 S. 392):
+ #strong[a)] Die Absenkung $w$ ist unabhängig von $z$: $w = w(x)$ – der Balken wird nicht dicker oder dünner.
+ #strong[b) Bernoulli:] Querschnitte bleiben #strong[eben]\; sie drehen sich nur um den Winkel $psi (x)$: $u(x,z) = psi (x) dot z$.
#bild("tm2k4_bernoulli", [Skript TM2 S. 392: Konsequenzen für die Balkenbiegung – unverformte und verformte Struktur, Drehung $psi$, Verschiebung $u = z dot psi$, Absenkung $w$.], height: 70mm)
Setzt man das ein (Skript TM2 S. 393):
#form[$ sigma = E frac(partial u, partial x) = E thin psi ' thin z, wide tau = G(w' + psi ) $


$ N = E psi ' integral z thin d A = E psi ' S_y = 0 med => med y "-Achse geht durch den Schwerpunkt", wide M = E psi ' integral z^2 thin d A = E I_y thin psi ' $]
Weil $N=0$ sein soll, muss das statische Moment $S_y$ verschwinden – deshalb liegt der Ursprung im Schwerpunkt. Aus $M = E I psi '$ folgt mit $sigma = E psi ' z$ sofort $sigma = frac(M, I) z$ (Abschnitt 4.2).
#bild("tm2k4_herleitung", [Skript TM2 S. 393: Zusammenführen von Annahmen, Kinematik und Werkstoffgesetz; unten die „Nebenbemerkung“ zu den Steifigkeiten (siehe Fehlerkasten).], height: 80mm)
#note([Fehler auf der Folie (Skript TM2 S. 393, Nebenbemerkung)], [Dort steht „$E A_s$ Schubsteifigkeit“ und „$G I$ Biegesteifigkeit“. Richtig ist: #strong[$E I$ = Biegesteifigkeit] (FS S. 28, Gl. 4.34; TM2-Buch S. 104) und #strong[$G A_s$ bzw. $kappa G A$ = Schubsteifigkeit] (so steht es auch auf derselben Folie in $Q = kappa G A_s (w'+ psi )$ und im FS S. 36: $A_S = kappa A$). Also: Biegung ↔ $E$, Schub ↔ $G$. Richtig sind $E A$ = Dehnsteifigkeit und $G I_T$ = Torsionssteifigkeit.], fill: sand)
#note([Merke – schubstarrer Balken], [Ist die Schubsteifigkeit sehr groß ($kappa G A_s -> infinity$), dann gilt $w' + psi = 0$, also $psi = -w'$. Querschnitte stehen dann auch nach der Verformung senkrecht auf der Balkenachse. Das ist die zweite Bernoulli-Annahme und die Grundlage der Biegelinie in 4.4 (Skript TM2 S. 395; Buch S. 109).])
#heading(level: 3, outlined: false)[Überlagerung von Spannungen]
Treten mehrere Beanspruchungen gleichzeitig auf, werden #strong[gleichgerichtete Spannungen addiert]: Zug/Druck (konstantes $sigma$) + Biegung (lineares $sigma$) ergeben ein verschobenes lineares $sigma$; Schub (aus $Q$) und Torsion (aus $M_T$) liefern Schubspannungen $tau$ (Skript TM2 S. 394).
#bild("tm2k4_ueberlagerung", [Skript TM2 S. 394: Überlagerung von Spannungen aus Zug, Biegung, Schub und Torsion – „Addition gleichgerichteter Spannungen“.], height: 45mm)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Reine Biegung:] Zwischen zwei gleich großen Kräften $F$ eines Vierpunkt-Biegeversuchs ist der Träger rein auf Biegung beansprucht (nur $M$, $Q=0$). #text(fill: muted)[\[TM2-Buch S. 84\]]
- #strong[Koordinaten:] $x$ entlang der Balkenachse durch alle Schwerpunkte, $z$ nach unten, $y$ bildet ein Rechtssystem. #text(fill: muted)[\[TM2-Buch S. 83\]]
- #strong[Annahmen a) und b)] (w unabhängig von z, ebene Querschnitte) sind für schlanke Balken sehr genau; für reine Biegung sogar exakt. #text(fill: muted)[\[TM2-Buch S. 103–104, 109\]]])
#src[Skript TM2 S. 386–395; FS TM2 S. 22, 28, 36; TM2-Buch S. 83–84, 101–104, 109.]

== TM2 4.2 Normalspannung und Widerstandsmoment <a-tm2-4-2>
Bei Biegung ist die Spannung #strong[linear] über die Höhe verteilt: $sigma(z) = c dot z$ (Bernoulli, FS 4.1). Den Faktor $c$ bekommt man, indem man alle kleinen Kräfte $sigma thin d A$ mit ihrem Hebel $z$ zum Biegemoment aufsummiert (Skript TM2 S. 504–508):
#form[$ M = integral z thin sigma thin d A = c integral z^2 thin d A = c thin I quad => quad c = M/I quad => quad sigma(z) = M/I thin z $]
FS TM2 S. 23, Gl. 4.2–4.3. Die Integralgröße $I = integral z^2 thin d A$ heißt #strong[Flächenträgheitsmoment] (Abschnitt 4.3). Die größte Spannung sitzt in der Faser, die am weitesten von der Nulllinie entfernt ist:
#form[$ sigma_(max) = M/I thin |z_(max)| = M/W_((b)), wide W_((b)) = I/(|z_(max)|) quad ["mm"^3] wide overline(tau) = Q_(max)/A $]
FS TM2 S. 23, Gl. 4.4–4.6 und 4.10. $W$ ist das #strong[Widerstandsmoment] (Skript TM2 S. 537). Damit gibt es drei Aufgabentypen (FS 4.7–4.9): Nachweis $sigma_(max) = M\/W <= sigma_("zul")$, Bemessung $W_("erf") = M\/sigma_("zul")$ und zulässige Last $M_(max) = W sigma_("zul")$.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k4_ftm_ansatz", [Skript TM2 S. 504: Kragarm mit Rechteckquerschnitt ($b times h$), lokales Koordinatensystem im Schwerpunkt.], height: 55mm)],
 [#bild("tm2k4_ftm_herleitung", [Skript TM2 S. 508: lineare Spannung $sigma(z) = c z$, Schnittmoment an der Fläche $d A$ und daraus $sigma = M\/I dot z$ bzw. $sigma_b = M_b\/W_b$.], height: 70mm)])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k4_widerstand", [Skript TM2 S. 537: Herleitung des Widerstandsmoments $W = I\/z_(max)$; $z_(max)$ ist der Abstand vom Schwerpunkt zur äußersten Faser.], height: 70mm)],
 [#bild("tm2k4_spannungsverlauf", [Skript TM2 S. 538: Spannungsverlauf bei Rechteck, Dreieck und Achteck. Die Spannung ist immer linear in $z$.], height: 70mm)])
#note([Merke], [- Die Nulllinie (neutrale Faser) geht durch den #strong[Schwerpunkt]. Deshalb immer zuerst den Schwerpunkt bestimmen.
- Beim unsymmetrischen Querschnitt (z. B. Dreieck) gibt es #strong[zwei] Randabstände. Für $sigma_(max)$ zählt der größere: $W = I\/|z_(max)|$.
- Die mittlere Schubspannung $overline(tau) = Q\/A$ ist bei schlanken Balken viel kleiner als $sigma_(max)$. Bei Übung 9.1 ist sie nur 1/60 davon.])
#note([Achtung: typische Fehler], [- $W$ wird nicht mit Steiner verschoben. Erst $I$ bezüglich der Schwerpunktachse ausrechnen, dann durch $|z_(max)|$ teilen.
- Einheiten: $I$ in mm#super[4], $W$ in mm#super[3], $M$ in Nmm. Wer in cm rechnet, muss am Ende sauber umrechnen (siehe Mitschrift unten).], fill: sand)
#note([In eigenen Worten], [Ein Lineal, flach gebogen, ist weich. Hochkant gebogen ist es steif. Das Material ist dasselbe, aber hochkant liegt es weiter weg von der Nulllinie. Weil $z$ quadratisch in $I$ eingeht, zählt der Abstand viel mehr als die Menge. #text(fill: muted)[(eigene Ergänzung)]])
#heading(level: 3, outlined: false)[Beispiel aus der 9. Übung (WZF 01.06.26): Kastenträger mit Einzellast]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k4_wzf0106_aufgabe", [WZF 01.06.26 S. 1: Einfeldträger ($L = 10$ m) mit $F = 200$ kN bei $L\/3$ vor B; Schnitt C–C ist ein quadratischer Kasten ($c = 333$ mm, $t = 15$ mm). Rot: „2. Aufgabe in Klausur!“], height: 62mm)],
 [#bild("tm2k4_w0106_qm", [WZF 01.06.26 S. 2: Lagerkräfte $F_A = F\/3$, $F_B = 2F\/3$; Q- und M-Verlauf mit $M_(max) = frac(2, 9) F L$ unter der Last.], height: 80mm)])
#note([Von dir markiert (rot, WZF 01.06.26 S. 1–2)], [„2. Aufgabe in Klausur!“ steht neben dem Querschnitt. Darunter hast du notiert: „Kap. 7 TM I ist das wichtigste, da alles vernetzt“ und eine Liste „TM1: ① Lagerkräfte ② Schnittgrößen ③ Fachwerk; ① so eine Aufgabe wie jetzt“. Übe also die ganze Kette: Lagerkräfte → Q/M-Verlauf → Schwerpunkt → $I$ → $W$ → $sigma_(max)$ → Nachweis.], fill: sand)
#note([Beispiel (WZF 01.06.26 und TM2-Buch Bsp. 4.5)], [+ Lagerkräfte: $F_A = F\/3$, $F_B = 2F\/3$. Größtes Moment unter der Last: $M_(max) = F\/3 dot 2L\/3 = frac(2, 9) F L = "444,4" dot 10^6 thin "Nmm"$. Größte Querkraft $|Q_(max)| = frac(2, 3) F = "133,3"$ kN.
+ Schwerpunkt: Der Kasten ist doppelt symmetrisch, S liegt in der Mitte.
+ $I_y$ genau mit Steiner (zwei Gurte $(c+t) times t$ im Abstand $c\/2$, zwei Stege $t times (c-t)$): $I_y = "3,700" dot 10^8 thin "mm"^4$. Dünnwandig ($t << c$): $I_y approx frac(2, 3) c^3 t = "3,693" dot 10^8 thin "mm"^4$.
+ Widerstandsmoment mit dem echten Randabstand $z_(max) = (c+t)\/2 = 174$ mm: $W_y = "2,126" dot 10^6 thin "mm"^3$.
+ $sigma_(max) = "444,4" dot 10^6 \/ ("2,126" dot 10^6) = 209 thin "N/mm"^2 > sigma_("zul") = 200 thin "N/mm"^2$. Der Nachweis ist #strong[nicht] erfüllt.
+ $overline(tau) = Q_(max)\/A = 133300\/(4 c t) = 133300\/19980 approx "6,7" thin "N/mm"^2 << sigma_(max)$.], fill: pale)
#bild("tm2k4_w0106_duenn", [WZF 01.06.26 S. 4: $I_y$ dünnwandig mit Steiner (Eigenanteil + Steiner-Anteil), Ergebnis $frac(2, 3) c^3 t$; unten die Skizze für $z_(max)$.], height: 85mm)
#note([Hinweise zur Mitschrift (WZF 01.06.26)], [- S. 3–5: Die Zahlen für $I_y$ sind in cm#super[4] gerechnet, aber mit mm#super[4] beschriftet: „370,01 · 10#super[2] mm#super[4]“ bzw. „369,26 · 10#super[3] mm#super[4]“. Richtig ist $I_y = "3,700" dot 10^8 thin "mm"^4 = 37001 thin "cm"^4$. $W_y = "2,126" dot 10^6 thin "mm"^3$ und $sigma_(max) = 209 thin "N/mm"^2$ stimmen.
- S. 5: Ebenso $A = 4 c t = 199,80$ cm#super[2] $= 19980 thin "mm"^2$ (nicht mm#super[2]).
- S. 1: $sigma_("zul")$ sieht wie „2000 N/mm²“ aus. Gemeint sind 200 N/mm² (so im TM2-Buch Bsp. 4.5, und nur dann gilt „$209 > sigma_("zul")$“).
- Warum 209 und nicht 200? Das Buch rechnet dünnwandig mit $z_(max) = c\/2$ und kommt genau auf $c approx 333$ mm für 200 N/mm². Die Mitschrift nimmt den echten Rand $z_(max) = (c+t)\/2$. Der Unterschied von 4 % zeigt, wie knapp die Bemessung ist.], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- Normalspannung $sigma = M\/I dot z$, Widerstandsmoment, erforderliches Widerstandsmoment. #text(fill: muted)[\[TM2-Buch S. 106–107\]]
- Beispiel 4.4: eingespanntes Rohr, zulässige Kraft aus $sigma_("zul") = 150$ MPa. #text(fill: muted)[\[TM2-Buch S. 107–108\]]
- Beispiel 4.5: derselbe Kastenträger wie in der Übung, Bemessung von $c$. #text(fill: muted)[\[TM2-Buch S. 108–109\]]])
#src[Skript TM2 S. 504–508, 537–538; FS TM2 S. 22–23; WZF 01.06.26 S. 1–5; Übung 9; TM2-Buch S. 106–109.]

== TM2 4.3 Flächenträgheitsmomente <a-tm2-4-3>
Das Flächenträgheitsmoment (FTM) ist eine reine #strong[Kenngröße der Querschnittsform]. Es sagt, wie gut der Querschnitt gegen Biegung um eine Achse gebaut ist. Man muss zwei Sorten auseinanderhalten (Skript TM2 S. 530–531, FS S. 24):
#tab(columns: 3,
 th([Größe], [Formel], [Wozu]),
 [Statisches Moment (1. Ordnung)], [$S_y = integral z thin d A, quad S_z = integral y thin d A$], [Schwerpunkt: $y_s = S_z\/A$, $z_s = S_y\/A$. Im Schwerpunktsystem ist $S_y = S_z = 0$.],
 [Axiale FTM (2. Ordnung)], [$I_y = integral z^2 thin d A, quad I_z = integral y^2 thin d A$], [Biegung um $y$ bzw. $z$; immer positiv],
 [Deviationsmoment], [$I_("yz") = -integral y z thin d A$], [Kopplung der Achsen; null, wenn eine Achse Symmetrieachse ist],
 [Polares FTM], [$I_p = integral r^2 thin d A = I_y + I_z$], [Torsion (Kapitel 5)],
)
FS TM2 S. 24, Gl. 4.11–4.18. Für Grundformen stehen die Werte in der Tabelle (FS S. 25), z. B. Rechteck $I_y = b h^3\/12$, Kreis $I = pi R^4\/4$.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k4_ftm1_symm", [Skript TM2 S. 531: FTM 1. und 2. Ordnung. Am symmetrischen Dreieck heben sich die statischen Momente links und rechts auf ($S_z = 0$), aber $S_y != 0$.], height: 75mm)],
 [#bild("tm2k4_rechteck_iy", [Skript TM2 S. 514: $I_y$ des Rechtecks durch Integration über Streifen $b thin d z$: $I_y = b h^3\/12$.], height: 50mm)
  #bild("tm2k4_fs_tabelle", [FS TM2 S. 25: Satz von Steiner und Tabelle der FTM (Rechteck, Quadrat, Dreieck, Kreis, dünner Kreisring, Halbkreis, Ellipse).], height: 80mm)])
#heading(level: 3, outlined: false)[Satz von Steiner und zusammengesetzte Flächen]
Liegt die Bezugsachse nicht im Schwerpunkt einer Teilfläche, kommt der #strong[Steiner-Anteil] dazu (Skript TM2 S. 543–544, FS S. 25):
#form[$ I_(overline(y)) = I_y + overline(z)_s^2 A, quad I_(overline(z)) = I_z + overline(y)_s^2 A, quad I_(overline(y) overline(z)) = I_("yz") - overline(y)_s overline(z)_s A $]
FS 4.19–4.21. Für zusammengesetzte Flächen addiert man die Teil-FTM, alle bezogen auf den #strong[gemeinsamen] Schwerpunkt (FS S. 26, Gl. 4.22–4.24). Aussparungen (Löcher) werden #strong[abgezogen].
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k4_steiner", [Skript TM2 S. 543: Parallelverschiebung. Aus $I_(overline(y)) = integral (z + overline(z)_s)^2 d A$ wird Eigenanteil + $2 overline(z)_s S_y$ (= 0) + $overline(z)_s^2 A$.], height: 85mm)],
 [#bild("tm2k4_steiner_box", [Skript TM2 S. 544: die drei Steiner-Formeln, rot umrahmt.], height: 35mm)
  #bild("tm2k4_platte_loecher", [Skript TM2 S. 576: Rechteck mit zwei Rechteckaussparungen; die Löcher gehen mit Minus in die Tabelle ein.], height: 45mm)])
#note([Rezept: FTM eines zusammengesetzten Querschnitts], [+ Teilflächen festlegen (Aussparungen mit Minus) und ein Hilfs-KS $y'$-$z'$ wählen.
+ Schwerpunkt: $y'_s = sum y'_(s i) A_i \/ sum A_i$, $z'_s = sum z'_(s i) A_i \/ sum A_i$ (FS TM1 4.14).
+ Endgültiges $y$-$z$-System durch S legen, Abstände $y_(s i)$, $z_(s i)$ jeder Teilfläche zu S ablesen.
+ Tabelle: Eigenanteil (FS-Tabelle) + Steiner-Anteil für jede Teilfläche, dann summieren.
+ Kontrolle: Symmetrieachse → $I_("yz") = 0$.])
#note([Achtung: typische Fehler], [- Steiner vergessen oder vom falschen Punkt aus messen (immer zum #strong[Gesamtschwerpunkt]).
- Steiner-Anteil beim Deviationsmoment mit Vorzeichen: $-y_s z_s A$. Das Vorzeichen von $y_s$ und $z_s$ zählt.
- Beim Abziehen einer Aussparung auch ihren Steiner-Anteil abziehen.], fill: sand)
#heading(level: 3, outlined: false)[Beispiel I-Profil: stehend gegen liegend]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k4_iprofil", [Skript TM2 S. 554: I-Profil stehend ($b = 75$, $h = 90$, $s = 7$, $t = 4$ mm): Tabellenrechnung mit Steiner, $I_y = 2717150$, $I_z = "492667,5" thin "mm"^4$.], height: 75mm)],
 [#bild("tm2k4_iprofil_disk", [Skript TM2 S. 557: Zwischenbetrachtung: stehend ist viel steifer, „wo viel Spannung, da viel Material“.], height: 40mm)])
Die Gurte liegen weit weg von der $y$-Achse, deshalb ist $I_y$ fast sechsmal so groß wie $I_z$. Stehend eingebaut (Biegung um $y$) nutzt das Profil sein Material gut, liegend nicht.
#note([Fehler auf der Folie (Skript TM2 S. 554)], [Bei „Berechnung des Widerstandsmoments“ sind die Randabstände vertauscht: $W_("by") = I_y\/37,5 = 72457$ und $W_("bz") = I_z\/52 = 9474$. Richtig ist $W_y = I_y\/|z_(max)| = 2717150\/52 = 52253 thin "mm"^3$ und $W_z = I_z\/|y_(max)| = "492667,5"\/"37,5" = 13138 thin "mm"^3$. Zu $I_y$ gehört der Abstand in $z$-Richtung (FS 4.5).], fill: sand)
#heading(level: 3, outlined: false)[Drehung des Koordinatensystems und Hauptachsen]
Dreht man das Koordinatensystem um $phi$, ändern sich die FTM genau wie die Spannungen in Kapitel 2 (Skript TM2 S. 546–548, FS S. 26):
#form[$ I_(eta) = frac(1, 2)(I_y + I_z) + frac(1, 2)(I_y - I_z) cos 2 phi + I_("yz") sin 2 phi $
$ I_(zeta) = frac(1, 2)(I_y + I_z) - frac(1, 2)(I_y - I_z) cos 2 phi - I_("yz") sin 2 phi, quad I_(eta zeta) = -frac(1, 2)(I_y - I_z) sin 2 phi + I_("yz") cos 2 phi $]
#form[$ tan 2 phi^* = (2 I_("yz"))/(I_y - I_z), wide I_(1,2) = frac(1, 2)(I_y + I_z) plus.minus sqrt(((I_y - I_z)/2)^2 + I_("yz")^2), wide I_y + I_z = I_1 + I_2 = I_p $]
FS 4.25–4.30. In den #strong[Hauptachsen] ist $I_(eta zeta) = 0$. Welcher Winkel zu $I_1 = I_(max)$ gehört, sieht man durch Einsetzen von $phi^*$ in 4.25 (FS 4.31). Zuordnung zu Kapitel 2: $sigma <-> I$, $tau <-> I_("yz")$; auch der Mohrsche Trägheitskreis funktioniert so (FS S. 27).
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k4_drehung", [Skript TM2 S. 546: gedrehtes System $eta = y cos phi + z sin phi$, $zeta = -y sin phi + z cos phi$.], height: 75mm)],
 [#bild("tm2k4_transformation", [Skript TM2 S. 547: Herleitung und Transformationsregeln (rot umrahmt).], height: 75mm)])
#bild("tm2k4_hauptachsen", [Skript TM2 S. 548: Trägheitstensor, Invariante, Hauptachsenwinkel und $I_(1,2)$.], height: 75mm)
#note([Merke], [Ist eine Achse Symmetrieachse, dann ist $I_("yz") = 0$ und $y$, $z$ sind schon Hauptachsen. Nur bei unsymmetrischen Querschnitten (Z-Profil, Winkel, abgeschnittene Ecke) muss man drehen.])
#heading(level: 3, outlined: false)[Beispiel aus der 10. Übung (WZF 08.06.26): Quadrat mit abgeschnittener Ecke]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k4_wzf0806_ue10", [WZF 08.06.26 S. 1: Übung 10, Aufgabe 10.1 (Rechteck mit Rechteckloch). Oben rot deine Notiz „Prüfung: Flächenträgheitsmomente mit versch. Ausschnitten!“], height: 60mm)],
 [#bild("tm2k4_wzf0806_bsp", [WZF 08.06.26 S. 5: Quadrat $c times c$, oben rechts ein Dreieck ($c\/2 times c\/2$) abgeschnitten; Schwerpunkt, FTM, Hauptachsen und Kontrollskizze.], height: 95mm)])
#note([Von dir markiert (rot, WZF 08.06.26 S. 1 und 4)], [„Prüfung: Flächenträgheitsmomente mit versch. Ausschnitten!“ und ein rotes Ausrufezeichen an der Überschrift „FTM, Steiner, KS-Drehung, Hauptachsen“. Übe Querschnitte mit Löchern und abgeschnittenen Ecken (Übung 10.1, 10.2, Skript S. 572–585).], fill: sand)
#note([Beispiel (WZF 08.06.26)], [+ Teilflächen: ① Quadrat $c^2$ (Schwerpunkt $c\/2$, $c\/2$), ② Dreieck $-c^2\/8$ (Schwerpunkt $c\/6$, $c\/6$ von der Ecke).
+ Schwerpunkt: $y'_s = z'_s = (c\/2 dot c^2 - c\/6 dot c^2\/8)\/(7 c^2\/8) = "0,548" c$.
+ Abstände zu S: Quadrat $-"0,048" c$, Dreieck $-"0,381" c$ (in $y$ und $z$).
+ $I_y = I_z = c^4 [1\/12 + "0,048"^2 - ("1,736" dot 10^(-3) + "0,381"^2\/8)] = "0,0657" c^4$.
+ $I_("yz") = c^4 [0 - "0,048"^2 - ("0,868" dot 10^(-3) - "0,381"^2\/8)] = "0,0150" c^4$.
+ Wegen $I_y = I_z$ ist $tan 2 phi^* -> infinity$, also $phi^* = 45°$. $I_1 = "0,0657" + "0,0150" = "0,0807" c^4$, $I_2 = "0,0507" c^4$. Kontrolle: $I_1 + I_2 = "0,1314" c^4 = I_y + I_z$ ✓.], fill: pale)
#note([Hinweise zur Mitschrift (WZF 08.06.26 S. 5)], [- Dort steht $I_("yz") = "0,0180" c^4$ und $I_1 = I_(eta^*) = "0,0867" c^4$. Mit der eigenen Klammer auf derselben Seite kommt $I_("yz") = "0,0150" c^4$ heraus, und dann $I_1 = "0,0807" c^4$. Dein $I_2 = "0,0507" c^4$ stimmt.
- Kontrolle mit der Invariante: $"0,0867" + "0,0507" = "0,1374" != 2 dot "0,0657" = "0,1314"$. Mit $"0,0807"$ geht sie auf. Nachgerechnet habe ich das auch numerisch (Integration über das Raster).], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- Definition der FTM, Trägheitsradien, Beispiel 4.1. #text(fill: muted)[\[TM2-Buch S. 85–93\]]
- Parallelverschiebung (Steiner), Beispiel 4.2. #text(fill: muted)[\[TM2-Buch S. 94–95\]]
- Drehung des Bezugssystems, Hauptträgheitsmomente, dünnwandiges Beispiel 4.3. #text(fill: muted)[\[TM2-Buch S. 96–100\]]])
#src[Skript TM2 S. 510–557, 572–585; FS TM2 S. 24–27; WZF 08.06.26 S. 1–5; Übung 10; TM2-Buch S. 85–100.]

== TM2 4.4 Biegelinie <a-tm2-4-4>
Die Biegelinie $w(x)$ ist die Durchbiegung der Balkenachse. Für den schubstarren Balken ($w' + psi = 0$) folgt aus $psi' = M\/(E I)$ die #strong[Differentialgleichung der Biegelinie] (Skript TM2 S. 395, FS S. 28):
#form[$ w''(x) = -M(x)/(E I) $
$ E I thin w^("IV") = q(x), quad E I thin w''' = -Q(x), quad E I thin w'' = -M(x), quad E I thin w' = -psi, quad E I thin w = "Biegelinie" $]
FS 4.34–4.38 (für $E I$ = konst.). $E I$ heißt #strong[Biegesteifigkeit]. Zwei Wege führen zum Ziel (FS S. 29):
- #strong[Statisch bestimmt:] $M(x)$ aus Schnitt und Gleichgewicht, dann #strong[2-mal] integrieren. Man braucht 2 Randbedingungen (für $w$ und $w'$).
- #strong[Immer möglich (auch statisch unbestimmt):] $q(x)$ #strong[4-mal] integrieren. Man braucht 4 Randbedingungen. $Q$ und $M$ fallen als Zwischenergebnis mit ab.
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k4_dgl", [Skript TM2 S. 395: aus $d Q\/d x = -q$, $d M\/d x = Q$, $psi' = M\/(E I)$ und $w' + psi = 0$ folgt $w'' = -M\/(E I)$ und die Kette bis $E I w^("IV") = q$.], height: 75mm)],
 [#bild("tm2k4_allg_dgl", [Skript TM2 S. 400: allgemeiner Satz der DGLn für $q = q_0 x^n$ mit den Konstanten $C_1$ bis $C_4$.], height: 40mm)
  #bild("tm2k4_rb_tabelle", [Skript TM2 S. 401: Randbedingungen für gelenkiges Lager, Einspannung, Parallelführung und freies Ende.], height: 40mm)])
#tab(columns: 5,
 th([Lager], [$w$], [$w'$], [$M$], [$Q$]),
 [gelenkiges Lager], [$= 0$], [$!= 0$], [$= 0$], [$!= 0$],
 [Einspannung], [$= 0$], [$= 0$], [$!= 0$], [$!= 0$],
 [Parallelführung], [$!= 0$], [$= 0$], [$!= 0$], [$= 0$],
 [freies Ende], [$!= 0$], [$!= 0$], [$= 0$], [$= 0$],
)
FS TM2 S. 29. Jede „= 0“ ist eine Randbedingung. Geometrische RB ($w$, $w'$) und statische RB ($M$, $Q$) sind gleich viel wert (TM2-Buch S. 111–112).
#note([Von dir markiert (rot, WZF 15.06.26 S. 3)], [„Integrieren in d. Klausur nicht so wichtig, eher Randbedingungen aufstellen!“ Trainiere deshalb vor allem: Lager ansehen → Tabelle → Bedingungen hinschreiben.], fill: sand)
#heading(level: 3, outlined: false)[Einfeldbalken: gleiche Last, andere Lager]
Mit derselben Streckenlast $q_0$ ergeben drei Lagerungen dieselbe allgemeine Lösung, aber andere Konstanten (Skript TM2 S. 407–410):
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k4_faelle_abc", [Skript TM2 S. 407: a) Kragarm, b) gelenkig–gelenkig, c) eingespannt–gelenkig; gemeinsame DGL und die je vier Randbedingungen.], height: 70mm)],
 [#bild("tm2k4_ss_loesung", [Skript TM2 S. 402: spezielle Lösung für den beidseitig gelenkig gelagerten Balken unter $q_0$.], height: 65mm)])
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k4_fall_a", [Skript TM2 S. 408: Fall a) Kragarm: $C_3 = C_4 = 0$ aus der Einspannung, $C_1$, $C_2$ aus $Q(L) = M(L) = 0$.], height: 50mm)],
 [#bild("tm2k4_fall_c", [Skript TM2 S. 410: Fall c) statisch unbestimmt: $C_1 = -frac(5, 8) q_0 L$, $C_2 = frac(1, 8) q_0 L^2$ aus dem Gleichungssystem.], height: 50mm)])
#note([Beispiel (Skript TM2 S. 402, gelenkig–gelenkig unter $q_0$)], [+ $E I w^("IV") = q_0$; viermal integrieren.
+ RB: $w(0) = w(l) = 0$, $M(0) = M(l) = 0$ → $C_2 = C_4 = 0$, $C_1 = -q_0 l\/2$, $C_3 = q_0 l^3\/24$.
+ $E I w = frac(1, 24) q_0 x^4 - frac(1, 12) q_0 l x^3 + frac(1, 24) q_0 l^3 x$. In der Mitte: $w_(max) = frac(5, 384) q_0 l^4\/(E I)$.], fill: pale)
#note([Fehler auf der Folie (Skript TM2 S. 402)], [In den Zeilen für $E I w'$ und $E I w$ steht $q_0 l^2\/24$. Richtig ist $q_0 l^3\/24$: Aus $w(l) = 0$ folgt $C_3 = q_0 l^3\/24$, und nur so stimmt die Einheit (N·mm#super[2] für $E I w'$). Außerdem ist „$frac(1, 2) - q_0 l\/2$“ als $frac(1, 2) dot (-q_0 l\/2)$ zu lesen.], fill: sand)
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k4_dreieck1", [Skript TM2 S. 411: Dreieckslast $q(x) = q_0 (1 - x\/L)$ am eingespannt–gelenkigen Balken; allgemeine DGL und RB.], height: 65mm)],
 [#bild("tm2k4_dreieck3", [Skript TM2 S. 413: spezielle Lösung und Lagerreaktionen: $A_v = Q(0) = frac(2, 5) q_0 L$, $M_A = frac(1, 15) q_0 L^2$.], height: 65mm)])
#heading(level: 3, outlined: false)[Beispiel aus der 11. Übung (WZF 15.06.26): Kragarm mit $F$ und $M_0$]
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k4_w1506_bsp1", [WZF 15.06.26 S. 1: Kragarm (Länge $L$), am freien Ende $F$ nach unten und $M_0$; gegeben $E I_y$, gesucht $w(x)$.], height: 55mm)],
 [#bild("tm2k4_wzf1506_rb", [WZF 15.06.26 S. 3: Konstanten aus den RB; rot deine Notiz zum Klausurfokus; darunter c) 4-fache Integration.], height: 60mm)])
#note([Beispiel (WZF 15.06.26, Beispiel 1)], [+ a) 2-fach: $M(x) = M_0 - F(L - x)$ aus dem Schnitt; $w'' = -M\/(E I)$ zweimal integrieren; Einspannung $w(0) = w'(0) = 0$ → $C_1 = C_2 = 0$.
+ Ergebnis: $w(x) = 1\/(E I) [F (L x^2\/2 - x^3\/6) - M_0 x^2\/2]$.
+ c) 4-fach: $q = 0$; RB $w(0) = w'(0) = 0$, $Q(L) = F$, $M(L) = M_0$ → dasselbe Ergebnis.
+ d) Superposition aus der Biegelinientafel (Fall 6 für $F$, Fall 10 für $M_0$): $w(x) = F L^3\/(E I) [frac(1, 2)(x\/L)^2 - frac(1, 6)(x\/L)^3] - M_0 L^2\/(E I) dot frac(1, 2)(x\/L)^2$.
+ Am Ende: $w(L) = F L^3\/(3 E I) - M_0 L^2\/(2 E I)$.], fill: pale)
#heading(level: 3, outlined: false)[Mehrfeldbalken: Übergangsbedingungen]
Ändert sich $q(x)$ sprunghaft, greift eine Einzelkraft mitten im Feld an oder ist ein Gelenk eingebaut, teilt man den Balken in #strong[Bereiche]. Jeder Bereich bekommt eigene Konstanten (4 pro Bereich). Neben den Randbedingungen braucht man #strong[Übergangsbedingungen] an jeder Grenze: $w$ und $w'$ sind stetig (außer am Gelenk: $w'$ springt), $M$ und $Q$ springen nur um eingeleitete Momente bzw. Kräfte (Skript TM2 S. 422–427; TM2-Buch S. 122–124).
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k4_mehrbereich", [Skript TM2 S. 422: Streckenlast nur auf dem Bereich $a$; Aufteilen in zwei Bereiche mit je eigener DGL ($C_1$–$C_4$ und $C_5$–$C_8$).], height: 50mm)
  #bild("tm2k4_ueberg_streckenlast", [Skript TM2 S. 424: Rand- und Übergangsbedingungen bei $x_1 = a$, $x_2 = 0$.], height: 55mm)],
 [#bild("tm2k4_matrix", [Skript TM2 S. 425: das $8 times 8$-Gleichungssystem für $C_1$–$C_8$ (rot „Hauptdiagonale“, „schwach besetzt“).], height: 60mm)
  #bild("tm2k4_ueberg_einzellast", [Skript TM2 S. 427: Einzellast an der Bereichsgrenze; am Freikörperbild folgt $Q$ springt um $F$.], height: 50mm)])
#heading(level: 3, outlined: false)[Föppl-Symbol: ein Ansatz für alle Bereiche]
Das Föppl-Symbol schaltet einen Term erst ab der Stelle $x = a$ ein (Skript TM2 S. 430, FS S. 30):
#form[$ chevron.l x - a chevron.r^n = cases((x - a)^n & "für" x > a, 0 & "für" x < a) wide integral chevron.l x - a chevron.r^n d x = 1/(n+1) chevron.l x - a chevron.r^(n+1) $]
Eine Einzelkraft $F$ bei $x = a$ steckt dann direkt in $E I w''' = -Q = F chevron.l x - a chevron.r^0 + C_1$. Es bleiben nur die 4 Randbedingungen; Übergangsbedingungen sind automatisch erfüllt. Bei Gelenken kommen Sprungterme für $Delta phi$ bzw. $Delta w$ dazu („Maximalansatz“, Skript S. 432).
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k4_foeppl_def", [Skript TM2 S. 430: Definition des Föppl-Symbols und Anwendung auf eine Einzellast; orange: Vorzeichenwahl von $F$.], height: 65mm)],
 [#bild("tm2k4_foeppl_teil", [Skript TM2 S. 431: Streckenlast auf Teilstück als „An-/Aus-Schalter“: $q_0 chevron.l x - 0 chevron.r^0 - q_0 chevron.l x - a chevron.r^0$.], height: 65mm)])
#bild("tm2k4_maximalansatz", [Skript TM2 S. 432: Maximalansatz mit Moment $M_0$, Lagerkraft $B$, Gelenk ($E I Delta phi$) und Parallelführung ($E I Delta w$).], height: 75mm)
#heading(level: 3, outlined: false)[Biegelinientafel und Superposition]
Für viele Standardfälle gibt es fertige Lösungen (Biegelinientafel, FS S. 46–49 = Tab. 4.3 aus Gross/Hauger/Schröder/Wall). Weil die DGL linear ist, darf man Lastfälle #strong[addieren] (FS 4.39, S. 30): $w = w_1 + w_2$, ebenso $w'$, $M$, $Q$. Bei statisch unbestimmten Systemen schneidet man ein Lager oder Gelenk frei, setzt dort eine unbekannte Kraft $X$ an und bestimmt $X$ aus der Verträglichkeit (gleiche Verschiebung an der Schnittstelle).
#grid(columns: 2, gutter: 5mm,
 [#bild("tm2k4_lastfall1", [Skript TM2 S. 437: Herleitung von Lastfall 1 (Einfeldträger, Einzelkraft bei $a$) mit dem Föppl-Symbol; Ergebnis in dimensionsloser Form mit $xi = x\/l$, $alpha = a\/l$, $beta = b\/l$.], height: 65mm)],
 [#bild("tm2k4_lastfall4", [Skript TM2 S. 438: Herleitung von Lastfall 4 (Einfeldträger, Moment $M_0$ bei $a$).], height: 55mm)])
#bild("tm2k4_wzf1506_gelenk", [WZF 15.06.26 S. 5: Beispiel 2: zwei Kragarme ($L$) mit Gelenk; links $F$ am Gelenk, rechts $q_0$. Freischneiden mit $X$, Fälle [6] und [7] der Tafel.], height: 85mm)
#note([Beispiel (WZF 15.06.26, Beispiel 2)], [+ Am Gelenk die Kraft $X$ ansetzen. Linker Kragarm: Last $F - X$, Tafel Fall 6: $w_(G I) = (F - X) L^3\/(3 E I)$.
+ Rechter Kragarm: $X$ (Fall 6) und $q_0$ (Fall 7, in der Skizze nach oben): $w_(G I I) = X L^3\/(3 E I) - q_0 L^4\/(8 E I)$.
+ Verträglichkeit $w_(G I) = w_(G I I)$ → $X = F\/2 + frac(3, 16) q_0 L$.
+ Einsetzen: $w_G = F L^3\/(6 E I) - q_0 L^4\/(16 E I)$.], fill: pale)
#note([Merke], [Rezept Superposition: System in Standardfälle zerlegen → Werte aus der Tafel ablesen (auf $a$, $b$, $l$ der Tafel achten) → addieren. Bei statischer Unbestimmtheit pro überzähliger Größe eine Verträglichkeitsbedingung.])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- Differentialgleichung der Biegelinie, geometrische und statische Randbedingungen, Tab. 4.2. #text(fill: muted)[\[TM2-Buch S. 109–112\]]
- Einfeldbalken: Beispiele 4.6 (Endmoment, = Übung 11.1), 4.8 (beidseitig eingespannt) und 4.9 (Träger gleicher Festigkeit, = Übung 11.3). #text(fill: muted)[\[TM2-Buch S. 116, 119, 121\]]
- Balken mit mehreren Feldern, Föppl-Klammer. #text(fill: muted)[\[TM2-Buch S. 122–125\]]
- Superposition und Biegelinientafel Tab. 4.3. #text(fill: muted)[\[TM2-Buch S. 126–134\]]])
#src[Skript TM2 S. 395–438; FS TM2 S. 28–30, 46–49; WZF 15.06.26 S. 1–5; Übung 11; TM2-Buch S. 109–134.]

#bild("map-t2k4", [Mindmap zu TM2 Kapitel 4 (eigene Darstellung nach Skript TM2 S. 386–557 und FS TM2 S. 22–30).], height: 70mm)
*Der Zusammenhang in TM2 Kapitel 4.* Aus Gleichgewicht, Kinematik und Hooke plus Bernoulli folgt, dass die Spannung im Querschnitt linear ist (4.1). Wie groß sie wird, hängt nur von $M$ und vom Widerstandsmoment ab (4.2). $I$ und $W$ sind reine Geometrie: Schwerpunkt, Steiner, bei Unsymmetrie Hauptachsen (4.3). Dieselbe Steifigkeit $E I$ bestimmt auch, wie stark sich der Balken durchbiegt (4.4). Die Schnittgrößen aus TM1 Kapitel 7 sind der Anfang jeder Biegeaufgabe.

#pagebreak()
== Verständnisfragen und Rechenaufgaben · TM2 Kapitel 4
#set enum(spacing: 0.85em)
Erkläre erst selbst. Bei Rechenaufgaben: erst Schnittgrößen, dann Schwerpunkt, dann $I$ und $W$. Die Lösungen folgen getrennt.

+ Warum geht die Nulllinie bei reiner Biegung durch den Schwerpunkt?
+ Was ist der Unterschied zwischen $I_y$ und $W_y$, und welche Einheit haben sie?
+ Warum ist ein I-Profil stehend steifer als liegend, obwohl die Fläche gleich ist?
+ Wann ist das Deviationsmoment $I_("yz")$ null?
+ Wozu braucht man den Satz von Steiner, und wann fällt der Steiner-Anteil weg?
+ Wie viele Randbedingungen braucht man bei 2-facher und bei 4-facher Integration?
+ Welche Größen sind an einer Einspannung null, welche an einem freien Ende?
+ Rechteck $b = 20$ mm, $h = 60$ mm: Berechne $I_y$ und $W_y$ hochkant und flach. #text(fill: muted)[(eigene Aufgabe)]
+ Ein Kragarm ($l = 2$ m) trägt am Ende $F = 3$ kN; Querschnitt wie Frage 8 hochkant. Wie groß ist $sigma_(max)$, und wo tritt es auf? #text(fill: muted)[(eigene Aufgabe)]

#heading(level: 3, outlined: false)[Vertiefende Verständnisfragen und Rechenaufgaben]
#block[
#set enum(start: 10)
+ *Übung 9, Aufg. 9.1:* Eingespannter Balken ($40 a$) mit $F$ am Ende, dünnwandiger Hutquerschnitt (Wanddicke $t$). a) Schwerpunkt, b) $I_y$ dünnwandig, c) $sigma_(max)$ und Ort, d) $overline(tau)$ im Vergleich.
  #bild("tm2k4_ue91", [Übung TM2 Nr. 9, Aufg. 9.1: Kragarm mit Hutprofil (Schnitt A–A).], height: 35mm)
+ *Übung 9, Aufg. 9.2:* Stahlstange mit 5 kN und 3 kN (Lager A, B). Q- und M-Verlauf, dann mit $sigma_("zul") = 12 thin "kN/cm"^2$ bemessen: a) Vollkreis, b) Hohlkreis mit 10 % größerem Außendurchmesser, c) Materialersparnis, d) $overline(tau)$.
  #bild("tm2k4_ue92", [Übung TM2 Nr. 9, Aufg. 9.2: Stange mit Kragende, 1,8 m / 1,2 m / 0,8 m.], height: 28mm)
+ *WZF 01.06.26:* Rechne den Kastenträger ($F = 200$ kN, $L = 10$ m, $c = 333$ mm, $t = 15$ mm, $sigma_("zul") = 200 thin "N/mm"^2$) selbst durch. Ist der Nachweis erfüllt?
+ *Übung 10, Aufg. 10.1:* Rechteck $4a times 6a$ mit Rechteckloch $2a times 3a$ (Abstand $a$ von oben). Schwerpunkt, $I_y$, $I_z$, $I_("yz")$, $W_y$, $W_z$.
  #bild("tm2k4_ue10", [Übung TM2 Nr. 10, Aufg. 10.1 (aus WZF 08.06.26).], height: 45mm)
+ *Übung 10, Aufg. 10.2:* Quadrat $a times a$ mit einem um 45° gedrehten Rechteckloch $b times c$ ($b = a\/4$, $c = a$). Schwerpunkt, Hauptachsen, Hauptträgheitsmomente.
  #bild("tm2k4_ue102", [Übung TM2 Nr. 10, Aufg. 10.2: Quadrat mit schrägem Schlitz.], height: 45mm)
+ *Übung 10, Aufg. 10.3:* Z-Profil (genau und dünnwandig): Schwerpunkt, Trägheitstensor, Hauptachsen und Hauptträgheitsmomente.
  #bild("tm2k4_ue103", [Übung TM2 Nr. 10, Aufg. 10.3: Z-Profil genau (links) und dünnwandig (rechts), Maße in mm.], height: 40mm)
+ *Übung 10, Aufg. 10.4:* C-förmiger Trägerquerschnitt (nicht dünnwandig): Schwerpunkt, $I_y$, $I_z$, $I_("yz")$, Hauptträgheitsmomente mit Richtung.
  #bild("tm2k4_ue104", [Übung TM2 Nr. 10, Aufg. 10.4: Querschnitt und Kragarm unter $q$.], height: 38mm)
+ *WZF 08.06.26:* Quadrat mit abgeschnittener Ecke ($c\/2 times c\/2$): Schwerpunkt, $I_y$, $I_z$, $I_("yz")$, Hauptachsen.
+ *Übung 11, Aufg. 11.1:* Gelenkig gelagerter Balken mit Endmoment $M_0$: a) Biegelinie, b) größte Durchbiegung und Ort.
+ *Übung 11, Aufg. 11.2:* Beidseitig eingespannter Balken unter $q_0$: Verlauf $M(x)$.
+ *Übung 11, Aufg. 11.3:* Kragarm unter $q_0$, Rechteck mit Breite $b$: a) $h(x)$ so, dass überall $sigma = sigma_0$, b) Absenkung am freien Ende.
  #bild("tm2k4_ue11", [Übung TM2 Nr. 11, Aufg. 11.1–11.3.], height: 95mm)
+ *Übung 11, Aufg. 11.4:* Mehrfeldbalken mit Gelenk G, $F$ am Gelenk, $q_0$ auf dem letzten Feld: Absenkung am Gelenk mit Superposition.
  #bild("tm2k4_ue11_4", [Übung TM2 Nr. 11, Aufg. 11.4.], height: 35mm)
+ *WZF 15.06.26:* Kragarm mit $F$ und $M_0$ am Ende: Stelle alle vier Randbedingungen auf und bestimme $w(x)$.
+ *Skript TM2 S. 554:* Berechne $W_y$ und $W_z$ des I-Profils ($I_y = 2717150$, $I_z = "492667,5" thin "mm"^4$, $y_(max) = "37,5"$, $z_(max) = 52$ mm).
+ *Buch:* Rohr ($R_a = 5$ cm, $R_i = 4$ cm, $l = 3$ m) einseitig eingespannt. Wie groß darf $F$ am Ende sein bei $sigma_("zul") = 150$ MPa? (TM2-Buch S. 107–108, Bsp. 4.4)
+ *Altklausur, Datum unbekannt, mit Musterlösung (Prüfung_unbekannt.pdf S. 1–2):* Querschnitt aus Halbkreis ① ($R = 20$ mm), Rechteck ② ($b times h$, Aussparung) und Rechteck ③ ($(b + t) times h$) mit $t = 10$, $b = 20$, $h = 40$ mm. a) $A_i$, $y'_i$, $z'_i$. b) Schwerpunkt. c) $I_y$ mit Steiner. d) Mit den vorgegebenen Werten $I_y = 400 thin 000$, $I_z = 120 thin 000$, $I_(y z) = 60 thin 000 thin "mm"^4$: Hauptträgheitsmomente und Hauptrichtung. e) Biegespannung an der Einspannung bei $M = 50$ Nm, $I_y = 56 thin 000 thin "mm"^4$, $z = "23,5"$ mm (unten).
  #bild("ak_unb_ftm", [Altklausur, Datum unbekannt, Aufg. 2, Abb. 1: zusammengesetzter Querschnitt mit Hilfs-KS $y'$-$z'$, Schwerpunkt $S$ und Hauptachse unter $phi^*$; rechts Rechteck ② gestrichelt in ③.], height: 55mm)
+ *Altklausur, Datum unbekannt, mit Musterlösung (Prüfung_unbekannt.pdf S. 4):* Balken der Länge $L$: in $A$ Parallelführung, in $B$ Festlager mit dem Moment $M_0$, dreieckige Streckenlast von $q_0$ bei $A$ auf 0 bei $B$. Gib die Randbedingungen und $q(x)$ für die 4-fache Integration an und skizziere die Biegelinie.
  #bild("ak_unb_balken", [Altklausur, Datum unbekannt, Aufg. 2 k), Musterlösung: Balken mit Dreieckslast und Moment $M_0$ in $B$; zwei mögliche Biegelinien ① und ② eingezeichnet.], height: 45mm)
+ *Altklausur SS 2018 (TM_Prüfung_2018.pdf S. 8–9):* Querschnitt aus Kreis ($R = a$) minus rechtwinkligem Dreieck (Katheten $a$ und $a\/2$) minus Rechteck ($a times a\/2$), $a = 30$ mm. a) Schwerpunkt aus der Tabelle. b) Eigen-FTM der Teilflächen allgemein. c) Steiner-Anteile von $I_(y z)$ mit den Abständen aus der Tabelle. d) Sind $y$ und $z$ Hauptachsen? e) Hauptträgheitsmomente und Richtung mit $I_y = 592 thin 000$, $I_z = 585 thin 000$, $I_(y z) = -7300 thin "mm"^4$.
  #bild("ak_2018_ftm", [Altklausur SS 2018, Aufg. 2, Abb. 1: Kreis mit Dreieck ② und Rechteck ③ als Aussparungen, Hilfs-KS $y'$-$z'$; rechts der eingespannte Träger.], height: 55mm)
  #bild("ak_2018_ftm_tab", [Altklausur SS 2018, Aufg. 2 b): Tabelle mit $A_i$, $y'_(S i)$, $z'_(S i)$ und den Abständen $y_(S i)$, $z_(S i)$ für Teil e).], height: 30mm)
+ *Altklausur SS 2018 (TM_Prüfung_2018.pdf S. 10):* Kragträger, links eingespannt, Länge $l$, Kraft $F$ am freien Ende, $I(x) = I_0 frac(l, l + x)$. Bestimme $M(x)$, $w'(x)$ und $w(x)$.
  #bild("ak_2018_ix", [Altklausur SS 2018, Aufg. 2 j), Abb. 4: links eingespannter Balken, nach rechts dünner werdend, $F$ am Ende.], height: 35mm)
+ *Altklausur SS 2018 (TM_Prüfung_2018.pdf S. 11):* Dreifeld-Balken: $A$ feste Einspannung, $G$ Gelenk bei $a\/2$, $B$ Loslager bei $a$, $C$ Loslager bei $2a$, Kraft $F$ in $G$, Dreieckslast von $2 q_0$ auf 0 im ersten Bereich, Trapezlast im dritten Feld. Gib RB, ÜB und $q(x)$ je Feld an. Ist das System statisch bestimmt? Wie machst du es statisch bestimmt?
  #bild("ak_2018_dreifeld", [Altklausur SS 2018, Aufg. 2 m), Abb. 5: Balken mit Feldern I, II, III, gemeinsame $x$-Koordinate ab $A$.], height: 35mm)
+ *Altklausur SS 2016, Musterlösung (PrüfungenTM2.pdf S. 13–14):* Zweifeld-Balken: $A$ freies Ende mit der Kraft $F$, $B$ Loslager bei $a$, $C$ feste Einspannung bei $2a$; Streckenlast von $q_0$ bei $A$ auf $2 q_0$ bei $B$, dann auf 0 bei $C$. RB, ÜB, $q(x)$, statische Bestimmtheit?
  #bild("ak_p13_zweifeld", [Altklausur SS 2016, Aufg. 2: Zweifeld-Balken mit dachförmiger Last, Bereiche I und II.], height: 40mm)
+ *Altklausur SS 2014 (PrüfungenTM2.pdf S. 41):* Balken der Länge $l$: $A$ Loslager bei $x = 0$, $B$ feste Einspannung bei $x = l$, Trapezlast von $q_0$ bei $A$ auf $"1,5" q_0$ bei $B$. RB und $q(x)$?
+ *Altklausur SS 2016, Musterlösung (PrüfungenTM2.pdf S. 28):* Querschnitt aus Rechteck ① $40 times 60$ mm minus Halbkreis ② ($r = 15$ mm) minus Dreieck ③ ($30 times 30$ mm), $h = 60$ mm. a) $A_i$, $y'_i$, $z'_i$. b) Schwerpunkt. c) $I_y$ mit Steiner. d) Hauptachsen? e) Hauptträgheitsmomente mit $I_y = 444 thin 000$, $I_z = 181 thin 000$, $I_(y z) = -126 thin 000 thin "mm"^4$.
  #bild("ak_ss16_ftm", [Altklausur SS 2016, Aufg. 2, Abb. 1, Musterlösung: Querschnitt mit Aussparungen, Schwerpunkt $S$ und Hauptachsen 1 und 2 unter $phi^*$.], height: 45mm)
+ *Altklausur mit Musterlösung (PrüfungenTM2.pdf S. 25–29):* Abgewinkeltes Profil, einseitig eingespannt, Querschnitt aus Halbring ($r_i = 15$, $t = 5$ mm) und Steg ($t times h$, $h = 40$ mm); $l_1 = "0,5"$ m, $l_2 = 1$ m, $F_1 = "0,9"$ kN, $F_2 = 10$ kN, $E = "2,1" dot 10^5$, $G = "0,808" dot 10^5 thin "N/mm"^2$. a) $A_i$ und $y'_i$. b) Schwerpunkt. c) $I_z$. d) Hauptachsen? e) Durchbiegung durch $F_1$ am Ende von $l_2$ mit $I = 43 thin 000 thin "mm"^4$.
  #bild("ak_p25_profil", [Altklausur mit Musterlösung, Aufg. 2: links das abgewinkelte Profil mit $F_1$ und $F_2$, Mitte der Querschnitt (Halbring mit Steg), rechts die Zahlenwerte.], height: 45mm)
]

#pagebreak()
== Lösungen TM2 Kapitel 4
#set enum(spacing: 0.65em)
+ Bei reiner Biegung ist $N = integral sigma thin d A = E psi' S_y = 0$. Das geht nur, wenn das statische Moment null ist, also die Achse durch den Schwerpunkt geht. #nachschlagen[Lernskript, #stelle(<a-tm2-4-1>)]
+ $I_y = integral z^2 d A$ (mm#super[4]) beschreibt die Form, $W_y = I_y\/|z_(max)|$ (mm#super[3]) liefert direkt $sigma_(max) = M\/W$. #nachschlagen[Lernskript, #stelle(<a-tm2-4-2>)]
+ $z$ geht quadratisch ein. Stehend liegen die Gurte weit von der Biegeachse. #nachschlagen[Lernskript, #stelle(<a-tm2-4-3>)]
+ Wenn $y$ oder $z$ eine Symmetrieachse ist (dann sind es Hauptachsen). #nachschlagen[Lernskript, #stelle(<a-tm2-4-3>)]
+ Um FTM von der Teilschwerpunktachse auf eine parallele Achse (Gesamtschwerpunkt) zu bringen. Er fällt weg, wenn beide Achsen zusammenfallen. #nachschlagen[Lernskript, #stelle(<a-tm2-4-3>)]
+ 2-fach: 2 RB (für $w$, $w'$). 4-fach: 4 RB. #nachschlagen[Lernskript, #stelle(<a-tm2-4-4>)]
+ Einspannung: $w = w' = 0$. Freies Ende: $M = Q = 0$. #nachschlagen[Lernskript, #stelle(<a-tm2-4-4>)]
+ Hochkant: $I_y = 20 dot 60^3\/12 = 360000 thin "mm"^4$, $W_y = 12000 thin "mm"^3$. Flach: $I = 60 dot 20^3\/12 = 40000 thin "mm"^4$, $W = 4000 thin "mm"^3$. #nachschlagen[Lernskript, #stelle(<a-tm2-4-2>)]
+ $|M_(max)| = 3 dot 2 = 6 thin "kNm" = 6 dot 10^6 thin "Nmm"$ an der Einspannung; $sigma_(max) = 6 dot 10^6\/12000 = 500 thin "N/mm"^2$, oben Zug, unten Druck. #nachschlagen[Lernskript, #stelle(<a-tm2-4-2>)]
+ a) S liegt in der Mitte, Abstand $a$ von der Oberkante ($A = 8 a t$). b) $I_y = frac(16, 3) a^3 t$. c) $M_(max) = 40 F a$ an der Einspannung, $W_y = frac(16, 3) a^2 t$, $sigma_(max) = "7,5" F\/(a t)$, oben Zug, unten Druck. d) $overline(tau) = F\/(8 a t) = sigma_(max)\/60$. #nachschlagen[Lernskript, #stelle(<a-tm2-4-2>)\; Lösung Übung 9]
+ $F_A = "1,2"$ kN, $F_B = "6,8"$ kN; $M = "2,16"$ kNm unter der 5-kN-Last, $M_B = -"2,4"$ kNm. a) $r = "2,94"$ cm. b) $R = "3,24"$ cm, $r_i = "2,30"$ cm. c) $A = "27,15"$ bzw. $"16,36" thin "cm"^2$, also 39,7 % weniger. d) $overline(tau) = "1,4"$ bzw. $"2,32" thin "N/mm"^2 << 120 thin "N/mm"^2$. #nachschlagen[Lernskript, #stelle(<a-tm2-4-2>)\; Lösung Übung 9]
+ $sigma_(max) = 209 thin "N/mm"^2 > 200$: nicht erfüllt (dünnwandig mit $z_(max) = c\/2$ wären es 200). $overline(tau) approx "6,7" thin "N/mm"^2$. #nachschlagen[Lernskript, #stelle(<a-tm2-4-2>)]
+ $z'_s = frac(19, 6) a$ (mittig in $y$), $I_y = "65,5" a^4$, $I_z = 30 a^4$, $I_("yz") = 0$, $W_y = "20,68" a^3$, $W_z = 15 a^3$. #nachschlagen[Lernskript, #stelle(<a-tm2-4-3>)\; Kurzlösung Übung 10]
+ S in der Mitte; Hauptachsen unter 45° (Symmetrie zum gedrehten System); $I_(xi) = a^4\/16$, $I_(eta) = frac(21, 256) a^4$, $I_(xi eta) = 0$. #nachschlagen[Lernskript, #stelle(<a-tm2-4-3>)\; Kurzlösung Übung 10]
+ a) $y'_s = 75$, $z'_s = 100$ mm. b) $I_y = 226 dot 10^5$, $I_z = "36,7" dot 10^5$, $I_("yz") = "68,1" dot 10^5 thin "mm"^4$. c) dünnwandig: $z'_s = "93,5"$, $I_y = 225 dot 10^5$, $I_z = "36,6" dot 10^5$, $I_("yz") = "68,4" dot 10^5$. d) $phi^* = "17,87"°$, $I_1 = "247,95" dot 10^5$, $I_2 = "14,75" dot 10^5 thin "mm"^4$. #nachschlagen[Lernskript, #stelle(<a-tm2-4-3>)\; Kurzlösung Übung 10]
+ a) $y'_s = 31$ mm, $z'_s = 39$ mm. b) $I_y = 988500$, $I_z = 288500$, $I_("yz") = 126000 thin "mm"^4$. c) $phi^* = "9,9"°$, $I_1 = 1010490$, $I_2 = 266510 thin "mm"^4$. #nachschlagen[Lernskript, #stelle(<a-tm2-4-3>)\; Kurzlösung Übung 10]
+ $z'_s = y'_s = "0,548" c$; $I_y = I_z = "0,0657" c^4$, $I_("yz") = "0,0150" c^4$; $phi^* = 45°$, $I_1 = "0,0807" c^4$, $I_2 = "0,0507" c^4$. #nachschlagen[Lernskript, #stelle(<a-tm2-4-3>)]
+ a) $w(x) = M_0 l^2\/(6 E I) dot (-(x\/l)^3 + x\/l)$. b) $w_(max) = M_0 l^2\/(9 sqrt(3) E I)$ bei $x = l\/sqrt(3)$. #nachschlagen[Lernskript, #stelle(<a-tm2-4-4>)\; Kurzlösung Übung 11; TM2-Buch S. 116]
+ $M(x) = q_0 l^2\/12 dot (-6 (x\/l)^2 + 6 (x\/l) - 1)$: an den Enden $-q_0 l^2\/12$, in der Mitte $+q_0 l^2\/24$. #nachschlagen[Lernskript, #stelle(<a-tm2-4-4>)\; Kurzlösung Übung 11]
+ a) $h(x) = sqrt(3 q_0\/(sigma_0 b)) dot x$. b) $w(x) = q_0 l^3\/(2 E I_0) dot (x ln(x\/l) - x + l)$, am freien Ende $w(0) = q_0 l^4\/(2 E I_0)$ mit $I_0 = I(x = l)$. #nachschlagen[Lernskript, #stelle(<a-tm2-4-4>)\; Kurzlösung Übung 11; TM2-Buch S. 121]
+ $w_G = F a^3\/(E I) dot frac(8, 27) + q_0 a^4\/(E I) dot frac(7, 216)$. #nachschlagen[Lernskript, #stelle(<a-tm2-4-4>)\; Kurzlösung Übung 11]
+ $w(0) = 0$, $w'(0) = 0$, $Q(L) = F$, $M(L) = M_0$; $w(x) = 1\/(E I) [F (L x^2\/2 - x^3\/6) - M_0 x^2\/2]$. #nachschlagen[Lernskript, #stelle(<a-tm2-4-4>)]
+ $W_y = 2717150\/52 = 52253 thin "mm"^3$, $W_z = "492667,5"\/"37,5" = 13138 thin "mm"^3$ (die Folie vertauscht die Abstände). #nachschlagen[Lernskript, #stelle(<a-tm2-4-3>)]
+ $I = pi (R_a^4 - R_i^4)\/4 = "289,8" thin "cm"^4$, $W = I\/R_a = "57,96" thin "cm"^3$; $F_(max) = sigma_("zul") W\/l = 150 dot 57960\/3000 approx "2,9"$ kN. #nachschlagen[Lernskript, #stelle(<a-tm2-4-2>)\; TM2-Buch S. 107–108]
+ a) $A = "628,32"$ / $-800$ / $1200 thin "mm"^2$, $y' = 0$ / $0$ / $-5$, $z' = -"8,49"$ / $10$ / $20$. b) $y'_S = -"5,83"$, $z'_S = "10,37"$ mm. c) $I_y = (17 thin 563 + 223 thin 516) - (106 thin 667 + 111) + (160 thin 000 + 111 thin 214) approx 405 thin 500 thin "mm"^4$. d) $I_(1,2) = 260 thin 000 plus.minus 152 thin 300$, also $I_1 = 412 thin 300$, $I_2 = 107 thin 700 thin "mm"^4$, $phi^* = "11,6"°$ (Achse von $I_1$). e) $sigma = M z\/I_y = 50 thin 000 dot "23,5"\/56 thin 000 = "21,0" thin "N/mm"^2$ (Zug unten). Die gedruckte Angabe $30 thin 000 thin "mm"^4$ ist im Bogen von Hand auf $56 thin 000$ korrigiert. #nachschlagen[Lernskript, #stelle(<a-tm2-4-3>), #stelle(<a-tm2-4-2>)\; Altklausur, Datum unbekannt, mit Musterlösung (Prüfung_unbekannt.pdf S. 1–2)]
+ $Q(0) = 0$, $w'(0) = 0$, $w(L) = 0$, $M(L) = -M_0$ (Vorzeichen nach Drehsinn von $M_0$). $q(x) = q_0 (1 - x\/L)$. #nachschlagen[Lernskript, #stelle(<a-tm2-4-4>)\; Altklausur, Datum unbekannt, mit Musterlösung (Prüfung_unbekannt.pdf S. 4)]
+ a) $y'_S = 63 thin 525\/2155 = "29,48"$, $z'_S = 62 thin 400\/2155 = "28,96"$ mm. b) Kreis: $I_y = I_z = pi a^4\/4$, $I_(y z) = 0$. Dreieck: $a^4\/288$, $a^4\/72$, $I_(y z) = a^4\/288$. Rechteck: $a^4\/96$, $a^4\/24$, 0. c) $-A y z$: $-1415$, $-4950$, $+"1912,5"$ (Aussparungen mit Minus); mit dem Eigenanteil des Dreiecks zusammen $I_(y z) approx -7265 thin "mm"^4$. d) Nein: der Querschnitt ist unsymmetrisch, $I_(y z) eq.not 0$. e) $I_1 = 596 thin 600$, $I_2 = 580 thin 400 thin "mm"^4$, $phi^* = -"32,2"°$ (Achse von $I_1$). #nachschlagen[Lernskript, #stelle(<a-tm2-4-3>)\; Altklausur SS 2018 (TM_Prüfung_2018.pdf S. 8–9), eigene Lösung]
+ $M = -F (l - x)$. $w'' = -M\/(E I) = frac(F (l^2 - x^2), E I_0 l)$. Mit $w'(0) = w(0) = 0$: $w' = frac(F, E I_0 l) (l^2 x - x^3\/3)$, $w = frac(F, E I_0 l) (l^2 x^2\/2 - x^4\/12)$, am Ende $w(l) = frac(5 F l^3, 12 E I_0)$. #nachschlagen[Lernskript, #stelle(<a-tm2-4-4>)\; Altklausur SS 2018 (TM_Prüfung_2018.pdf S. 10), eigene Lösung]
+ RB: $w_I (0) = 0$, $w'_I (0) = 0$, $w_(I I I)(2a) = 0$, $M_(I I I)(2a) = 0$. ÜB bei $a\/2$: $w_I = w_(I I)$, $M_I = 0$, $M_(I I) = 0$, $Q_I - F = Q_(I I)$. ÜB bei $a$: $w_(I I) = 0$, $w_(I I I) = 0$, $w'_(I I) = w'_(I I I)$, $M_(I I) = M_(I I I)$. $q_I = 2 q_0 (1 - 2x\/a)$, $q_(I I I) = q_0 x\/(2a)$. Lager $3 + 1 + 1 = 5$, Gelenk 2, zusammen $7 > 6$: einfach statisch unbestimmt. Statisch bestimmt: Lager $C$ entfernen und durch eine unbekannte Kraft $X$ ersetzen. #nachschlagen[Lernskript, #stelle(<a-tm2-4-4>)\; Altklausur SS 2018 (TM_Prüfung_2018.pdf S. 11), eigene Lösung]
+ RB: $M_I (0) = 0$, $Q_I (0) = F$ (Vorzeichen nach Richtung von $F$), $w_(I I)(2a) = 0$, $w'_(I I)(2a) = 0$. ÜB bei $a$: $w_I = 0$, $w_(I I) = 0$, $w'_I = w'_(I I)$, $M_I = M_(I I)$. $q_I = q_0 (1 + x\/a)$, $q_(I I) = 2 q_0 (2 - x\/a)$. Lager $3 + 1 = 4 > 3$: einfach statisch unbestimmt. #nachschlagen[Lernskript, #stelle(<a-tm2-4-4>)\; Altklausur SS 2016, Musterlösung (PrüfungenTM2.pdf S. 13–14)]
+ $w(0) = 0$, $M(0) = 0$, $w(l) = 0$, $w'(l) = 0$. $q(x) = q_0 (1 + x\/(2l))$. #nachschlagen[Lernskript, #stelle(<a-tm2-4-4>)\; Altklausur SS 2014 (PrüfungenTM2.pdf S. 41)]
+ a) $A = 2400$ / $-"353,4"$ / $-450 thin "mm"^2$, $y' = 20$ / $"33,63"$ / $10$, $z' = 30$ / $20$ / $50$. b) $y'_S = "19,8"$, $z'_S = "26,6"$ mm. c) $I_y = (720 thin 000 + 27 thin 744) - (19 thin 880 + 15 thin 394) - (22 thin 500 + 246 thin 402) approx 444 thin 000 thin "mm"^4$. In der Musterlösung stand zuerst $528 thin 000$, korrigiert auf $444 thin 000$. d) Nein, unsymmetrisch. e) $I_1 approx 494 thin 600$, $I_2 approx 130 thin 400 thin "mm"^4$, $phi^* = -"21,9"°$. #nachschlagen[Lernskript, #stelle(<a-tm2-4-3>)\; Altklausur SS 2016, Musterlösung (PrüfungenTM2.pdf S. 28)]
+ a) Außen-Halbkreis $"628,32"$, innen $-"353,43"$, Steg $200 thin "mm"^2$; $y' = -"13,49"$ / $-"11,37"$ / $-"2,5"$. b) $y'_S = -"10,44"$ mm, $z'_S = 0$. c) $I_z = (17 thin 561 + 5845) - (5556 + 306) + ("416,7" + 12 thin 609) approx 30 thin 600 thin "mm"^4$. d) Ja: symmetrisch, $I_(y z) = 0$. e) $w = frac(F_1 l_2^3, 3 E I) = frac(900 dot 1000^3, 3 dot "2,1" dot 10^5 dot 43 thin 000) = "33,2"$ mm. #nachschlagen[Lernskript, #stelle(<a-tm2-4-3>), #stelle(<a-tm2-4-4>)\; Altklausur mit Musterlösung (PrüfungenTM2.pdf S. 25–29)]

#pagebreak()
= TM2 Kapitel 5 · Torsion <k-tm2-5>
#tab(columns: 2,
 [Vorlesungen], [Kein handschriftliches VL-Datum auf den Torsionsfolien (Sosnowsky-Skript, Teil 11 „Torsion“; Skript TM2 S. 350: „Dieses Kapitel beinhaltet bereits Themen aus Teil 11“). Datierte Mitschriften: #strong[WZF 22.06.26] („12. Übung TM2: Torsion“) → 5.1–5.4; #strong[WZF 11.05.26] („7. Übung“, dünnwandiger Behälter mit Torsionsmoment) → 5.2],
 [Quellen], [Skript TM2 S. 109–128 (Torsion dick- und dünnwandiger Querschnitte, handschriftliche Folien), S. 350–384 („Spannungen und Schnittgrößen II: Torsion“; S. 363–378 sind identisch mit S. 111–125), S. 600–604 (Teil 11 Torsion), S. 617–618 (Übung 12); FS TM2 S. 15, 19, 37–41 (Kap. 5 Torsion); WZF-Mitschrift 22.06.26 S. 1–5, WZF-Mitschrift 11.05.26 S. 1–2; TM2-Buch Kap. 5 (S. 167–196)],
 [Passende Übungen], [Übung 7: 7.1 a)–b) (Kernlochbohrer, Schubspannung aus $M_t$) · Übung 12: 12.1 (Welle dimensionieren: Voll-/Hohlwelle), 12.2 (konischer Stab), 12.3 (geschlossen ↔ geschlitzt), 12.4 (dünnwandiges Dreiecksprofil) – Aufgabentext 12.1/12.2 in Skript TM2 S. 617, Lösungen in „Lösung Übung 12“ S. 1–6 · Übung 13: 13.1 b)–c) (konischer Stab, $tau_("max")(x)$), 13.2 c)–d) (dünnwandig geschlossenes Profil: $I_T$, $W_T$, Ort von $tau_("max")$) · Beispiel WZF 22.06.26 (Vollquadrat ↔ Kasten ↔ geschlitzter Kasten); dazu Altklausur-Aufgaben am Ende der vertiefenden Fragen],
)
Torsion heißt: Ein Moment dreht den Stab #strong[um seine eigene Längsachse]. Im Querschnitt entstehen dabei nur #strong[Schubspannungen], und der Stab verdreht sich um einen Winkel $theta.alt$. Zwei Formeln tragen das ganze Kapitel: $tau_("max") = M_T /W_T$ (Festigkeit) und $theta.alt ' = M_T /(G I_T )$ (Steifigkeit). Der Rest ist nur die Frage: #strong[Welche Werte haben $W_T$ und $I_T$ für meinen Querschnitt?] – Vollkreis, Rohr, geschlossenes oder offenes dünnwandiges Profil.
#note([Dein Feynman-Schritt: die 5 Kernideen von Kapitel 5. Erst ohne Skript aufzählen und erklären, dann vergleichen.], [+ #strong[Torsion = eindimensionaler Lastfall wie Zug/Druck:] $M_T$ statt $N$, $G I_T$ statt $E A$, $Delta theta.alt$ statt $Delta l$. Gleiche Struktur der Formeln.
+ #strong[Zwei Nachweise:] Spannung $tau_("max") = M_T /W_T <= tau_("zul")$ und Verformung $theta.alt ' = M_T /(G I_T )$ bzw. $Delta theta.alt = M_T l/(G I_T )$.
+ #strong[Dickwandig/Vollkreis:] $tau$ wächst linear mit $r$, Maximum am Rand. $I_T = I_p = frac(pi, 2) R^4$, $W_T = frac(pi, 2) R^3$.
+ #strong[Dünnwandig geschlossen:] konstanter, umlaufender Schubfluss $T = M_T /(2A_m )$ (Bredt). $tau_("max")$ bei $t_("min")$.
+ #strong[Dünnwandig offen:] Schub läuft im Profil „hin und zurück“ → sehr kleiner Hebelarm → $I_T = frac(1, 3) sum h_i t_i^3$ winzig. Darum: bei Torsion möglichst #strong[geschlossene] Profile.
Zusammenfassung der Abschnitte 5.1–5.4; Quellen stehen dort.])
== TM2 5.1 Die kreiszylindrische Welle <a-tm2-5-1>
Ein #strong[Torsionsmoment] $M_T$ ist ein Moment um die #strong[Längsachse] (x-Achse) des Stabes – Sosnowsky nennt es „Moment um die starke Achse des lokalen Koordinatensystems“ (Skript TM2 S. 601). Beispiele: Antriebswelle, Schraubendreher, Bohrer, Fahrzeugrahmen.
Bei einer runden Welle drehen sich die Querschnitte als Ganzes gegeneinander. Eine gerade Linie auf der Oberfläche wird zur Schraubenlinie. Das ist eine #strong[Schubverzerrung] $gamma$. Über das Hookesche Gesetz für Schub $tau = G gamma$ folgt: Es gibt #strong[nur Schubspannungen], keine Normalspannungen. Sie stehen senkrecht auf dem Radius und wachsen #strong[linear mit dem Abstand $r$] von der Achse. In der Mitte ist $tau = 0$, am Rand ist $tau$ maximal.
#note([In eigenen Worten], [Wringe ein nasses Handtuch aus. Die äußeren Fasern werden stark verdreht und gezerrt, die Mitte kaum. Genauso trägt in der Welle vor allem der #strong[Rand] das Moment – deshalb ist ein Rohr fast so stark wie eine Vollwelle, spart aber viel Material. #text(fill: muted)[(eigene Ergänzung)]])
#note([Zielsetzung (Folie)], [Dickwandige Querschnitte: Schubspannungsverlauf #strong[linear] über den Querschnitt, Schubspannung verläuft in #strong[eine Richtung]. Dünnwandige Querschnitte: Schubspannung #strong[konstant] über die Wanddicke, #strong[umlaufender] Schubspannungsverlauf (Skript TM2 S. 110).])
#heading(level: 3, outlined: false)[Herleitung in drei Schritten (Kinematik – Werkstoff – Gleichgewicht)]
Für die DGL der Torsion braucht man wie bei Zug/Druck: #strong[Gleichgewicht, Kinematik, Werkstoffgesetz] (Skript TM2 S. 355).
+ #strong[Kinematik:] Der Bogen $r thin d theta.alt$ am Umfang ist gleich $gamma thin d x$ → $gamma = r thin frac(d theta.alt, d x) = r thin theta.alt '$. Die Verdrehung pro Länge $theta.alt '$ heißt #strong[Verwindung].
+ #strong[Werkstoffgesetz:] $tau = G gamma = G thin r thin theta.alt '$ → linear in $r$.
+ #strong[Gleichgewicht:] Das Moment aller Schubspannungen ist das Torsionsmoment: $M_T = integral_A r thin tau thin d A = G theta.alt ' integral_A r^2 thin d A = G theta.alt ' I_p$.
#bild("tm2k5_kinematik", [Skript TM2 S. 112: Herleitung Kinematik und polares FTM (Kreiswelle). Ergebnis: $G I_T theta.alt ' = M_T$ und $theta.alt_L = M_T L/(G I_T )$. Auf der Folie heißt der Verdrehwinkel $theta$, in FS und Buch $theta.alt$.], height: 58mm)
#heading(level: 3, outlined: false)[Formeln]
#form[$ tau (r) = frac(M_T, I_T) thin r quad [ frac("N", "mm"^2) ], wide tau_("max") = frac(M_T, I_T) thin R = frac(M_T, W_T) $]
FS (5.2), (5.3), (5.5): Spannungsverteilung und Maximalwert am Rand $r = R$. Einheiten: $M_T$ in Nmm, $I_T$ in mm⁴, $W_T$ in mm³.
#form[$ I_(T,"kr") = I_p = frac(pi, 2) R^4 = frac(pi, 32) d^4 [ "mm"^4 ], wide W_(T,"kr") = frac(I_T, R) = frac(pi, 2) R^3 = frac(pi, 16) d^3 [ "mm"^3 ] $]
FS (5.1), (5.4): Torsionsträgheitsmoment und Torsionswiderstandsmoment des Vollkreises. Nur beim Kreis gilt $I_T = I_p$!
#form[$ theta.alt ' = frac(d theta.alt, d x) = frac(M_T, G thin I_T), wide Delta theta.alt = integral_0^l frac(M_T, G thin I_T) thin d x med attach(=, t: M_T "," thin G I_T thin = thin "const") med frac(M_T thin l, G thin I_T) quad [ "rad" ] $]
FS (5.6)–(5.9) bzw. (5.11)–(5.12): Verwindung und Verdrehwinkel. $G I_T$ = #strong[Torsionssteifigkeit], $G$ = Schubmodul (Stahl ca. $0","8 dot 10^5 upright(N/m m^2 )$).
#bild("tm2k5_formeln_kreis", [Skript TM2 S. 113: $tau_("max") = M_T /W_T$ und $tau = frac(M_T, I_T) r$ („vgl. Biegung“), Anwendung auf Kreiswelle, dickwandiges und dünnwandiges Rohr.], height: 58mm)
#bild("tm2k5_tau_linear", [Skript TM2 S. 362: Schubspannungsverteilung im Vollkreis. $tau$ wächst linear vom Mittelpunkt ($tau = 0$) bis zum Rand ($tau_("max")$) und läuft dort tangential.], height: 40mm)
#note([Fehler auf der Folie (Skript TM2 S. 113 = S. 357/365)], [Dort steht für das dickwandige Rohr $I_p = frac(pi, 2) (R_a - R_i )^4$ und für das dünnwandige Rohr $I_T approx pi thin 2R_m thin t$. Richtig ist (FS S. 39–40, TM2-Buch (5.11), (5.12)):

$ I_T = frac(pi, 2) (R_a^4 - R_i^4 ), wide I_T approx 2 pi R_m^3 thin t . $

Prüfe mit Einheiten: $pi thin 2 R_m t$ hat mm² – ein Trägheitsmoment braucht mm⁴. Und $(R_a - R_i )^4 = t^4$ wäre winzig; man muss die #strong[Kreisflächen] abziehen, also erst hoch 4, dann subtrahieren.], fill: sand)
#heading(level: 3, outlined: false)[Das polare Flächenträgheitsmoment]
Mit $r^2 = y^2 + z^2$ folgt sofort: $I_p = integral r^2 thin d A = integral (y^2 + z^2 ) thin d A = I_y + I_z$. Das polare FTM ist die #strong[Summe der beiden axialen FTM] (bekannt aus Kap. 4 Biegung). Für den Vollkreis rechnet man mit Kreisringen $d A = 2 pi r thin d r$:
#form[$ I_p = integral_0^R r^2 dot 2 pi r thin d r = 2 pi frac(R^4, 4) = frac(pi, 2) R^4 wide (= 2 dot frac(pi, 4) R^4 = I_y + I_z ) $]
#bild("tm2k5_polares_ftm", [Skript TM2 S. 114: Herleitung des polaren FTM, $I_p = I_x + I_y$ (Folie: Achsen x, y), Integration über Kreisringe $d A = 2 pi r thin d r$.], height: 45mm)
#note([Fehler vermeiden (Bezeichnung)], [Die Folie S. 114 schreibt die axialen FTM als $I_x = integral x^2 d A$, $I_y = integral y^2 d A$ und merkt an „Bezeichnungen angepasst: $I_y, I_z$“. In FS und Buch ist $x$ die Stabachse, der Querschnitt liegt in der $y$-$z$-Ebene → $I_p = I_y + I_z$. Gemeint ist dasselbe.], fill: sand)
#heading(level: 3, outlined: false)[Rohre: dickwandig und dünnwandig]
#tab(columns: 4,
 th([Querschnitt], [$I_T$], [$W_T$], [$tau_("max")$ wo?]),
 [Vollkreis (Radius $R$)], [$frac(pi, 2) R^4$], [$frac(pi, 2) R^3$], [am Rand $r = R$],
 [dickwandiges Rohr ($alpha = R_i /R_a$)], [$frac(pi, 2) R_a^4 (1- alpha^4 )$], [$frac(pi, 2) R_a^3 (1- alpha^4 )$], [am äußeren Rand $R_a$],
 [dünnwandiges Rohr ($t << R_m$)], [$2 pi R_m^3 t$], [$2 pi R_m^2 t$], [ganze Wand ($tau$ ≈ konstant)],
)
#note([Merke], [$W_T$ des dickwandigen Rohrs ist $I_T /R_a$, also $frac(pi, 2R_a) (R_a^4 - R_i^4 )$ – #strong[nicht] $frac(pi, 2) (R_a^3 - R_i^3 )$. Widerstandsmomente darf man nicht einfach subtrahieren, Trägheitsmomente schon.])
#heading(level: 3, outlined: false)[Nicht-runde Vollquerschnitte]
Die Herleitung gilt exakt nur für den Kreis. Für andere dickwandige bzw. Vollquerschnitte schlägt die Folie vor, „ersatzweise gut mit dem durch den #strong[Inkreis] beschriebenen runden Ersatzquerschnitt“ zu rechnen (Skript TM2 S. 354). Die FS-Tabelle (aus dem Buch) gibt für Ellipse und Quadrat genauere Werte an, z. B. Quadrat (Seite $a$): $W_T = 0","208 thin a^3$, $I_T = 0","141 thin a^4$, $tau_("max")$ in der #strong[Mitte der Seiten].
#bild("tm2k5_inkreis", [Skript TM2 S. 354: Runder Ersatzquerschnitt (Inkreis) für Rechteck, Ellipse und Quadrat.], height: 45mm)
#note([Widerspruch Folie ↔ Buch], [Die Folie empfiehlt den Inkreis als Ersatz. Das Buch sagt: Für nicht-runde Vollquerschnitte gelten die Kreisformeln #strong[nicht], dort braucht man die Torsionstheorie nach de Saint-Venant; die Ergebnisse stehen in Tab. 5.1 #text(fill: muted)[\[TM2-Buch S. 192–193\]]. Vergleich am Quadrat (Seite $a$, Inkreis $R = a/2$):
- $W_T$: Inkreis $frac(pi, 16) a^3 = 0","196 thin a^3$ ↔ Tabelle $0","208 thin a^3$ → nur 6 % zu klein, also #strong[auf der sicheren Seite] für die Spannung.
- $I_T$: Inkreis $frac(pi, 32) a^4 = 0","098 thin a^4$ ↔ Tabelle $0","141 thin a^4$ → 30 % zu klein, der Verdrehwinkel wird deutlich zu groß berechnet.
Fazit: Wenn die Tabellenwerte (FS S. 39) gegeben sind, nimm sie. Der Inkreis ist nur eine grobe, sichere Abschätzung. #text(fill: muted)[(eigene Ergänzung, Zahlen nachgerechnet)]], fill: sand)
#heading(level: 3, outlined: false)[Beispiel von der Folie: Vollkreis unter Torsion]
#bild("tm2k5_bsp_vollkreis", [Skript TM2 S. 116: Beispiel Vollprofil. Kurbel mit Kräftepaar $F$ im Abstand $2R$, Welle Radius $r$, Länge $L$.], height: 95mm)
#note([Beispiel (Skript TM2 S. 116)], [Geg.: Hebel $R = 200$ mm, Wellenradius $r = 20$ mm, $L = 5$ m, $tau_("zul") = 150 upright(N/m m^2 )$, $G = 0","8 dot 10^5 upright(N/m m^2 )$. Ges.: a) $F_("max")$, b) $Delta theta.alt$ bei $F_("max")$.
+ Torsionsmoment aus dem Kräftepaar: $M_T = 2R F$, konstant über die Länge $L$.
+ $tau_("max") = frac(M_T, W_T) = frac(2R F, pi r^3 /2) = frac(4R F, pi r^3) <= tau_("zul")$ → $F <= frac(pi r^3 thin tau_("zul"), 4R) = frac(pi dot 8000 dot 150, 4 dot 200) "N" = 4712 "N"$ → $F_("max") approx 4","71$ kN.
+ $Delta theta.alt = frac(M_T L, G I_T)$. Trick: $M_T = tau_("max")W_T$ und $W_T /I_T = 1/r$ → $Delta theta.alt = frac(tau_("max")L, G thin r) = frac(150 dot 5000, 0","8 dot 10^5 dot 20) = 0","469 "rad" approx 26","9 degree$ (Folie: 0,47 rad ≙ 27°).
Plausibel? 5 m lange, dünne Welle (40 mm) → großer Winkel. Ja.], fill: pale)
#note([Merke (nützlicher Trick)], [Wenn $tau_("max")$ bekannt ist, gilt beim Kreis $Delta theta.alt = frac(tau_("max") thin l, G thin R)$. Bei gleicher Spannung verdreht sich eine #strong[dünne, lange] Welle stärker.])
#heading(level: 3, outlined: false)[Analogie Zug/Druck ↔ Torsion]
#tab(columns: 3,
 th([], [Zug/Druck (Kap. 1)], [Torsion (Kap. 5)]),
 [Schnittgröße], [$N$], [$M_T$],
 [Spannung], [$sigma = N/A$], [$tau_("max") = M_T /W_T$],
 [Steifigkeit], [$E A$], [$G I_T$],
 [Verformung], [$Delta l = frac(N thin l, E A)$], [$Delta theta.alt = frac(M_T thin l, G I_T)$],
 [DGL], [$(E A u')' = -n$], [$(G I_T theta.alt ')' = -m_T$],
)
#note([Fehler auf der Folie (Skript TM2 S. 361)], [Dort steht „die #strong[Biege]steifigkeit $G I_T$ bei Torsion ersetzt die Dehnsteifigkeit $E A$“ und „#strong[Biege]winkel $theta.alt$ ersetzt die axiale Längenänderung $Delta L$“. Richtig: $G I_T$ ist die #strong[Torsionssteifigkeit] (Biegesteifigkeit ist $E I$) und $theta.alt$ ist der #strong[Verdrehwinkel] (so auch in deiner WZF-Mitschrift 22.06.26 S. 1 und im TM2-Buch S. 172).], fill: sand)
#note([Aus deiner Mitschrift (WZF 22.06.26 S. 1)], [Formeln: $tau_("max") = M_T /W_T$ (FS 5.10); Verwindung = Verdrehung pro Längeneinheit $theta.alt ' = d theta.alt /d x = M_T /(G I_T )$ mit $G$ = Schubmodul, $I_T$ = Torsionsträgheitsmoment, $G I_T$ = Torsionssteifigkeit. Integration von $0$ bis $L$: $Delta theta.alt = theta.alt (L) - theta.alt (0) = frac(M_T L, G I_T)$ für $G I_T =$const und $M_T =$const (FS 5.12).])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Woher kommt Torsion?] Eine schräge Kraft an der Ecke eines Kragträgers erzeugt gleichzeitig Zug, Biegung und Torsion ($M_x = frac(b, 2) F_z - frac(h, 2) F_y$). #text(fill: muted)[\[TM2-Buch S. 169–170\]]
- #strong[Kinematische Annahmen:] Querschnitte drehen sich als Ganzes, bleiben eben (keine Verwölbung) – bei der Kreiswelle exakt erfüllt. #text(fill: muted)[\[TM2-Buch S. 170\]]
- #strong[Vorzeichen:] $theta.alt$ und $M_T$ positiv im Sinn einer Rechtsschraube um die x-Achse am positiven Schnittufer. #text(fill: muted)[\[TM2-Buch S. 171–172\]]
- #strong[Schubspannungen am Rand tangential:] Die Oberfläche ist unbelastet, also gibt es keine radiale Komponente (zugeordnete Schubspannungen). #text(fill: muted)[\[TM2-Buch S. 171\]]
- #strong[Schraubenfeder:] Der Draht wird auf Torsion beansprucht ($M_T = a F$); Federkonstante $c = frac(G d^4, 64 thin a^3 n)$ – weicher mit mehr Windungen $n$ und größerem Wicklungsradius $a$. #text(fill: muted)[\[TM2-Buch S. 175–176\]]
- #strong[Kombination mit Biegung:] Welle mit Querarm → Biegung $sigma$ und Torsion $tau$ an der Einspannung, Dimensionierung mit Vergleichsspannung (GEH), $R_("erf") = 48$ mm. #text(fill: muted)[\[TM2-Buch S. 179–180\]]])
#src[Skript TM2 S. 110–116, 352–357, 361–362, 601; FS TM2 S. 37–40; WZF-Mitschrift 22.06.26 S. 1; TM2-Buch S. 169–180, 192–193.]
== TM2 5.1 (Fortsetzung) DGL der Torsion, Vorgehen und statisch unbestimmte Wellen <a-tm2-5-1-2>
Bisher war $M_T$ über die ganze Welle konstant. Greift aber ein #strong[verteiltes Torsionsmoment] $m_T (x)$ an (Moment pro Länge, Einheit Nmm/mm), dann ändert sich $M_T$ längs $x$. Das Gleichgewicht am Stabelement $d x$ liefert – genau wie $N' = -n$ beim Zugstab:
#form[$ d M_T + m_T thin d x = 0 med => med frac(d M_T, d x) = -m_T, wide "mit " M_T = G I_T theta.alt ' colon quad (G I_T thin theta.alt ')' = -m_T $]
DGL der Torsion (Skript TM2 S. 115; TM2-Buch (5.13), (5.14)). Für $G I_T =$const: $G I_T thin theta.alt '' = -m_T (x)$.
#bild("tm2k5_dgl", [Skript TM2 S. 115: Herleitung der allgemeinen DGL der Torsion am Freikörperbild (FKB) des Elements $d x$.], height: 55mm)
Die DGL ist von #strong[2. Ordnung] → zweimal integrieren → zwei Konstanten $C_1, C_2$. Sie folgen aus zwei Randbedingungen, an jedem Rand eine:
- #strong[Einspannung:] $theta.alt = 0$
- #strong[freies Ende mit Moment $M_x$:] $M_T = G I_T theta.alt ' = M_x$ (ohne Moment: $theta.alt ' = 0$)
#note([In eigenen Worten], [Das ist dasselbe Rezept wie bei der Biegelinie (Kap. 4), nur eine Stufe einfacher: Dort integrierst du viermal ($q -> Q -> M -> w' -> w$), hier nur zweimal ($m_T -> M_T -> theta.alt$). #text(fill: muted)[(eigene Ergänzung)]])
#heading(level: 3, outlined: false)[Allgemeines Vorgehen (FS S. 38–39)]
+ $M_T$ bzw. $M_T (x)$ bestimmen (Schnitt + Momentengleichgewicht um die Stabachse). Bei statischer Unbestimmtheit: Bindung lösen, unbekanntes Moment $X$ einführen.
+ $I_T$ und $W_T$ aus der Geometrie bestimmen (Tabelle FS S. 39–40; ggf. $I_T (x)$, $W_T (x)$).
+ Ungünstigste Stelle: $tau_("max") = M_T /W_T$ dort, wo $M_T /W_T$ am größten ist.
+ Verdrehung: $Delta theta.alt = integral_0^l frac(M_T, G I_T) thin d x$, Sonderfall $frac(M_T l, G I_T)$. Bei stat. Unbestimmtheit: #strong[Verträglichkeitsbedingung] für $theta.alt$ → $X$.
#bild("tm2k5_fs_tab1", [FS TM2 S. 39: Tabelle (aus Gross/Hauger/Schröder/Wall) mit $W_T$, $I_T$ und Ort von $tau_("max")$ für Vollkreis, Ellipse, Quadrat und dickwandiges Kreisrohr.], height: 45mm)
#heading(level: 3, outlined: false)[Beispiel von der Folie: beidseitig eingespannte Welle (statisch unbestimmt)]
#bild("tm2k5_stat_unbest", [Skript TM2 S. 359 (Aufgabe nach Gross et al., Formel- und Aufgabensammlung TM2): Welle der Länge $L = a + b$, beidseitig eingespannt, auf dem Stück $b$ durch $m_0$ belastet. Rechts: Momentenverlauf und Verdrehwinkel. Achsenende ist mit „b“ beschriftet – gemeint ist $x = L$.], height: 80mm)
#note([Beispiel (Skript TM2 S. 359)], [Ges.: Verlauf von $M_T (x)$ und $theta.alt (x)$. Streckenmoment ab $x = a$: $m_T (x) = m_0 chevron.l x-a chevron.r^0$ (Föppl-Klammer, „schaltet“ bei $x = a$ ein).
+ DGL: $G I_T theta.alt '' = -m_0 chevron.l x-a chevron.r^0$
+ 1. Integration: $G I_T theta.alt ' = -m_0 chevron.l x-a chevron.r + C_1$
+ 2. Integration: $G I_T theta.alt = - frac(m_0, 2) chevron.l x-a chevron.r^2 + C_1 x + C_2$
+ RB $theta.alt (0) = 0$: Klammer ist 0 (da $0 - a < 0$) → $C_2 = 0$.
+ RB $theta.alt (L) = 0$: $- frac(m_0, 2) b^2 + C_1 L = 0$ → $C_1 = frac(m_0 b^2, 2L)$.
+ Momentenverlauf: $M_T (x) = G I_T theta.alt ' = frac(m_0 b^2, 2L) - m_0 chevron.l x-a chevron.r$. Links konstant $+ frac(m_0 b^2, 2L)$, ab $a$ linear fallend bis $M_T (L) = - frac(m_0 b(a+L), 2L)$.
+ Verdrehwinkel: links linear ($tilde.op x$), ab $a$ parabelförmig ($tilde.op -x^2$) mit #strong[tangentialem Übergang] bei $a$; Maximum dort, wo $M_T = 0$.
Kontrolle: Die beiden Einspannmomente zusammen müssen das Gesamtmoment $m_0 b$ aufnehmen: $frac(m_0 b^2, 2L) + frac(m_0 b(a+L), 2L) = frac(m_0 b(b + a + L), 2L) = m_0 b$. ✓], fill: pale)
#note([Zahlenbeispiel], [#text(fill: muted)[(eigene Ergänzung)]: $a = b = 1$ m, $L = 2$ m, $m_0 = 100$ Nmm/mm. Dann $M_T$ links $= frac(100 dot 1000^2, 2 dot 2000) = 25 thin 000$ Nmm = 25 Nm, rechts $M_T (L) = -75$ Nm. Größter Verdrehwinkel bei $M_T = 0$: $x = a + frac(b^2, 2L) = 1","25$ m. Die rechte Einspannung (näher an der Last) trägt 3/4 des Moments.], fill: pale)
#note([Fehler vermeiden (typische Fehler)], [- Föppl-Klammer: $chevron.l x-a chevron.r^n = 0$ für $x < a$ – sonst bekommst du falsche Konstanten.
- Bei Wellen mit mehreren Abschnitten (abgesetzte Welle, verschiedene $G I_T$) braucht jeder Abschnitt eigene Konstanten plus #strong[Übergangsbedingungen]: gleicher Winkel und gleiches Moment an der Stoßstelle.
- Statisch unbestimmt heißt: Gleichgewicht allein reicht nicht – du brauchst die Verformung ($theta.alt$ an beiden Einspannungen = 0).], fill: sand)
#heading(level: 3, outlined: false)[Übungsaufgaben zur Kreiswelle (Übung 12)]
#note([Übung 12.1 (Skript TM2 S. 617, Lösung Übung 12 S. 1–2)], [Stahlwelle, $M_T = 1800$ Nm, $G = 80 thin 000 upright(N/m m^2 )$. Bedingungen: a) $tau < tau_("zul") = 45 upright(N/m m^2 )$, b) $theta.alt ' < 0","25 degree/ "m"$.
+ a) $tau_("max") = frac(16 M_T, pi d^3)$ → $d = root(3, frac(16 dot 1","8 dot 10^6, pi dot 45)) = 58","84$ mm.
+ b) $theta.alt ' = frac(32 M_T, G pi d^4)$. Einheiten! $0","25 degree/ "m" = 0","25 dot frac(pi, 180) dot 10^(-3) "rad/mm"$ → $d = root(4, frac(32 M_T, G pi theta.alt ')) = 85","13$ mm.
+ Maßgebend ist der #strong[größere] Durchmesser: $d = 85","13$ mm (Steifigkeit entscheidet!).
+ c) Hohlwelle, Wand $t = 10$ mm: benötigt $W_T = M_T / tau_("zul") = 40 thin 000 upright(m m^3 )$ und $I_T = M_T /(G theta.alt ') = 5","157 dot 10^6 upright(m m^4 )$. \
  
  dünnwandig: $R_m = sqrt(W_T /(2 pi t)) = 25","23$ mm → $d_a = 60","46$ mm; $R_m = root(3, I_T /(2 pi t)) = 43","46$ mm → $d_a = 96","92$ mm. \
  
  dickwandig (durch Probieren): $d_a approx 64$ mm bzw. $96","6$ mm.
Materialvergleich #text(fill: muted)[(eigene Ergänzung)]: Vollwelle $A = frac(pi, 4) 85","13^2 approx 5690 upright(m m^2 )$, Hohlwelle ($d_a = 96","6$, $t = 10$) $A approx 2720 upright(m m^2 )$ – #strong[weniger als die Hälfte] an Stahl für dieselbe Steifigkeit.], fill: pale)
#note([Übung 12.2 (Skript TM2 S. 617, Lösung Übung 12 S. 3): konischer Stab.], [Eingespannt bei $x = 0$ mit Radius $2r$, am Ende $x = l$ Radius $r$: $R(x) = r(2 - x/l)$. Dann sind $I_T (x) = frac(pi, 2) r^4 (2- frac(x, l) )^4$ und $W_T (x)$ #strong[Funktionen von $x$]:
- Randspannung: $tau (x) = frac(2M_T, pi r^3 (2 - x/l)^3)$ → größte Spannung am dünnen Ende.
- Verdrehung: $theta.alt (x) = integral frac(M_T, G I_T (x)) d x$ mit RB $theta.alt (0) = 0$: $theta.alt (x) = frac(2 M_T l, 3 G pi r^4) [ frac(1, (2 - x/l)^3) - frac(1, 8) ]$.], fill: pale)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Randbedingungen:] an jedem Rand entweder $theta.alt$ oder $M_T = G I_T theta.alt '$ vorgegeben. #text(fill: muted)[\[TM2-Buch S. 174–175\]]
- #strong[Superposition bei mehreren Einzelmomenten:] Stab mit $M_0$ und $M_1$: Endverdrehung = Summe der Verdrehungen der Abschnitte; $theta.alt_C = 0$ für $M_1 = - frac(2, 3) M_0$. #text(fill: muted)[\[TM2-Buch S. 176–177\]]
- #strong[Abgesetzte, beidseitig eingespannte Welle] mit verteiltem $m_T$: abschnittsweise Integration, 4 Konstanten aus 2 Rand- und 2 Übergangsbedingungen. #text(fill: muted)[\[TM2-Buch S. 177–178\]]
- #strong[Rahmen mit Torsion und Biegung] (statisch unbestimmt, Superposition „0“- und „1“-System, Verträglichkeit $w_B = 0$). #text(fill: muted)[\[TM2-Buch S. 194–195\]]])
#src[Skript TM2 S. 115, 355, 358–359, 361, 617–618; FS TM2 S. 38–39; Lösung Übung 12 S. 1–3; TM2-Buch S. 174–178, 194–195.]
== TM2 5.2 Dünnwandige geschlossene Profile <a-tm2-5-2>
Bei dünnwandigen Querschnitten (Rohr, Kastenprofil, Hohlprofil) gilt der lineare Spannungsverlauf nicht mehr: „Der Spannungsverlauf muss sich nach der Form des Querschnitts richten“ (Skript TM2 S. 118). Die Wand ist so dünn, dass man annimmt: $tau$ ist #strong[über die Wanddicke konstant] und läuft #strong[tangential] entlang der Profilmittellinie einmal ganz herum. „Geschlossen“ heißt: Der Umlauf ist geschlossen – auch Hohlprofile mit Ecken sind geschlossene Profile.
Man fasst $tau$ und $t$ zum #strong[Schubfluss] zusammen: $T = tau dot t$ (Einheit N/mm, Kraft pro Länge). Das Gleichgewicht am Wandelement zeigt: #strong[Der Schubfluss ist überall gleich groß.] Wo die Wand dünn ist, muss $tau$ also größer sein.
#note([In eigenen Worten], [Wasser in einem geschlossenen Ringkanal: Durch jeden Querschnitt fließt pro Sekunde dieselbe Menge. Wo der Kanal eng ist (kleines $t$), fließt es schneller (großes $tau$). Der Schubfluss $T$ ist die „Durchflussmenge“, $tau$ die „Fließgeschwindigkeit“. #text(fill: muted)[(eigene Ergänzung)]])
#bild("tm2k5_beispiele_duenn", [Skript TM2 S. 370: Beispiele für dünnwandige Querschnitte (Rechteckrohr, Lochprofil, C-Schiene, U- und Z-Profil). Nur das Rechteckrohr ist geschlossen.], height: 45mm)
#bild("tm2k5_schubfluss", [Skript TM2 S. 119: Torsion dünnwandig geschlossener Profile. Außen- und Innenfläche belastungsfrei → Schub an der Oberfläche tangential, im Inneren tangential und konstant → Schubfluss $T = tau dot t$.], height: 70mm)
#heading(level: 3, outlined: false)[Warum ist der Schubfluss konstant?]
Freischnitt eines Wandelements $d x times d s$ (Skript TM2 S. 120):
- Gleichgewicht in $s$-Richtung: $(T + frac(partial T, partial x) d x)d s - T thin d s = 0$ → $frac(partial T, partial x) = 0$: konstant #strong[längs der Stabachse].
- Gleichgewicht in $x$-Richtung: $(T + frac(partial T, partial s) d s)d x - T thin d x = 0$ → $frac(partial T, partial s) = 0$: konstant #strong[rund um das Profil].
- Voraussetzung: keine Normalspannungen $N = 0$ ≙ #strong[keine (behinderte) Verwölbung].
#bild("tm2k5_gg_element", [Skript TM2 S. 120: Gleichgewicht am Element. „Schubfluss rund um das Profil ist konstant“: $T = tau dot t =$konst.], height: 60mm)
#heading(level: 3, outlined: false)[1. Bredtsche Formel]
Der Schubfluss auf dem Wegstück $d s$ erzeugt das Moment $d M_T = r_(perp) T thin d s$. Einmal rundherum integriert: $M_T = T integral.cont r_(perp) d s$. Und $r_(perp) d s$ ist die doppelte Fläche des kleinen Dreiecks → $integral.cont r_(perp) d s = 2A_m$.
#form[$ M_T = 2A_m thin T quad => quad tau = frac(T, t) = frac(M_T, 2A_m thin t), wide tau_("max") = frac(M_T, W_T), quad W_T = 2A_m thin t_("min") [ upright(m m^3 ) ] $]
1. Bredtsche Formel, FS (5.13), Skript TM2 S. 121. $A_m$ = Fläche, die die #strong[Profilmittellinie] einschließt. $tau_("max")$ tritt bei der kleinsten Wanddicke $t_("min")$ auf.
#bild("tm2k5_bredt1", [Skript TM2 S. 121: Zusammenhang Schubfluss und Torsionsmoment, 1. Bredtsche Regel; Konsequenzen: $tau_("max")$ bei $t_("min")$, $W_T = 2A_m t$. Rot auf der Folie: „Achtung: im Allgemeinen gilt $A_m != A$!“], height: 58mm)
#note([Fehler vermeiden (typische Fehler)], [- $A_m$ ist die #strong[eingeschlossene] Fläche bis zur Wandmitte – #strong[nicht] die Materialfläche $A$ des Querschnitts und nicht die Außenfläche. Beim Kasten $c times c$ mit Mittellinienmaß $c$: $A_m = c^2$.
- In $W_T$ steht $t_("min")$ – beim offenen Profil (5.3) ist es dagegen $t_("max")$. Nicht verwechseln!
- Die Folie schreibt $W_T = 2A_m thin t$ (für konstante Wanddicke). Bei veränderlicher Wanddicke immer $t_("min")$ einsetzen (FS (5.13), TM2-Buch (5.21)).], fill: sand)
#heading(level: 3, outlined: false)[2. Bredtsche Formel]
Für die Verdrehung braucht man die Kinematik: Ein Punkt der Mittellinie verschiebt sich tangential um $d v = r_(perp) d theta.alt$. Mit $tau = G gamma$, $gamma = frac(partial v, partial x) + frac(partial u, partial s)$ und der Bedingung, dass beim #strong[geschlossenen] Profil die Längsverschiebung nach einem Umlauf wieder gleich ist ($integral.cont frac(partial u, partial s) d s = u_E - u_A = 0$), folgt:
#form[$ theta.alt ' = frac(M_T, G thin I_T), wide I_T = frac((2A_m )^2, integral.cont frac(d s, t)) [ upright(m m^4 ) ], wide t = "const:" I_T = frac((2A_m )^2 thin t, U) $]
2. Bredtsche Formel, FS (5.14), Skript TM2 S. 122. $integral.cont d s/t$ = Summe „Länge durch Dicke“ aller Wandstücke entlang der Mittellinie; $U$ = Umfang der Mittellinie.
#bild("tm2k5_bredt2", [Skript TM2 S. 122: Verformung ohne Verwölbung, $d v = r_(perp) d theta.alt$, Schubverzerrung, 2. Bredtsche Regel und Torsionsträgheitsmoment $I_T = (2A_m )^2 / integral.cont frac(d s, t)$.], height: 58mm)
#note([Merke], [Für das dünnwandige Kreisrohr ($A_m = pi R_m^2$, $U = 2 pi R_m$) liefern beide Bredt-Formeln genau die Rohrwerte aus 5.1: $W_T = 2 pi R_m^2 t$, $I_T = frac((2 pi R_m^2 )^2 t, 2 pi R_m) = 2 pi R_m^3 t$. Gute Kontrolle!])
#bild("tm2k5_fs_tab2", [FS TM2 S. 40: $W_T$ und $I_T$ für dünnwandige geschlossene Hohlquerschnitte, das dünnwandige Kreisrohr, das schmale Rechteck und aus schmalen Rechtecken zusammengesetzte (offene) Profile.], height: 45mm)
#heading(level: 3, outlined: false)[Beispiele]
#note([Aus deiner Mitschrift (WZF 11.05.26 S. 1–2, „7. Übung TM2: Zweiachsiger Spannungszustand“)], [Dünnwandiger Behälter mit Innendruck $p$ und Torsionsmoment $M_t$; mittlerer Radius $r = 10$ mm, Wanddicke $t = 1$ mm, $p = 10 upright(N/m m^2 )$, $M_t = 31 thin 420$ Nmm. Kesselformeln (FS 2.20): $sigma_x = frac(p r, 2t) = 50 upright(N/m m^2 )$, $sigma_y = frac(p r, t) = 100 upright(N/m m^2 )$. Torsion (FS 2.19): $tau_("xy") = - frac(M_t, 2 pi r dot t dot r) = - frac(31 thin 420, 2 pi dot 10^2 dot 1) = -50 upright(N/m m^2 )$ (Vorzeichen aus der Skizze: $tau$ am positiven Schnittufer entgegen der positiven Richtung). Danach Hauptspannungen, Schweißnahtrichtung, Vergleichsspannungen (→ Kap. 2).
 \
#emph[Hinweis:] In deiner Mitschrift steht „$M_t = 31420 upright(N/m m^2 )$“ – die Einheit eines Moments ist Nmm, nicht N/mm². Mit Nmm geht die Rechnung auf.])
#bild("tm2k5_wzf_rohr", [WZF-Mitschrift 11.05.26 S. 1: Dünnwandiger Behälter, eingespannt, mit Innendruck $p$ und Torsionsmoment $M_t$.], height: 45mm)
#note([Merke], [FS (2.19) $tau = frac(M_t, 2 pi r_m^2 t)$ ist nichts anderes als die 1. Bredtsche Formel für das Kreisrohr: $A_m = pi r_m^2$ → $tau = frac(M_t, 2A_m t)$.])
#note([Übung 7.1 b) (Kernlochbohrer, Lösung Übung 7 S. 1)], [Dünnwandiges Rohr, $d_m = 100$ mm, $t = 2$ mm, $M_t = 0","943$ kNm. Die Umfangskraft $M_t /r_m$ verteilt sich auf die Ringfläche $d_m pi t$:
$tau = frac(M_t /r_m, d_m pi t) = frac(943 dot 10^3 /50, 100 dot pi dot 2) = +30 upright(N/m m^2 )$. Zusammen mit $sigma_x = -20 upright(N/m m^2 )$ aus der Anpresskraft → ebener Spannungszustand (Kap. 2). Gleiches Ergebnis mit Bredt: $tau = frac(M_t, 2 pi r_m^2 t)$.], fill: pale)
#note([Beispiel (WZF 22.06.26 S. 2–3, Teil b): dünnwandiger Kasten.], [Quadratischer Kasten, Mittellinienmaß $c$, Wanddicke oben $2d$, sonst $d$, mit $d = 0","1c$.
+ $A_m = c^2$, $t_("min") = d = 0","1c$ → $W_T = 2A_m t_("min") = 2c^2 dot 0","1c = 0","2 thin c^3$.
+ $integral.cont frac(d s, t) = frac(c, 2d) + frac(c, d) + frac(c, d) + frac(c, d) = frac(7c, 2d)$.
+ $I_T = frac((2c^2 )^2, 7c/(2d)) = frac(8c^3 d, 7) = frac(8 dot 0","1, 7) c^4 = 0","114 thin c^4$.
+ $tau_("max")$ an der Stelle der #strong[kleinsten Wanddicke] $t_("min")$ (Seiten und unten).
Erstaunlich: $W_T$ ≈ $0","208c^3$ des #strong[vollen] Quadrats und $I_T$ ≈ 80 % davon – bei nur etwa der halben Materialfläche ($approx 5c d = 0","5c^2$). #text(fill: muted)[(eigene Ergänzung)]], fill: pale)
#note([Übung 13.2 c)–d) (Lösung Übung 13 S. 6)], [Geschlossenes Profil (Rechteck mit Dach, „Haus“-Form): $A_m = 25 dot 47","5 + frac(1, 2) dot 25 dot 12","5 = 1343","75 upright(m m^2 )$; $integral.cont frac(d s, t) = frac(47","5+25+47","5, 5) + frac(2 dot 17","68, 3","536) = 34$ → $I_T = frac((2 dot 1343","75)^2, 34) = 212 thin 431 upright(m m^4 )$; $W_T = 2 dot 1343","75 dot 3","536 = 9503 upright(m m^3 )$. $tau_("max")$ im dünnen Querschnitt, also im „Dach“.], fill: pale)
#note([Klausurbezug], [In einer Altklausur (Muster) wurde genau so gefragt: „Ist das Profil als offen oder geschlossen zu betrachten?“ → $W_T = 2A_m t_("min")$ und $I_T = (2A_m )^2 / integral.cont frac(d s, t)$ mit Formel und Zahl → Querschnittsverdrehung $Delta theta.alt$ #strong[in Grad] → Ort und Größe von $tau_("max")$ mit Begründung („$M_T =$const, $t =$const → ganzer Umfang über die ganze Länge“).], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Praxis:] Kastenträger im Brückenbau, Tragflächenprofile in der Luftfahrt sind dünnwandige geschlossene Profile. #text(fill: muted)[\[TM2-Buch S. 180\]]
- #strong[Annahmen:] $tau$ konstant über $t$; keine Normalspannungen in $x =$const; Querschnittsform bleibt erhalten; die #strong[Verwölbung] (Verschiebung in x-Richtung) kann sich frei einstellen. Wird sie behindert, entstehen Normalspannungen → Wölbkrafttorsion (nicht behandelt). #text(fill: muted)[\[TM2-Buch S. 183\]]
- #strong[Verwölbung des Kastenträgers:] verläuft linear längs der Seiten; sie verschwindet für $h/t_h = b/t_b$ – ein dünnwandiger #strong[quadratischer] Kasten mit konstanter Wanddicke verwölbt sich nicht (gilt nicht für den Vollquerschnitt). #text(fill: muted)[\[TM2-Buch S. 186–187\]]
- #strong[Brückenelement] mit trapezförmigem Kasten, exzentrische Last $F$: $M_T = b F$, $A_m = frac(3, 2) b^2$, $tau_("max") = frac(F, 3b t)$; Absenkung = Anteil Torsion $b thin theta.alt_l$ + Anteil Biegung $frac(F l^3, 3E I)$. #text(fill: muted)[\[TM2-Buch S. 187–189\]]])
#src[Skript TM2 S. 118–122, 370; FS TM2 S. 15, 40–41; WZF-Mitschrift 11.05.26 S. 1–2; WZF-Mitschrift 22.06.26 S. 2–4; Übung 7 Aufg. 7.1, Lösung Übung 7 S. 1; Lösung Übung 13 S. 6; Altklausur (PrüfungenTM2.pdf S. 29); TM2-Buch S. 180–189.]
== TM2 5.3 Dünnwandige offene Profile <a-tm2-5-3>
#note([In eigenen Worten], [Schneidet man ein geschlossenes Rohr der Länge nach auf, kann der Schubfluss nicht mehr „rundherum“ laufen. Er muss in jeder Wand #strong[hin und wieder zurück] laufen: auf der einen Wandseite nach vorn, auf der anderen nach hinten. Der Hebelarm dieser beiden Ströme ist nur ein Bruchteil der Wanddicke. Darum trägt ein offenes Profil fast kein Torsionsmoment und verdreht sich sehr stark. #text(fill: muted)[(eigene Ergänzung)]])
#note([Alltagsvergleich #text(fill: muted)[(eigene Ergänzung)]], [Eine Papprolle aus der Küchenrolle lässt sich kaum verdrehen. Schneidest du sie der Länge nach auf, kannst du sie mit zwei Fingern verwinden. Material und Form sind fast gleich, nur der Schlitz ist neu.])
#heading(level: 3, outlined: false)[Herleitung am schmalen Rechteck]
#bild("tm2k5_offen_herl", [Skript TM2 S. 123: schmales Rechteck (Höhe $h$, Dicke $t$). Die Schubspannung wächst linear über die Dicke, $tau(y) = frac(tau_0, t\/2) y$. Man denkt sich das Rechteck aus ineinander geschachtelten dünnen „Rohren“ mit $A_m = 2 y h$ und addiert deren Momente $d M_T = 2 A_m d T$. Ergebnis (rot): $M_T = frac(1, 3) tau_0 h t^2$.], height: 62mm)
Jedes dieser gedachten Rohre ist geschlossen. Für ein Rohr gilt Bredt: $d M_T = 2 A_m thin d T$ mit $d T = tau(y) thin d y$. Integriert von der Mitte ($y = 0$) bis zum Rand ($y = t\/2$) ergibt sich das Moment des ganzen Rechtecks.
#bild("tm2k5_offen_wt", [Skript TM2 S. 124: $tau_("max")$ am Rand, $W_T = frac(1, 3) h t^2$; $I_T$ aus $d I_T = frac(4 (2 A_m h)^2, 2 h\/d y) = 8 h y^2 d y$, also $I_T = frac(1, 3) h t^3$. Rechts unten die Formeln für zusammengesetzte Profile.], height: 62mm)
#form[$ W_T = frac(1, 3) h t^2, wide I_T = frac(1, 3) h t^3 wide "(schmales Rechteck, FS 5.15)" $]
#form[$ I_T approx frac(1, 3) sum_i h_i t_i^3, wide W_T approx frac(I_T, t_("max")) = frac(1, 3) frac(sum_i h_i t_i^3, t_("max")) wide "(zusammengesetzt, FS 5.16)" $]
Einheiten: $I_T$ in mm#super[4], $W_T$ in mm#super[3]. $h_i$ ist die Länge der Mittellinie eines Teilrechtecks, $t_i$ seine Dicke.
#bild("tm2k5_fs_offen", [FS TM2 S. 41: links ein schmales Rechteck mit dem Schubfluss, der in der Wand hin und zurück läuft (rot: „„Fluß“ von $tau$ (geschlossen?)“), rechts ein aus Rechtecken zusammengesetztes offenes Profil (Teile $h_1$, $h_2$, $h_3$ mit Mittellinie). Darunter (5.15) und (5.16).], height: 70mm)
#note([Merke], [- Offen: $tau_("max")$ im Teil mit der #strong[größten] Wanddicke $t_("max")$.
- Geschlossen: $tau_("max")$ an der Stelle mit der #strong[kleinsten] Wanddicke $t_("min")$.
- $I_T$ geht mit $t^3$: Eine doppelt so dicke Wand ist 8-mal so steif.
- Gekrümmte Teile (z. B. geschlitztes Rohr) rechnet man abgewickelt als Rechteck, beim Kreisrohr mit $h = 2 pi R_m$. #text(fill: muted)[\[TM2-Buch S. 191\]]])
#note([Achtung: typische Fehler], [- $t^2$ und $t^3$ verwechseln: $W_T$ hat $t^2$, $I_T$ hat $t^3$.
- Bei $W_T$ durch $t_("max")$ teilen, nicht durch $t_("min")$ (das ist die Regel für geschlossene Profile).
- Ein Profil mit Schlitz ist #strong[offen], auch wenn der Schlitz winzig ist. Prüfe zuerst: Kann der Schubfluss einmal rundherum laufen?
- Die Teilrechtecke nicht doppelt zählen: An Ecken die Mittellinienlängen nehmen.], fill: sand)
#heading(level: 3, outlined: false)[Beispiel von der Folie: geschlossen ↔ offen]
#bild("tm2k5_vergleich_og", [Skript TM2 S. 125: Stab ($L = 5000$ mm) unter Torsion. Links das geschlossene Kastenprofil (Seite $a$, zwei Wände $2t$, zwei Wände $t$), rechts dasselbe Profil mit Schlitz (offen). Gegeben $a = 200$ mm, $t = 2$ mm, $tau_("zul") = 40 thin "N/mm"^2$, $G = "0,8" dot 10^5 thin "N/mm"^2$.], height: 90mm)
#note([Beispiel (Skript TM2 S. 125)], [Gesucht: zulässiges Moment $M_(T "zul") = tau_("zul") W_T$ und die Verdrehung $Delta theta.alt = frac(M_(T "zul") L, G I_T)$.
+ #strong[Geschlossen:] $A_m = a^2$, $integral.cont frac(d s, t) = 2 (frac(a, 2t) + frac(a, t)) = frac(3a, t)$ → $I_T = frac(4 a^4, 3a\/t) = frac(4, 3) t a^3$; $W_T = 2 A_m t_("min") = 2 a^2 t = 160 thin 000 thin "mm"^3$ → $M_(T "zul") = "6,4" dot 10^6$ Nmm $= 6400$ Nm; $Delta theta.alt = frac(3 tau_("zul") L, 2 G a) = "0,0188" "rad" approx "1,07"°$.
+ #strong[Offen:] $I_T = frac(1, 3) sum h_i t_i^3 = frac(1, 3) (2 a (2t)^3 + 2 a t^3) = 6 a t^3$; $W_T = I_T \/ t_("max") = 3 a t^2 = 2400 thin "mm"^3$ → $M_(T "zul") = 96 thin 000$ Nmm $= 96$ Nm; $Delta theta.alt = frac(tau_("zul") L, G thin t_("max")) = "0,625" "rad" approx "35,8"°$.
Ergebnis: Der Schlitz senkt das tragbare Moment auf $1\/67$, und schon dabei verdreht sich der offene Stab 33-mal so stark. (Alle Zahlen nachgerechnet.)], fill: pale)
#note([Fehler auf der Folie (Skript TM2 S. 125)], [Die Momente stehen dort als „6400 mN“ und „96 mN“. Richtig ist #strong[Nm] (Newtonmeter). „mN“ wäre Millinewton, also eine Kraft. Beim Schubmodul ist der Exponent schwer lesbar: Mit $G = "0,8" dot 10^5 thin "N/mm"^2$ ergeben sich genau die Winkel der Folie.], fill: sand)
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- #strong[Herleitung] wie auf der Folie über ineinander geschachtelte Hohlquerschnitte mit $A_m approx 2 y h$; Ergebnis (5.31) $W_T = frac(1, 3) h t^2$, (5.32) $I_T = frac(1, 3) h t^3$, (5.33)–(5.34) für zusammengesetzte Profile. #text(fill: muted)[\[TM2-Buch S. 189–191\]]
- #strong[Vollquerschnitte] (Quadrat, Ellipse): Hier gelten weder die Kreis- noch die Dünnwand-Formeln. Man braucht die Theorie nach de Saint-Venant; die Ergebnisse stehen in Tab. 5.1. #text(fill: muted)[\[TM2-Buch S. 191–193\]]
- #strong[Beispiel 5.5:] geschlossenes ↔ geschlitztes dünnwandiges Rohr (gleiche Länge, gleicher Werkstoff, gleiches Moment). $frac(tau_("max",g), tau_("max",o)) = frac(1, 3) frac(t, R_m)$ und $frac(theta.alt_g, theta.alt_o) = frac(1, 3) (frac(t, R_m))^2$. Fazit des Buches: Bei Torsion nach Möglichkeit geschlossene Profile verwenden. #text(fill: muted)[\[TM2-Buch S. 191, 193\]]])
#src[Skript TM2 S. 123–125; FS TM2 S. 41; Lösung Übung 12 S. 4; TM2-Buch S. 189–193.]

== TM2 5.4 Vergleich der Querschnitte <a-tm2-5-4>
#note([In eigenen Worten], [Für dasselbe Moment kann man ganz verschiedene Querschnitte nehmen. Die Frage ist: Welcher braucht am #strong[wenigsten Material]? Bei Torsion wirkt vor allem das Material weit außen. Ein dünnwandiges, geschlossenes Rohr legt fast das ganze Material nach außen und ist darum am sparsamsten. Ein offenes Profil ist das Gegenteil. #text(fill: muted)[(eigene Ergänzung)]])
#bild("tm2k5_vergleich_qs", [Skript TM2 S. 127: Vergleich von vier Profilen für $M_T = 12 dot 10^3$ Nm und $tau_("zul") = 50 thin "N/mm"^2$, gesucht der kostengünstigste Querschnitt. Spalten: Profil, $W_T$, charakteristische Länge, Fläche.], height: 62mm)
#tab(columns: 4,
 th([Profil], [$W_T$], [Maß], [Fläche $A$]),
 [Vollkreis, Radius $a$], [$frac(pi, 2) a^3$], [$a = "53,5"$ mm], [$"89,9" thin "cm"^2$],
 [Vollquadrat, Seite $2b$], [$"0,208" dot 8 b^3$], [$b = "52,4"$ mm], [$"109,8" thin "cm"^2$],
 [Rohr geschlossen, $t = c\/10$], [$2 pi c^2 t = frac(pi, 5) c^3$], [$c = "72,6"$ mm], [$"33,1" thin "cm"^2$],
 [Rohr geschlitzt, $t = d\/10$], [$frac(2 pi, 3) d t^2$], [$d = "225,4"$ mm], [$"319,2" thin "cm"^2$],
)
Das geschlossene Rohr braucht nur ein Drittel des Materials der Vollwelle. Das geschlitzte Rohr braucht rund zehnmal so viel wie das geschlossene. (Werte der Folie nachgerechnet; kleine Abweichungen durch Rundung.)
#heading(level: 3, outlined: false)[Beispiel aus der Übung (WZF 22.06.26)]
#bild("tm2k5_wzf_bsp_quer", [WZF-Mitschrift 22.06.26 S. 2: Kragarm der Länge $L$ mit Torsionsmoment $M_T$ am Ende; gegeben $M_T$, $G$, $L$; gesucht $tau_("max")$ und $Delta theta.alt$ für a) Vollquerschnitt $c times c$, b) dünnwandigen geschlossenen Kasten (Wanddicke oben $2d$, sonst $d$, $d = "0,1" c$), c) denselben Kasten mit Schlitz in der unteren Wand.], height: 95mm)
#bild("tm2k5_w2206_loes", [WZF-Mitschrift 22.06.26 S. 3: Lösung zu a) $W_T = "0,208" c^3$, $I_T = "0,141" c^4$, $tau_("max")$ in der Mitte der Seiten; zu b) $A_m = c^2$, $W_T = 2 A_m t_("min") = "0,2" c^3$, $integral.cont d s\/t = frac(c, 2d) + 3 frac(c, d)$, $I_T = "0,114" c^4$.], height: 110mm)
#bild("tm2k5_wzf_schubfluss", [WZF-Mitschrift 22.06.26 S. 4: oben der Schubfluss im geschlossenen Kasten ($tau_("max")$ an der kleinsten Wanddicke $t_("min")$); Mitte Teil c) mit Schlitz, $W_T = frac(1, 3) frac(sum h_i t_i^3, t_("max"))$ mit $t_("max") = 2d$; unten der Schubfluss im offenen Kasten ($tau_("max")$ in der Wand mit $t_("max")$).], height: 110mm)
#bild("tm2k5_w2206_it", [WZF-Mitschrift 22.06.26 S. 5: $I_T = frac(1, 3) sum h_i t_i^3 = frac(1, 3) (frac(c, 2) d^3 + c d^3 + c (2d)^3 + c d^3 + frac(c, 2) d^3) = frac(11, 3) c d^3$, mit $d = "0,1" c$: „$I_T = "0,00367" c^3$ (≈ 3,22 % von $I_T (a)$)“.], height: 32mm)
#note([Beispiel (WZF 22.06.26 S. 2–5)], [#tab(columns: 4,
 th([], [$W_T$], [$I_T$], [Ort von $tau_("max")$]),
 [a) Vollquadrat], [$"0,208" c^3$], [$"0,141" c^4$], [Rand, Mitte der Seiten],
 [b) Kasten geschlossen], [$"0,2" c^3$], [$"0,114" c^4$], [Wände mit $t_("min") = d$],
 [c) Kasten geschlitzt], [$frac(11, 6) c d^2 = "0,0183" c^3$], [$frac(11, 3) c d^3 = "0,00367" c^4$], [obere Wand ($t_("max") = 2d$)],
)
Bei c) zählt die untere Wand als zwei Teile der Länge $c\/2$ (links und rechts vom Schlitz). Dann gilt $tau_("max") = M_T\/W_T$ und $Delta theta.alt = M_T L\/(G I_T)$ für jeden Fall.], fill: pale)
#note([Hinweise zur Mitschrift (WZF 22.06.26 S. 4–5)], [- „$I_T = "0,00367" dot c^3$“: Ein Torsionsträgheitsmoment hat die Einheit Länge#super[4]. Richtig ist $"0,00367" thin c^4$.
- Die Prozentangaben „≈ 9,12 % von $W_T (a)$“ und „≈ 3,22 % von $I_T (a)$“ passen nicht zu a). Sie vergleichen mit #strong[b)]: $"0,01833"\/"0,2" = "9,2" %$ und $"0,00367"\/"0,114" = "3,2" %$. Bezogen auf a) sind es $"8,8" %$ und $"2,6" %$. Die Aussage bleibt gleich: Der Schlitz macht das Profil rund 10-mal schwächer und rund 30-mal weicher.], fill: sand)
#note([Merke], [Für Torsion: #strong[geschlossen und dünnwandig] ist am sparsamsten. Ein Schlitz zerstört die Torsionssteifigkeit fast völlig. Ein dünnwandiger Kasten erreicht mit der Hälfte des Materials fast dieselben Werte wie der Vollquerschnitt.])
#bild("tm2k5_lkw_rahmen", [Skript TM2 S. 382: Fahrgestell eines Lkw (Leiterrahmen aus offenen Längsträgern mit Querträgern), Bildquelle auf der Folie: zuckerfabrik24.de.], height: 50mm)
#note([Praxisbezug #text(fill: muted)[(eigene Ergänzung)]], [Ein Lkw-Leiterrahmen ist aus offenen Profilen gebaut und darum #strong[torsionsweich]. Das ist gewollt: Im Gelände kann sich der Rahmen verwinden, und alle Räder bleiben am Boden. Wo Steifigkeit gefragt ist (Pkw-Karosserie, Brücke, Flugzeugflügel), nimmt man geschlossene Kästen. Für dich als Wirtschaftsingenieur: Die Profilwahl ist eine Kostenfrage. Gleiches Moment, aber ein Drittel des Materials heißt weniger Gewicht und weniger Stahlkosten.])
#note([Aus dem Buch (Ergänzung zur Vorlesung)], [- Die Formeln aus Tab. 5.1 gelten für konstantes $I_T$; näherungsweise auch, wenn $G I_T$ nur schwach veränderlich ist. #text(fill: muted)[\[TM2-Buch S. 191\]]
- Tab. 5.1 fasst $W_T$, $I_T$ und den Ort von $tau_("max")$ für alle Querschnitte dieses Kapitels zusammen (Vollkreis, Ellipse, Quadrat, dickwandiges Rohr, dünnwandig geschlossen, dünnwandiges Kreisrohr, schmales Rechteck, zusammengesetzte offene Profile). #text(fill: muted)[\[TM2-Buch S. 192–193\]]])
#src[Skript TM2 S. 127, 382; FS TM2 S. 39–41; WZF-Mitschrift 22.06.26 S. 2–5; TM2-Buch S. 191–193.]

#bild("map-t2k5", [Mindmap zu TM2 Kapitel 5 (eigene Darstellung nach Skript TM2 S. 109–127, 350–384 und FS TM2 S. 37–41).], height: 70mm)
*Der Zusammenhang in TM2 Kapitel 5.* Torsion ist der dritte Grundlastfall nach Zug/Druck und Biegung. Wie bei Zug gibt es eine Spannungsformel ($tau_("max") = M_T\/W_T$) und eine Verformungsformel ($Delta theta.alt = M_T l\/(G I_T)$). Für den Kreis kommen $I_T$ und $W_T$ aus dem polaren FTM (5.1), das du aus Kap. 4 kennst ($I_p = I_y + I_z$). Für dünnwandige Profile entscheidet nur eine Frage: Ist das Profil geschlossen (Bredt, 5.2) oder offen ($frac(1, 3) sum h t^3$, 5.3)? Der Vergleich (5.4) zeigt, warum man für Torsion geschlossene Rohre baut. Die Schubspannung aus Torsion geht zusammen mit $sigma$ aus Zug oder Biegung in den ebenen Spannungszustand und die Vergleichsspannung aus Kap. 2 ein.

#pagebreak()
== Verständnisfragen und Rechenaufgaben · TM2 Kapitel 5
#set enum(spacing: 0.85em)
Erkläre erst selbst. Bei Rechenaufgaben: erst $M_T$ bestimmen, dann entscheiden, welcher Querschnittstyp vorliegt, dann $W_T$ und $I_T$. Die Lösungen folgen getrennt.

+ Welche Spannungen entstehen im Querschnitt bei reiner Torsion, und wie sind sie beim Vollkreis verteilt?
+ Welche Größen aus Zug/Druck entsprechen $M_T$, $G I_T$ und $Delta theta.alt$?
+ Warum gilt $I_T = I_p$ nur beim Kreis?
+ Was ist der Schubfluss, und warum ist er in einem geschlossenen dünnwandigen Profil konstant?
+ Wo tritt $tau_("max")$ im geschlossenen und wo im offenen dünnwandigen Profil auf?
+ Warum ist ein geschlitztes Rohr so viel torsionsweicher als ein geschlossenes?
+ Vollwelle $d = 40$ mm, $M_T = 500$ Nm, $l = 1$ m, $G = "0,8" dot 10^5 thin "N/mm"^2$. Berechne $tau_("max")$ und $Delta theta.alt$ in Grad. #text(fill: muted)[(eigene Aufgabe)]

#heading(level: 3, outlined: false)[Vertiefende Verständnisfragen und Rechenaufgaben]
#block[
#set enum(start: 8)
+ *Skript TM2 S. 116:* Kurbel mit Kräftepaar $F$ (Hebel $R = 200$ mm), Welle $r = 20$ mm, $L = 5$ m, $tau_("zul") = 150 thin "N/mm"^2$, $G = "0,8" dot 10^5 thin "N/mm"^2$. a) $F_("max")$, b) $Delta theta.alt$ bei $F_("max")$.
+ *Skript TM2 S. 359:* Welle der Länge $L = a + b$, an beiden Enden eingespannt, auf dem Stück $b$ mit dem Streckenmoment $m_0$ belastet. Bestimme $M_T (x)$ und beide Einspannmomente.
+ *Übung 7, Aufg. 7.1 b):* Dünnwandiges Rohr (Kernlochbohrer), $d_m = 100$ mm, $t = 2$ mm, $M_t = "0,943"$ kNm. Wie groß ist $tau$?
+ *Übung 12, Aufg. 12.1:* Stahlwelle, $M_T = 1800$ Nm, $G = 80 thin 000 thin "N/mm"^2$. Durchmesser für a) $tau < 45 thin "N/mm"^2$, b) $theta.alt' < "0,25" °\/"m"$. c) Dasselbe für eine Hohlwelle mit 10 mm Wand (dünnwandig und dickwandig gerechnet). Vergleiche.
+ *Übung 12, Aufg. 12.2:* Konischer Stab, Radius $R(x) = r (2 - x\/l)$, eingespannt bei $x = 0$, am Ende $M_T$. Randspannung $tau(x)$ und Verdrehung $theta.alt(x)$.
+ *Übung 12, Aufg. 12.3:* Kreisrohr (Mittelradius $R_m$), eine Hälfte mit Wanddicke $delta$, die andere mit $2 delta$. a) geschlossen, b) der Länge nach geschlitzt: $W_T$, $I_T$, Ort von $tau_("max")$. c) Verhältnisse $tau_b\/tau_a$ und $theta.alt_b\/theta.alt_a$.
+ *Übung 12, Aufg. 12.4:* Geschlossenes dünnwandiges Dreiecksprofil (gleichseitig, Seite $a = 1$ cm, eine Wand $delta_1$, zwei Wände $delta_2$), Länge $l = 100$ cm, $M_T = 350 sqrt(3)$ Ncm, $tau_("zul") = 7000 thin "N/cm"^2$, $G = "0,8" dot 10^7 thin "N/cm"^2$, zulässige Verdrehung $Delta theta.alt = 7 sqrt(3)\/60$. Bestimme $tau_("max")$ und $Delta theta.alt$ allgemein, dann $delta_1$ und $delta_2$.
+ *Übung 13, Aufg. 13.1 b)–c):* Konischer Vollstab $R(x) = a (2 - x\/l)$, $a = 50$ mm, Druckkraft $F = "883,6"$ kN und Torsionsmoment $M_T = "46,39"$ kNm. Gib $sigma(x)$ und $tau_("max")(x)$ an und berechne beide bei $x = l\/2$.
+ *Übung 13, Aufg. 13.2 c)–d):* „Haus“-Profil (Rechteck $25 times "47,5"$ mm mit Dach, Wand $t = 5$ mm, Dachschrägen $"17,68"$ mm lang mit $t = "3,536"$ mm). Berechne $A_m$, $integral.cont d s\/t$, $I_T$, $W_T$ und gib den Ort von $tau_("max")$ an.
+ *Skript TM2 S. 125:* Kasten $a = 200$ mm, $t = 2$ mm (zwei Wände $2t$), $L = 5$ m, $tau_("zul") = 40 thin "N/mm"^2$. Zulässiges Moment und Verdrehung für das geschlossene und das geschlitzte Profil.
+ *Skript TM2 S. 127:* Welcher Querschnitt ist für $M_T = 12$ kNm und $tau_("zul") = 50 thin "N/mm"^2$ am sparsamsten: Vollkreis, Vollquadrat, geschlossenes Rohr ($t = c\/10$) oder geschlitztes Rohr ($t = d\/10$)?
+ *WZF 22.06.26:* Vergleiche $W_T$ und $I_T$ von a) Vollquadrat $c times c$, b) geschlossenem Kasten (oben $2d$, sonst $d$, $d = "0,1" c$), c) demselben Kasten mit Schlitz unten. Wo liegt jeweils $tau_("max")$?
+ *TM2-Buch Bsp. 5.5:* Ein dünnwandiges Rohr ($R_m$, $t$) wird einmal geschlossen und einmal geschlitzt verwendet. Wie verhalten sich die maximalen Spannungen und die Endverdrehungen?
+ *Altklausur mit Musterlösung (PrüfungenTM2.pdf S. 29):* Profil aus TM2 Kap. 4 (Bild dort, letzte Altklausur-Aufgabe). a) Offen oder geschlossen? b) $A_m$, $W_T$, $I_T$. c) Druckspannung und $Delta l$ durch $F_2$ auf $l_2$; welche Gefahr? d) $M_T$ aus $F_1$ und Verdrehung über $l_2$ in Grad. e) Wo und wie groß ist $tau_("max")$?
+ *Altklausur, Datum unbekannt, mit Musterlösung (Prüfung_unbekannt.pdf S. 3):* Symmetrisches Profil (Kreisring mit dreieckigem Anbau), $r_i = 15$, $t_1 = 5$, $t_2 = "3,5"$ mm, $l = 1$ m, $F_2 = 10$ kN. a) Offen oder geschlossen? Wo liegt $tau_("max")$? b) Mit $A_m = "787,3" thin "mm"^2$ und $integral.cont d s\/t = "25,14"$: $I_T$ und $W_T$. c) Druckspannung ($A = "449,3" thin "mm"^2$), $Delta l$ und Gefahr.
  #bild("ak_unb_torsion", [Altklausur, Datum unbekannt, Abb. 2: Profil mit den Kräften $F_1$, $F_2$; rechts der Querschnitt mit den Wanddicken $t_1$ und $t_2$ und den Zahlenwerten.], height: 40mm)
+ *Altklausur SS 2018 (TM_Prüfung_2018.pdf S. 10):* Profile aus Rechtecken mit den Dicken $t_1 >> t_2$ (ohne Rechnung): a) Bild links, Biegung um $y$: wo liegen $S$ und die größte Biegespannung? b) Bild Mitte (geschlossen) und rechts (offen), Torsion: wo liegt jeweils $tau_("max")$? c) Welcher Querschnitt hat bei gleichem $M_T$ deutlich kleinere Verdrehung und Spannung?
  #bild("ak_2018_torsion", [Altklausur SS 2018, Aufg. 2 h), Abb. 2: drei dreieckige Profile aus dicken ($t_1$) und dünnen ($t_2$) Wänden; das rechte ist offen.], height: 45mm)
+ *Altklausur SS 2016, Musterlösung (PrüfungenTM2.pdf S. 12):* Zwei U-Profile sollen zu einem Träger verschweißt werden. Wie ordnest du sie an a) für möglichst großen Widerstand gegen Biegung um die $y$-Achse, b) gegen Torsion?
  #bild("ak_u_profile", [Altklausur SS 2016, Aufg. 2, Abb. 2, Musterlösung: links die beiden U-Profile, Mitte Rücken an Rücken als I-Form, rechts zu einem geschlossenen Kasten verschweißt.], height: 45mm)
]

#pagebreak()
== Lösungen TM2 Kapitel 5
#set enum(spacing: 0.65em)
+ Nur Schubspannungen. Beim Vollkreis wachsen sie linear von 0 in der Mitte bis $tau_("max")$ am Rand und laufen tangential. #nachschlagen[Lernskript, #stelle(<a-tm2-5-1>)]
+ $M_T$ ↔ $N$, $G I_T$ ↔ $E A$, $Delta theta.alt$ ↔ $Delta l$. #nachschlagen[Lernskript, #stelle(<a-tm2-5-1>)]
+ Nur beim Kreis bleiben die Querschnitte eben (keine Verwölbung). Bei anderen Formen verwölbt sich der Querschnitt, und $I_T$ ist kleiner als $I_p$. #nachschlagen[Lernskript, #stelle(<a-tm2-5-1>)\; TM2-Buch S. 191]
+ $T = tau dot t$, Kraft pro Länge entlang der Wand. Aus dem Kräftegleichgewicht am Wandelement in Längsrichtung folgt $T = "const"$. #nachschlagen[Lernskript, #stelle(<a-tm2-5-2>)]
+ Geschlossen: bei $t_("min")$. Offen: im Teil mit $t_("max")$. #nachschlagen[Lernskript, #stelle(<a-tm2-5-3>)]
+ Ohne Schlitz läuft der Schubfluss rundherum mit dem großen Hebelarm (Fläche $A_m$). Mit Schlitz läuft er in der Wand hin und zurück, Hebelarm nur ein Teil von $t$; deshalb $I_T tilde t^3$ statt $tilde A_m^2 t$. #nachschlagen[Lernskript, #stelle(<a-tm2-5-3>)]
+ $W_T = pi d^3\/16 = 12 thin 566 thin "mm"^3$, $tau_("max") = 5 dot 10^5\/12 thin 566 = "39,8" thin "N/mm"^2$. $I_T = pi d^4\/32 = 251 thin 327 thin "mm"^4$, $Delta theta.alt = 5 dot 10^5 dot 1000\/("0,8" dot 10^5 dot 251 thin 327) = "0,0249" "rad" = "1,42"°$. #nachschlagen[Lernskript, #stelle(<a-tm2-5-1>)]
+ a) $F_("max") = pi r^3 tau_("zul")\/(4R) approx "4,71"$ kN. b) $Delta theta.alt = tau_("max") L\/(G r) = "0,469" "rad" approx "26,9"°$. #nachschlagen[Lernskript, #stelle(<a-tm2-5-1>)]
+ $M_T (x) = frac(m_0 b^2, 2L) - m_0 chevron.l x - a chevron.r$. Einspannmoment links $frac(m_0 b^2, 2L)$, rechts $frac(m_0 b (a + L), 2L)$; zusammen $m_0 b$. #nachschlagen[Lernskript, #stelle(<a-tm2-5-1-2>)]
+ $tau = frac(M_t\/r_m, d_m pi t) = 30 thin "N/mm"^2$. #nachschlagen[Lernskript, #stelle(<a-tm2-5-2>)\; Lösung Übung 7 S. 1]
+ a) $d = "58,84"$ mm, b) $d = "85,13"$ mm (maßgebend). c) dünnwandig $d_a = "60,46"$ bzw. $"96,92"$ mm, dickwandig $d_a approx 64$ bzw. $"96,6"$ mm. Die Hohlwelle braucht weniger als die Hälfte des Materials. #nachschlagen[Lernskript, #stelle(<a-tm2-5-1-2>)\; Lösung Übung 12 S. 1–2]
+ $tau(x) = frac(2 M_T, pi r^3 (2 - x\/l)^3)$, $theta.alt(x) = frac(2 M_T l, 3 G pi r^4) [frac(1, (2 - x\/l)^3) - frac(1, 8)]$. #nachschlagen[Lernskript, #stelle(<a-tm2-5-1-2>)\; Lösung Übung 12 S. 3]
+ a) $W_T = 2 pi R_m^2 delta$, $I_T = frac(8, 3) pi R_m^3 delta$, $tau_("max")$ im dünnen Teil. b) $W_T = frac(3, 2) pi R_m delta^2$, $I_T = 3 pi R_m delta^3$, $tau_("max")$ im dicken Teil. c) $frac(tau_b, tau_a) = frac(4 R_m, 3 delta) >> 1$, $frac(theta.alt_b, theta.alt_a) = frac(8 R_m^2, 9 delta^2) >> 1$. #nachschlagen[Lernskript, #stelle(<a-tm2-5-3>)\; Lösung Übung 12 S. 4]
+ $A_m = frac(sqrt(3), 4) a^2$, $tau_("max") = frac(2 M_T, sqrt(3) a^2 delta_1)$ in der Wand $delta_1$ (falls $delta_1 < delta_2$). $integral.cont d s\/t = a frac(2 delta_1 + delta_2, delta_1 delta_2)$, $Delta theta.alt = frac(4 M_T l (2 delta_1 + delta_2), 3 G a^3 delta_1 delta_2)$. Zahlen: $delta_1 = "0,1"$ cm, $delta_2 = "0,2"$ cm. #nachschlagen[Lernskript, #stelle(<a-tm2-5-2>)\; Lösung Übung 12 S. 5–6]
+ $sigma(x) = frac(-F, pi a^2 (2 - x\/l)^2)$, $tau_("max")(x) = frac(2 M_T, pi a^3 (2 - x\/l)^3)$. Bei $x = l\/2$: $sigma = -50 thin "N/mm"^2$, $tau_("max") = 70 thin "N/mm"^2$ (danach ebener Spannungszustand, Kap. 2). #nachschlagen[Lernskript, #stelle(<a-tm2-5-1-2>)\; Lösung Übung 13 S. 1]
+ $A_m = "1343,75" thin "mm"^2$, $integral.cont d s\/t = 34$, $I_T = 212 thin 431 thin "mm"^4$, $W_T = 9503 thin "mm"^3$; $tau_("max")$ im Dach (kleinste Wanddicke). #nachschlagen[Lernskript, #stelle(<a-tm2-5-2>)\; Lösung Übung 13 S. 6]
+ Geschlossen: $M_(T "zul") = 6400$ Nm, $Delta theta.alt = "1,07"°$. Offen: $M_(T "zul") = 96$ Nm, $Delta theta.alt = "35,8"°$. #nachschlagen[Lernskript, #stelle(<a-tm2-5-3>)]
+ Geschlossenes Rohr: $A = "33,1" thin "cm"^2$ (Vollkreis 89,9, Quadrat 109,8, geschlitztes Rohr 319,2). #nachschlagen[Lernskript, #stelle(<a-tm2-5-4>)]
+ a) $"0,208" c^3$ / $"0,141" c^4$, Mitte der Seiten. b) $"0,2" c^3$ / $"0,114" c^4$, Wände mit $t = d$. c) $"0,0183" c^3$ / $"0,00367" c^4$, obere Wand ($2d$). #nachschlagen[Lernskript, #stelle(<a-tm2-5-4>)]
+ $tau_("max",g)\/tau_("max",o) = t\/(3 R_m)$, $theta.alt_g\/theta.alt_o = frac(1, 3) (t\/R_m)^2$: Das geschlossene Rohr ist viel fester und noch viel steifer. #nachschlagen[Lernskript, #stelle(<a-tm2-5-3>)\; TM2-Buch S. 191, 193]
+ a) Geschlossen. b) $A_m = frac(1, 2) dot "17,5"^2 pi + "2,5" dot 35 = "568,6" thin "mm"^2$, $W_T = 2 A_m t = 5686 thin "mm"^3$, $I_T = (2 A_m)^2 \/ integral.cont d s\/t = 68 thin 071 thin "mm"^4$ (ohne die zwei kurzen Stücke von $"2,5"$ mm: 71 853). c) $sigma = -10 thin 000\/"474,89" = -"21,1" thin "N/mm"^2$, $Delta l = -"0,10"$ mm; Gefahr Knicken. d) $M_T = F_1 l_1 = 450$ Nm, $Delta theta.alt = "0,0818" "rad" = "4,69"°$. e) $tau = M_T\/W_T = "79,2" thin "N/mm"^2$ am ganzen Umfang über die ganze Länge, weil $M_T$ und $t$ konstant sind. #nachschlagen[Lernskript, #stelle(<a-tm2-5-2>)\; TM2 Kap. 1\; Altklausur mit Musterlösung (PrüfungenTM2.pdf S. 29)]
+ a) Geschlossen; $tau_("max")$ bei $t_("min") = t_2$ (Dreiecksseiten). b) $I_T = (2 dot "787,3")^2\/"25,14" approx 98 thin 600 thin "mm"^4$, $W_T = 2 A_m t_("min") = 5511 thin "mm"^3$. c) $sigma = -"22,3" thin "N/mm"^2$, $Delta l = -"0,106"$ mm, Gefahr Knicken. #nachschlagen[Lernskript, #stelle(<a-tm2-5-2>)\; Altklausur, Datum unbekannt, mit Musterlösung (Prüfung_unbekannt.pdf S. 3)]
+ a) $S$ auf der Symmetrieachse; $z_("max")$ und $sigma_("max")$ in den linken Ecken. b) Geschlossen: in den dünnen Wänden $t_2$, weil $tau = M_T\/(2 A_m t)$. Offen: in den dicken Wänden $t_1$, weil $tau tilde t$. c) Das geschlossene Profil. #nachschlagen[Lernskript, #stelle(<a-tm2-5-3>), #stelle(<a-tm2-5-4>)\; Altklausur SS 2018 (TM_Prüfung_2018.pdf S. 10), eigene Lösung]
+ a) Rücken an Rücken zu einem I-Profil: viel Fläche weit weg von der $y$-Achse, großes $W_y$. b) Mit den offenen Seiten zueinander zu einem geschlossenen Kasten: großes $A_m$, der Schubfluss läuft rundherum. #nachschlagen[Lernskript, #stelle(<a-tm2-5-4>), #stelle(<a-tm2-4-2>)\; Altklausur SS 2016, Musterlösung (PrüfungenTM2.pdf S. 12)]

#pagebreak()
= Anhang

== Formelsammlung mit Voraussetzungen
Vorzeichen wie in der Vorlesung: Schnittgrößen positiv am positiven Schnittufer, $z$ nach unten, $w$ nach unten positiv, Zug positiv.

#tab(columns: (1.15fr, 1.8fr, 1.7fr),
 th([Thema], [Formel], [Voraussetzung / Einheit]),
 [Gleichgewicht eben], [$sum F_x = 0$, $sum F_y = 0$, $sum M_((A)) = 0$], [Starrer Körper, vollständig freigeschnitten. Bezugspunkt $A$ beliebig.],
 [Moment einer Kraft], [$M_((A)) = F dot a$], [$a$ = senkrechter Abstand der Wirkungslinie von $A$; N·m.],
 [Kraftzerlegung], [$F_x = F cos alpha$, $F_y = F sin alpha$, $F = sqrt(F_x^2 + F_y^2)$], [$alpha$ gegen die $x$-Achse gemessen.],
 [Schwerpunkt], [$x_S = frac(sum x_i A_i, sum A_i)$, $y_S = frac(sum y_i A_i, sum A_i)$], [Zusammengesetzte Flächen; Aussparungen mit Minus.],
 [Streckenlast], [$F_R = integral q(x) thin d x$, Angriff im Flächenschwerpunkt], [Rechteck: Mitte; Dreieck: bei 1/3 von der hohen Seite.],
 [Statische Bestimmtheit, ein Körper], [$f = 3 - sum r$], [$f = 0$ bestimmt, $f < 0$ unbestimmt, $f > 0$ beweglich (eben).],
 [Statische Bestimmtheit, mehrteilig], [$3n = r + v$], [$n$ Teilkörper, $r$ Lager-, $v$ Verbindungswertigkeiten (Gelenk 2).],
 [Fachwerk], [$2k = s + r$], [$k$ Knoten, $s$ Stäbe, $r$ Lagerwertigkeiten (eben). Notwendig, nicht hinreichend.],
 [Nullstäbe], [Regel 1, 2, 3], [1: unbelasteter Knoten mit 2 Stäben. 2: Last in Richtung eines von 2 Stäben. 3: unbelasteter Knoten, 2 von 3 Stäben in einer Linie.],
 [Schnittgrößen, Balken], [$frac(d Q, d x) = -q$, $frac(d M, d x) = Q$], [Gerader Balken; an Einzelkraft springt $Q$, an Einzelmoment springt $M$.],
 [Haftung], [$H <= mu_0 N$], [Grenzfall $H = mu_0 N$; Richtung von $H$ gegen die drohende Bewegung.],
 [Reibung], [$R = mu N$], [Körper gleitet; $mu < mu_0$.],
 [Seilhaftung / Seilreibung], [$S_2 = S_1 e^(mu_0 alpha)$ bzw. $S_1 e^(mu alpha)$], [$S_2$ = größere Seilkraft, $alpha$ Umschlingungswinkel in rad.],
 [Spannung im Stab], [$sigma = N\/A$], [Schnitt senkrecht zur Stabachse; N/mm².],
 [Hooke, Wärmedehnung], [$epsilon = sigma\/E + alpha_T Delta T$], [Linear elastisch.],
 [Längenänderung], [$Delta l = integral_0^l epsilon thin d x$; konstant: $Delta l = frac(N l, E A) + alpha_T Delta T l$], [Vorzeichen: Verlängerung positiv.],
 [Hauptspannungen], [$sigma_(1,2) = frac(sigma_x + sigma_y, 2) plus.minus sqrt((frac(sigma_x - sigma_y, 2))^2 + tau_(x y)^2)$], [Ebener Spannungszustand.],
 [Hauptrichtung], [$tan 2 phi^* = frac(2 tau_(x y), sigma_x - sigma_y)$], [Welche Hauptspannung dazu gehört: durch Einsetzen prüfen.],
 [Größte Schubspannung], [$tau_("max") = frac(1, 2) (sigma_1 - sigma_2)$], [Unter $45°$ zu den Hauptrichtungen.],
 [Hauptdehnungen], [$epsilon_(1,2) = frac(epsilon_x + epsilon_y, 2) plus.minus sqrt((frac(epsilon_x - epsilon_y, 2))^2 + (frac(gamma_(x y), 2))^2)$, $tan 2 phi^* = frac(gamma_(x y), epsilon_x - epsilon_y)$], [Wie bei den Spannungen, aber mit $gamma\/2$.],
 [Elastizitätsgesetz eben], [$epsilon_x = frac(1, E)(sigma_x - nu sigma_y)$, $epsilon_z = -frac(nu, E)(sigma_x + sigma_y)$, $gamma = tau\/G$], [Linear elastisch, isotrop, $sigma_z = 0$.],
 [Umgekehrt], [$sigma_1 = frac(E, 1 - nu^2)(epsilon_1 + nu epsilon_2)$], [Ebener Spannungszustand.],
 [Schubmodul], [$G = frac(E, 2(1 + nu))$], [Stahl: $G approx "0,808" dot 10^5 thin "N/mm"^2$.],
 [Biegespannung], [$sigma = frac(M, I) z$, $sigma_("max") = M\/W$, $W = I\/abs(z_("max"))$], [Gerade Biegung um eine Hauptachse; $z$ vom Schwerpunkt.],
 [Flächenträgheitsmomente], [$I_y = integral z^2 d A$, $I_z = integral y^2 d A$, $I_(y z) = -integral y z thin d A$], [Rechteck $b h^3\/12$, Kreis $pi d^4\/64$; mm#super[4].],
 [Steiner], [$I_y = I_(overline(y)) + z_S^2 A$, $I_(y z) = I_(overline(y) overline(z)) - y_S z_S A$], [Nur von der eigenen Schwerpunktachse aus verschieben.],
 [Hauptträgheitsmomente], [$I_(1,2) = frac(I_y + I_z, 2) plus.minus sqrt((frac(I_y - I_z, 2))^2 + I_(y z)^2)$, $tan 2 phi^* = frac(2 I_(y z), I_y - I_z)$], [Symmetrieachsen sind Hauptachsen ($I_(y z) = 0$).],
 [Biegelinie], [$E I w'' = -M$ bzw. $E I w'''' = q$], [Kleine Durchbiegung; 2 bzw. 4 Integrationskonstanten aus RB und ÜB.],
 [Kragarm, Kraft am Ende], [$w_("max") = frac(F l^3, 3 E I)$], [Konstantes $E I$.],
 [Torsion Kreiswelle], [$tau_("max") = M_T\/W_T$, $theta' = frac(M_T, G I_T)$, $Delta theta = frac(M_T l, G I_T)$], [Vollkreis: $I_T = pi R^4\/2$, $W_T = pi R^3\/2$; Winkel in rad.],
 [Dünnwandig geschlossen (Bredt)], [$T = tau t = frac(M_T, 2 A_m)$, $W_T = 2 A_m t_("min")$, $I_T = frac((2 A_m)^2, integral.cont d s\/t)$], [$A_m$ = von der Wandmittellinie umschlossene Fläche; $tau_("max")$ bei $t_("min")$.],
 [Dünnwandig offen], [$I_T = frac(1, 3) sum h_i t_i^3$, $W_T = I_T\/t_("max")$], [$tau_("max")$ im Teil mit $t_("max")$.],
)

#note("Wichtige Zahlen", [
Stahl: $E = "2,1" dot 10^5 thin "N/mm"^2$, $G approx "0,808" dot 10^5 thin "N/mm"^2$, $nu = "0,3"$.

$1 thin "N/mm"^2 = 1 thin "MPa"$; $1 thin "kNm" = 10^6 thin "Nmm"$; $1 thin "rad" = "57,3"°$; $1 "‰" = 10^(-3)$.

$g approx "9,81" thin "m/s"^2$.
])


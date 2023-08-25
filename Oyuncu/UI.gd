extends CanvasLayer

onready var Envanter = $Envanter
onready var HizliErisim = $HizliErisim
onready var Sandik = $Sandik_slotlari

var tutulan_esya = null
var sandiklar = []

func _input(event):
	if event.is_action_pressed("Envanter"):
		if tutulan_esya != null :
			tutulan_esya.visible = true
		Envanter.visible = !Envanter.visible
		if Envanter.visible and !sandiklar.empty() :
			Sandik.visible = true
			Sandik.kirmizi.value = sandiklar[0].sandik_rengi.get_modulate().r8
			Sandik.yesil.value = sandiklar[0].sandik_rengi.get_modulate().g8
			Sandik.mavi.value = sandiklar[0].sandik_rengi.get_modulate().b8
			Envanter.animasyonPlayer.play("SandıkAçık")
		else :
			Sandik.visible = false
			Envanter.animasyonPlayer.play("SandıkKapalı")
		if !Envanter.visible and !sandiklar.empty():
			sandiklar[0].sandik_rengi_ayarla(Sandik.renklist)
		HizliErisim.envanter_acikmi = !HizliErisim.envanter_acikmi
		Envanter.envanter_slotlarini_guncelle()

	if !Envanter.visible :
		if tutulan_esya != null :
			tutulan_esya.visible = false
		if event.is_action_pressed("FareTekerlekYukarı"):
			OyuncuEnvanter.aktif_esya_asagi_cevirme()
		elif event.is_action_pressed("FareTekerlekAşağı"):
			OyuncuEnvanter.aktif_esya_yukari_cevirme()

func esyayi_envanterden_sandiga_ve_hizlierisime_yolla(slot,esya_isim,esya_miktar):
	if !sandiklar.empty() :
		OyuncuEnvanter.esya_sil(slot,OyuncuEnvanter.envanter)
		OyuncuEnvanter.esya_ekleme(esya_isim, esya_miktar, Sandik.sandik)
		Envanter.envanter_slotlarini_guncelle()
		Sandik.sandik_slotlarini_guncelle()
	else :
		OyuncuEnvanter.esya_sil(slot,OyuncuEnvanter.envanter)
		OyuncuEnvanter.esya_ekleme(esya_isim, esya_miktar, OyuncuEnvanter.hizlierisim)
		Envanter.envanter_slotlarini_guncelle()
		HizliErisim.hizlierisim_slotlarini_guncelle()

func esyayi_sandiktan_envantere_yolla(slot,esya_isim,esya_miktar):
	if !sandiklar.empty() :
		OyuncuEnvanter.esya_sil(slot,Sandik.sandik)
		OyuncuEnvanter.esya_ekleme(esya_isim, esya_miktar, OyuncuEnvanter.envanter)
		Envanter.envanter_slotlarini_guncelle()
		Sandik.sandik_slotlarini_guncelle()

func esyayi_hizlierisimden_envantere_ve_sandiga_yolla(slot,esya_isim,esya_miktar):
	if !sandiklar.empty() :
		OyuncuEnvanter.esya_sil(slot, OyuncuEnvanter.hizlierisim)
		OyuncuEnvanter.esya_ekleme(esya_isim, esya_miktar, Sandik.sandik)
		HizliErisim.hizlierisim_slotlarini_guncelle()
		Sandik.sandik_slotlarini_guncelle()
		Envanter.envanter_slotlarini_guncelle()
	else :
		OyuncuEnvanter.esya_sil(slot, OyuncuEnvanter.hizlierisim)
		OyuncuEnvanter.esya_ekleme(esya_isim, esya_miktar, OyuncuEnvanter.envanter)
		HizliErisim.hizlierisim_slotlarini_guncelle()
		Envanter.envanter_slotlarini_guncelle()

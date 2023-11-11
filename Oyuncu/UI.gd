extends CanvasLayer

onready var Envanter = $Envanter
onready var HizliErisim = $HizliErisim
onready var Sandik = $Sandik_slotlari

onready var envanter_sozluk = Envanter.envanter
onready var hizli_erisim_sozluk = HizliErisim.hizlierisim

var tutulan_esya = null
var sandiklar = []
var FareSlot = null

func _input(event):
	if event.is_action_pressed("Envanter"):
		find_parent("Oyuncu").YerdenEsyaAlmaZamanlayiciSifirla()
		OyuncuEnvanter.hizliErisim_guncelle(hizli_erisim_sozluk)
		find_parent("Oyuncu").gorunurlukKapa()
		if tutulan_esya != null :
			tutulan_esya.visible = !tutulan_esya.visible
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
		slotlari_guncelle()

	if Envanter.visible :
		if event.is_action_pressed("Esc"):
			Envanter.visible = !Envanter.visible
			Sandik.visible = false
			Envanter.animasyonPlayer.play("SandıkKapalı")
			HizliErisim.envanter_acikmi = !HizliErisim.envanter_acikmi

	else :
		if event.is_action_pressed("FareTekerlekYukarı"):
			OyuncuEnvanter.aktif_esya_asagi_cevirme(hizli_erisim_sozluk)

		elif event.is_action_pressed("FareTekerlekAşağı"):
			OyuncuEnvanter.aktif_esya_yukari_cevirme(hizli_erisim_sozluk)

func TusKontrol(Tus: String):
	if Input.is_action_pressed(Tus):
		return true
	else :
		return false

func hizliE_esyalari_San_v_Env_yer_deis(slot , slot_sayisi ):

	var HizliErisimSlot = HizliErisim.hizli_erisim.get_children()[slot_sayisi]

	if Envanter.visible :
		if FareSlot != null:
			if slot.get_parent().name == "EnvanterSlotlari" :
				if slot.esya and HizliErisimSlot.esya :
					OyuncuEnvanter.bos_slota_esya_ekle(slot.esya,  HizliErisimSlot, hizli_erisim_sozluk)
					OyuncuEnvanter.bos_slota_esya_ekle(HizliErisimSlot.esya, slot, envanter_sozluk)
				elif slot.esya and !HizliErisimSlot.esya :
					OyuncuEnvanter.bos_slota_esya_ekle(slot.esya,  HizliErisimSlot, hizli_erisim_sozluk)
					OyuncuEnvanter.esya_sil(slot, envanter_sozluk)
				elif !slot.esya and HizliErisimSlot.esya :
					OyuncuEnvanter.esya_sil(HizliErisimSlot, hizli_erisim_sozluk)
					OyuncuEnvanter.bos_slota_esya_ekle(HizliErisimSlot.esya, slot, envanter_sozluk)

			elif slot.get_parent().name == "SandikSlotlari" :
				if slot.esya and HizliErisimSlot.esya :
					OyuncuEnvanter.bos_slota_esya_ekle(slot.esya,  HizliErisimSlot, hizli_erisim_sozluk)
					OyuncuEnvanter.bos_slota_esya_ekle(HizliErisimSlot.esya, slot, Sandik.sandik)
				elif slot.esya and !HizliErisimSlot.esya :
					OyuncuEnvanter.bos_slota_esya_ekle(slot.esya,  HizliErisimSlot, hizli_erisim_sozluk)
					OyuncuEnvanter.esya_sil(slot, Sandik.sandik)
				elif !slot.esya and HizliErisimSlot.esya :
					OyuncuEnvanter.esya_sil(HizliErisimSlot, hizli_erisim_sozluk)
					OyuncuEnvanter.bos_slota_esya_ekle(HizliErisimSlot.esya, slot, Sandik.sandik)

			else :
				if slot.esya and HizliErisimSlot.esya :
					OyuncuEnvanter.bos_slota_esya_ekle(slot.esya,  HizliErisimSlot, hizli_erisim_sozluk)
					OyuncuEnvanter.bos_slota_esya_ekle(HizliErisimSlot.esya, slot, hizli_erisim_sozluk)
				elif slot.esya and !HizliErisimSlot.esya :
					OyuncuEnvanter.bos_slota_esya_ekle(slot.esya,  HizliErisimSlot, hizli_erisim_sozluk)
					OyuncuEnvanter.esya_sil(slot, hizli_erisim_sozluk)
				elif !slot.esya and HizliErisimSlot.esya :
					OyuncuEnvanter.esya_sil(HizliErisimSlot, hizli_erisim_sozluk)
					OyuncuEnvanter.bos_slota_esya_ekle(HizliErisimSlot.esya, slot, hizli_erisim_sozluk)

		slotlari_guncelle()

func esyayi_envanterden_sandiga_ve_hizlierisime_yolla(slot,esya_isim,esya_miktar):

	if !sandiklar.empty() :
		if OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, Sandik.sandik) >= esya_miktar :
			OyuncuEnvanter.esya_sil(slot, envanter_sozluk)
			OyuncuEnvanter.esya_ekleme(esya_isim, esya_miktar, Sandik.sandik)
		else :
			OyuncuEnvanter.esya_miktar_ekleme(slot, -OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, Sandik.sandik), envanter_sozluk)
			OyuncuEnvanter.esya_ekleme(esya_isim, OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, Sandik.sandik), Sandik.sandik)

	else :
		if OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, hizli_erisim_sozluk, true) >= esya_miktar :
			OyuncuEnvanter.esya_sil(slot, envanter_sozluk)
			OyuncuEnvanter.esya_ekleme(esya_isim, esya_miktar, hizli_erisim_sozluk)
		elif OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, hizli_erisim_sozluk, true) != 0 : 
			OyuncuEnvanter.esya_miktar_ekleme(slot, -OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, hizli_erisim_sozluk, true), envanter_sozluk)
			OyuncuEnvanter.esya_ekleme(esya_isim, OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, hizli_erisim_sozluk, true), hizli_erisim_sozluk)

	slotlari_guncelle()

func esyayi_sandiktan_envantere_yolla(slot,esya_isim,esya_miktar):

	if !sandiklar.empty() :
		if OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, envanter_sozluk) >= esya_miktar :
			OyuncuEnvanter.esya_sil(slot,Sandik.sandik)
			OyuncuEnvanter.esya_ekleme(esya_isim, esya_miktar, envanter_sozluk)
		else :
			OyuncuEnvanter.esya_miktar_ekleme(slot, -OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, envanter_sozluk), Sandik.sandik)
			OyuncuEnvanter.esya_ekleme(esya_isim, OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, envanter_sozluk), envanter_sozluk)

	slotlari_guncelle()

func esyayi_hizlierisimden_envantere_ve_sandiga_yolla(slot,esya_isim,esya_miktar):

	if !sandiklar.empty() :
		if OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, Sandik.sandik) >= esya_miktar :
			OyuncuEnvanter.esya_sil(slot, hizli_erisim_sozluk)
			OyuncuEnvanter.esya_ekleme(esya_isim, esya_miktar, Sandik.sandik)
		else :
			OyuncuEnvanter.esya_miktar_ekleme(slot, -OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, Sandik.sandik), hizli_erisim_sozluk)
			OyuncuEnvanter.esya_ekleme(esya_isim, OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, Sandik.sandik), Sandik.sandik)
	else :
		if OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, envanter_sozluk) >= esya_miktar :
			OyuncuEnvanter.esya_sil(slot, hizli_erisim_sozluk)
			OyuncuEnvanter.esya_ekleme(esya_isim, esya_miktar, envanter_sozluk)
		else :
			OyuncuEnvanter.esya_miktar_ekleme(slot, -OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, envanter_sozluk), hizli_erisim_sozluk)
			OyuncuEnvanter.esya_ekleme(esya_isim, OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, envanter_sozluk), envanter_sozluk)

	slotlari_guncelle()

func slotlari_guncelle():
	HizliErisim.hizlierisim_slotlarini_guncelle()
	Envanter.envanter_slotlarini_guncelle()
	Sandik.sandik_slotlarini_guncelle()

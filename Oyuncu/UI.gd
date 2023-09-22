extends CanvasLayer

onready var Envanter = $Envanter
onready var HizliErisim = $HizliErisim
onready var Sandik = $Sandik_slotlari

var tutulan_esya = null
var sandiklar = []
var FareSlot = null

func _input(event):
	if event.is_action_pressed("Envanter"):
		find_parent("Oyuncu").YerdenEsyaAlmaZamanlayiciSifirla()
		OyuncuEnvanter.hizliErisim_guncelle()
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
		slotlari_guncelle()

	if !Envanter.visible :
		if tutulan_esya != null :
			tutulan_esya.visible = false

		if event.is_action_pressed("FareTekerlekYukarı"):
			OyuncuEnvanter.aktif_esya_asagi_cevirme()

		elif event.is_action_pressed("FareTekerlekAşağı"):
			OyuncuEnvanter.aktif_esya_yukari_cevirme()

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
					OyuncuEnvanter.bos_slota_esya_ekle(slot.esya,  HizliErisimSlot, OyuncuEnvanter.hizlierisim)
					OyuncuEnvanter.bos_slota_esya_ekle(HizliErisimSlot.esya, slot, OyuncuEnvanter.envanter)
				elif slot.esya and !HizliErisimSlot.esya :
					OyuncuEnvanter.bos_slota_esya_ekle(slot.esya,  HizliErisimSlot, OyuncuEnvanter.hizlierisim)
					OyuncuEnvanter.esya_sil(slot, OyuncuEnvanter.envanter)
				elif !slot.esya and HizliErisimSlot.esya :
					OyuncuEnvanter.esya_sil(HizliErisimSlot, OyuncuEnvanter.hizlierisim)
					OyuncuEnvanter.bos_slota_esya_ekle(HizliErisimSlot.esya, slot, OyuncuEnvanter.envanter)

			elif slot.get_parent().name == "SandikSlotlari" :
				if slot.esya and HizliErisimSlot.esya :
					OyuncuEnvanter.bos_slota_esya_ekle(slot.esya,  HizliErisimSlot, OyuncuEnvanter.hizlierisim)
					OyuncuEnvanter.bos_slota_esya_ekle(HizliErisimSlot.esya, slot, Sandik.sandik)
				elif slot.esya and !HizliErisimSlot.esya :
					OyuncuEnvanter.bos_slota_esya_ekle(slot.esya,  HizliErisimSlot, OyuncuEnvanter.hizlierisim)
					OyuncuEnvanter.esya_sil(slot, Sandik.sandik)
				elif !slot.esya and HizliErisimSlot.esya :
					OyuncuEnvanter.esya_sil(HizliErisimSlot, OyuncuEnvanter.hizlierisim)
					OyuncuEnvanter.bos_slota_esya_ekle(HizliErisimSlot.esya, slot, Sandik.sandik)

			else :
				if slot.esya and HizliErisimSlot.esya :
					OyuncuEnvanter.bos_slota_esya_ekle(slot.esya,  HizliErisimSlot, OyuncuEnvanter.hizlierisim)
					OyuncuEnvanter.bos_slota_esya_ekle(HizliErisimSlot.esya, slot, OyuncuEnvanter.hizlierisim)
				elif slot.esya and !HizliErisimSlot.esya :
					OyuncuEnvanter.bos_slota_esya_ekle(slot.esya,  HizliErisimSlot, OyuncuEnvanter.hizlierisim)
					OyuncuEnvanter.esya_sil(slot, OyuncuEnvanter.hizlierisim)
				elif !slot.esya and HizliErisimSlot.esya :
					OyuncuEnvanter.esya_sil(HizliErisimSlot, OyuncuEnvanter.hizlierisim)
					OyuncuEnvanter.bos_slota_esya_ekle(HizliErisimSlot.esya, slot, OyuncuEnvanter.hizlierisim)

		slotlari_guncelle()

func esyayi_envanterden_sandiga_ve_hizlierisime_yolla(slot,esya_isim,esya_miktar):

	if !sandiklar.empty() :
		if OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, Sandik.sandik) >= esya_miktar :
			OyuncuEnvanter.esya_sil(slot,OyuncuEnvanter.envanter)
			OyuncuEnvanter.esya_ekleme(esya_isim, esya_miktar, Sandik.sandik)
		else :
			OyuncuEnvanter.esya_miktar_ekleme(slot, -OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, Sandik.sandik), OyuncuEnvanter.envanter)
			OyuncuEnvanter.esya_ekleme(esya_isim, OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, Sandik.sandik), Sandik.sandik)

	else :
		if OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, OyuncuEnvanter.hizlierisim, true) >= esya_miktar :
			OyuncuEnvanter.esya_sil(slot,OyuncuEnvanter.envanter)
			OyuncuEnvanter.esya_ekleme(esya_isim, esya_miktar, OyuncuEnvanter.hizlierisim)
		elif OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, OyuncuEnvanter.hizlierisim, true) != 0 : 
			OyuncuEnvanter.esya_miktar_ekleme(slot, -OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, OyuncuEnvanter.hizlierisim, true), OyuncuEnvanter.envanter)
			OyuncuEnvanter.esya_ekleme(esya_isim, OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, OyuncuEnvanter.hizlierisim, true), OyuncuEnvanter.hizlierisim)

	slotlari_guncelle()

func esyayi_sandiktan_envantere_yolla(slot,esya_isim,esya_miktar):

	if !sandiklar.empty() :
		if OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, OyuncuEnvanter.envanter) >= esya_miktar :
			OyuncuEnvanter.esya_sil(slot,Sandik.sandik)
			OyuncuEnvanter.esya_ekleme(esya_isim, esya_miktar, OyuncuEnvanter.envanter)
		else :
			OyuncuEnvanter.esya_miktar_ekleme(slot, -OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, OyuncuEnvanter.envanter), Sandik.sandik)
			OyuncuEnvanter.esya_ekleme(esya_isim, OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, OyuncuEnvanter.envanter), OyuncuEnvanter.envanter)

	slotlari_guncelle()

func esyayi_hizlierisimden_envantere_ve_sandiga_yolla(slot,esya_isim,esya_miktar):

	if !sandiklar.empty() :
		if OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, Sandik.sandik) >= esya_miktar :
			OyuncuEnvanter.esya_sil(slot, OyuncuEnvanter.hizlierisim)
			OyuncuEnvanter.esya_ekleme(esya_isim, esya_miktar, Sandik.sandik)
		else :
			OyuncuEnvanter.esya_miktar_ekleme(slot, -OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, Sandik.sandik), OyuncuEnvanter.hizlierisim)
			OyuncuEnvanter.esya_ekleme(esya_isim, OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, Sandik.sandik), Sandik.sandik)
	else :
		if OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, OyuncuEnvanter.envanter) >= esya_miktar :
			OyuncuEnvanter.esya_sil(slot, OyuncuEnvanter.hizlierisim)
			OyuncuEnvanter.esya_ekleme(esya_isim, esya_miktar, OyuncuEnvanter.envanter)
		else :
			OyuncuEnvanter.esya_miktar_ekleme(slot, -OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, OyuncuEnvanter.envanter), OyuncuEnvanter.hizlierisim)
			OyuncuEnvanter.esya_ekleme(esya_isim, OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(esya_isim, OyuncuEnvanter.envanter), OyuncuEnvanter.envanter)

	slotlari_guncelle()

func slotlari_guncelle():
	HizliErisim.hizlierisim_slotlarini_guncelle()
	Envanter.envanter_slotlarini_guncelle()
	Sandik.sandik_slotlarini_guncelle()

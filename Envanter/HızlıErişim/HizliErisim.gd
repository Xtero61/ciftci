extends Node2D

const SlotSinifi = preload("res://Envanter/Slot.gd")

onready var hizli_erisim = $HizliErisimSlotlari
onready var slotlar = hizli_erisim.get_children()

var envanter_acikmi : bool = false

var hizlierisim = {
	0: ["Taş Kılıç", 1],
	1: ["Taş Kazma", 1],
	2: ["Taş Balta", 1],
	3: ["Taş Kürek", 1],
	4: ["Taş Çapa", 1],
	5: ["Sulama Kabı", 1],
	6: ["Taş Çekiç", 1],
	7: ["Olta", 1],
	8: ["Odun", 1],
}

func hizlierisim_slotlarini_guncelle():
	for i in range(slotlar.size()):
		if hizlierisim.has(i):
			slotlar[i].esya_olusturma(hizlierisim[i][0], hizlierisim[i][1])
		else:
			if slotlar[i].esya != null:
				slotlar[i].esya_sil()

func _ready():
	for i in range(slotlar.size()):
		slotlar[i].connect("gui_input", self, "slot_gui_girdisi", [slotlar[i]])
		OyuncuEnvanter.connect("aktif_esya_guncellendi", slotlar[i], "style_yenile")
		slotlar[i].slot_sayisi = i
		slotlar[i].slot_tip = SlotSinifi.SlotTipi.HIZLIERISIM
	hizlierisim_slotlarini_guncelle()

func slot_gui_girdisi(event:InputEvent, slot: SlotSinifi):
	find_parent("UI").FareSlot = slot
	if envanter_acikmi :
		if event is InputEventMouseButton:
			if find_parent("UI").TusKontrol("Shift") :
				if event.button_index == BUTTON_LEFT and event.pressed :
					if slot.esya :
						find_parent("UI").esyayi_hizlierisimden_envantere_ve_sandiga_yolla(slot, slot.esya.esya_isim, slot.esya.esya_miktar)

			elif event.button_index == BUTTON_LEFT and event.pressed:
				if find_parent("UI").tutulan_esya != null :
					if !slot.esya:
						sol_tik_bos_slot(slot)
					else:
						if find_parent("UI").tutulan_esya.esya_isim != slot.esya.esya_isim :
							sol_tik_farkli_esya(event, slot)
						else :
							sol_tik_ayni_esya(slot)
				elif slot.esya:
					sol_tik_basilmiyorsa(slot)

			elif event.button_index == BUTTON_RIGHT and event.pressed:
				if find_parent("UI").tutulan_esya != null :
					if !slot.esya:
						sag_tik_tutulan_esya_varsa(slot)
					else:
						if find_parent("UI").tutulan_esya.esya_isim == slot.esya.esya_isim :
							sag_tik_tutulan_esya_varsa_slottaki_esya_da_ayniysa(slot)
				elif slot.esya:
					sag_tik_slottaki_esyanin_yarisini_alma(slot)

func sag_tik_slottaki_esyanin_yarisini_alma(slot : SlotSinifi):

	if slot.esya.esya_miktar > 1 :
		var esya_yarisi
		var tutulan_esya_yarisi
		if slot.esya.esya_miktar % 2 == 0 :
			esya_yarisi = slot.esya.esya_miktar / 2
			tutulan_esya_yarisi = slot.esya.esya_miktar / 2
		else :
			esya_yarisi = slot.esya.esya_miktar / 2 + 1
			tutulan_esya_yarisi = slot.esya.esya_miktar / 2

		OyuncuEnvanter.bos_slot_belli_miktar_esya_ekle(slot.esya,slot,esya_yarisi, hizlierisim)
		find_parent("UI").tutulan_esya = slot.esya
		slot.SlottanSecme()
		find_parent("UI").tutulan_esya.global_position = get_global_mouse_position()
		find_parent("UI").tutulan_esya.esya_miktar = tutulan_esya_yarisi
		find_parent("UI").tutulan_esya.esya_miktar_yazisi()
		hizlierisim_slotlarini_guncelle()

func sag_tik_tutulan_esya_varsa_slottaki_esya_da_ayniysa(slot: SlotSinifi):
	if find_parent("UI").tutulan_esya.esya_miktar > 0:
		var birikme_miktari = int(JsonVeri.esya_veri[slot.esya.esya_isim]["BirikmeMiktarı"])
		if slot.esya.esya_miktar < birikme_miktari :
			find_parent("UI").tutulan_esya.esya_miktari_azalt(1)
			OyuncuEnvanter.esya_miktar_ekleme(slot, 1, hizlierisim)
		if find_parent("UI").tutulan_esya.esya_miktar == 0 :
			find_parent("UI").tutulan_esya.queue_free()
			find_parent("UI").tutulan_esya = null
		hizlierisim_slotlarini_guncelle()

func sag_tik_tutulan_esya_varsa(slot: SlotSinifi):
	if find_parent("UI").tutulan_esya.esya_miktar > 0:
		find_parent("UI").tutulan_esya.esya_miktari_azalt(1)
		OyuncuEnvanter.bos_slot_belli_miktar_esya_ekle(find_parent("UI").tutulan_esya, slot, 1, hizlierisim)
		if find_parent("UI").tutulan_esya.esya_miktar == 0 :
			find_parent("UI").tutulan_esya.queue_free()
			find_parent("UI").tutulan_esya = null
		hizlierisim_slotlarini_guncelle()

func sol_tik_bos_slot(slot: SlotSinifi):
	OyuncuEnvanter.bos_slota_esya_ekle(find_parent("UI").tutulan_esya, slot, hizlierisim)
	slot.SlotaKoyma(find_parent("UI").tutulan_esya)
	find_parent("UI").tutulan_esya = null

func sol_tik_farkli_esya(event: InputEvent , slot: SlotSinifi):
	OyuncuEnvanter.esya_sil(slot, hizlierisim)
	OyuncuEnvanter.bos_slota_esya_ekle(find_parent("UI").tutulan_esya, slot, hizlierisim)
	var degis_esya = slot.esya
	slot.SlottanSecme()
	degis_esya.global_position = event.global_position
	slot.SlotaKoyma(find_parent("UI").tutulan_esya)
	find_parent("UI").tutulan_esya = degis_esya

func sol_tik_ayni_esya(slot: SlotSinifi):
	var birikme_miktari = int(JsonVeri.esya_veri[slot.esya.esya_isim]["BirikmeMiktarı"])
	var degisecek_miktar = birikme_miktari - slot.esya.esya_miktar
	if degisecek_miktar >= find_parent("UI").tutulan_esya.esya_miktar:
		OyuncuEnvanter.esya_miktar_ekleme(slot, find_parent("UI").tutulan_esya.esya_miktar, hizlierisim)
		slot.esya.esya_miktari_ekle(find_parent("UI").tutulan_esya.esya_miktar)
		find_parent("UI").tutulan_esya.queue_free()
		find_parent("UI").tutulan_esya = null
	else :
		OyuncuEnvanter.esya_miktar_ekleme(slot, degisecek_miktar, hizlierisim)
		slot.esya.esya_miktari_ekle(degisecek_miktar)
		find_parent("UI").tutulan_esya.esya_miktari_azalt(degisecek_miktar)

func sol_tik_basilmiyorsa(slot: SlotSinifi):
	OyuncuEnvanter.esya_sil(slot, hizlierisim)
	find_parent("UI").tutulan_esya = slot.esya
	slot.SlottanSecme()
	find_parent("UI").tutulan_esya.global_position = get_global_mouse_position()

func AktifSlot():
	return hizli_erisim.get_children()[OyuncuEnvanter.aktif_slot]

func _input(event):

	if !envanter_acikmi :
		if event.is_action_pressed("Yuva0"):
			pass
		elif event.is_action_pressed("Yuva1"):
			OyuncuEnvanter.aktif_slot = 0
			OyuncuEnvanter.hizliErisim_guncelle(hizlierisim)
		elif event.is_action_pressed("Yuva2"):
			OyuncuEnvanter.aktif_slot = 1
			OyuncuEnvanter.hizliErisim_guncelle(hizlierisim)
		elif event.is_action_pressed("Yuva3"):
			OyuncuEnvanter.aktif_slot = 2
			OyuncuEnvanter.hizliErisim_guncelle(hizlierisim)
		elif event.is_action_pressed("Yuva4"):
			OyuncuEnvanter.aktif_slot = 3
			OyuncuEnvanter.hizliErisim_guncelle(hizlierisim)
		elif event.is_action_pressed("Yuva5"):
			OyuncuEnvanter.aktif_slot = 4
			OyuncuEnvanter.hizliErisim_guncelle(hizlierisim)
		elif event.is_action_pressed("Yuva6"):
			OyuncuEnvanter.aktif_slot = 5
			OyuncuEnvanter.hizliErisim_guncelle(hizlierisim)
		elif event.is_action_pressed("Yuva7"):
			OyuncuEnvanter.aktif_slot = 6
			OyuncuEnvanter.hizliErisim_guncelle(hizlierisim)
		elif event.is_action_pressed("Yuva8"):
			OyuncuEnvanter.aktif_slot = 7
			OyuncuEnvanter.hizliErisim_guncelle(hizlierisim)
		elif event.is_action_pressed("Yuva9"):
			OyuncuEnvanter.aktif_slot = 8
			OyuncuEnvanter.hizliErisim_guncelle(hizlierisim)

		if AktifSlot().esya != null :
			if find_parent("UI").TusKontrol("Ctrl") and event.is_action_pressed("EsyaAtma"):
				OyuncuEnvanter.yere_esya_atma(AktifSlot(), find_parent("Oyuncu").AtilanEsyaDogma.global_position, 
				find_parent("Oyuncu").esya_atma_yon, hizlierisim, true)
				hizlierisim_slotlarini_guncelle()
				OyuncuEnvanter.hizliErisim_esya_ele_verme(hizlierisim)
			elif event.is_action_pressed("EsyaAtma"):
				OyuncuEnvanter.yere_esya_atma(AktifSlot(), find_parent("Oyuncu").AtilanEsyaDogma.global_position, 
				find_parent("Oyuncu").esya_atma_yon, hizlierisim)
				hizlierisim_slotlarini_guncelle()
				OyuncuEnvanter.hizliErisim_esya_ele_verme(hizlierisim)
	else :

		if find_parent("UI").TusKontrol("Ctrl") and event.is_action_pressed("EsyaAtma") :
			if find_parent("UI").FareSlot != null and find_parent("UI").FareSlot.esya :
				if find_parent("UI").FareSlot.get_parent().name == "HizliErisimSlotlari":
					OyuncuEnvanter.yere_esya_atma(find_parent("UI").FareSlot, find_parent("Oyuncu").AtilanEsyaDogma.global_position, 
					find_parent("Oyuncu").esya_atma_yon, hizlierisim, true)
					hizlierisim_slotlarini_guncelle()
					OyuncuEnvanter.hizliErisim_esya_ele_verme(hizlierisim)
		elif event.is_action_pressed("EsyaAtma") :
			if find_parent("UI").FareSlot != null and find_parent("UI").FareSlot.esya :
				if find_parent("UI").FareSlot.get_parent().name == "HizliErisimSlotlari":
					OyuncuEnvanter.yere_esya_atma(find_parent("UI").FareSlot, find_parent("Oyuncu").AtilanEsyaDogma.global_position, 
					find_parent("Oyuncu").esya_atma_yon, hizlierisim)
					hizlierisim_slotlarini_guncelle()
					OyuncuEnvanter.hizliErisim_esya_ele_verme(hizlierisim)

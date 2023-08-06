extends Node2D

const SlotSinifi = preload("res://Envanter/Slot.gd")

onready var hizli_erisim = $HizliErisimSlotlari
onready var slotlar = hizli_erisim.get_children()

var envanter_acikmi : bool = false

func hizlierisim_slotlarini_guncelle():
	for i in range(slotlar.size()):
		if OyuncuEnvanter.hizlierisim.has(i):
			slotlar[i].esya_olusturma(OyuncuEnvanter.hizlierisim[i][0],OyuncuEnvanter.hizlierisim[i][1])

func _ready():
	for i in range(slotlar.size()):
		slotlar[i].connect("gui_input", self, "slot_gui_girdisi", [slotlar[i]])
		OyuncuEnvanter.connect("aktif_esya_guncellendi", slotlar[i], "style_yenile")
		slotlar[i].slot_sayisi = i
		slotlar[i].slot_tip = SlotSinifi.SlotTipi.HIZLIERISIM
	hizlierisim_slotlarini_guncelle()

func slot_gui_girdisi(event:InputEvent, slot: SlotSinifi):
	if envanter_acikmi :
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed:
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

func sol_tik_bos_slot(slot: SlotSinifi):
	OyuncuEnvanter.bos_slota_esya_ekle(find_parent("UI").tutulan_esya, slot, true)
	slot.SlotaKoyma(find_parent("UI").tutulan_esya)
	find_parent("UI").tutulan_esya = null

func sol_tik_farkli_esya(event: InputEvent , slot: SlotSinifi):
	OyuncuEnvanter.esya_sil(slot, true)
	OyuncuEnvanter.bos_slota_esya_ekle(find_parent("UI").tutulan_esya, slot, true)
	var degis_esya = slot.esya
	slot.SlottanSecme()
	degis_esya.global_position = event.global_position
	slot.SlotaKoyma(find_parent("UI").tutulan_esya)
	find_parent("UI").tutulan_esya = degis_esya

func sol_tik_ayni_esya(slot: SlotSinifi):
	var birikme_miktari = int(JsonVeri.esya_veri[slot.esya.esya_isim]["BirikmeMiktarı"])
	var degisecek_miktar = birikme_miktari - slot.esya.esya_miktar
	if degisecek_miktar >= find_parent("UI").tutulan_esya.esya_miktar:
		OyuncuEnvanter.esya_miktar_ekleme(slot, find_parent("UI").tutulan_esya.esya_miktar, true)
		slot.esya.esya_miktari_ekle(find_parent("UI").tutulan_esya.esya_miktar)
		find_parent("UI").tutulan_esya.queue_free()
		find_parent("UI").tutulan_esya = null
	else :
		OyuncuEnvanter.esya_miktar_ekleme(slot, degisecek_miktar, true)
		slot.esya.esya_miktari_ekle(degisecek_miktar)
		find_parent("UI").tutulan_esya.esya_miktari_azalt(degisecek_miktar)

func sol_tik_basilmiyorsa(slot: SlotSinifi):
	OyuncuEnvanter.esya_sil(slot, true)
	find_parent("UI").tutulan_esya = slot.esya
	slot.SlottanSecme()
	find_parent("UI").tutulan_esya.global_position = get_global_mouse_position()

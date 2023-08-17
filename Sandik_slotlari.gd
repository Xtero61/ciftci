extends Node2D

const SlotSinifi = preload("res://Envanter/Slot.gd")

onready var sandik_slotlari = $SandikSlotlari
onready var slotlar = sandik_slotlari.get_children()

var sandik = {}

func sandik_slotlarini_guncelle():
	for i in range(slotlar.size()):
		if sandik.has(i):
			slotlar[i].esya_olusturma(sandik[i][0],sandik[i][1])
		else:
			if slotlar[i].esya != null:
				slotlar[i].esya_sil()

func _ready():
	for i in range(slotlar.size()):
		slotlar[i].connect("gui_input", self, "slot_gui_girdisi", [slotlar[i]])
		slotlar[i].slot_sayisi = i
		slotlar[i].slot_tip = SlotSinifi.SlotTipi.ENVANTER
	sandik_slotlarini_guncelle()

func slot_gui_girdisi(event:InputEvent, slot: SlotSinifi):
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
	OyuncuEnvanter.bos_slota_esya_ekle(find_parent("UI").tutulan_esya, slot, sandik)
	slot.SlotaKoyma(find_parent("UI").tutulan_esya)
	find_parent("UI").tutulan_esya = null

func sol_tik_farkli_esya(event: InputEvent , slot: SlotSinifi):
	OyuncuEnvanter.esya_sil(slot, sandik)
	OyuncuEnvanter.bos_slota_esya_ekle(find_parent("UI").tutulan_esya, slot, sandik)
	var degis_esya = slot.esya
	slot.SlottanSecme()
	degis_esya.global_position = event.global_position
	slot.SlotaKoyma(find_parent("UI").tutulan_esya)
	find_parent("UI").tutulan_esya = degis_esya

func sol_tik_ayni_esya(slot: SlotSinifi):
	var birikme_miktari = int(JsonVeri.esya_veri[slot.esya.esya_isim]["BirikmeMiktarı"])
	var degisecek_miktar = birikme_miktari - slot.esya.esya_miktar
	if degisecek_miktar >= find_parent("UI").tutulan_esya.esya_miktar:
		OyuncuEnvanter.esya_miktar_ekleme(slot, find_parent("UI").tutulan_esya.esya_miktar, sandik)
		slot.esya.esya_miktari_ekle(find_parent("UI").tutulan_esya.esya_miktar)
		find_parent("UI").tutulan_esya.queue_free()
		find_parent("UI").tutulan_esya = null
	else :
		OyuncuEnvanter.esya_miktar_ekleme(slot, degisecek_miktar, sandik)
		slot.esya.esya_miktari_ekle(degisecek_miktar)
		find_parent("UI").tutulan_esya.esya_miktari_azalt(degisecek_miktar)

func sol_tik_basilmiyorsa(slot: SlotSinifi):
	OyuncuEnvanter.esya_sil(slot, sandik)
	find_parent("UI").tutulan_esya = slot.esya
	slot.SlottanSecme()
	find_parent("UI").tutulan_esya.global_position = get_global_mouse_position()

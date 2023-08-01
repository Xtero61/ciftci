extends Node2D

const SlotSinifi = preload("res://Slot.gd")
onready var envanter_slotlari = $EnvanterSlotlari
var tutulan_esya = null 

func envanter_slotlarini_guncelle():
	var slotlar = envanter_slotlari.get_children()
	for i in range(slotlar.size()):
		if OyuncuEnvanter.envanter.has(i):
			slotlar[i].esya_olusturma(OyuncuEnvanter.envanter[i][0],OyuncuEnvanter.envanter[i][1])

func _ready():
	var slotlar = envanter_slotlari.get_children()
	for i in range(slotlar.size()):
		slotlar[i].connect("gui_input", self, "slot_gui_girdisi", [slotlar[i]])
		slotlar[i].slot_sayisi = i
	envanter_slotlarini_guncelle()

func slot_gui_girdisi(event:InputEvent, slot: SlotSinifi):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if tutulan_esya != null :
				if !slot.esya:
					sol_tik_bos_slot(slot)
				else:
					if tutulan_esya.esya_isim != slot.esya.esya_isim :
						sol_tik_farkli_esya(event, slot)
					else :
						sol_tik_ayni_esya(slot)
			elif slot.esya:
				sol_tik_basilmiyorsa(slot)


func sol_tik_bos_slot(slot: SlotSinifi):
	OyuncuEnvanter.bos_slota_esya_ekle(tutulan_esya, slot)
	slot.SlotaKoyma(tutulan_esya)
	tutulan_esya = null

func sol_tik_farkli_esya(event: InputEvent , slot: SlotSinifi):
	OyuncuEnvanter.esya_sil(slot)
	OyuncuEnvanter.bos_slota_esya_ekle(tutulan_esya, slot)
	var degis_esya = slot.esya
	slot.SlottanSecme()
	degis_esya.global_position = event.global_position
	slot.SlotaKoyma(tutulan_esya)
	tutulan_esya = degis_esya

func sol_tik_ayni_esya(slot: SlotSinifi):
	var birikme_miktari = int(JsonVeri.esya_veri[slot.esya.esya_isim]["BirikmeMiktarı"])
	var degisecek_miktar = birikme_miktari - slot.esya.esya_miktar
	if degisecek_miktar >= tutulan_esya.esya_miktar:
		OyuncuEnvanter.esya_miktar_ekleme(slot, tutulan_esya.esya_miktar)
		slot.esya.esya_miktari_ekle(tutulan_esya.esya_miktar)
		tutulan_esya.queue_free()
		tutulan_esya = null
	else :
		OyuncuEnvanter.esya_miktar_ekleme(slot, degisecek_miktar)
		slot.esya.esya_miktari_ekle(degisecek_miktar)
		tutulan_esya.esya_miktari_azalt(degisecek_miktar)

func sol_tik_basilmiyorsa(slot: SlotSinifi):
	OyuncuEnvanter.esya_sil(slot)
	tutulan_esya = slot.esya
	slot.SlottanSecme()
	tutulan_esya.global_position = get_global_mouse_position()

func _input(_event):
	if tutulan_esya:
		tutulan_esya.global_position = get_global_mouse_position()

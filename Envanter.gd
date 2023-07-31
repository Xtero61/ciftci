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
	for env_slot in envanter_slotlari.get_children():
		env_slot.connect("gui_input", self, "slot_gui_girdisi", [env_slot])
	envanter_slotlarini_guncelle()

func slot_gui_girdisi(event:InputEvent, slot: SlotSinifi):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if tutulan_esya != null :
				if !slot.esya:
					slot.SlotaKoyma(tutulan_esya)
					tutulan_esya = null
				else:
					if tutulan_esya.esya_isim != slot.esya.esya_isim :
						var degis_esya = slot.esya
						slot.SlottanSecme()
						degis_esya.global_position = event.global_position
						slot.SlotaKoyma(tutulan_esya)
						tutulan_esya = degis_esya
					else :
						var birikme_miktari = int(JsonVeri.esya_veri[slot.esya.esya_isim]["BirikmeMiktarı"])
						var degisecek_miktar = birikme_miktari - slot.esya.esya_miktar
						if degisecek_miktar >= tutulan_esya.esya_miktar:
							slot.esya.esya_miktari_ekle(tutulan_esya.esya_miktar)
							tutulan_esya.queue_free()
							tutulan_esya = null
						else :
							slot.esya.esya_miktari_ekle(degisecek_miktar)
							tutulan_esya.esya_miktari_azalt(degisecek_miktar)
			elif slot.esya:
				tutulan_esya = slot.esya
				slot.SlottanSecme()
				tutulan_esya.global_position = get_global_mouse_position()

func _input(_event):
	if tutulan_esya:
		tutulan_esya.global_position = get_global_mouse_position()

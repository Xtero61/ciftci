extends Node2D

const SlotSinifi = preload("res://Envanter/Slot.gd")
onready var envanter_slotlari = $EnvanterSlotlari
onready var animasyonPlayer = $AnimationPlayer

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
		slotlar[i].slot_tip = SlotSinifi.SlotTipi.ENVANTER
	envanter_slotlarini_guncelle()

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
	OyuncuEnvanter.bos_slota_esya_ekle(find_parent("UI").tutulan_esya, slot, OyuncuEnvanter.envanter)
	slot.SlotaKoyma(find_parent("UI").tutulan_esya)
	find_parent("UI").tutulan_esya = null

func sol_tik_farkli_esya(event: InputEvent , slot: SlotSinifi):
	OyuncuEnvanter.esya_sil(slot, OyuncuEnvanter.envanter)
	OyuncuEnvanter.bos_slota_esya_ekle(find_parent("UI").tutulan_esya, slot, OyuncuEnvanter.envanter)
	var degis_esya = slot.esya
	slot.SlottanSecme()
	degis_esya.global_position = event.global_position
	slot.SlotaKoyma(find_parent("UI").tutulan_esya)
	find_parent("UI").tutulan_esya = degis_esya

func sol_tik_ayni_esya(slot: SlotSinifi):
	var birikme_miktari = int(JsonVeri.esya_veri[slot.esya.esya_isim]["BirikmeMiktarı"])
	var degisecek_miktar = birikme_miktari - slot.esya.esya_miktar
	if degisecek_miktar >= find_parent("UI").tutulan_esya.esya_miktar:
		OyuncuEnvanter.esya_miktar_ekleme(slot, find_parent("UI").tutulan_esya.esya_miktar,OyuncuEnvanter.envanter)
		slot.esya.esya_miktari_ekle(find_parent("UI").tutulan_esya.esya_miktar)
		find_parent("UI").tutulan_esya.queue_free()
		find_parent("UI").tutulan_esya = null
	else :
		OyuncuEnvanter.esya_miktar_ekleme(slot, degisecek_miktar, OyuncuEnvanter.envanter)
		slot.esya.esya_miktari_ekle(degisecek_miktar)
		find_parent("UI").tutulan_esya.esya_miktari_azalt(degisecek_miktar)

func sol_tik_basilmiyorsa(slot: SlotSinifi):
	OyuncuEnvanter.esya_sil(slot, OyuncuEnvanter.envanter)
	find_parent("UI").tutulan_esya = slot.esya
	slot.SlottanSecme()
	find_parent("UI").tutulan_esya.global_position = get_global_mouse_position()

func _input(event):
	if find_parent("UI").tutulan_esya:
		find_parent("UI").tutulan_esya.global_position = get_global_mouse_position()
		find_parent("UI").tutulan_esya.visible = true

	if $".".visible: 
		pass
	else :
		if event.is_action_pressed("Yuva0"):
			pass
		elif event.is_action_pressed("Yuva1"):
			OyuncuEnvanter.aktif_slot = 0
			OyuncuEnvanter.hizliErisim_guncelle()
		elif event.is_action_pressed("Yuva2"):
			OyuncuEnvanter.aktif_slot = 1
			OyuncuEnvanter.hizliErisim_guncelle()
		elif event.is_action_pressed("Yuva3"):
			OyuncuEnvanter.aktif_slot = 2
			OyuncuEnvanter.hizliErisim_guncelle()
		elif event.is_action_pressed("Yuva4"):
			OyuncuEnvanter.aktif_slot = 3
			OyuncuEnvanter.hizliErisim_guncelle()
		elif event.is_action_pressed("Yuva5"):
			OyuncuEnvanter.aktif_slot = 4
			OyuncuEnvanter.hizliErisim_guncelle()
		elif event.is_action_pressed("Yuva6"):
			OyuncuEnvanter.aktif_slot = 5
			OyuncuEnvanter.hizliErisim_guncelle()
		elif event.is_action_pressed("Yuva7"):
			OyuncuEnvanter.aktif_slot = 6
			OyuncuEnvanter.hizliErisim_guncelle()
		elif event.is_action_pressed("Yuva8"):
			OyuncuEnvanter.aktif_slot = 7
			OyuncuEnvanter.hizliErisim_guncelle()
		elif event.is_action_pressed("Yuva9"):
			OyuncuEnvanter.aktif_slot = 8
			OyuncuEnvanter.hizliErisim_guncelle()
		

extends Node2D

const SlotSinifi = preload("res://Envanter/Slot.gd")

onready var sandik_slotlari = $SandikSlotlari
onready var slotlar = sandik_slotlari.get_children()
onready var simge_sandik_rengi = $RenkSecici/SandikRenkliIcon
onready var kirmizi = $RenkSecici/Renkler/kirmizi
onready var yesil = $RenkSecici/Renkler/yesil
onready var mavi = $RenkSecici/Renkler/mavi
onready var Sandik = $"."

var SANDIK_SLOT = 17
var sandik = {}
var renklist = [144,109,82]

func sandik_slotlarini_guncelle():
	for i in range(slotlar.size()):
		if sandik.has(i):
			slotlar[i].esya_olusturma(sandik[i][0],sandik[i][1])
			slotlar[i].esya.esya_miktar_yazisi()
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
	find_parent("UI").FareSlot = slot
 
	if event is InputEventMouseButton:

		if ShiftKontrol() :
			if event.button_index == BUTTON_LEFT and event.pressed :
				if slot.esya :
					find_parent("UI").esyayi_sandiktan_envantere_yolla(slot, slot.esya.esya_isim, slot.esya.esya_miktar)

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

func ShiftKontrol():
	if Input.is_action_pressed("Shift"):
		return true
	else :
		return false

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

		OyuncuEnvanter.bos_slot_belli_miktar_esya_ekle(slot.esya,slot,esya_yarisi,sandik)
		find_parent("UI").tutulan_esya = slot.esya
		slot.SlottanSecme()
		find_parent("UI").tutulan_esya.global_position = get_global_mouse_position()
		find_parent("UI").tutulan_esya.esya_miktar = tutulan_esya_yarisi
		find_parent("UI").tutulan_esya.esya_miktar_yazisi()
		sandik_slotlarini_guncelle()

func sag_tik_tutulan_esya_varsa_slottaki_esya_da_ayniysa(slot: SlotSinifi):
	if find_parent("UI").tutulan_esya.esya_miktar > 0:
		var birikme_miktari = int(JsonVeri.esya_veri[slot.esya.esya_isim]["BirikmeMiktarı"])
		if slot.esya.esya_miktar < birikme_miktari :
			find_parent("UI").tutulan_esya.esya_miktari_azalt(1)
			OyuncuEnvanter.esya_miktar_ekleme(slot, 1, sandik)
		if find_parent("UI").tutulan_esya.esya_miktar == 0 :
			find_parent("UI").tutulan_esya.queue_free()
			find_parent("UI").tutulan_esya = null
		sandik_slotlarini_guncelle()

func sag_tik_tutulan_esya_varsa(slot: SlotSinifi):	
	if find_parent("UI").tutulan_esya.esya_miktar > 0:
		find_parent("UI").tutulan_esya.esya_miktari_azalt(1)
		OyuncuEnvanter.bos_slot_belli_miktar_esya_ekle(find_parent("UI").tutulan_esya, slot, 1, sandik)
		if find_parent("UI").tutulan_esya.esya_miktar == 0 :
			find_parent("UI").tutulan_esya.queue_free()
			find_parent("UI").tutulan_esya = null
		sandik_slotlarini_guncelle()

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

func _input(event):
	if Sandik.visible :
		if find_parent("UI").TusKontrol("Ctrl") and event.is_action_pressed("EsyaAtma") :
			if find_parent("UI").FareSlot != null and find_parent("UI").FareSlot.esya :
				if find_parent("UI").FareSlot.get_parent().name == "SandikSlotlari":
					OyuncuEnvanter.yere_esya_atma(find_parent("UI").FareSlot, find_parent("Oyuncu").AtilanEsyaDogma.global_position, 
					find_parent("Oyuncu").esya_atma_yon, sandik, true)
					sandik_slotlarini_guncelle()
		elif event.is_action_pressed("EsyaAtma") :
			if find_parent("UI").FareSlot != null and find_parent("UI").FareSlot.esya :
				if find_parent("UI").FareSlot.get_parent().name == "SandikSlotlari":
					OyuncuEnvanter.yere_esya_atma(find_parent("UI").FareSlot, find_parent("Oyuncu").AtilanEsyaDogma.global_position, 
					find_parent("Oyuncu").esya_atma_yon, sandik)
					sandik_slotlarini_guncelle()


func _on_kirmizi_value_changed(value):
	renklist[0] = float(value)
	$RenkSecici/SandikRenkliIcon.modulate = Color8(renklist[0],renklist[1],renklist[2])


func _on_yesil_value_changed(value):
	renklist[1] = float(value)
	$RenkSecici/SandikRenkliIcon.modulate = Color8(renklist[0],renklist[1],renklist[2])


func _on_mavi_value_changed(value):
	renklist[2] = float(value)
	$RenkSecici/SandikRenkliIcon.modulate = Color8(renklist[0],renklist[1],renklist[2])

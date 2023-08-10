extends CanvasLayer

onready var Envanter = $Envanter
onready var HizliErisim = $HizliErisim

var tutulan_esya = null 

func _input(event):
	if event.is_action_pressed("Envanter"):
		if tutulan_esya != null :
			tutulan_esya.visible = true
		Envanter.visible = !Envanter.visible
		HizliErisim.envanter_acikmi = !HizliErisim.envanter_acikmi
		Envanter.envanter_slotlarini_guncelle()

	if !Envanter.visible :
		if tutulan_esya != null :
			tutulan_esya.visible = false
		if event.is_action_pressed("FareTekerlekYukarı"):
			OyuncuEnvanter.aktif_esya_asagi_cevirme()
		elif event.is_action_pressed("FareTekerlekAşağı"):
			OyuncuEnvanter.aktif_esya_yukari_cevirme()

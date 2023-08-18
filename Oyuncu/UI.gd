extends CanvasLayer

onready var Envanter = $Envanter
onready var HizliErisim = $HizliErisim
onready var Sandik = $Sandik_slotlari

var tutulan_esya = null
var sandiklar = []

func _input(event):
	if event.is_action_pressed("Envanter"):
		if tutulan_esya != null :
			tutulan_esya.visible = true
		Envanter.visible = !Envanter.visible
		if Envanter.visible and !sandiklar.empty() :
			Sandik.visible = true
			Envanter.animasyonPlayer.play("SandıkAçık")
		else :
			Sandik.visible = false
			Envanter.animasyonPlayer.play("SandıkKapalı")
		HizliErisim.envanter_acikmi = !HizliErisim.envanter_acikmi
		Envanter.envanter_slotlarini_guncelle()

	if !Envanter.visible :
		if tutulan_esya != null :
			tutulan_esya.visible = false
		if event.is_action_pressed("FareTekerlekYukarı"):
			OyuncuEnvanter.aktif_esya_asagi_cevirme()
		elif event.is_action_pressed("FareTekerlekAşağı"):
			OyuncuEnvanter.aktif_esya_yukari_cevirme()

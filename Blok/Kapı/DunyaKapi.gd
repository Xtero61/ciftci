extends Node2D

onready var animasyonPlayer = $AnimationPlayer
onready var vurulmaPlayer = $VurulmaPlayer 

var VurulmaSayi : int = 0
var KirilmaSayi : int = 3

func kapi_etrafi_kontrol():
	Genel._KapiUstu("Koyma",global_position)

func _on_Kapi_body_entered(body):
	if body.name == "Oyuncu":
		animasyonPlayer.play("Açılma")

func _on_Kapi_body_exited(body):
	if body.name == "Oyuncu":
		animasyonPlayer.play("Kapanma")

func _on_KapiKirilma_area_entered(area):
	if area.name == "Cekic":
		VurulmaSayi += 1
		vurulmaPlayer.play("Vurulma")
		if VurulmaSayi == KirilmaSayi :
			Genel._KapiUstu("Silme",global_position)
			queue_free()

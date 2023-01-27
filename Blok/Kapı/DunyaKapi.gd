extends Node2D

onready var animasyonPlayer = $AnimationPlayer 

var VurulmaSayi : int = 0
var KirilmaSayi : int = 3

func _on_Kapi_body_entered(body):
	if body.name == "Oyuncu":
		animasyonPlayer.play("Açılma")

func _on_Kapi_body_exited(body):
	if body.name == "Oyuncu":
		animasyonPlayer.play("Kapanma")

func _on_KapiKirilma_area_entered(area):
	if area.name == "Cekic":
		VurulmaSayi += 1
		if VurulmaSayi == KirilmaSayi :
			queue_free()

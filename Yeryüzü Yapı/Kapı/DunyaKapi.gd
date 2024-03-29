extends Node2D

onready var animasyonPlayer = $AnimationPlayer
onready var vurulmaPlayer = $VurulmaPlayer 
onready var kapiAnimasyon = $KapiAnimasyon
onready var TimerYokOlma = $TimerYokOlma

var VurulmaSayi : int = 0
var KirilmaSayi : int = 3

func _ready():
	kapi_etrafi_kontrol()

func kapi_etrafi_kontrol():
	TilemapGenel._KapiUstuKoy(global_position)

func _on_Kapi_body_entered(body):
	if body.name == "Oyuncu":
		animasyonPlayer.play("Kapi_anim")

func _on_Kapi_body_exited(body):
	if body.name == "Oyuncu":
		animasyonPlayer.play("Kapi_anim",-1,-1,true)

func _on_KapiKirilma_area_entered(area):
	if area.name == "Cekic":
		VurulmaSayi += 1
		vurulmaPlayer.play("Vurulma")
		if VurulmaSayi == KirilmaSayi :
			TilemapGenel._YapiYapmaKapiSil(global_position)
			TimerYokOlma.start()

func _on_KapiYonuCevirSol_area_entered(area):
	if area.name == "KapiKirilma":
		kapiAnimasyon.scale.x = -1

func _on_KapiYonuCevirSag_area_entered(area):
	if area.name == "KapiKirilma":
		kapiAnimasyon.scale.x = 1

func _on_TimerYokOlma_timeout():
	TilemapGenel._KapiUstuSil(global_position)
	queue_free()

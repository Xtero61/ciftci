extends Node2D

onready var VurulmaEfek = $VurulmaEfek
onready var animasyonPlayer = $AnimationPlayer
onready var TimerYokOlma = $TimerYokOlma
onready var Cevir = $Cevir
onready var AgacUst = $Cevir/AgacUst 
onready var AgacAlt = $Cevir/AgacAlt

export var YikilmaSayi : int = 10

var VurulmaSayi : int = 0
var VurulmaYonu : Vector2


func _on_AgacArea_area_entered(area):

	if area.name == "Balta" :
		VurulmaSayi += 1

		if VurulmaSayi <= YikilmaSayi :
			VurulmaYonu = area.global_position.direction_to(global_position).normalized()
			animasyonPlayer.play("Vurulma")
			VurulmaEfek.rotation = VurulmaYonu.angle()
			VurulmaEfek.emitting = true

		if VurulmaSayi == YikilmaSayi :
			VurulmaYonu = area.global_position.direction_to(global_position).normalized()

			if VurulmaYonu.x > 0 :
				animasyonPlayer.play("Yıkılma")
			else :
				Cevir.scale.x = -1
				AgacUst.flip_h = true
				AgacAlt.flip_h = true
				animasyonPlayer.play("Yıkılma")
			TimerYokOlma.start()

func _on_TimerYokOlma_timeout():
	queue_free()

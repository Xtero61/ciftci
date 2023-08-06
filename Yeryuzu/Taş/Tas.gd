extends Node2D

onready var VurulmaEfek = $VurulmaEfek
onready var animasyonPlayer = $AnimationPlayer
onready var TimerYokOlma = $TimerYokOlma

export var YikilmaSayi : int = 10

var VurulmaSayi : int = 0
var VurulmaYonu : Vector2

func _on_TasArea_area_entered(area):

	if area.name == "Kazma":
		VurulmaSayi += 1

		if VurulmaSayi <= YikilmaSayi :
			VurulmaYonu = area.global_position.direction_to(global_position).normalized()
			animasyonPlayer.play("Vurulma")
			VurulmaEfek.rotation = VurulmaYonu.angle()
			VurulmaEfek.emitting = true

		if VurulmaSayi == YikilmaSayi :
			VurulmaYonu = area.global_position.direction_to(global_position).normalized()
			animasyonPlayer.play("Kırılma")
			TimerYokOlma.start()

func _on_TimerYokOlma_timeout():
	queue_free()



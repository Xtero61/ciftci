extends Node2D

onready var VurulmaEfek = $VurulmaEfek
onready var animasyonPlayer = $AnimationPlayer
onready var TimerYokOlma = $TimerYokOlma
onready var dunya_esya = load("res://Esyalar/DunyaEsya.tscn")

export var YikilmaSayi : int = 10

var Dunya_yolu : String = "/root/Dunya/Yapi"
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
			
			for _i in range(4 + randi() % 3): #[ 4 , 6 ] sayı üretiyor
				var esya = dunya_esya.instance()
				esya.global_position = global_position
				esya.yer_esya_isim = "Taş"
				get_node(Dunya_yolu).call_deferred("add_child",esya)

func _on_TimerYokOlma_timeout():
	queue_free()



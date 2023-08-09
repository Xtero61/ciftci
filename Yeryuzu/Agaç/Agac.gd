extends Node2D

onready var VurulmaEfek = $VurulmaEfek
onready var animasyonPlayer = $AnimationPlayer
onready var TimerYokOlma = $TimerYokOlma
onready var Cevir = $Cevir
onready var AgacUst = $Cevir/AgacUst 
onready var AgacAlt = $Cevir/AgacAlt
onready var dunya_esya = load("res://Esyalar/DunyaEsya.tscn")

export var YikilmaSayi : int = 10

var VurulmaSayi : int = 0
var VurulmaYonu : Vector2
var Dunya_yolu : String = "/root/Dunya/Yapi"


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

			for _i in range(4 + randi() % 3): #[ 4 , 6 ] sayı üretiyor
				var esya = dunya_esya.instance()
				esya.global_position = global_position
				esya.yer_esya_isim = "Odun"
				get_node(Dunya_yolu).call_deferred("add_child",esya)

func _on_TimerYokOlma_timeout():
	queue_free()

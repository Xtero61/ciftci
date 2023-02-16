extends Area2D

onready var BuyukDaire = $BuyukDaire
onready var KucukDaire = $BuyukDaire/KucukDaire

onready var maks_mesafe = $CollisionShape2D.shape.radius

var yon = Vector2.ZERO
var Dokundu = false

func _input(event):
	if event is InputEventScreenTouch:
		var mesafe = event.position.distance_to(BuyukDaire.global_position)
		if not Dokundu :
			if mesafe < maks_mesafe :
				Dokundu = true
		else :
			KucukDaire.position = Vector2.ZERO
			Dokundu = false

func _process(delta):
	if Dokundu :
		yon = $".".global_position.direction_to(KucukDaire.global_position)
		KucukDaire.global_position = get_global_mouse_position()
		KucukDaire.position = BuyukDaire.position + (KucukDaire.position-BuyukDaire.position).clamped(maks_mesafe)
	else :
		yon = Vector2.ZERO

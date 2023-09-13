extends RigidBody2D

onready var resim = $Sprite

var yer_esya_isim
var yer_esya_miktar
var oyuncu = null
var aliniyor = false
var hiz : Vector2 = Vector2.ZERO

func _ready():
	resim.texture = load(JsonVeri.esya_veri[yer_esya_isim]["ResimYolu"])
	set_linear_velocity(Vector2(rand_range(200, -200),rand_range(200, -200)))
	yer_esya_miktar = 1

func _physics_process(delta):
	if aliniyor == true :
		var yon = global_position.direction_to(oyuncu.global_position)
		apply_impulse(yon,yon*1000*delta)

		var mesafe = global_position.distance_to(oyuncu.global_position)
		if mesafe < 12 :
			queue_free()

func alinan_esya(body):
	oyuncu = body
	aliniyor = true

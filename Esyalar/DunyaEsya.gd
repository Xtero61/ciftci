extends RigidBody2D

onready var resim = $Sprite
onready var resim2 = $Sprite2

var yer_esya_isim
var yer_esya_miktar : int = 1
var oyuncu = null
var aliniyor = false
var hiz : Vector2 = Vector2.ZERO
var yon : Vector2 = Vector2.ZERO

func _ready():
	resim.texture = load(JsonVeri.esya_veri[yer_esya_isim]["ResimYolu"])
	resim2.texture = load(JsonVeri.esya_veri[yer_esya_isim]["ResimYolu"])

	if yer_esya_miktar > 2 :
		resim2.visible = true

	if yon == Vector2.ZERO :
		set_linear_velocity(Vector2(rand_range(200, -200),rand_range(200, -200)))
	else :
		set_linear_velocity(Vector2(float(yon.x*200),float(yon.y*200)))

func _physics_process(delta):
	if aliniyor == true :
		var cekilme_yon = global_position.direction_to(oyuncu.global_position)
		apply_impulse(cekilme_yon,cekilme_yon*1000*delta)

		var mesafe = global_position.distance_to(oyuncu.global_position)
		if mesafe < 12 :
			queue_free()

func alinan_esya(body):
	oyuncu = body
	aliniyor = true

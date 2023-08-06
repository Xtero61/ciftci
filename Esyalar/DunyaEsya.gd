extends RigidBody2D


var yer_esya_isim
var yer_esya_miktar
onready var resim = $Sprite

func _ready():
	yer_esya_isim = "Odun"
	resim.texture = load(JsonVeri.esya_veri[yer_esya_isim]["ResimYolu"])

var oyuncu = null
var aliniyor = false
var hiz : Vector2 = Vector2.ZERO

func _physics_process(delta):
	if aliniyor == true :
		var yon = global_position.direction_to(oyuncu.global_position)
		apply_impulse(yon,yon*1000*delta)

		var mesafe = global_position.distance_to(oyuncu.global_position)
		if mesafe < 12 :
			OyuncuEnvanter.esya_ekleme(yer_esya_isim, 1)
			queue_free()

func alinan_esya(body):
	oyuncu = body
	aliniyor = true

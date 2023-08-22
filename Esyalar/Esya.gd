extends Node2D

var esya_isim = null
var esya_miktar = null

onready var resim = $TextureRect
onready var esya_g_sayi = $Label

func _ready():
	var random = randi() % 3
	if random == 0 :
		esya_isim = "Odun"
	elif random == 1 :
		esya_isim = "Taş Kazma"
	else :
		esya_isim = "Taş Balta"

	$TextureRect.texture = load(JsonVeri.esya_veri[esya_isim]["ResimYolu"])
	var yigin_boyu = int(JsonVeri.esya_veri[esya_isim]["BirikmeMiktarı"])
	esya_miktar = randi() % yigin_boyu + 1

	esya_miktar_yazisi()

func esya_miktar_yazisi() :
	if esya_miktar == 1:
		$Label.visible = false
	else:
		$Label.visible = true
		$Label.text = String(esya_miktar)

func esya_ayarla(esya_is, esya_mik):
	esya_isim = esya_is
	esya_miktar = esya_mik

	resim.texture = load(JsonVeri.esya_veri[esya_isim]["ResimYolu"])
	
	var yigin_boyu = int(JsonVeri.esya_veri[esya_isim]["BirikmeMiktarı"])
	if yigin_boyu == 1:
		esya_g_sayi.visible = false
	else :
		esya_g_sayi.visible = true
		esya_g_sayi.text = String(esya_miktar)

func esya_miktari_ekle(eklencek_miktar):
	esya_miktar += eklencek_miktar
	esya_miktar_yazisi()

func esya_miktari_azalt(azaltilacak_miktar):
	esya_miktar -= azaltilacak_miktar
	esya_miktar_yazisi()

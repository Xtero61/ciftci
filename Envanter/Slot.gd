extends Panel

var dolu_resim = preload("res://Envanter/Resimler/DoluSlot.png")
var bos_resim = preload("res://Envanter/Resimler/Slot.png")

var dolu_style : StyleBoxTexture = null
var bos_style : StyleBoxTexture = null

var EsyaSinifi = preload("res://Esyalar/Esya.tscn")
var esya = null
var slot_sayisi

func _ready():
	dolu_style = StyleBoxTexture.new()
	bos_style = StyleBoxTexture.new()
	dolu_style.texture = dolu_resim
	bos_style.texture = bos_resim

#	if randi() % 2 == 0:
#		esya = EsyaSinifi.instance()
#		add_child(esya)
	style_yenile()

func style_yenile():
	if esya == null :
		set('custom_styles/panel',bos_style)
	else :
		set('custom_styles/panel',dolu_style)

func SlottanSecme():
	remove_child(esya)
	var envanterNode = find_parent("Envanter")
	envanterNode.add_child(esya)
	esya = null
	style_yenile()

func SlotaKoyma(yeni_esya):
	esya = yeni_esya
	esya.position = Vector2(0,0)
	var envanterNode = find_parent("Envanter")
	envanterNode.remove_child(esya)
	add_child(esya)
	style_yenile()

func esya_olusturma(esya_isim, esya_miktar):
	if esya == null:
		esya = EsyaSinifi.instance()
		add_child(esya)
		esya.esya_ayarla(esya_isim, esya_miktar)
	else :
		esya.esya_ayarla(esya_isim, esya_miktar)
	style_yenile()

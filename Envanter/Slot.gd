extends Panel

var dolu_resim = preload("res://Envanter/Resimler/DoluSlot.png")
var bos_resim = preload("res://Envanter/Resimler/Slot.png")
var secili_resim = preload("res://Envanter/Resimler/SlotSeçili.png")

var dolu_style : StyleBoxTexture = null
var bos_style : StyleBoxTexture = null
var secili_style : StyleBoxTexture = null
var aktif_slot : bool

var UI : String = "/root/Dunya/Yapi/Oyuncu/UI"
var EsyaSinifi = preload("res://Esyalar/Esya.tscn")
var esya = null
var slot_sayisi
var slot_tip

enum SlotTipi{
	HIZLIERISIM = 0,
	ENVANTER,
}

func _ready():
	dolu_style = StyleBoxTexture.new()
	bos_style = StyleBoxTexture.new()
	secili_style = StyleBoxTexture.new()
	dolu_style.texture = dolu_resim
	bos_style.texture = bos_resim
	secili_style.texture = secili_resim

#	if randi() % 2 == 0:
#		esya = EsyaSinifi.instance()
#		add_child(esya)
	style_yenile()

func style_yenile():
	if SlotTipi.HIZLIERISIM == slot_tip and OyuncuEnvanter.aktif_slot == slot_sayisi:
		set('custom_styles/panel',secili_style)
		aktif_slot = true
	elif esya == null :
		set('custom_styles/panel',bos_style)
		aktif_slot = false
	else :
		set('custom_styles/panel',dolu_style)
		aktif_slot = false

func SlottanSecme():
	remove_child(esya)
	var envanterNode = get_node(UI)
	envanterNode.add_child(esya)
	esya = null
	style_yenile()

func SlotaKoyma(yeni_esya):
	esya = yeni_esya
	esya.position = Vector2(0,0)
	var envanterNode = get_node(UI)
	envanterNode.remove_child(esya)
	add_child(esya)
	style_yenile()

func esya_sil():
	remove_child(esya)
	esya = null
	style_yenile()

func esya_olusturma(esya_isim, esya_miktar):
	if esya == null:
		esya = EsyaSinifi.instance()
		add_child(esya)
		esya.esya_ayarla(esya_isim, esya_miktar)
	else :
		esya.esya_ayarla(esya_isim, esya_miktar)
	style_yenile()
	esya.esya_miktar_yazisi()

func _on_slot1_mouse_exited():
	find_parent("UI").FareSlot = null


func _on_slot2_mouse_exited():
	find_parent("UI").FareSlot = null


func _on_slot3_mouse_exited():
	find_parent("UI").FareSlot = null


func _on_slot4_mouse_exited():
	find_parent("UI").FareSlot = null


func _on_slot5_mouse_exited():
	find_parent("UI").FareSlot = null


func _on_slot6_mouse_exited():
	find_parent("UI").FareSlot = null


func _on_slot7_mouse_exited():
	find_parent("UI").FareSlot = null


func _on_slot8_mouse_exited():
	find_parent("UI").FareSlot = null


func _on_slot9_mouse_exited():
	find_parent("UI").FareSlot = null


func _on_slot10_mouse_exited():
	find_parent("UI").FareSlot = null


func _on_slot11_mouse_exited():
	find_parent("UI").FareSlot = null


func _on_slot12_mouse_exited():
	find_parent("UI").FareSlot = null


func _on_slot13_mouse_exited():
	find_parent("UI").FareSlot = null


func _on_slot14_mouse_exited():
	find_parent("UI").FareSlot = null


func _on_slot15_mouse_exited():
	find_parent("UI").FareSlot = null


func _on_slot16_mouse_exited():
	find_parent("UI").FareSlot = null


func _on_slot17_mouse_exited():
	find_parent("UI").FareSlot = null


func _on_slot18_mouse_exited():
	find_parent("UI").FareSlot = null

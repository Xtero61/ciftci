extends Node2D

onready var imlec_resim = $imlec
const kare_boyu = 16.0

func _process(_delta):
	var Kurek_Capa = get_parent().Esya_Vurma_Yer.global_position + Vector2(8,8)
	imlec_resim.global_position = Vector2(stepify(Kurek_Capa.x , kare_boyu) , stepify(Kurek_Capa.y , kare_boyu)) - Vector2(8,8)
	
#	var mouse_pos = get_global_mouse_position()
#
#	area.position.x = stepify(mouse_posx , 16)
#	area.position.y = stepify(mouse_pos.y , 16)

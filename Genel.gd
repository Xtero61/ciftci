extends Node2D

const YERYUZU_TILEMAP : String = "/root/Dunya/Yeryuzu"
const TARLA_TILEMAP : String = "/root/Dunya/Tarla"
const YAPI_TILEMAP : String = "/root/Dunya/Yapi"
const CATI_TILEMAP : String = "/root/Dunya/Cati"

#Yeryüzü döşeme sayıları
const yeryuzu_kara : int = 3
const yeryuzu_kenar_kara : int = 2
const yeryuzu_deniz : int = 1

#Tarla döşeme sayıları
const tarla_toprak : int = 0
const tarla_suru_toprak : int = 1
const tarla_suru_toprak_1 : int = 2
const tarla_sulu_toprak : int = 3

#Yapı döşeme sayıları
const yapi_duvar : int = 0
const yapi_duvar_camli : int = 1
const yapi_kapi : int = 2 
const yapi_cati : int = 0
const bos : int = -1


var Kapisahne = load("res://Blok/Kapı/DunyaKapi.tscn")

func _TarlaYapma(Koy_Sil_Sula,Fare_yer): 

	#aldığı kordinatı tilemap kordinatına çevirir
	var tile = get_node(TARLA_TILEMAP).world_to_map(Fare_yer)
	
	if Koy_Sil_Sula == "Koy" :
		#tarlayı haritanın sulu yerine yapılmaması için olan if
		if get_node(YERYUZU_TILEMAP).get_cell(tile.x,tile.y) == yeryuzu_kara :
			if get_node(YAPI_TILEMAP).get_cell(tile.x,tile.y-1) == bos :

				#verilen kordinata tarla_toprak koyar
				if get_node(TARLA_TILEMAP).get_cell(tile.x,tile.y) == bos :
					get_node(TARLA_TILEMAP).set_cell(tile.x,tile.y,tarla_toprak)
					get_node(TARLA_TILEMAP).update_bitmask_region(tile,tile)

				#verilen kordinat tarla_toprak ise tarla_suru_toprak koyar
				elif get_node(TARLA_TILEMAP).get_cell(tile.x,tile.y) == tarla_toprak :
					get_node(TARLA_TILEMAP).set_cell(tile.x,tile.y,tarla_suru_toprak)
					get_node(TARLA_TILEMAP).update_bitmask_region(tile,tile)

				#verilen kordinat tarla_suru_toprak ise tarla_suru_toprak_1 koyar
				elif get_node(TARLA_TILEMAP).get_cell(tile.x,tile.y) == tarla_suru_toprak :
					get_node(TARLA_TILEMAP).set_cell(tile.x,tile.y,tarla_suru_toprak_1)
					get_node(TARLA_TILEMAP).update_bitmask_region(tile,tile)

	elif Koy_Sil_Sula == "Sula" :
		if get_node(TARLA_TILEMAP).get_cell(tile.x,tile.y) == tarla_suru_toprak_1 :
			get_node(TARLA_TILEMAP).set_cell(tile.x,tile.y,tarla_sulu_toprak)
			get_node(TARLA_TILEMAP).update_bitmask_region(tile,tile)

	elif Koy_Sil_Sula == "Sil" :
		get_node(TARLA_TILEMAP).set_cell(tile.x,tile.y,bos)
		get_node(TARLA_TILEMAP).update_bitmask_region(tile,tile)

func _YapiYapma(Koy_Sil_Cati,YapilanYapi,Fare_yer):
	#aldığı kordinatı tilemap kordinatına çevirir
	var tile = get_node(YAPI_TILEMAP).world_to_map(Fare_yer)
	
	if Koy_Sil_Cati == "Koy":
		#Yapının haritanın sulu yerine yapılmaması için olan if
		if get_node(YERYUZU_TILEMAP).get_cell(tile.x,tile.y) == yeryuzu_kara :
			if YapilanYapi == yapi_kapi :
				var Kapi = Kapisahne.instance()
				get_node(YAPI_TILEMAP).add_child(Kapi)
				Kapi.global_position = Fare_yer

			elif get_node(YAPI_TILEMAP).get_cell(tile.x,tile.y-1) == bos :
				get_node(YAPI_TILEMAP).set_cell(tile.x,tile.y-1,YapilanYapi)
				get_node(YAPI_TILEMAP).update_bitmask_region(tile,tile)

	elif Koy_Sil_Cati == "Cati":
		get_node(CATI_TILEMAP).set_cell(tile.x,tile.y,YapilanYapi)
		get_node(CATI_TILEMAP).update_bitmask_region(tile,tile)

	elif Koy_Sil_Cati == "Sil" :
		if get_node(CATI_TILEMAP).get_cell(tile.x,tile.y) != bos :
			get_node(CATI_TILEMAP).set_cell(tile.x,tile.y,bos)
			get_node(CATI_TILEMAP).update_bitmask_region(tile,tile)
		else:
			get_node(YAPI_TILEMAP).set_cell(tile.x,tile.y-1,bos)
			get_node(YAPI_TILEMAP).update_bitmask_region(tile,tile)


func _CatiAltindaMi(Oyuncu_Yer):
	var tile = get_node(CATI_TILEMAP).world_to_map(Oyuncu_Yer)
	if get_node(CATI_TILEMAP).get_cell(tile.x,tile.y-1) != bos :
		get_node(CATI_TILEMAP).modulate = Color("b4ffffff")
	else :
		get_node(CATI_TILEMAP).modulate = Color("ffffffff")

extends Node2D

const YERYUZU_TILEMAP : String = "/root/Dunya/Navigation2D/Yeryuzu"
const TARLA_TILEMAP : String = "/root/Dunya/Tarla"
const YAPI_TILEMAP : String = "/root/Dunya/Yapi"
const CATI_TILEMAP : String = "/root/Dunya/Cati"
const CATILAR : String = "/root/Dunya/Catilar"
const ZEMIN_TILEMAP : String = "/root/Dunya/Zemin"

#Yeryüzü döşeme sayıları
const yeryuzu_kara : int = 3
const yeryuzu_kenar_kara : int = 2
const yeryuzu_deniz : int = 1

enum Yeryuzu {
	deniz = 1,
	kenar_kara,
	kara,
}

#Tarla döşeme sayıları
const tarla_toprak : int = 0
const tarla_suru_toprak : int = 1
const tarla_suru_toprak_1 : int = 2
const tarla_sulu_toprak : int = 3

#Yapı döşeme sayıları
const yapi_duvar : int = 0
const yapi_duvar_camli : int = 1
const yapi_kapi : int = 2
const yapi_kapi_ust : int = 4
const yapi_cati : int = 0
const yapi_sandik : int = 5
const bos : int = -1

const zemin : int = 0

var SulamaEfekSahne = load("res://SulamaEfek.tscn")
var Kapisahne = load("res://Yeryüzü Yapı/Kapı/DunyaKapi.tscn")
var Sandiksahne = load("res://Yeryüzü Yapı/Sandık/Sandik.tscn")

var CatiListesi = []

func _CatiSil(Fare_yer):
	var bayrak = false
	for cati in CatiListesi:
		var tile = cati.world_to_map(Fare_yer)
		if cati.get_cell(tile.x,tile.y) != bos :
			cati.set_cell(tile.x,tile.y,bos)
			cati.update_bitmask_region(tile,tile)
			bayrak = true
	return bayrak

func _CatiVarmiYakinda(Fare_yer):
	for cati in CatiListesi:
		var tile = cati.world_to_map(Fare_yer)
		if (cati.get_cell(tile.x-1,tile.y) != bos or
			cati.get_cell(tile.x+1,tile.y) != bos or 
			cati.get_cell(tile.x,tile.y-1) != bos or
			cati.get_cell(tile.x,tile.y+1) != bos) :
			return cati
	return null

func _CatiKoy(Fare_yer):
	var secili_tilemap = _CatiVarmiYakinda(Fare_yer)
	if secili_tilemap == null :
		secili_tilemap = TileMap.new()
		secili_tilemap.set_tileset(get_node(CATI_TILEMAP).get_tileset())
		secili_tilemap.set_cell_size(Vector2(16, 16))
		CatiListesi.append(secili_tilemap)
		get_node(CATILAR).add_child(secili_tilemap)

	var tile = secili_tilemap.world_to_map(Fare_yer)
	secili_tilemap.set_cell(tile.x,tile.y,yapi_cati)
	secili_tilemap.update_bitmask_region(tile,tile)

func _TarlaYapmaKoy(Fare_yer):
	var tile = get_node(TARLA_TILEMAP).world_to_map(Fare_yer)

	#tarlayı haritanın sulu yerine yapılmaması için olan if
	if _YapiYapmaZeminKontrol(tile) :
		if get_node(YAPI_TILEMAP).get_cell(tile.x,tile.y) == bos :
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

func _TarlaYapmaSula(Fare_yer):
	var tile = get_node(TARLA_TILEMAP).world_to_map(Fare_yer)

	if get_node(TARLA_TILEMAP).get_cell(tile.x,tile.y) == tarla_suru_toprak_1 :
		get_node(TARLA_TILEMAP).set_cell(tile.x,tile.y,tarla_sulu_toprak)
		get_node(TARLA_TILEMAP).update_bitmask_region(tile,tile)
		var SulamaEfek = SulamaEfekSahne.instance()
		get_node(YAPI_TILEMAP).add_child(SulamaEfek)
		SulamaEfek.global_position = Fare_yer

func _TarlaYapmaSil(Fare_yer):
	var tile = get_node(TARLA_TILEMAP).world_to_map(Fare_yer)

	get_node(TARLA_TILEMAP).set_cell(tile.x,tile.y,bos)
	get_node(TARLA_TILEMAP).update_bitmask_region(tile,tile)

func _TarlaYapmaKontrol(Fare_yer):
	var tile = get_node(TARLA_TILEMAP).world_to_map(Fare_yer)

	if get_node(TARLA_TILEMAP).get_cell(tile.x,tile.y) == tarla_suru_toprak_1 :
		return true
	else :
		return false

func _TarlaYapmaSuDoldur(Fare_yer):
	var tile = get_node(TARLA_TILEMAP).world_to_map(Fare_yer)

	if get_node(YERYUZU_TILEMAP).get_cell(tile.x,tile.y) == yeryuzu_kenar_kara or get_node(YERYUZU_TILEMAP).get_cell(tile.x,tile.y) == yeryuzu_deniz :
		return true
	else :
		return false

func _YapiYapmaZeminKontrol(tile):
	if get_node(YERYUZU_TILEMAP).get_cell(tile.x,tile.y) == yeryuzu_kara and get_node(YAPI_TILEMAP).get_cell(tile.x,tile.y) == bos :
		return true
	else:
		return false

func _YapiYapmaKoy(YapilanYapi, Fare_yer):
	var tile = get_node(YAPI_TILEMAP).world_to_map(Fare_yer)

	#Yapının haritanın sulu yerine yapılmaması için olan if
	if _YapiYapmaZeminKontrol(tile) :
		if YapilanYapi == yapi_kapi :
			var Kapi = Kapisahne.instance()
			get_node(YAPI_TILEMAP).add_child(Kapi)
			Kapi.global_position = get_node(YAPI_TILEMAP).map_to_world(tile) + Vector2(8,8)
			get_node(YAPI_TILEMAP).set_cell(tile.x,tile.y,yapi_kapi)

		elif YapilanYapi == yapi_sandik :
			var Sandik = Sandiksahne.instance()
			get_node(YAPI_TILEMAP).add_child(Sandik)
			Sandik.global_position = get_node(YAPI_TILEMAP).map_to_world(tile) + Vector2(8,8)
			get_node(YAPI_TILEMAP).set_cell(tile.x,tile.y,yapi_sandik)

		else :
			get_node(YAPI_TILEMAP).set_cell(tile.x,tile.y,YapilanYapi)
			get_node(YAPI_TILEMAP).update_bitmask_region(tile,tile)

	_YapiYapmaKapiEtrafiKontrol()

func _YapiYapmaSil(Fare_yer):
	var tile = get_node(YAPI_TILEMAP).world_to_map(Fare_yer)

	if !_CatiSil(Fare_yer):
		if get_node(YAPI_TILEMAP).get_cell(tile.x,tile.y) != bos :
			if get_node(YAPI_TILEMAP).get_cell(tile.x,tile.y) != yapi_kapi and get_node(YAPI_TILEMAP).get_cell(tile.x,tile.y) != yapi_sandik :
				get_node(YAPI_TILEMAP).set_cell(tile.x,tile.y,bos)
				get_node(YAPI_TILEMAP).update_bitmask_region(tile,tile)
		else :
			get_node(ZEMIN_TILEMAP).set_cell(tile.x,tile.y,bos)
			get_node(ZEMIN_TILEMAP).update_bitmask_region(tile,tile)

	_YapiYapmaKapiEtrafiKontrol()

func _YapiYapmaKapiSil(Fare_yer):
	var tile = get_node(YAPI_TILEMAP).world_to_map(Fare_yer)

	get_node(YAPI_TILEMAP).set_cell(tile.x,tile.y,bos)
	get_node(YAPI_TILEMAP).update_bitmask_region(tile,tile)

	_YapiYapmaKapiEtrafiKontrol()

func _YapiYapmaCati(Fare_yer):
	_CatiKoy(Fare_yer)

func _YapiYapmaKapiEtrafiKontrol():
	get_tree().call_group("Kapi","kapi_etrafi_kontrol")

func _KapiUstuKoy(Kapi_yer):
	var tile = get_node(YAPI_TILEMAP).world_to_map(Kapi_yer)

	if ((get_node(YAPI_TILEMAP).get_cell(tile.x-1,tile.y) == yapi_duvar or get_node(YAPI_TILEMAP).get_cell(tile.x-1,tile.y) == yapi_duvar_camli)
	 or (get_node(YAPI_TILEMAP).get_cell(tile.x+1,tile.y) == yapi_duvar or get_node(YAPI_TILEMAP).get_cell(tile.x+1,tile.y) == yapi_duvar_camli)):
		get_node(YAPI_TILEMAP).set_cell(tile.x,tile.y+1,yapi_kapi_ust)
		get_node(YAPI_TILEMAP).update_bitmask_region(tile,tile)

	elif ((get_node(YAPI_TILEMAP).get_cell(tile.x-1,tile.y) != yapi_duvar or get_node(YAPI_TILEMAP).get_cell(tile.x-1,tile.y) != yapi_duvar_camli)
	   or (get_node(YAPI_TILEMAP).get_cell(tile.x+1,tile.y) != yapi_duvar or get_node(YAPI_TILEMAP).get_cell(tile.x+1,tile.y) != yapi_duvar_camli)):
		_KapiUstuSil(Kapi_yer)

func _ZeminYapKoy(YapilanYapi, Fare_yer):
	var tile = get_node(TARLA_TILEMAP).world_to_map(Fare_yer)
	
	if _YapiYapmaZeminKontrol(tile) :
		if get_node(YAPI_TILEMAP).get_cell(tile.x,tile.y) == bos :
			get_node(ZEMIN_TILEMAP).set_cell(tile.x, tile.y, YapilanYapi)
			get_node(ZEMIN_TILEMAP).update_bitmask_region(tile,tile)

func _KapiUstuSil(Kapi_yer):
	var tile = get_node(YAPI_TILEMAP).world_to_map(Kapi_yer)

	get_node(YAPI_TILEMAP).set_cell(tile.x,tile.y+1,bos)
	get_node(YAPI_TILEMAP).update_bitmask_region(tile,tile)

func _CatiAltindaMi(Oyuncu_Yer):
	var tile = get_node(CATI_TILEMAP).world_to_map(Oyuncu_Yer)
	if get_node(CATI_TILEMAP).get_cell(tile.x,tile.y-2) != bos :
		get_node(CATI_TILEMAP).modulate = Color("70ffffff")
	else :
		get_node(CATI_TILEMAP).modulate = Color("ffffffff")

	for cati in CatiListesi:
		if cati.get_cell(tile.x,tile.y-2) != bos :
			cati.modulate = Color("70ffffff")
		else:
			cati.modulate = Color("ffffffff")
	

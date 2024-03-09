extends Node

onready var ismim = $".".name
onready var TimerEfek = $TimerEfek
onready var Simge = $Simge
onready var Efek = $Simge/Efek

var cekicMenuSecili = 0
var cekicMenu = false

func _process(_delta):
	if ! find_parent("Oyuncu").Envanter.visible :
		if Input.is_action_just_pressed("YapıMenu"):
			if cekicMenu :
				$YapiMenu/ana/AnimationPlayer.play("Kapanma")
				cekicMenuSecili = $YapiMenu/ana/Menu.frame
			else :
				$YapiMenu/ana/AnimationPlayer.play("Açılma")
			cekicMenu = !cekicMenu

func Islev_Oynat(Yapilacak_Yer):
	Efek.visible = true
	TimerEfek.start()
	if cekicMenuSecili == 0 : 
		$VurmaAlan.disabled = false

	if cekicMenuSecili == 1 :
		YapiYap(TilemapGenel.yapi_duvar, Yapilacak_Yer)
	elif cekicMenuSecili == 2 :
		YapiYap(TilemapGenel.yapi_duvar_camli, Yapilacak_Yer)
	elif cekicMenuSecili == 3 :
		YapiYap(TilemapGenel.yapi_kapi, Yapilacak_Yer)
	elif cekicMenuSecili == 4 :
		YapiYapCati(Yapilacak_Yer)
	elif cekicMenuSecili == 5 :
		ZeminYap(TilemapGenel.zemin, Yapilacak_Yer)
	elif cekicMenuSecili == 6 :
		YapiYap(TilemapGenel.yapi_sandik, Yapilacak_Yer)
	else :
		Yik(Yapilacak_Yer)

func _on_TimerEfek_timeout():
	Efek.visible = false
	$VurmaAlan.disabled = true

func YapiYap(Yapi, Yapilacak_yer):
	TilemapGenel._YapiYapmaKoy(Yapi,Yapilacak_yer)

func ZeminYap(Yapi, Yapilacak_Yer):
	TilemapGenel._ZeminYapKoy(Yapi, Yapilacak_Yer)

func YapiYapCati(Yapilacak_yer):
	TilemapGenel._YapiYapmaCati(Yapilacak_yer)

func Yik(Yapilacak_Yer):
	TilemapGenel._YapiYapmaSil(Yapilacak_Yer)

func menu_kapa() :
	$YapiMenu/ana/AnimationPlayer.play("Kapanma")
	cekicMenu = false
	cekicMenuSecili = $YapiMenu/ana/Menu.frame

# Çekiç menü tuşları
func _on_MenuSlot0_input_event(_viewport, _event, _shape_idx):
	if Input.is_mouse_button_pressed(1):
		if $YapiMenu/ana/Menu.frame != 0 :
			find_parent("Oyuncu").gorunurlukKapa()
			$YapiMenu/ana/Menu.frame = 0
			menu_kapa()

func _on_MenuSlot1_input_event(_viewport, _event, _shape_idx):
	if Input.is_mouse_button_pressed(1):
		if $YapiMenu/ana/Menu.frame != 1 :
			$YapiMenu/ana/Menu.frame = 1
			find_parent("Oyuncu").gorunurlukKapa()
			find_parent("Oyuncu").cekicDuvar.visible = true
			menu_kapa()

func _on_MenuSlot2_input_event(_viewport, _event, _shape_idx):
	if Input.is_mouse_button_pressed(1):
		if $YapiMenu/ana/Menu.frame != 2 :
			$YapiMenu/ana/Menu.frame = 2
			find_parent("Oyuncu").gorunurlukKapa()
			find_parent("Oyuncu").cekicCamDuvar.visible = true
			menu_kapa()

func _on_MenuSlot3_input_event(_viewport, _event, _shape_idx):
	if Input.is_mouse_button_pressed(1):
		if $YapiMenu/ana/Menu.frame != 3 :
			$YapiMenu/ana/Menu.frame = 3
			find_parent("Oyuncu").gorunurlukKapa()
			find_parent("Oyuncu").cekicKapi.visible = true
			menu_kapa()

func _on_MenuSlot4_input_event(_viewport, _event, _shape_idx):
	if Input.is_mouse_button_pressed(1):
		if $YapiMenu/ana/Menu.frame != 4 :
			$YapiMenu/ana/Menu.frame = 4
			find_parent("Oyuncu").gorunurlukKapa()
			find_parent("Oyuncu").cekicCati.visible = true
			menu_kapa()

func _on_MenuSlot5_input_event(_viewport, _event, _shape_idx):
	if Input.is_mouse_button_pressed(1):
		if $YapiMenu/ana/Menu.frame != 5 :
			$YapiMenu/ana/Menu.frame = 5
			find_parent("Oyuncu").gorunurlukKapa()
			find_parent("Oyuncu").cekicZemin.visible = true
			menu_kapa()

func _on_MenuSlot6_input_event(_viewport, _event, _shape_idx):
	if Input.is_mouse_button_pressed(1):
		if $YapiMenu/ana/Menu.frame != 6 :
			$YapiMenu/ana/Menu.frame = 6
			find_parent("Oyuncu").gorunurlukKapa()
			find_parent("Oyuncu").cekicSandik.visible = true
			menu_kapa()

func _on_MenuSlot7_input_event(_viewport, _event, _shape_idx):
	if Input.is_mouse_button_pressed(1):
		if $YapiMenu/ana/Menu.frame != 7 :
			$YapiMenu/ana/Menu.frame = 7
			find_parent("Oyuncu").gorunurlukKapa()
			menu_kapa()

func _on_MenuSlot8_input_event(_viewport, _event, _shape_idx):
	if Input.is_mouse_button_pressed(1):
		if $YapiMenu/ana/Menu.frame != 8 :
			$YapiMenu/ana/Menu.frame = 8
			find_parent("Oyuncu").gorunurlukKapa()
			menu_kapa()

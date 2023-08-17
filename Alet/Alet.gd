extends Node

onready var ismim = $".".name
onready var TimerEfek = $TimerEfek
onready var Simge = $Simge
onready var Efek = $Simge/Efek

var sulama_hak = 0 
var olta_atma = true
var cekicMenu = false
var cekicMenuSecili = 0

func _process(_delta):

	if ismim == "Cekic":
		if Input.is_action_just_pressed("YapıMenu"):
			if cekicMenu :
				$YapiMenu/ana/AnimationPlayer.play("Kapanma")
				cekicMenuSecili = $YapiMenu/ana/Menu.frame
			else :
				$YapiMenu/ana/AnimationPlayer.play("Açılma")
			cekicMenu = !cekicMenu

	if ismim == "Olta":
		var ip = $OltaUcuYer/ip
		ip.points[0] = $OltaUcuYer/OltaUcu/OltaUcu.global_position
		ip.points[1] = $LineBasPos.global_position

func Islev_Oynat(Yapilcak_Yer):

	if olta_atma == true :
		Efek.visible = true
	
	TimerEfek.start()
	if ismim != "SulamaKabi" and ismim != "Capa":
		if ! ismim == "Cekic":
			$VurmaAlan.disabled = false
		elif cekicMenuSecili == 0 : 
			$VurmaAlan.disabled = false

	if ismim == "Capa":
		Capalama(Yapilcak_Yer)

	elif ismim == "Kurek":
		Kurekleme(Yapilcak_Yer)

	elif ismim == "SulamaKabi" :
		if sulama_hak > 0 and Genel._TarlaYapma("Kontrol",Yapilcak_Yer) :
			Sulama(Yapilcak_Yer)
			sulama_hak -= 1
		elif Genel._TarlaYapma("Su_doldur",Yapilcak_Yer) :
			sulama_hak = 20
		if sulama_hak == 0 :
			Simge.frame = 0
		else :
			Simge.frame = 1

	elif ismim == "Olta":
		pass

	elif ismim == "Cekic" :
		if cekicMenuSecili == 1 :
			YapiYap(Genel.yapi_duvar,Yapilcak_Yer,"")
		elif cekicMenuSecili == 2 :
			YapiYap(Genel.yapi_duvar_camli,Yapilcak_Yer,"")
		elif cekicMenuSecili == 3 :
			YapiYap(Genel.yapi_kapi,Yapilcak_Yer,"")
		elif cekicMenuSecili == 4 :
			YapiYap(Genel.yapi_cati,Yapilcak_Yer,"Cati")
		else :
			Yik(Yapilcak_Yer)

func Capalama(Yapilcak_Yer):
	Genel._TarlaYapma("Koy",Yapilcak_Yer)

func Kurekleme(Yapilcak_Yer):
	Genel._TarlaYapma("Sil",Yapilcak_Yer)

func Sulama(Yapilcak_Yer):
	Genel._TarlaYapma("Sula",Yapilcak_Yer)

func YapiYap(Yapi,Yapilacak_yer,Tur):
	if ! Tur == "Cati":
		Genel._YapiYapma("Koy",Yapi,Yapilacak_yer)
	else :
		Genel._YapiYapma("Cati",Yapi,Yapilacak_yer)

func Yik(Yapilcak_Yer):
	Genel._YapiYapma("Sil",-1,Yapilcak_Yer)

func _on_TimerEfek_timeout():

	Efek.visible = false

	if ismim != "SulamaKabi" and ismim != "Capa":
		$VurmaAlan.disabled = true
	if ismim == "Olta":
		if olta_atma == true :
			$OltaUcuYer/OltaUcu.position = $OltaUcuPos.global_position
			$OltaUcuYer.visible = true
			olta_atma = false
		else :
			$OltaUcuYer.visible = false
			olta_atma = true

func menu_kapa() :
	$YapiMenu/ana/AnimationPlayer.play("Kapanma")
	cekicMenu = false
	cekicMenuSecili = $YapiMenu/ana/Menu.frame

# Çekiç menü tuşları
func _on_MenuSlot0_input_event(_viewport, _event, _shape_idx):
	if Input.is_mouse_button_pressed(1):
		if $YapiMenu/ana/Menu.frame != 0 :
			$YapiMenu/ana/Menu.frame = 0
			menu_kapa()

func _on_MenuSlot1_input_event(_viewport, _event, _shape_idx):
	if Input.is_mouse_button_pressed(1):
		if $YapiMenu/ana/Menu.frame != 1 :
			$YapiMenu/ana/Menu.frame = 1
			menu_kapa()

func _on_MenuSlot2_input_event(_viewport, _event, _shape_idx):
	if Input.is_mouse_button_pressed(1):
		if $YapiMenu/ana/Menu.frame != 2 :
			$YapiMenu/ana/Menu.frame = 2
			menu_kapa()

func _on_MenuSlot3_input_event(_viewport, _event, _shape_idx):
	if Input.is_mouse_button_pressed(1):
		if $YapiMenu/ana/Menu.frame != 3 :
			$YapiMenu/ana/Menu.frame = 3
			menu_kapa()

func _on_MenuSlot4_input_event(_viewport, _event, _shape_idx):
	if Input.is_mouse_button_pressed(1):
		if $YapiMenu/ana/Menu.frame != 4 :
			$YapiMenu/ana/Menu.frame = 4
			menu_kapa()

func _on_MenuSlot5_input_event(_viewport, _event, _shape_idx):
	if Input.is_mouse_button_pressed(1):
			if $YapiMenu/ana/Menu.frame != 5 :
				$YapiMenu/ana/Menu.frame = 5
				menu_kapa()

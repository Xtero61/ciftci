extends KinematicBody2D

onready var YurumeEfek = $YurumeEfek
onready var imlec = $imlec
onready var Cevir = $Cevir
onready var Sol_el = $Cevir/SolEl
onready var Sag_el = $Cevir/SagEl
onready var animationPlayer = $VucutAnimationPlayer
onready var VanimationPlayer = $VurmaAnimationPlayer
onready var Dolu_el = $DoluEl
onready var Esya_Vurma_Yer = $DoluEl/EsyaVurmaYer
onready var El_Cevir = $DoluEl/Cevir
onready var El_Esya_Yer = $DoluEl/Cevir/AnimasyonO
onready var TimerVurma = $TimerVurma
onready var AndroidUI = $AndroidUI
onready var YurumeDokunmatikTus = $AndroidUI/YurumeDokunmatikTus
onready var YonDokunmatikTus = $AndroidUI/YonDokunmatikTus
onready var TimerOlta = $TimerOlta
onready var CekicKoyulcakYapi = $CekicKoyulcakYapi
onready var cekicCamDuvar = $CekicKoyulcakYapi/CamliDuvaricon
onready var cekicDuvar = $CekicKoyulcakYapi/Duvaricon
onready var cekicCati = $CekicKoyulcakYapi/Catiicon
onready var cekicKapi = $CekicKoyulcakYapi/Kapi
onready var cekicZemin = $CekicKoyulcakYapi/TahtaZeminIcon

var kare_boyu = 16.0
var vektor = Vector2.ZERO
export(int) var Hiz = 50

func _ready():
	if OS.get_name() != "Android":
		AndroidUI.visible = false
	else :
		AndroidUI.visible = true

func gorunurlukKapa():
	cekicCamDuvar.visible = false
	cekicDuvar.visible = false
	cekicCati.visible = false
	cekicKapi.visible = false
	cekicZemin.visible = false

func _process(_delta):
	var imlec_yer = Esya_Vurma_Yer.global_position + Vector2(8,8)
	imlec.global_position = Vector2(stepify(imlec_yer.x , kare_boyu) , stepify(imlec_yer.y , kare_boyu)) - Vector2(8,8)

	if El_Esya_Yer.get_child_count() == 3 :
		if El_Esya_Yer.get_child(2).name == "Cekic":
			if El_Esya_Yer.get_child(2).cekicMenuSecili == 1 :
				gorunurlukKapa()
				cekicDuvar.visible = true
			elif El_Esya_Yer.get_child(2).cekicMenuSecili == 2:
				gorunurlukKapa()
				cekicCamDuvar.visible = true
			elif El_Esya_Yer.get_child(2).cekicMenuSecili == 3:
				gorunurlukKapa()
				cekicKapi.visible = true
			elif El_Esya_Yer.get_child(2).cekicMenuSecili == 4:
				gorunurlukKapa()
				cekicCati.visible = true
			elif El_Esya_Yer.get_child(2).cekicMenuSecili == 5 :
				gorunurlukKapa()
				cekicZemin.visible = true
			else :
				gorunurlukKapa()
			CekicKoyulcakYapi.visible = true
			CekicKoyulcakYapi.global_position = imlec.global_position
		else :
			CekicKoyulcakYapi.visible = false
	else :
		CekicKoyulcakYapi.visible = false

func _physics_process(delta):

	#oyuncunun vektörünün ayarlanması
	var Yon : Vector2 = Vector2.ZERO
	if AndroidUI.visible == false :
		Yon.x = Input.get_action_strength("Sag") - Input.get_action_strength("Sol")
		Yon.y = Input.get_action_strength("Asagi") - Input.get_action_strength("Yukari")
	else :
		Yon = YurumeDokunmatikTus.get_output()

	#eldeki eşyanın sallanması
	if Dolu_el.visible == true :
		El_Esya_Yer.position.y = sin(OS.get_ticks_msec() * delta * 0.35)

	#oyuncunun vektörünün sıfıra eşit veya olmadığı yerlerde yapılması gereken kodlar
	if Yon == Vector2.ZERO :
		YurumeEfek.emitting = false
		animationPlayer.play("Durus")
		vektor = vektor.move_toward(Vector2.ZERO , 500 * delta)

	else :
		Genel._CatiAltindaMi(global_position)
		YurumeEfek.emitting = true
		animationPlayer.play("Yurume")
		vektor = vektor.move_toward(Yon.normalized() * Hiz , 500 * delta)

	vektor = move_and_slide(vektor)

func EldekiEsyayiSil():
	if El_Esya_Yer.get_child_count() == 3 :
		El_Esya_Yer.remove_child(El_Esya_Yer.get_child(2))

func _input(event):

	if event.is_action_pressed("Yuva0"):
		EldekiEsyayiSil()
	elif event.is_action_pressed("Yuva1"):
		EldekiEsyayiSil()
		var Sahne = load("res://Alet/Kılıç/Kilic.tscn")
		var Kilic = Sahne.instance()
		El_Esya_Yer.add_child(Kilic) 
	elif event.is_action_pressed("Yuva2"):
		EldekiEsyayiSil()
		var Sahne = load("res://Alet/Kazma/Kazma.tscn")
		var Kazma = Sahne.instance()
		El_Esya_Yer.add_child(Kazma)
	elif event.is_action_pressed("Yuva3"):
		EldekiEsyayiSil()
		var Sahne = load("res://Alet/Balta/Balta.tscn")
		var Balta = Sahne.instance()
		El_Esya_Yer.add_child(Balta)
	elif event.is_action_pressed("Yuva4"):
		EldekiEsyayiSil()
		var Sahne = load("res://Alet/Kürek/Kurek.tscn")
		var Kurek = Sahne.instance()
		El_Esya_Yer.add_child(Kurek)
	elif event.is_action_pressed("Yuva5"):
		EldekiEsyayiSil()
		var Sahne = load("res://Alet/Çapa/Capa.tscn")
		var Capa = Sahne.instance()
		El_Esya_Yer.add_child(Capa)
	elif event.is_action_pressed("Yuva6"):
		EldekiEsyayiSil()
		var Sahne = load("res://Alet/Sulama Kabı/SulamaKabi.tscn")
		var SulamaKabi = Sahne.instance()
		El_Esya_Yer.add_child(SulamaKabi)
	elif event.is_action_pressed("Yuva7"):
		EldekiEsyayiSil()
		var Sahne = load("res://Alet/Çekiç/Cekic.tscn")
		var Cekic = Sahne.instance()
		El_Esya_Yer.add_child(Cekic)
	elif event.is_action_pressed("Yuva8"):
		EldekiEsyayiSil()
		var Sahne = load("res://Alet/Olta/Olta.tscn")
		var Olta = Sahne.instance()
		El_Esya_Yer.add_child(Olta)
	elif event.is_action_pressed("Yuva9"):
		EldekiEsyayiSil()
		#var Sahne = load("res://Blok/Çatı/Cati.tscn")
		#var CamliDuvar = Sahne.instance()
		#El_Esya_Yer.add_child(CamliDuvar)

	var fare_global : Vector2
	if AndroidUI.visible == false :
		fare_global = get_global_mouse_position()
			#oyuncunun yönü ve eldeki eşyanın yönü
		if fare_global.x - global_position.x < 0:
			Cevir.scale.x = -1
			El_Cevir.scale.y = -1
		else:
			Cevir.scale.x = 1
			El_Cevir.scale.y = 1
		#eldeki esyayı fare göre çevirme
		Dolu_el.look_at(fare_global)

	else :
		fare_global = YonDokunmatikTus.get_output()
		if fare_global.x < 0 :
			Cevir.scale.x = -1
			El_Cevir.scale.y = -1
		else :
			Cevir.scale.x = 1
			El_Cevir.scale.y = 1
		#eldeki esyayı fare göre çevirme
		Dolu_el.look_at(fare_global*500)

	#elde eşya olup olmamasına göre animasyon değişimleri
	if El_Esya_Yer.get_child_count() == 3 : 
		
		var EldekiEsya = El_Esya_Yer.get_child(2)
		
		Sag_el.visible = false
		Sol_el.visible = false
		Dolu_el.visible = true

		if AndroidUI.visible == false:
		#eldeki eşyayla vurma
			if event.is_action_pressed("Vurma") and ! VanimationPlayer.is_playing():

				if EldekiEsya.name != "Olta":
					if ! EldekiEsya.cekicMenu :
						TimerVurma.start()
				else :
					if EldekiEsya.atma :
						TimerOlta.wait_time = 0.3
					else :
						TimerOlta.wait_time = 0.15
					TimerOlta.start()

				if EldekiEsya.name == "SulamaKabi":
					VanimationPlayer.play("Sulama")
				elif EldekiEsya.name == "Olta":
					VanimationPlayer.play("OltaAtma")
				else : 
					if EldekiEsya.name == "Cekic":
						if ! EldekiEsya.cekicMenu :
							VanimationPlayer.play("Vurma")
					else :
						VanimationPlayer.play("Vurma")
		else :
			pass

	else :
		Sag_el.visible = true
		Sol_el.visible = true
		Dolu_el.visible = false

func _on_TimerVurma_timeout():
	El_Esya_Yer.get_child(2).call("Islev_Oynat",imlec.global_position)

func _on_TimerOlta_timeout():
	El_Esya_Yer.get_child(2).call("Islev_Oynat",imlec.global_position)

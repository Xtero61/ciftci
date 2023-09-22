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
onready var EsyaAlmaAlan = $EsyaAlmaAlani
onready var Envanter = $UI/Envanter
onready var Sandik = $UI/Sandik_slotlari
onready var UI = $UI
onready var AtilanEsyaDogma = $DoluEl/AtilanEsyaDogma

export(int) var Hiz : int = 50
var kare_boyu = 16.0
var vektor : Vector2 = Vector2.ZERO
var esya_atma_yon : Vector2

func _ready():
	OyuncuEnvanter.hizliErisim_esya_ele_verme()
	if El_Esya_Yer.get_child_count() == 3 : 
		Sag_el.visible = false
		Sol_el.visible = false
		Dolu_el.visible = true

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

func _process(delta):
	YerdenEsyaAlma(Input, delta)

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
		if !Envanter.visible :
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

func _input(event):

	var fare_global : Vector2
	if AndroidUI.visible == false :
		fare_global = get_global_mouse_position()
			#oyuncunun yönü ve eldeki eşyanın yönü
		if !Envanter.visible :
			if fare_global.x - global_position.x < 0:
				Cevir.scale.x = -1
				El_Cevir.scale.y = -1
			else:
				Cevir.scale.x = 1
				El_Cevir.scale.y = 1
			#eldeki esyayı fare göre çevirme
			if !Envanter.visible :
				Dolu_el.look_at(fare_global)
				esya_atma_yon = AtilanEsyaDogma.global_position.direction_to(Esya_Vurma_Yer.global_position)

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
		esya_atma_yon = global_position.direction_to(imlec.global_position)

	#elde eşya olup olmamasına göre animasyon değişimleri
	if El_Esya_Yer.get_child_count() == 3 : 
		
		var EldekiEsya = El_Esya_Yer.get_child(2)
		
		Sag_el.visible = false
		Sol_el.visible = false
		Dolu_el.visible = true

		if AndroidUI.visible == false:
		#eldeki eşyayla vurma
			if !Envanter.visible :
				if event.is_action_pressed("Vurma") and ! VanimationPlayer.is_playing():

					if EldekiEsya.name != "Olta":
						if ! EldekiEsya.cekicMenu :
							TimerVurma.start()
					else :
						if EldekiEsya.olta_atma :
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

var basili_tutuluyor = false
var zamanlayici = 0
var adim_araligi = 0.12  # İşlem adımları arasındaki zaman aralığı (saniye)

func YerdenEsyaAlma(event, delta):
	if !Envanter.visible :
		if event.is_action_pressed("YerdenEsyaAlma"):
			if not basili_tutuluyor:
				basili_tutuluyor = true
				zamanlayici = adim_araligi
				EsyaAlma()

		if event.is_action_just_released("YerdenEsyaAlma"):
			basili_tutuluyor = false
			zamanlayici = 0
			adim_araligi = 0.12
	    
		if basili_tutuluyor:
			zamanlayici -= delta
			if zamanlayici <= 0:
				zamanlayici = adim_araligi
				if adim_araligi >= 0.04 :
					adim_araligi -= 0.002
				EsyaAlma()

func YerdenEsyaAlmaZamanlayiciSifirla():
	basili_tutuluyor = false
	adim_araligi = 0.12

func EsyaAlma():
	if EsyaAlmaAlan.AlandakiEsyalar.size() > 0 :
		var alinan_esya = EsyaAlmaAlan.AlandakiEsyalar[0]
		if OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(alinan_esya.yer_esya_isim, OyuncuEnvanter.envanter) >= alinan_esya.yer_esya_miktar :
			OyuncuEnvanter.esya_ekleme(alinan_esya.yer_esya_isim, alinan_esya.yer_esya_miktar, OyuncuEnvanter.envanter)
			alinan_esya.alinan_esya(self)
			EsyaAlmaAlan.AlandakiEsyalar.erase(alinan_esya)
			Envanter.envanter_slotlarini_guncelle()

extends Node

onready var ismim = $".".name
onready var TimerEfek = $TimerEfek
onready var Simge = $Simge
onready var Efek = $Simge/Efek

var sulama_hak = 0 

func Islev_Oynat(Yapilcak_Yer):

	Efek.visible = true
	TimerEfek.start()
	if ismim != "SulamaKabi" and ismim != "Capa":
		var VurmaAlan = $VurmaAlan
		VurmaAlan.disabled = false

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

	elif ismim == "Cekic" :
		Yik(Yapilcak_Yer)

func Capalama(Yapilcak_Yer):
	Genel._TarlaYapma("Koy",Yapilcak_Yer)

func Kurekleme(Yapilcak_Yer):
	Genel._TarlaYapma("Sil",Yapilcak_Yer)

func Sulama(Yapilcak_Yer):
	Genel._TarlaYapma("Sula",Yapilcak_Yer)

func Yik(Yapilcak_Yer):
	Genel._YapiYapma("Sil",-1,Yapilcak_Yer)

func _on_TimerEfek_timeout():
	Efek.visible = false
	if ismim != "SulamaKabi" and ismim != "Capa":
		var VurmaAlan = $VurmaAlan
		VurmaAlan.disabled = true

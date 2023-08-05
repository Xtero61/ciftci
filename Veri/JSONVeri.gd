extends Node2D

var esya_veri :  Dictionary = {
	"Odun": {
		"EsyaTürü": "Kaynak",
		"BirikmeMiktarı": 64,
		"ResimYolu": "res://Esyalar/Resimler/Odun.png",
	},
	"Taş Kazma": {
		"EsyaTürü": "Kazma",
		"BirikmeMiktarı": 1,
		"ResimYolu" : "res://Alet/Kazma/TaşKazma.png",
	},
	"Taş Balta": {
		"EsyaTürü": "Balta",
		"BirikmeMiktarı": 1,
		"ResimYolu": "res://Alet/Balta/TaşBalta.png",
	},
	"Taş Kürek": {
		"EsyaTürü": "Kürek",
		"BirikmeMiktarı": 1,
		"ResimYolu" : "res://Alet/Kürek/TaşKürek.png",
	},
	"Taş Kılıç": {
		"EsyaTürü": "Kılıç",
		"BirikmeMiktarı": 1,
		"ResimYolu" : "res://Alet/Kılıç/TaşKılıç.png",
	},
	"Taş Çapa": {
		"EsyaTürü": "Çapa",
		"BirikmeMiktarı": 1,
		"ResimYolu" : "res://Alet/Çapa/TaşÇapa.png",
	},
	"Taş Çekiç": {
		"EsyaTürü": "Çekiç",
		"BirikmeMiktarı": 1,
		"ResimYolu" : "res://Alet/Çekiç/TaşÇekiç.png",
	},
	"Sulama Kabı": {
		"EsyaTürü": "Sulama Kabı",
		"BirikmeMiktarı": 1,
		"ResimYolu" : "res://Alet/Sulama Kabı/SulamaKabı.png",
	},
	"Olta": {
		"EsyaTürü": "Olta",
		"BirikmeMiktarı": 1,
		"ResimYolu" : "res://Alet/Olta/Olta.png",
	},
}

#func _ready():
#	esya_veri = YukleVeri("res://Veri/JSONVeri.gd")
#
#func YukleVeri(dosya_yolu):
#	var json_veri
#	var dosya_veri = File.new()
#
#	dosya_veri.open(dosya_yolu, File.READ)
#	json_veri = JSON.parse(dosya_veri.get_as_text())
#	dosya_veri.close()
#	return json_veri.result

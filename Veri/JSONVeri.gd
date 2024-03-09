extends Node2D

var esya_veri :  Dictionary = {
	"Odun": {
		"EsyaTürü": "Kaynak",
		"BirikmeMiktarı": 64,
		"ResimYolu": "res://Esyalar/Resimler/Odun.png",
	},
	"Taş": {
		"EsyaTürü": "Kaynak",
		"BirikmeMiktarı": 64,
		"ResimYolu": "res://Esyalar/Resimler/Taş.png",
	},
	"Taş Kazma": {
		"EsyaTürü": "Kazma",
		"BirikmeMiktarı": 1,
		"ResimYolu" : "res://Alet/Kazma/TaşKazma.png",
		"EsyaSahne": "res://Alet/Kazma/Kazma.tscn",
	},
	"Taş Balta": {
		"EsyaTürü": "Balta",
		"BirikmeMiktarı": 1,
		"ResimYolu": "res://Alet/Balta/TaşBalta.png",
		"EsyaSahne": "res://Alet/Balta/Balta.tscn",
	},
	"Taş Kürek": {
		"EsyaTürü": "Kürek",
		"BirikmeMiktarı": 1,
		"ResimYolu" : "res://Alet/Kürek/TaşKürek.png",
		"EsyaSahne": "res://Alet/Kürek/Kurek.tscn",
	},
	"Taş Kılıç": {
		"EsyaTürü": "Kılıç",
		"BirikmeMiktarı": 1,
		"ResimYolu" : "res://Alet/Kılıç/TaşKılıç.png",
		"EsyaSahne": "res://Alet/Kılıç/Kilic.tscn",
	},
	"Taş Çapa": {
		"EsyaTürü": "Çapa",
		"BirikmeMiktarı": 1,
		"ResimYolu" : "res://Alet/Çapa/TaşÇapa.png",
		"EsyaSahne": "res://Alet/Çapa/Capa.tscn",
	},
	"Taş Çekiç": {
		"EsyaTürü": "Çekiç",
		"BirikmeMiktarı": 1,
		"ResimYolu" : "res://Alet/Çekiç/TaşÇekiç.png",
		"EsyaSahne": "res://Alet/Çekiç/Cekic.tscn",
	},
	"Sulama Kabı": {
		"EsyaTürü": "Sulama Kabı",
		"BirikmeMiktarı": 1,
		"ResimYolu" : "res://Alet/Sulama Kabı/SulamaKabı.png",
		"ResimYolu2" : "res://Alet/Sulama Kabı/SulamaKabıSulu.png",
		"EsyaSahne": "res://Alet/Sulama Kabı/SulamaKabi.tscn",
	},
	"Olta": {
		"EsyaTürü": "Olta",
		"BirikmeMiktarı": 1,
		"ResimYolu" : "res://Alet/Olta/Olta.png",
		"EsyaSahne": "res://Alet/Olta/Olta.tscn",
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

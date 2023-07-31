extends Node2D

var esya_veri :  Dictionary = {
	"Odun": {
		"EsyaTürü": "Kaynak",
		"BirikmeMiktarı": 64,
		"ResimYolu": "res://Odun.png",
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
	}
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

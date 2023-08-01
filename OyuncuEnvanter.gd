extends Node

const ENVANTER_SLOT = 17
const SlotSinifi = preload("res://Slot.gd")
const EsyaSinifi = preload("res://Esya.gd")

var envanter = {
	0: ["Taş Kazma", 1],
	1: ["Odun", 62],
	2: ["Taş Balta", 1]
}

func esya_ekleme(esya_isim, esya_miktar):
	for esya in envanter :
		if envanter[esya][0] == esya_isim:
			var birikme_miktari = int(JsonVeri.esya_veri[esya_isim]["BirikmeMiktarı"])
			var eklenecek_miktar = birikme_miktari - envanter[esya][1]
			if eklenecek_miktar >= esya_miktar:
				envanter[esya][1] += esya_miktar
				return
			else :
				envanter[esya][1] += eklenecek_miktar
				esya_miktar = esya_miktar - eklenecek_miktar

	for i in range(ENVANTER_SLOT):
		if envanter.has(i) == false :
			envanter[i] = [esya_isim, esya_miktar]
			return

func bos_slota_esya_ekle(esya: EsyaSinifi, slot: SlotSinifi):
	envanter[slot.slot_sayisi] = [esya.esya_isim, esya.esya_miktar]

func esya_sil(slot: SlotSinifi):
	envanter.erase(slot.slot_sayisi)

func esya_miktar_ekleme(slot: SlotSinifi , eklenecek_miktar: int):
	envanter[slot.slot_sayisi][1] += eklenecek_miktar

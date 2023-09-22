extends Node

signal aktif_esya_guncellendi

const ENVANTER_SLOT = 18
const HIZLI_ERISIM_SLOT = 9
const OYUNCU_EL_YOLU : String = "/root/Dunya/Yapi/Oyuncu/DoluEl/Cevir/AnimasyonO"
const SlotSinifi = preload("res://Envanter/Slot.gd")
const EsyaSinifi = preload("res://Esyalar/Esya.gd")

var envanter = {
	0: ["Odun", 64],
	1: ["Taş", 20],
}

var hizlierisim = {
	0: ["Taş Kılıç", 1],
	1: ["Taş Kazma", 1],
	2: ["Taş Balta", 1],
	3: ["Taş Kürek", 1],
	4: ["Taş Çapa", 1],
	5: ["Sulama Kabı", 1],
	6: ["Taş Çekiç", 1],
	7: ["Olta", 1],
	8: ["Odun", 1],
}

var aktif_slot = 0
var DunyaEsyaS = load("res://Esyalar/DunyaEsya.tscn")

func esya_ekleme(esya_isim, esya_miktar, sozluk : Dictionary):
	for esya in sozluk :
		if sozluk[esya][0] == esya_isim:
			var birikme_miktari = int(JsonVeri.esya_veri[esya_isim]["BirikmeMiktarı"])
			var eklenecek_miktar = birikme_miktari - sozluk[esya][1]
			if eklenecek_miktar >= esya_miktar:
				sozluk[esya][1] += esya_miktar
				slot_goruntusu_yenile(esya,sozluk[esya][0],sozluk[esya][1])
				return
			else :
				sozluk[esya][1] += eklenecek_miktar
				slot_goruntusu_yenile(esya,sozluk[esya][0],sozluk[esya][1])
				esya_miktar = esya_miktar - eklenecek_miktar

	for i in range(ENVANTER_SLOT):
		if sozluk.has(i) == false :
			sozluk[i] = [esya_isim, esya_miktar]
			slot_goruntusu_yenile(i,sozluk[i][0],sozluk[i][1])
			return

func bu_esya_icin_kac_tane_yer_var(esya_isim, sozluk : Dictionary, hizlierisim_mi : bool = false) :

	var esya_kapasitesi : int = 0
	var birikme_miktari = int(JsonVeri.esya_veri[esya_isim]["BirikmeMiktarı"])
	
	for esya in sozluk :
		if sozluk[esya][0] == esya_isim:
			esya_kapasitesi += birikme_miktari - sozluk[esya][1]
	
	if hizlierisim_mi :
		for i in range(HIZLI_ERISIM_SLOT) :
			if !sozluk.has(i) :
				esya_kapasitesi += birikme_miktari
	else :
		for i in range(ENVANTER_SLOT) :
			if !sozluk.has(i) :
				esya_kapasitesi += birikme_miktari

	return esya_kapasitesi

func slot_goruntusu_yenile(slot_sayisi, esya_isim, yeni_miktar):
	var slot = get_tree().root.get_node("/root/Dunya/Yapi/Oyuncu/UI/Envanter/EnvanterSlotlari/slot" + str(slot_sayisi + 1))
	if slot.esya != null :
		slot.esya.esya_ayarla(esya_isim, yeni_miktar)
	else :
		slot.esya_olusturma(esya_isim, yeni_miktar)

func bos_slota_esya_ekle(esya: EsyaSinifi, slot: SlotSinifi, sozluk: Dictionary):
	sozluk[slot.slot_sayisi] = [esya.esya_isim, esya.esya_miktar]

func bos_slot_belli_miktar_esya_ekle(esya: EsyaSinifi, slot: SlotSinifi, miktar, sozluk: Dictionary):
	sozluk[slot.slot_sayisi] = [esya.esya_isim, miktar]
	esya.esya_miktar_yazisi()

func esya_sil(slot: SlotSinifi, sozluk: Dictionary = {}):
	return sozluk.erase(slot.slot_sayisi)

func esya_miktar_ekleme(slot: SlotSinifi , eklenecek_miktar: int, sozluk: Dictionary):
	sozluk[slot.slot_sayisi][1] += eklenecek_miktar
	if sozluk[slot.slot_sayisi][1] == 0 :
		esya_sil(slot, sozluk)

func yere_esya_atma(slot: SlotSinifi, olusma_yer: Vector2, yon: Vector2, sozluk: Dictionary, CokluAtma: bool = false):
	if CokluAtma :
		OyuncuEnvanter.esya_sil(slot, sozluk)
		OyuncuEnvanter.atilan_esya_olusturma(slot.esya.esya_isim, slot.esya.esya_miktar, olusma_yer, yon)
	else:
		OyuncuEnvanter.esya_miktar_ekleme(slot, -1, sozluk)
		OyuncuEnvanter.atilan_esya_olusturma(slot.esya.esya_isim, 1, olusma_yer, yon)

func atilan_esya_olusturma(esya_isim, esya_miktar, position, yon):
	var DunyaEsya = DunyaEsyaS.instance()
	DunyaEsya.yer_esya_isim = esya_isim
	DunyaEsya.yer_esya_miktar = esya_miktar
	DunyaEsya.global_position = position
	DunyaEsya.yon = yon
	get_node(Genel.YAPI_TILEMAP).add_child(DunyaEsya)

func aktif_esya_yukari_cevirme():
	aktif_slot = (aktif_slot + 1) % HIZLI_ERISIM_SLOT
	hizliErisim_guncelle()

func aktif_esya_asagi_cevirme():
	if aktif_slot == 0:
		aktif_slot = HIZLI_ERISIM_SLOT - 1
	else :
		aktif_slot -= 1
		hizliErisim_guncelle()

func hizliErisim_guncelle():
	emit_signal("aktif_esya_guncellendi")
	hizliErisim_esya_ele_verme()

func hizliErisim_esya_ele_verme():
	if hizlierisim.has(aktif_slot):
		oyuncu_el_esya_sil()
		if JsonVeri.esya_veri[hizlierisim[aktif_slot][0]]["EsyaTürü"] != "Kaynak" :
			var sahne = load(JsonVeri.esya_veri[hizlierisim[aktif_slot][0]]["EsyaSahne"]).instance()
			get_node(OYUNCU_EL_YOLU).add_child(sahne)
	else :
		oyuncu_el_esya_sil()

func oyuncu_el_esya_sil():
	if get_node(OYUNCU_EL_YOLU).get_child_count() == 3 :
		get_node(OYUNCU_EL_YOLU).remove_child(get_node(OYUNCU_EL_YOLU).get_child(2))

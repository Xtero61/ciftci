extends Node

signal aktif_esya_guncellendi

const ENVANTER_SLOT = 17
const HIZLI_ERISIM_SLOT = 9
const OYUNCU_EL_YOLU : String = "/root/Dunya/Yapi/Oyuncu/DoluEl/Cevir/AnimasyonO"
const SlotSinifi = preload("res://Envanter/Slot.gd")
const EsyaSinifi = preload("res://Esyalar/Esya.gd")

var envanter = {
	0: ["Odun", 20],
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
}

var aktif_slot = 0

func esya_ekleme(esya_isim, esya_miktar):
	for esya in envanter :
		if envanter[esya][0] == esya_isim:
			var birikme_miktari = int(JsonVeri.esya_veri[esya_isim]["BirikmeMiktarı"])
			var eklenecek_miktar = birikme_miktari - envanter[esya][1]
			if eklenecek_miktar >= esya_miktar:
				envanter[esya][1] += esya_miktar
				slot_goruntusu_yenile(esya,envanter[esya][0],envanter[esya][1])
				return
			else :
				envanter[esya][1] += eklenecek_miktar
				slot_goruntusu_yenile(esya,envanter[esya][0],envanter[esya][1])
				esya_miktar = esya_miktar - eklenecek_miktar

	for i in range(ENVANTER_SLOT):
		if envanter.has(i) == false :
			envanter[i] = [esya_isim, esya_miktar]
			slot_goruntusu_yenile(i,envanter[i][0],envanter[i][1])
			return

func slot_goruntusu_yenile(slot_sayisi, esya_isim, yeni_miktar):
	var slot = get_tree().root.get_node("/root/Dunya/Yapi/Oyuncu/UI/Envanter/EnvanterSlotlari/slot" + str(slot_sayisi + 1))
	if slot.esya != null :
		slot.esya.esya_ayarla(esya_isim, yeni_miktar)
	else :
		slot.esya_olusturma(esya_isim, yeni_miktar)

func bos_slota_esya_ekle(esya: EsyaSinifi, slot: SlotSinifi, hizlierisim_mi : bool = false):
	if hizlierisim_mi:
		hizlierisim[slot.slot_sayisi] = [esya.esya_isim, esya.esya_miktar]
		hizliErisim_esya_ele_verme()
	else :
		envanter[slot.slot_sayisi] = [esya.esya_isim, esya.esya_miktar]

func esya_sil(slot: SlotSinifi, hizlierisim_mi : bool = false):
	if hizlierisim_mi:
		hizlierisim.erase(slot.slot_sayisi)
		hizliErisim_esya_ele_verme()
	else :
		envanter.erase(slot.slot_sayisi)

func esya_miktar_ekleme(slot: SlotSinifi , eklenecek_miktar: int, hizlierisim_mi : bool = false):
	if hizlierisim_mi:
		hizlierisim[slot.slot_sayisi][1] += eklenecek_miktar
		hizliErisim_esya_ele_verme()
	else:
		envanter[slot.slot_sayisi][1] += eklenecek_miktar

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

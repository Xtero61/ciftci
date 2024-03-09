extends Node

onready var ismim = $".".name
onready var Simge = $Simge

onready var sulama_hak = find_parent("Oyuncu").HizliErisim.AktifSlot().esya.sulama_hak

func _ready():
	ResimYenileme()

func Islev_Oynat(Yapilacak_Yer):
	
	if sulama_hak > 0 and TilemapGenel._TarlaYapmaKontrol(Yapilacak_Yer) :
		Sulama(Yapilacak_Yer)
		sulama_hak -= 1
		find_parent("Oyuncu").HizliErisim.AktifSlot().esya.sulama_hak = sulama_hak
	elif TilemapGenel._TarlaYapmaSuDoldur(Yapilacak_Yer) :
		sulama_hak = 20
		find_parent("Oyuncu").HizliErisim.AktifSlot().esya.sulama_hak = sulama_hak
	ResimYenileme()

func ResimYenileme():
	if sulama_hak == 0 :
		Simge.frame = 0
	else :
		Simge.frame = 1
	if sulama_hak == 0 :
		find_parent("Oyuncu").HizliErisim.AktifSlot().esya.sulamakabresim = 0
	else :
		find_parent("Oyuncu").HizliErisim.AktifSlot().esya.sulamakabresim = 1
	find_parent("Oyuncu").HizliErisim.hizlierisim_slotlarini_guncelle()
		
func Sulama(Yapilcak_Yer):
	TilemapGenel._TarlaYapmaSula(Yapilcak_Yer)

extends Node

onready var ismim = $".".name
onready var TimerEfek = $TimerEfek
onready var Simge = $Simge
onready var Efek = $Simge/Efek

func Islev_Oynat(Yapilacak_Yer):
	Efek.visible = true
	TimerEfek.start()
	Capalama(Yapilacak_Yer)

func _on_TimerEfek_timeout():
	Efek.visible = false

func Capalama(Yapilcak_Yer):
	TilemapGenel._TarlaYapmaKoy(Yapilcak_Yer)

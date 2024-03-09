extends Node

onready var ismim = $".".name
onready var TimerEfek = $TimerEfek
onready var Simge = $Simge
onready var Efek = $Simge/Efek

func Islev_Oynat(Yapilacak_Yer):
	Efek.visible = true
	TimerEfek.start()
	$VurmaAlan.disabled = false
	if ismim == "Kurek":
		Kurekleme(Yapilacak_Yer)

func _on_TimerEfek_timeout():
	Efek.visible = false
	$VurmaAlan.disabled = true

func Kurekleme(Yapilcak_Yer):
	TilemapGenel._TarlaYapmaSil(Yapilcak_Yer)

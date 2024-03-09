extends Node

onready var ismim = $".".name
onready var TimerEfek = $TimerEfek
onready var Simge = $Simge
onready var Efek = $Simge/Efek

func Islev_Oynat(_Yapilacak_Yer):
	Efek.visible = true
	TimerEfek.start()
	$VurmaAlan.disabled = false

func _on_TimerEfek_timeout():
	Efek.visible = false
	$VurmaAlan.disabled = true

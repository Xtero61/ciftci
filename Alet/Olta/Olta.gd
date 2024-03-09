extends Node

onready var ismim = $".".name
onready var TimerEfek = $TimerEfek
onready var Simge = $Simge
onready var Efek = $Simge/Efek

onready var ip = $OltaUcuYer/ip
var olta_atma = true

func _process(_delta):
	ip.points[0] = $OltaUcuYer/OltaUcu/OltaUcu.global_position
	ip.points[1] = $LineBasPos.global_position

func Islev_Oynat(_Yapilacak_Yer):
	if olta_atma == true :
		Efek.visible = true
	TimerEfek.start()
	$VurmaAlan.disabled = false

func _on_TimerEfek_timeout():
	Efek.visible = false
	$VurmaAlan.disabled = true
	if olta_atma == true :
		$OltaUcuYer/OltaUcu.position = $OltaUcuPos.global_position
		$OltaUcuYer.visible = true
		olta_atma = false
	else :
		$OltaUcuYer.visible = false
		olta_atma = true

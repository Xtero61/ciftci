extends CanvasLayer

onready var Envanter = $Envanter

func _input(event):
	if event.is_action_pressed("Envanter"):
		Envanter.visible = !Envanter.visible
		Envanter.envanter_slotlarini_guncelle()

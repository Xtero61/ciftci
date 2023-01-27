extends Particles2D

onready var ben = $"."
onready var timer = $Timer

func _ready():
	ben.emitting = true
	timer.start()

func _on_Timer_timeout():
	queue_free()

extends Node2D



func _on_Kapi_body_entered(body):
	if body.name == "Oyuncu":
		$AnimationPlayer.play("Açılma")


func _on_Kapi_body_exited(body):
	if body.name == "Oyuncu":
		$AnimationPlayer.play("Kapanma")

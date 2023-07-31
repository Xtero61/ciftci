extends Area2D

var AlandakiEsyalar = {}

func _on_EsyaAlmaAlani_body_entered(body):

	if body is RigidBody2D:
		AlandakiEsyalar[body] = body

func _on_EsyaAlmaAlani_body_exited(body):
	if AlandakiEsyalar.has(body) :
		AlandakiEsyalar.erase(body)

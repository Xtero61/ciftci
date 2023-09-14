extends Area2D

var AlandakiEsyalar = []

func _on_EsyaAlmaAlani_body_entered(body):

	if body is RigidBody2D:
		AlandakiEsyalar.append(body)
		for body in AlandakiEsyalar :
			if !OyuncuEnvanter.bu_esya_icin_kac_tane_yer_var(body.yer_esya_isim , OyuncuEnvanter.envanter) >= body.yer_esya_miktar :
					var esya = body
					AlandakiEsyalar.erase(body)
					AlandakiEsyalar.append(esya)

func _on_EsyaAlmaAlani_body_exited(body):
	if AlandakiEsyalar.has(body) :
		AlandakiEsyalar.erase(body)

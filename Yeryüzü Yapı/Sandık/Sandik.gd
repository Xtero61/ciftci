extends Node2D

var sandik : Dictionary = {}

onready var sandik_rengi = $SandikAnimasyon/SandikAnimasyonrenkli

func sandik_rengi_ayarla(list):
	sandik_rengi.set_modulate(Color8(list[0],list[1],list[2]))

func _on_SandikArea2D_area_entered(area):
	if area.name == "ImlecArea2D":
		$AnimationPlayer.play("Sandik_anim")
		area.find_parent("Oyuncu").Sandik.sandik = sandik
		area.find_parent("Oyuncu").Sandik.sandik_slotlarini_guncelle()
		area.find_parent("Oyuncu").UI.sandiklar.append($".")

func _on_SandikArea2D_area_exited(area):
	if area.name == "ImlecArea2D":
		$AnimationPlayer.play("Sandik_anim",-1,-1,true)
		area.find_parent("Oyuncu").UI.sandiklar.erase($".")
		
		

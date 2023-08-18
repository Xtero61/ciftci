extends Node2D

export var sandik : Dictionary = {
	0: ["Taş Kılıç", 1],
	1: ["Taş Kazma", 1],
}

func _on_SandikArea2D_area_entered(area):
	if area.name == "ImlecArea2D":
		$AnimationPlayer.play("Açılma")
		area.find_parent("Oyuncu").Sandik.sandik = sandik
		area.find_parent("Oyuncu").Sandik.sandik_slotlarini_guncelle()
		area.find_parent("Oyuncu").UI.sandiklar.append($".")

func _on_SandikArea2D_area_exited(area):
	if area.name == "ImlecArea2D":
		$AnimationPlayer.play("Kapanma")
		area.find_parent("Oyuncu").UI.sandiklar.erase($".")
		
		

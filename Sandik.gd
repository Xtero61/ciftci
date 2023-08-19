extends Node2D

export var sandik : Dictionary = {
	0: ["Taş Kılıç", 1],
	1: ["Taş Kazma", 1],
}

onready var sandik_rengi = $SandikAnimasyon/SandikAnimasyonrenkli

func sandik_rengi_ayarla(list):
	sandik_rengi.set_modulate(Color8(list[0],list[1],list[2]))

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
		
		

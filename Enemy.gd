extends Sprite

signal tagged(tagged_enemy)


func _on_Area2D_area_entered(area):
	emit_signal("tagged",self)

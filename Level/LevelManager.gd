extends Node2D

var game_over = preload("res://Screens/Death.tscn")
onready var player=$Player
func _on_DeathZone_death():
	player.queue_free()
	var death_instance= game_over.instance()
	add_child(death_instance)


func _on_Area2D_body_entered(_body):
	print(1)


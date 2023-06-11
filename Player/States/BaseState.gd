extends Node
class_name BaseState

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player:Player
var bullet= preload("res://Bullet/Bullet.tscn")
var bullet_instance=null
export var anim_name:String
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func enter():
	player.anim.play(anim_name)

func exit():
	pass

func _input(_event):
	return null

func _process(_delta):
	return null


func get_input():
	if(Input.is_action_pressed("ui_left")):
		return -1
	elif(Input.is_action_pressed("ui_right")):
		return 1
	
	return 0

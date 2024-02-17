extends KinematicBody2D
class_name Player

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var anim= $AnimationTree.get('parameters/playback')
onready var state= $StateDebugLabel/State_Manager
onready var shootdir=$Position2D
onready var fire_timer=$FireCooldown
onready var player_sprt=$Sprite
var velocity= Vector2.ZERO
export var gravity:float
var block_movement:bool=false
# Called when the node enters the scene tree for the first time.
func _ready():
	state.init(self)

func _unhandled_input(event):
	state._input(event)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	state._process(delta)

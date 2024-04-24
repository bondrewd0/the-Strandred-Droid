extends KinematicBody2D
class_name Player

onready var anim= $AnimationTree.get('parameters/playback')
onready var state= $StateDebugLabel/State_Manager
onready var shootdir=$Position2D
onready var fire_timer=$FireCooldown
onready var tagged_timer=$TaggedEffect
onready var player_sprt=$Sprite
onready var floor_detection = $FloorDetection

var velocity= Vector2.ZERO
export var gravity:float
var block_movement:bool=false
var tagged_obj:bool=false
signal tp(pos)
var on_floor:bool
# Called when the node enters the scene tree for the first time.
func _ready():
	
	state.init(self)

func _unhandled_input(event):
	state._input(event)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	state._process(delta)


func _on_FloorDetection_body_entered(body):
	var layer=body.get_collision_layer()
	if layer==4 or layer==64:
		on_floor=true


func _on_FloorDetection_body_exited(body):
	var layer=body.get_collision_layer()
	if layer==4 or layer==64:
		on_floor=false

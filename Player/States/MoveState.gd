class_name Movestate
extends BaseState

export var move_speed=60

export (NodePath) var idle_node
export (NodePath) var shoot_node
export (NodePath) var move_node
export (NodePath) var jump_node
export (NodePath) var fall_node

onready var idle_state:BaseState= get_node(idle_node)
onready var shooting:BaseState= get_node(shoot_node)
onready var move_state: BaseState=get_node(move_node)
onready var jump_state: BaseState=get_node(jump_node)
onready var fall_state: BaseState = get_node(fall_node)
#  <   >
func _process(_delta):
	if(!player.is_on_floor()):
		return fall_state
	var move=get_input()
	
	if move >0:
		player.player_sprt.flip_h=false
		player.shootdir.position.x=20
	if move < 0:
		player.player_sprt.flip_h=true
		player.shootdir.position.x=-20
	player.velocity.y+=player.gravity
	player.velocity.x= move*move_speed
	if(!player.block_movement):
		player.velocity = player.move_and_slide(player.velocity,Vector2.UP)
	
	if move==0:
		
		return idle_state
	
	return null


func _input(_event):
	if(Input.is_action_just_pressed("Jump")):
		return jump_state
	if(Input.is_action_pressed("trigger")):
		return shooting
	return null

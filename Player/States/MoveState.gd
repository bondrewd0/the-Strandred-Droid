class_name Movestate
extends BaseState

export var move_speed=60

export (NodePath) var idle_node
export (NodePath) var charge_node
export (NodePath) var jump_node
export (NodePath) var fall_node

onready var idle_state:BaseState= get_node(idle_node)
onready var charging_state:BaseState= get_node(charge_node)
onready var jump_state: BaseState=get_node(jump_node)
onready var fall_state: BaseState = get_node(fall_node)

var inertia=100

func _process(_delta):
	if(!player.on_floor):
		return fall_state
	var move=get_input()
	for index in player.get_slide_count():
		var collision=player.get_slide_collision(index)
		if collision.collider.is_in_group("MovableProps"):
			print(collision.collider)
			collision.collider.apply_central_impulse(-collision.normal*inertia)
		pass
	if move >0:
		player.player_sprt.flip_h=false
		player.shootdir.position.x=20
	if move < 0:
		player.player_sprt.flip_h=true
		player.shootdir.position.x=-20
	player.velocity.y+=player.gravity
	player.velocity.x= move*move_speed
	if(!player.block_movement):
		player.velocity = player.move_and_slide(player.velocity,Vector2.UP,false,4,PI/4,false)
	
	if move==0:
		
		return idle_state
	
	return null


func _input(_event):
	if(Input.is_action_just_pressed("Jump")):
		return jump_state
	if(Input.is_action_pressed("trigger")):
		return charging_state
	return null

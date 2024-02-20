extends BaseState

export (NodePath) var move_node
export (NodePath) var charge_node
export (NodePath) var jump_node

onready var move_state: BaseState=get_node(move_node)
onready var charging_state: BaseState=get_node(charge_node)
onready var jump_state: BaseState=get_node(jump_node)
func _input(_event):
	if(Input.is_action_pressed("Left")) or (Input.is_action_pressed("Right")):
		return move_state
	if(Input.is_action_pressed("trigger")):
		return charging_state
	if(Input.is_action_just_pressed("Jump")):
		return jump_state
	return null


func _process(_delta):
	return null

func enter():
	.enter()
	player.velocity.x=0


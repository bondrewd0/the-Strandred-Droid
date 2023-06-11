extends BaseState

export (NodePath) var move_node
export (NodePath) var shoot_node
export (NodePath) var jump_node
export (NodePath) var fall_node

onready var move_state: BaseState=get_node(move_node)
onready var shooting_state: BaseState=get_node(shoot_node)
onready var jump_state: BaseState=get_node(jump_node)
onready var fall_state: BaseState = get_node(fall_node)
func _input(event):
	if(Input.is_action_pressed("ui_left")) or (Input.is_action_pressed("ui_right")):
		return move_state
	if(Input.is_action_pressed("trigger")):
		return shooting_state
	if(Input.is_action_just_pressed("ui_up")):
		return jump_state
	return null
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player.velocity.y+= player.gravity
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	return null

func enter():
	.enter()
	player.velocity.x=0


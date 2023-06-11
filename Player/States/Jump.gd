extends BaseState
export (float)var jump_force=100
export (float)var move_speed=60

export (NodePath) var walk_node
export (NodePath) var idle_node
export (NodePath) var fall_node

onready var walk_state: BaseState = get_node(walk_node)
onready var idle_state: BaseState = get_node(idle_node)
onready var fall_state: BaseState = get_node(fall_node)

func enter():
	.enter()
	player.velocity.y= -jump_force
	
func _process(delta):
	var move=0
	if(Input.is_action_pressed("ui_left")):
		move=-1
		player.anim.flip_h=true
	elif(Input.is_action_pressed("ui_right")):
		move=1
		player.anim.flip_h=false
		
	player.velocity.y+=player.gravity
	player.velocity.x= move*move_speed
	if(!player.block_movement):
		player.velocity = player.move_and_slide(player.velocity,Vector2.UP)
	if(player.velocity.y>0):
		return fall_state
	if(player.is_on_floor()):
		if move!=0:
			return walk_state
		return idle_state
	
	return null

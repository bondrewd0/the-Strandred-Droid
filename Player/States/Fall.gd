extends BaseState

export (float)var move_speed=60.0

export (NodePath) var walk_node
export (NodePath) var idle_node

onready var walk_state: BaseState = get_node(walk_node)
onready var idle_state: BaseState = get_node(idle_node)

func _process(_delta):
	var move=0
	if(!player.block_movement):
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
	if(player.is_on_floor()):
		if move!=0:
			return walk_state
		else:
			return idle_state
	
	return null

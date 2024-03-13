extends BaseState
export (float)var jump_force=25.0
export (float)var move_speed=60.0


export (NodePath) var fall_node
export (NodePath) var charge_node

onready var charging_state: BaseState=get_node(charge_node)
onready var fall_state: BaseState = get_node(fall_node)

func enter():
	.enter()
	player.velocity.y= -jump_force
	
func _process(_delta):
	var move=0
	
	if(Input.is_action_pressed("Left")):
		move=-1
		player.player_sprt.flip_h=true
	elif(Input.is_action_pressed("Right")):
		move=1
		player.player_sprt.flip_h=false
		
	player.velocity.y+=player.gravity
	player.velocity.x= move*move_speed
	if(!player.block_movement):
		player.velocity = player.move_and_slide(player.velocity,Vector2.UP,false,4,PI/4,false)
	if(player.velocity.y>0):
		return fall_state
	return null

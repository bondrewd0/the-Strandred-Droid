extends BaseState

var chargin:bool
var can_shoot:bool=true
var bullet_force:int=0

export (NodePath) var move_node
export (NodePath) var idle_node
export (NodePath) var jump_node

onready var move_state: BaseState=get_node(move_node)
onready var idle_state:BaseState= get_node(idle_node)
onready var jump_state: BaseState=get_node(jump_node)
func enter():
	.enter()
	player.velocity.x=0
	player.block_movement=true

func _process(delta):
	if(chargin and can_shoot):
		bullet_force+=5
		if(bullet_force >=100):
			bullet_force=100
	if(Input.is_action_just_pressed("trigger")and bullet_instance):
		if(bullet_instance.state==1):
			player.global_position=bullet_instance.global_position
			bullet_instance.queue_free()
			bullet_instance=null
			player.fire_timer.start(2)
	if(!chargin):
		if(Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left")):
			return move_state
		else:
			return idle_state
	return null
func delete_instance():
	bullet_instance=null

func _unhandled_input(event):
	if(Input.is_action_pressed("trigger")and bullet_instance==null):
		chargin=true
	if(Input.is_action_just_released("trigger")and bullet_instance==null):
		if(can_shoot):
			chargin=false
			can_shoot=false
			bullet_instance=bullet.instance()
			bullet_instance.connect("dead",self,"delete_instance")
			if(player.anim.is_flipped_h()):
				bullet_instance.position=player.shootdir.global_position
				bullet_instance.direction=Vector2(-1,0)
			if(!player.anim.is_flipped_h()):
				bullet_instance.position=player.shootdir.global_position
				bullet_instance.direction=Vector2(1,0)
			bullet_instance.speed*=bullet_force
			add_child(bullet_instance)
			player.fire_timer.start(5)


func _input(event):
	if(Input.is_action_just_pressed("ui_up")):
		return jump_state
	return null

func _on_FireCooldown_timeout():
	bullet_force=0
	can_shoot=true
	player.fire_timer.stop()

func exit():
	.exit()
	player.block_movement=false

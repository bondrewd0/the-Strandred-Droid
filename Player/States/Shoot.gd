extends BaseState

var chargin:bool
var can_shoot:bool=true
var bullet_force:int=0

export var anim_name2:String
export (NodePath) var move_node
export (NodePath) var idle_node
export (NodePath) var jump_node

onready var move_state: BaseState=get_node(move_node)
onready var idle_state:BaseState= get_node(idle_node)
onready var jump_state: BaseState=get_node(jump_node)

func enter():
	if can_shoot:
		.enter()
		player.block_movement=true
	pass

func _process(_delta):
	if can_shoot:
		if Input.is_action_pressed("trigger"):
			chargin=true
			charge_Up()
		if(Input.is_action_just_released("trigger")and bullet_instance==null):
			fire()
	if Input.is_action_just_pressed("trigger"):
		if bullet_instance:
			teleport()
		if player.tagged_obj :
			switch_place()
	if(!chargin):
		if(get_input()!=0):
			return move_state
		else:
			return idle_state
	return null

func delete_instance():
	bullet_instance=null

func _input(_event):
	if(Input.is_action_just_pressed("Jump")):
		return jump_state
	return null

func _on_FireCooldown_timeout():
	bullet_force=0
	can_shoot=true

func exit():
	player.block_movement=false

func charge_Up():
	bullet_force+=1
	if bullet_force >=20:
		bullet_force=20

func fire():
	player.anim.travel(anim_name2)
	chargin=false
	can_shoot=false
	bullet_instance=bullet.instance()
	bullet_instance.connect("dead",self,"delete_instance")
	bullet_instance.connect("tagged",self,"set_tagged")
	if(player.player_sprt.is_flipped_h()):
		bullet_instance.position=player.shootdir.global_position
		bullet_instance.direction=-1
	if(!player.player_sprt.is_flipped_h()):
		bullet_instance.position=player.shootdir.global_position
		bullet_instance.direction=1
	bullet_instance.speed*=bullet_force
	add_child(bullet_instance)
	player.fire_timer.start(5)

func teleport():
	player.global_position=bullet_instance.global_position
	bullet_instance.queue_free()
	bullet_instance=null
	player.fire_timer.start(2)

func set_tagged():
	player.tagged_obj=!player.tagged_obj
	player.tagged_timer.start()

func switch_place():
	player.emit_signal("tp",player.global_position)
	set_tagged()


func _on_TaggedEffect_timeout():
	if player.tagged_obj:
		set_tagged()

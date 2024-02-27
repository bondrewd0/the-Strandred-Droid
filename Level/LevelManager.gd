extends Node2D

var game_over = preload("res://Screens/Death.tscn")
onready var player=$Player
var enemy_path=preload("res://Enemy.tscn")
var tagged_ref
var player_pos
var tagged_pos
func _ready():
	player.connect("tp",self,"player_signal")
	_spawn_enemies()

func _on_DeathZone_death():
	player.queue_free()
	var death_instance= game_over.instance()
	add_child(death_instance)


func _on_Area2D_body_entered(_body):
	print(_body.get_collision_layer())

func player_signal(pos):
	player_pos=pos
	print(player_pos)
	switch_pos(player_pos,tagged_pos,tagged_ref)

func enemy_reciber(pos,enemy_node):
	tagged_pos=pos
	tagged_ref=enemy_node
	print(enemy_node)
	

func switch_pos(pos1,pos2,enemy):
	print(2)
	var aux=pos1
	pos1=pos2
	pos2=aux
	player.global_position=pos2
	enemy._new_pos(pos1)

func _spawn_enemies():
	var enemy_ins=enemy_path.instance()
	enemy_ins.position=Vector2(924,263)
	enemy_ins.connect("send_pos",self,"enemy_reciber")
	add_child(enemy_ins)
	var enemy_ins2=enemy_path.instance()
	enemy_ins2.position=Vector2(900,263)
	enemy_ins2.connect("send_pos",self,"enemy_reciber")
	add_child(enemy_ins2)

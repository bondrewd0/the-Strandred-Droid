extends KinematicBody2D


var marked:bool=false
onready var f_mov=$Forward
onready var switch_t=$Switch_tween
var gravity=2
var movement=Vector2.ZERO
var dir=1
export var distance=0
export  var movement_speed=0
var pos:Vector2
var pos_x
signal send_pos(pos,id)
# Called when the node enters the scene tree for the first time.
func _ready():
	pos=Vector2(position.x+distance,global_position.y)
	pos_x=position.x
	activate_Tween()



func _process(delta):
	if !is_on_floor():
		movement.y+=gravity
	movement=move_and_slide(movement,Vector2.UP)

func _on_Area2D_area_entered(area):
	var layer=area.get_collision_layer()
	if layer==2:
		marked=true


func _input(event):
	if Input.is_action_just_pressed("trigger") and marked:
		emit_signal("send_pos",self.global_position,self)
		f_mov.stop_all()

func activate_Tween():
	f_mov.interpolate_property(self,"pos_x",pos_x,pos.x,movement_speed,Tween.TRANS_LINEAR)
	f_mov.start()



func _on_Forward_tween_completed(object, key):
	dir=dir*-1
	
	switch_t.start()


func _on_Switch_tween_timeout():
	pos.x=pos_x+distance*dir
	if f_mov.is_active():
		activate_Tween()




func _on_Forward_tween_step(object, key, elapsed, value):
	global_position.x=pos_x


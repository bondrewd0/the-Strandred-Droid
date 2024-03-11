extends KinematicBody2D


var marked:bool=false
onready var switch_t=$Switch_Dir
onready var st_timer=$StunTimer
var gravity=2
var movement=Vector2.ZERO
var dir=1
export var distance=100
export  var movement_speed=10
var pos_x
var target_pos
var stunned:bool=false
var switching:bool=false
var on_floor
signal send_pos(pos,id)
# Called when the node enters the scene tree for the first time.
func _ready():
	pos_x=Vector2(position.x+distance*dir,position.y)
	
	target_pos=(pos_x-position).normalized()
	pass



func _on_Area2D_area_entered(area):
	var layer=area.get_collision_layer()
	if layer==2:
		marked=true

func _input(_event):
	if Input.is_action_just_pressed("trigger") and marked:
		stunned=true
		st_timer.start()
		emit_signal("send_pos",self.global_position,self)
		


func _process(delta):
	if !on_floor:
		movement.y+=gravity
	if position.distance_to(pos_x)>1 and !stunned and !switching:
		movement.x=target_pos.x*movement_speed
		movement=move_and_slide(movement,Vector2.UP)
		return
	elif !switching:
		switching=true
		switch_t.start()
	if position.y<0:
		queue_free()



func _on_Switch_Dir_timeout():
	if !stunned:
		update_target()
	else:
		st_timer.start(0.5)


func _on_FloorDetector_body_entered(body):
	var layer=body.get_collision_layer()
	if layer==4:
		on_floor=true


func _on_FloorDetector_body_exited(body):
	var layer=body.get_collision_layer()
	if layer==4:
		on_floor=false



func _on_StunTimer_timeout():
	stunned=false
	update_target()

func update_target():
	dir=dir*-1
	pos_x=Vector2(position.x+distance*dir,position.y)
	target_pos=(pos_x-position).normalized()
	$Sprite.flip_h=!$Sprite.flip_h
	switching=false

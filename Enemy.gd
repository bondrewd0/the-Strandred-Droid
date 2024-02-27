extends KinematicBody2D


var marked:bool=false
signal send_pos(pos,id)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	var layer=area.get_collision_layer()
	if layer==2:
		marked=true


func _input(event):
	if Input.is_action_just_pressed("trigger") and marked:
		emit_signal("send_pos",self.global_position,self)

func _new_pos(pos):
	self.global_position=pos

extends RigidBody2D


var marked:bool=false
signal send_pos(pos,id)
func _on_Box_body_entered(body):
	var layer=body.get_collision_layer()
	print(layer)


func _on_Area2D_area_entered(area):
	var layer=area.get_collision_layer()
	print(layer)
	if layer==2:
		marked=true
		$MarkedTimer.start()
		print(1)


func _input(_event):
	if Input.is_action_just_pressed("trigger") and marked:
		emit_signal("send_pos",self.global_position,self)
		


func _on_MarkedTimer_timeout():
	marked=false

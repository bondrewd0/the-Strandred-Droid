extends KinematicBody2D

var direction:int
var speed=10
var velocity= Vector2(0,0)
var state:int
var timer:float
var tagged_position:Vector2
signal dead

func _ready():
	state=1
	timer=speed/40
	$Despawner.start(timer)
	$AnimatedSprite.play("Active")
	



func _process(delta):
	velocity.x= delta*speed*direction
	if(speed >=0):
		move_and_collide(velocity)
		speed-=1
	





func _on_Despawner_timeout():
	state=0;
	emit_signal("dead")
	queue_free()


func _on_Area2D_body_entered(body):
	print(body)



func _on_Area2D_area_entered(area):
	tagged_position= area.global_position
	speed=0
	global_position= tagged_position

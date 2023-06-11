extends KinematicBody2D

var direction:int
var speed=10
var velocity= Vector2(0,0)
var state:int
var timer:float
signal dead

func _ready():
	state=1
	timer=speed/40
	print(timer)
	print(speed)
	$Despawner.start(timer)
	$AnimatedSprite.play("Active")


func _process(delta):
	velocity.x= delta*speed*direction
	if(speed >=0):
		var col_info=move_and_collide(velocity)
		speed-=1
	





func _on_Despawner_timeout():
	state=0;
	emit_signal("dead")
	queue_free()


func _on_Area2D_body_entered(body):
	print(body)

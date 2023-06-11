extends KinematicBody2D

var direction= Vector2(0,0)
var speed=1000
var velocity= Vector2(0,0)
var state:int
var timer:float
signal dead

func _ready():
	state=1
	timer=speed/(20000)
	$Despawner.start(timer)
	$AnimatedSprite.play("Active")

func _process(delta):
	velocity= delta*speed*direction
	if(speed >=0):
		var col_info=move_and_collide(velocity.normalized())
		speed-=500





func _on_Despawner_timeout():
	state=0;
	emit_signal("dead")
	queue_free()


func _on_Area2D_body_entered(body):
	print(body)

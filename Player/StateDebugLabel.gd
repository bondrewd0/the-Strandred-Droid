extends Label

onready var state= $State_Manager
 
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if(!state.current_state):
		pass
	else:
		text= "State: " + state.current_state.name

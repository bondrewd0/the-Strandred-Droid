extends Node
class_name State_Manager
var current_state: BaseState

export(NodePath) var start_state 

func init(player:Player):
	for child in get_children():
		child.player = player
	
	change_state(get_node(start_state))

func change_state(new_state:BaseState):
	if(current_state):
		current_state.exit()
	
	current_state=new_state
	current_state.enter()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var new_state= current_state._process(delta)
	if new_state:
		change_state(new_state)

func _input(event):
	var new_state= current_state._input(event)
	if new_state:
		change_state(new_state)

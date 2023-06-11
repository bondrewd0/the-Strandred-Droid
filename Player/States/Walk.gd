extends Movestate

func _input(event):
	
	var new_state= ._input(event)
	if(new_state):
		return new_state
	
	return null

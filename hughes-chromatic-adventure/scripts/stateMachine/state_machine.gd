class_name StateMachine extends Node

@export var initial_state: State

var current_state: State

func _ready():
	if initial_state:
		change_state(initial_state)
	else:
		push_warning("No initial state in state machine, grabbing first child")
		var first_child := get_child(0)
		if first_child is State:
			change_state(first_child)
		else:
			push_error("No initial state even after picking first child!")


func change_state(new_state: State):
	if new_state == current_state:
		return

	if current_state:
		current_state.exit()

	current_state = new_state
	current_state.enter()


func _process(delta):
	if !current_state:
		return

	var new_state = current_state.process(delta)
	if new_state:
		change_state(new_state)


func _physics_process(delta):
	if !current_state:
		return

	var new_state = current_state.physics_process(delta)
	if new_state:
		change_state(new_state)


func _unhandled_input(event):
	if !current_state:
		return

	var new_state = current_state.input(event)
	if new_state:
		change_state(new_state)

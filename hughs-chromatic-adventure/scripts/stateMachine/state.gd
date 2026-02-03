class_name State extends Node

## Called when the state is first entered.
func enter() -> void:
	pass


## Called when the state is exited.
func exit() -> void:
	pass


## Called on every unhandled input event while in this state. If you return a different state
## from input, the state machine will switch to that new state.
func input(_event: InputEvent) -> State:
	return null


## Called during process while in this state. If you return a different state
## from process, the state machine will switch to that new state.
func process(_delta) -> State:
	return null


## Called during physics_process while in this state. If you return a different state
## from physics_process, the state machine will switch to that new state.
func physics_process(_delta) -> State:
	return null

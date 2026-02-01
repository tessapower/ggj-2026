extends State

@export var player: Player
@export var spawning_state: State


func _ready() -> void:
	if !player:
		push_error('I need a player to work!')
	if !spawning_state:
		push_error('I need a spawning_state to work!')


func enter() -> void:
	# TODO: Play the dead animation!
	pass
	
	
func process(_delta) -> State:
	# TODO: Wait for dead animation to finish!
	# TODO: Wait a tiny length of time after!
	return spawning_state

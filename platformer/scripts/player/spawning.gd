extends State

@export var player: Player
@export var walking_state: State


func _ready() -> void:
	if !player:
		push_error('I need a player to work!')
	if !walking_state:
		push_error('I need a walking_state to work!')
	# Default player spawn point to where player is, but we
	# should only call this when player is ready.
	# Our ready is called before player ready, so defer!
	_set_player_spawn_point.call_deferred()


func _set_player_spawn_point() -> void:
	player.spawn_point = player.global_position

func enter() -> void:
	player.global_position = player.spawn_point
	player.visible = true
	# TODO: Play the spawning animation!
	

func process(_delta) -> State:
	# TODO: When the spawning animation is done...
	# await animation.play('spawning') or whatever...
	return walking_state

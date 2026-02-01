extends State

@export var player: Player
@export var walking_state: State
@export var sprite: AnimatedSprite2D


var spawn_sound = load('res://assets/sfx/spawn_1.wav')

func _ready() -> void:
	if !player:
		push_error('I need a player to work!')
	if !walking_state:
		push_error('I need a walking_state to work!')
	if !sprite:
		push_error('I need a sprite to work!')
	# Default player spawn point to where player is.
	_set_player_spawn_point()


func _set_player_spawn_point() -> void:
	player.spawn_point = player.global_position


func enter() -> void:
	player.is_time_to_die = false
	player.global_position = player.spawn_point
	player.visible = true
	sprite.play(&'Spawn')
	SoundManager.play_sound(spawn_sound, "SFX")
	

func process(_delta) -> State:
	if !sprite.is_playing():
		return walking_state
	return

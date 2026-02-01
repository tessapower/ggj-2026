extends State

@export var player: Player
@export var spawning_state: State
@export var sprite: AnimatedSprite2D

func _ready() -> void:
	if !player:
		push_error('I need a player to work!')
	if !spawning_state:
		push_error('I need a spawning_state to work!')
	if !sprite:
		push_error('I need a sprite to work!')


func enter() -> void:
	sprite.play(&'Die')
	
	
func process(_delta) -> State:
	if !sprite.is_playing():
		return spawning_state
	return

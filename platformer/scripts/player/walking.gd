extends State

@export_subgroup("Attributes")
@export var groundSpeed = 60.0
@export var gravity = 60.0 # Not the real gravity

@export_subgroup("Nodes")
@export var player: Player
@export var sprite: AnimatedSprite2D

@export_subgroup("States")
@export var falling_state: State
@export var jumping_state: State
@export var dead_state: State

var landing_sound = load('res://assets/sfx/land_1.wav')

func enter() -> void:
	player.has_double_jumped = false
	SoundManager.play_sound(landing_sound)
	

func physics_process(delta) -> State:
	if player.is_time_to_die:
		return dead_state
	# Gravity.
	player.velocity.y += gravity * delta

	var direction = Input.get_axis("left", "right")
	if direction:
		player.velocity.x = direction * groundSpeed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, groundSpeed)

	var not_landing = sprite.animation != "Land"
	var stopped_landing = sprite.animation == "Land" and is_zero_approx(sprite.frame_progress - 1.0)

	if not_landing or stopped_landing:
		if is_zero_approx(player.velocity.x):
			sprite.play("Idle")
		else:
			sprite.play("Walk")

	if player.velocity.x < 0:
		sprite.flip_h = true
	elif player.velocity.x > 0:
		sprite.flip_h = false

	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		return jumping_state

	player.move_and_slide()

	if not player.is_on_floor():
		return falling_state

	return null

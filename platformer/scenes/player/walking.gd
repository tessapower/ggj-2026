extends State

@export_subgroup("Attributes")
@export var groundSpeed = 60.0
@export var gravity = 60.0 # Not the real gravity

@export_subgroup("Nodes")
@export var player: Player

@export_subgroup("States")
@export var falling_state: State
@export var jumping_state: State

func enter() -> void:
	player.has_double_jumped = false


func physics_process(delta) -> State:
	# Gravity.
	player.velocity.y += gravity * delta

	var direction = Input.get_axis("left", "right")
	if direction:
		player.velocity.x = direction * groundSpeed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, groundSpeed)

	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		return jumping_state

	player.move_and_slide()

	if not player.is_on_floor():
		return falling_state

	return null

extends State

signal landed

@export_subgroup("Attributes")
@export var air_speed: float = 60.0
@export var jump_height: float = 28.0
@export var time_to_jump_apex: float = 0.3
@export var coyote_time: float = 0.16
@export var jump_buffer_time: float = 0.10

@export_subgroup("Nodes")
@export var player: Player
@export var sprite: AnimatedSprite2D

@export_subgroup("States")
@export var walking_state: State
@export var jumping_state: State

var jump_velocity: float = 0
var half_jump_velocity: float = 0
var normal_gravity: float = 0
var float_gravity: float = 0
var current_gravity: float = 0
var coyote_time_counter: float = 0
var is_still_holding_jump: bool = false
var jump_buffer_counter: float = 0
var just_started_falling = true


func _ready():
	normal_gravity = (2 * jump_height) / (time_to_jump_apex ** 2)
	float_gravity = normal_gravity / 2
	current_gravity = normal_gravity
	jump_velocity = -normal_gravity * time_to_jump_apex
	half_jump_velocity = jump_velocity / 2


func enter() -> void:
	coyote_time_counter = 0
	is_still_holding_jump = Input.is_action_pressed("jump")
	current_gravity = normal_gravity
	jump_buffer_counter = 0
	just_started_falling = true


func exit() -> void:
	sprite.rotation = 0


#func process(_delta) -> State:
	#if player.velocity.y != 0:
		#sprite.rotation = sign(player.velocity.x) * (player.velocity.y / 200) * .1
#
	#return null


func physics_process(delta) -> State:
	var was_on_floor = player.is_on_floor()
	var old_vel_y = player.velocity.y

	player.velocity.y += current_gravity * delta
	coyote_time_counter += delta

	var direction = Input.get_axis("left", "right")
	if direction:
		player.velocity.x = direction * air_speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, air_speed)

	if player.velocity.y > 0 and just_started_falling:
		sprite.play("Fall")
		just_started_falling = false
	
	if player.velocity.x < 0:
		sprite.flip_h = true
	elif player.velocity.x > 0:
		sprite.flip_h = false

	# Jump buffer.
	if jump_buffer_counter > 0:
		jump_buffer_counter -= delta

	if Input.is_action_just_pressed("jump") and player.velocity.y > 0:
		jump_buffer_counter = jump_buffer_time


	# Coyote time.
	if Input.is_action_just_pressed("jump") and player.velocity.y >= 0 and coyote_time_counter < coyote_time:
		return jumping_state


	# Floaty peaks.
	if is_still_holding_jump and !Input.is_action_pressed("jump"):
		is_still_holding_jump = false

	if Input.is_action_pressed("jump") and old_vel_y < 0 and player.velocity.y > 0 and is_still_holding_jump:
		current_gravity = float_gravity

	if !Input.is_action_pressed("jump") and current_gravity == float_gravity:
		current_gravity = normal_gravity


	# Responsive jump.
	if !Input.is_action_pressed("jump") and player.velocity.y < half_jump_velocity:
		player.velocity.y = half_jump_velocity


	# Double-jump.
	if Input.is_action_just_pressed("jump") and !player.has_double_jumped and player.can_double_jump:
		player.has_double_jumped = true
		return jumping_state


	player.move_and_slide()


	# Did we land?
	if !was_on_floor and player.is_on_floor():
		landed.emit()
		# Are we in time to hit the jump buffer?
		if jump_buffer_counter > 0:
			return jumping_state
		else:
			sprite.play("Land")
			return walking_state

	return null

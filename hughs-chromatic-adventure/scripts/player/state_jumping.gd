extends State

signal jumped

@export_subgroup("Attributes")
@export var jump_height: float = 28.0
@export var time_to_jump_apex: float = 0.3

@export_subgroup("Nodes")
@export var player: Player
@export var sprite: AnimatedSprite2D

@export_subgroup("States")
@export var falling_state: State

var jump_velocity: float = 0
var normal_gravity: float = 0
var jump_sound = load('res://assets/sfx/jump_stream_randomizer.tres')


func play_jump():
	if sprite.animation == "Jump":
		# restart the jump animation if it was already playing
		sprite.stop()
	sprite.play("Jump")


func _ready():
	normal_gravity = (2 * jump_height) / (time_to_jump_apex ** 2)
	jump_velocity = -normal_gravity * time_to_jump_apex


func enter() -> void:
	SoundManager.play_sound(jump_sound, "SFX")


func physics_process(_delta) -> State:
	player.velocity.y = jump_velocity
	jumped.emit()
	player.move_and_slide()
	play_jump()
	return falling_state

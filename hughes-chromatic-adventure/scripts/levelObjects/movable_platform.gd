extends Node2D

@export var randomize_start_direction: bool = true
@export var move_width: float = 96.0
@export var move_time: float = 3.0

@onready var platform: TileMapLayer = $Platform
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	_make_animation_unique()
	_setup_movement_animation()

	if randomize_start_direction and animation_player and animation_player.has_animation("move"):
		# Randomly start at beginning (0.0) or end (move_time) of animation
		# and flip playback_speed so platforms start moving in opposite directions
		if randf() < 0.5:
			animation_player.seek(0.0, true)
			animation_player.playback_speed = abs(animation_player.playback_speed)
		else:
			animation_player.seek(move_time, true)
			animation_player.playback_speed = -abs(animation_player.playback_speed)


func _make_animation_unique() -> void:
	if not animation_player:
		return

	# Get the animation library
	var lib = animation_player.get_animation_library("")
	if not lib:
		return

	# Create a new unique library
	var unique_lib = AnimationLibrary.new()

	# Duplicate each animation in the library
	for anim_name in lib.get_animation_list():
		var original_anim = lib.get_animation(anim_name)
		var duplicated_anim = original_anim.duplicate(true)  # deep duplicate
		unique_lib.add_animation(anim_name, duplicated_anim)

	# Replace the library with our unique one
	animation_player.remove_animation_library("")
	animation_player.add_animation_library("", unique_lib)


func _setup_movement_animation() -> void:
	if not animation_player or not animation_player.has_animation("move"):
		return

	var animation = animation_player.get_animation("move")

	# Set the animation length
	animation.length = move_time

	# Find or create the position track
	# Since root_node is set to Platform, ".:position" means Platform's position
	var track_idx = animation.find_track(".:position", Animation.TYPE_VALUE)

	if track_idx == -1:
		# Create track if it doesn't exist
		track_idx = animation.add_track(Animation.TYPE_VALUE)
		animation.track_set_path(track_idx, ".:position")
		animation.track_set_interpolation_type(track_idx, Animation.INTERPOLATION_CUBIC)

	# Clear existing keys
	while animation.track_get_key_count(track_idx) > 0:
		animation.track_remove_key(track_idx, 0)

	# Get the platform's starting position
	var start_pos = platform.position

	# Add keyframes: left -> center -> right (with ping-pong it goes back)
	animation.track_insert_key(track_idx, 0, start_pos + Vector2(-move_width, 0))
	animation.track_insert_key(track_idx, move_time / 2.0, start_pos)
	animation.track_insert_key(track_idx, move_time, start_pos + Vector2(move_width, 0))

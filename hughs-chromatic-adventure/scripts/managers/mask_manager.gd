extends Node

signal mask_changed(new_color: MASK_COLOR)
signal mask_collected(new_color: MASK_COLOR)

enum MASK_COLOR {
	NONE,
	RED,
	BLUE,
	GREEN,
}

var mask_switch_sound = load("res://assets/sfx/switch_color_stream_randomizer.tres")


# Keeps track of the masks the player has collected
var masks: Dictionary[MASK_COLOR, bool] = {
	MASK_COLOR.RED: false,
	MASK_COLOR.GREEN: false,
	MASK_COLOR.BLUE: false,
}

# Getter functions for checking if certain colored mask is on

var is_red_on: bool:
	get:
		return current_color == MASK_COLOR.RED


var is_blue_on: bool:
	get:
		return current_color == MASK_COLOR.BLUE


var is_green_on: bool:
	get:
		return current_color == MASK_COLOR.GREEN


var current_color: MASK_COLOR: set = _on_current_color_changed


func _on_current_color_changed(new_color):
	if current_color == new_color:
		return

	current_color = new_color
	get_tree().call_group(&'red_things', _get_function_for_color(MASK_COLOR.RED))
	get_tree().call_group(&'green_things', _get_function_for_color(MASK_COLOR.GREEN))
	get_tree().call_group(&'blue_things', _get_function_for_color(MASK_COLOR.BLUE))
	
	# Play switch sound
	SoundManager.play_sound(mask_switch_sound, "SFX")

	# Update the music playing to match the mask color
	match current_color:
		MASK_COLOR.NONE:
			MusicManager.crossfade_sync_stream([0])
		MASK_COLOR.RED:
			MusicManager.crossfade_sync_stream([0, 1])
		MASK_COLOR.GREEN:
			MusicManager.crossfade_sync_stream([0, 2])
		MASK_COLOR.BLUE:
			MusicManager.crossfade_sync_stream([0, 3])

	mask_changed.emit(current_color)


func _get_function_for_color(color: MASK_COLOR) -> StringName:
	return &'mask_color_activate' if current_color == color else &'mask_color_deactivate'


func remove_mask() -> void:
	current_color = MASK_COLOR.NONE


func toggle(color: MASK_COLOR) -> void:
	if color == current_color:
		current_color = MASK_COLOR.NONE
	else:
		current_color = color


# Used to reset the state of collected masks
func reset_mask_state(skip_tutorial: bool = false) -> void:
	for mask in masks:
		masks[mask] = false

	if skip_tutorial:
		masks[MASK_COLOR.BLUE] = true


func enable_mask_color(color: MASK_COLOR) -> void:
	masks[color] = true
	emit_signal("mask_collected", color)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&'toggle_red') and masks[MaskManager.MASK_COLOR.RED]:
		toggle(MASK_COLOR.RED)
	if event.is_action_pressed(&'toggle_green') and masks[MaskManager.MASK_COLOR.GREEN]:
		toggle(MASK_COLOR.GREEN)
	if event.is_action_pressed(&'toggle_blue') and masks[MaskManager.MASK_COLOR.BLUE]:
		toggle(MASK_COLOR.BLUE)

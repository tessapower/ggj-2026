extends Node

# TODO: Could be overkill to be in a component?!

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&'toggle_red'):
		MaskManager.is_red_on = !MaskManager.is_red_on
	if event.is_action_pressed(&'toggle_blue'):
		MaskManager.is_blue_on = !MaskManager.is_blue_on
	if event.is_action_pressed(&'toggle_green'):
		MaskManager.is_green_on = !MaskManager.is_green_on

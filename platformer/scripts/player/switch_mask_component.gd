extends Node

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&'toggle_red'):
		MaskManager.toggle(MaskManager.MASK_COLOR.RED)
	if event.is_action_pressed(&'toggle_blue'):
		MaskManager.toggle(MaskManager.MASK_COLOR.BLUE)
	if event.is_action_pressed(&'toggle_green'):
		MaskManager.toggle(MaskManager.MASK_COLOR.GREEN)

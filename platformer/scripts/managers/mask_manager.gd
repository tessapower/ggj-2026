extends Node

signal mask_changed()

var is_red_on: bool:
	get:
		return current_color == MASK_COLOR.RED
var is_blue_on: bool:
	get:
		return current_color == MASK_COLOR.BLUE
var is_green_on: bool:
	get:
		return current_color == MASK_COLOR.GREEN

enum MASK_COLOR {
	NONE,
	RED,
	BLUE,
	GREEN,
}

var current_color: MASK_COLOR: set = _on_current_color_changed

func _on_current_color_changed(new_value):
	if current_color == new_value:
		return
	current_color = new_value
	mask_changed.emit()


func reset_masks() -> void:
	current_color = MASK_COLOR.NONE


func toggle(color: MASK_COLOR) -> void:
	if color == current_color:
		current_color = MASK_COLOR.NONE
	else:
		current_color = color

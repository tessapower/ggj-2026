extends Node

signal mask_changed()

var is_red_on: bool: set = on_is_red_on_changed
var is_blue_on: bool: set = on_is_blue_on_changed
var is_green_on: bool: set = on_is_green_on_changed

# It's a lot of duplication, I know! But I thought that's better
# than trying to be too clever.
# TODO: Offer some way to flip multiple mask settings so mask_changed is only emitted once for the batch?

func on_is_red_on_changed(new_value: bool):
	if is_red_on == new_value:
		return
	is_red_on = new_value
	mask_changed.emit()


func on_is_blue_on_changed(new_value: bool):
	if is_blue_on == new_value:
		return
	is_blue_on = new_value
	mask_changed.emit()


func on_is_green_on_changed(new_value: bool):
	if is_green_on == new_value:
		return
	is_green_on = new_value
	mask_changed.emit()


func reset_masks() -> void:
	is_red_on = false
	is_blue_on = false
	is_green_on = false

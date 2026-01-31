extends Node2D


func _ready() -> void:
	MaskManager.mask_changed.connect(_on_mask_changed)


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed(&'ui_cancel'):
		get_tree().quit()


func _on_mask_changed() -> void:
	prints('Red:', MaskManager.is_red_on, 'Blue:', MaskManager.is_blue_on, 'Green:', MaskManager.is_green_on)

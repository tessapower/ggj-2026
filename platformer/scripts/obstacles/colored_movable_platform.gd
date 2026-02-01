extends Node2D

## This is the 1-based layer index! 2 = red, 3 = blue, 4 = green!
@export var layer_value: int = 1

@onready var animatable_body_2d: AnimatableBody2D = $AnimatableBody2D
@onready var activated_sprite: Sprite2D = $AnimatableBody2D/ActivatedSprite
@onready var deactivated_sprite: Sprite2D = $AnimatableBody2D/DeactivatedSprite


func mask_color_activate() -> void:
	activated_sprite.visible = false
	deactivated_sprite.visible = true
	animatable_body_2d.set_collision_layer_value(layer_value, false)


func mask_color_deactivate() -> void:
	activated_sprite.visible = true
	deactivated_sprite.visible = false
	animatable_body_2d.set_collision_layer_value(layer_value, true)

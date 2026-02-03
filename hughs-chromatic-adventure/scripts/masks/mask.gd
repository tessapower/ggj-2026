extends Node

@export var mask_color: MaskManager.MASK_COLOR = MaskManager.MASK_COLOR.NONE

var red_pickup_sound = load("res://assets/sfx/mask_pickup/red_mask_pickup.wav")
var green_pickup_sound = load("res://assets/sfx/mask_pickup/green_mask_pickup.wav")
var blue_pickup_sound = load("res://assets/sfx/mask_pickup/blue_mask_pickup.wav")

func play_mask_pickup_sound(mask_color: MaskManager.MASK_COLOR) -> void:
	match mask_color:
		MaskManager.MASK_COLOR.RED:
			SoundManager.play_sound(red_pickup_sound, "SFX")
		MaskManager.MASK_COLOR.GREEN:
			SoundManager.play_sound(green_pickup_sound, "SFX")
		MaskManager.MASK_COLOR.BLUE:
			SoundManager.play_sound(blue_pickup_sound, "SFX")

func _on_mask_pickup(body: Node2D) -> void:
	if body is Player:
		MaskManager.enable_mask_color(mask_color)
		play_mask_pickup_sound(mask_color)
		
		# Remove mask node from the scene
		queue_free()

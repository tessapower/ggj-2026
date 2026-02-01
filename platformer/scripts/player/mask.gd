extends Node

@export var mask_color: MaskManager.MASK_COLOR = MaskManager.MASK_COLOR.NONE


func _on_mask_pickup(body: Node2D) -> void:
	if body.name == "Player":
		MaskManager.enable_mask_color(mask_color)
		
		# Remove mask node from the scene
		queue_free()

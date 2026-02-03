extends StaticBody2D

@export_enum("Yellow", "Purple") var key_color = ""

func _on_door_approach(body: Node2D) -> void:
	if body is Player:
		print("check for key!")

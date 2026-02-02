extends Node2D

var last_location

func _body_entered(body: Node2D) -> void:
	if body is Player:
		body.change_respawn_point(position)

		queue_free()

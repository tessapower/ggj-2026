class_name Goal extends Node2D

signal level_complete

func _player_entered(body: Node2D) -> void:
	if body is Player:
		emit_signal("level_complete")

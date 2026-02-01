class_name Goal extends Node2D

signal goal_reached()

func _player_entered(body: Node2D) -> void:
	if body is Player:
		goal_reached.emit()

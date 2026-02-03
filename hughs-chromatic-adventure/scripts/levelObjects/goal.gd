class_name Goal extends Node2D

func _player_entered(body: Node2D) -> void:
	if body is Player:
		GamestateManager.level_complete.emit()

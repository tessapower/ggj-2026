extends Node2D

var last_location

# const sfx = preload("res://assets/sfx/collect_checkpoint_1.wav")

func _body_entered(body: Node2D) -> void:
	if body is Player:
		body.change_respawn_point(position)
		# SoundManager.play_sound(sfx, "SFX")

		queue_free()

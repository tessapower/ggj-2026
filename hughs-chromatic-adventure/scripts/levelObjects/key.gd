extends Node2D

@export_enum("Yellow", "Purple") var color = ""

const sfx = preload("res://assets/sfx/collect_key_1.wav")

signal picked_up(color: String)

func _body_entered(body: Node2D) -> void:
	if body is Player:
		emit_signal("picked_up", color)
		SoundManager.play_sound(sfx, "SFX")
		queue_free()

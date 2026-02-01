extends Node2D

var last_location

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _body_entered(body: Node2D) -> void:
	body.change_respawnpoint(position)

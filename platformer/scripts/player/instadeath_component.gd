extends Area2D

@export var player: Player

func _ready() -> void:
	if !player:
		push_error("I can't work without a player!")
	body_entered.connect(_on_body_entered)


func _on_body_entered(_body: Node2D):
	player.is_time_to_die = true

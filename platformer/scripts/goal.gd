extends Node2D

signal goal_reached()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _player_entered(body: Node2D) -> void:
	if body.name == "Player":
		goal_reached.emit()

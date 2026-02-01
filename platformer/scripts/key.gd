extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("key")
		body.toggle_key()
		var tween = create_tween()
		tween.tween_property(self, "modulate:a", 0, 0.5) # Fades over 0.5 second
		await tween.finished
		queue_free()

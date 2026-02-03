extends StaticBody2D

@export_enum("Yellow", "Purple") var key_color = ""

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D

var level: Node = null
var is_open: bool = false


func set_level(level_node: Node) -> void:
	level = level_node


func _on_door_approach(body: Node2D) -> void:
	if is_open:
		return

	if body is Player:
		if level and level.has_method("has_key") and level.has_key(key_color):
			_open_door()


func _open_door() -> void:
	is_open = true

	# Consume the key
	if level and level.has_method("consume_key"):
		level.consume_key(key_color)
		# TODO: Play door unlocking sound

		# Disable collision
		collision_shape.set_deferred("disabled", true)

		# Animate door disappearing
		var tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(sprite, "modulate:a", 0.0, 0.25)
		tween.tween_callback(queue_free)

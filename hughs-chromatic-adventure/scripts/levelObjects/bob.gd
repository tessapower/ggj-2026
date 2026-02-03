extends Sprite2D

func _ready():
	bob_animation()


func bob_animation():
	var tween = create_tween()
	tween.set_loops()  # Infinite loop
	tween.tween_property(self, "position:y", -3, 1.0)
	tween.tween_property(self, "position:y", 0, 2.0)

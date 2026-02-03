extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	color_rect.visible = false

func fade_to_scene(scene_path: String) -> void:
	color_rect.visible = true
	animation_player.play("fade_out")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(scene_path)
	animation_player.play("fade_in")
	await animation_player.animation_finished
	color_rect.visible = false

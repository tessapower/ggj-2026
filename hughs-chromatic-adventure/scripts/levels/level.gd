extends Node

# The scene file that will be loaded when this level is completed
@export_file("*.tscn") var next_scene: String

# The goal on this level
var goal: Goal


func _ready() -> void:
	goal = $Goal
	if goal:
		goal.level_complete.connect(_on_level_complete)


# Callback function for when the goal on this level is reached
func _on_level_complete() -> void:
	# Hand off to the next scene
	_load_next_scene()


func _load_next_scene() -> void:
	if next_scene:
		# Reset masks
		MaskManager.remove_mask()
		TransitionManager.fade_to_scene(next_scene)

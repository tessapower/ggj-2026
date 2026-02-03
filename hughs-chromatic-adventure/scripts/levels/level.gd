extends Node

# The scene file that will be loaded when this level is completed
@export_file("*.tscn") var next_scene: String

# Track keys collected in this level only
var keys_collected: Dictionary = {"Purple": 0, "Yellow": 0}


# The goal on this level
var goal: Goal


func _ready() -> void:
	goal = $Goal
	if goal:
		goal.level_complete.connect(_on_level_complete)

	# Connect all keys in the level
	_connect_keys()
	# Connect all doors in the level
	_connect_doors()


func _connect_keys() -> void:
	# Find all Key nodes in the level (using groups)
	var keys = get_tree().get_nodes_in_group("keys")
	for key in keys:
		if key.has_signal("picked_up"):
			key.picked_up.connect(_on_key_picked_up)


func _connect_doors() -> void:
	# Find all doors and give them a reference to check keys
	var doors = get_tree().get_nodes_in_group("doors")
	for door in doors:
		if door.has_method("set_level"):
			door.set_level(self)


func _on_key_picked_up(color: String) -> void:
	keys_collected[color] = keys_collected.get(color, 0) + 1


func has_key(color: String) -> bool:
	return keys_collected.get(color, 0) > 0


func consume_key(color: String) -> void:
	if has_key(color):
		keys_collected[color] -= 1

# Callback function for when the goal on this level is reached
func _on_level_complete() -> void:
	# Hand off to the next scene
	_load_next_scene()


func _load_next_scene() -> void:
	if next_scene:
		# Reset masks
		MaskManager.remove_mask()
		TransitionManager.fade_to_scene(next_scene)

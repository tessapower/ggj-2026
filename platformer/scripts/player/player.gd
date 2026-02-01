class_name Player extends CharacterBody2D

var respawnpoint = Vector2i(0, 0)

## Whether the player can double jump
var can_double_jump := true

var has_double_jumped := false

var spawn_point: Vector2
var is_time_to_die: bool = false

## change the respawn point
func change_respawnpoint(new_coords):
	respawnpoint = new_coords

class_name Player extends CharacterBody2D

# Initial respawn point is (0,0).  
var respawnpoint = Vector2i(global_position)

## Whether the player can double jump
var can_double_jump := true

var has_double_jumped := false

## change the respawn point
func change_respawnpoint(new_coords):
	respawnpoint = new_coords

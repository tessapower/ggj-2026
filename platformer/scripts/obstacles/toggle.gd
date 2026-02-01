# toggle.gd

extends TileMapLayer

var is_activated: bool = false
const TILE_OFFSET: int = 4


func mask_color_activate() -> void:
	if is_activated:
		return # Already activated, do nothing

	is_activated = true
	var cells = get_used_cells()
	for coords in cells:
		var atlas_coords = get_cell_atlas_coords(coords)
		set_cell(coords, 0, Vector2i(atlas_coords.x, atlas_coords.y + TILE_OFFSET))


func mask_color_deactivate() -> void:
	if not is_activated:
		return # Already deactivated, do nothing

	is_activated = false
	var cells = get_used_cells()
	for coords in cells:
		var atlas_coords = get_cell_atlas_coords(coords)
		set_cell(coords, 0, Vector2i(atlas_coords.x, atlas_coords.y - TILE_OFFSET))

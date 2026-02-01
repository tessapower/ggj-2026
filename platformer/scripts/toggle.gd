extends TileMapLayer

## Physics layers: 2 = Red, 3 = Blue, 4 = Green
@export var layer_value: int = -1

func _ready() -> void:
	if layer_value == -1:
		printerr("Layer not initialized!!")

func mask_color_activate() -> void:
	var cells = get_used_cells();
	for i in cells.size():
		var coords = cells[i]
		var atlas_coords = get_cell_atlas_coords(coords)
		set_cell(Vector2i(coords.x,coords.y), layer_value, Vector2i(atlas_coords.x, atlas_coords.y + 4));

func mask_color_deactivate() -> void:
	var cells = get_used_cells();
	for i in cells.size():
		var coords = cells[i]
		var atlas_coords = get_cell_atlas_coords(coords)
		set_cell(Vector2i(coords.x,coords.y), layer_value, Vector2i(atlas_coords.x, atlas_coords.y - 4));

extends TileMapLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MaskManager.mask_changed.connect(_on_mask_changed)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(event):
	pass

func _on_mask_changed() -> void:
	prints('Red:', MaskManager.is_red_on, 'Blue:', MaskManager.is_blue_on, 'Green:', MaskManager.is_green_on)

	var cells = get_used_cells();
	for i in cells.size():
		var coords = cells[i]
		var atlas_coords = get_cell_atlas_coords(coords)
		if MaskManager.is_red_on and name == "Red Layer":
			set_cell(Vector2i(coords.x,coords.y), 4, Vector2i(atlas_coords.x, atlas_coords.y+4));
		elif !MaskManager.is_red_on and name == "Red Layer" and atlas_coords.y > 3:
			set_cell(Vector2i(coords.x,coords.y), 4, Vector2i(atlas_coords.x, atlas_coords.y-4));
			
		if MaskManager.is_blue_on and name == "Blue Layer":
			set_cell(Vector2i(coords.x,coords.y), 2, Vector2i(atlas_coords.x, atlas_coords.y+4));
		elif ! MaskManager.is_blue_on and name == "Blue Layer" and atlas_coords.y > 3:
			set_cell(Vector2i(coords.x,coords.y), 2, Vector2i(atlas_coords.x, atlas_coords.y-4));
		
		if MaskManager.is_green_on and name == "Green Layer":
			set_cell(Vector2i(coords.x,coords.y), 3, Vector2i(atlas_coords.x, atlas_coords.y+4));
		elif !MaskManager.is_green_on and name == "Green Layer" and atlas_coords.y > 3:
			set_cell(Vector2i(coords.x,coords.y), 3, Vector2i(atlas_coords.x, atlas_coords.y-4));

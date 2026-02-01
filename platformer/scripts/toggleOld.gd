extends Node2D

@onready var blue_layer : TileMapLayer = $"Blue Layer"
@onready var green_layer : TileMapLayer = $"Green Layer"
@onready var red_layer : TileMapLayer = $"Red Layer"
var toggle = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MaskManager.mask_changed.connect(_on_mask_changed)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(event):
	#if event.is_action_pressed("toggle_red"):
	if event.is_action_pressed("up"):
		var cells = red_layer.get_used_cells();
		for i in cells.size():
			var atlas_coords = red_layer.get_cell_atlas_coords(cells[i]);
			if toggle == true:
				red_layer.set_cell(Vector2i(cells[i].x,cells[i].y), 4, Vector2i(atlas_coords.x, atlas_coords.y+4));
				toggle = false
			else:
				red_layer.set_cell(Vector2i(cells[i].x,cells[i].y), 4, Vector2i(atlas_coords.x, atlas_coords.y-4));
				toggle = true

func _on_mask_changed() -> void:
	prints('Red:', MaskManager.is_red_on, 'Blue:', MaskManager.is_blue_on, 'Green:', MaskManager.is_green_on)

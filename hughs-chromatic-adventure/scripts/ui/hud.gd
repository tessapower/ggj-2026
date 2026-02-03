extends CanvasLayer

@onready var red_mask_icon: TextureRect = $Content/Masks/RedMask
@onready var green_mask_icon: TextureRect = $Content/Masks/GreenMask
@onready var blue_mask_icon: TextureRect = $Content/Masks/BlueMask

const ICON_SIZE = 30
const INACTIVE_REGION = Rect2(0, 0, ICON_SIZE, ICON_SIZE)
const ACTIVE_REGION = Rect2(ICON_SIZE, 0, ICON_SIZE, ICON_SIZE)


func _ready() -> void:
	MaskManager.mask_changed.connect(_on_mask_changed)
	MaskManager.mask_collected.connect(_on_mask_collected)

	# Set initial visibility based on collection status
	red_mask_icon.modulate = Color.WHITE if MaskManager.masks[MaskManager.MASK_COLOR.RED] else Color(1, 1, 1, 0.3)
	green_mask_icon.modulate = Color.WHITE if MaskManager.masks[MaskManager.MASK_COLOR.GREEN] else Color(1, 1, 1, 0.3)
	blue_mask_icon.modulate = Color.WHITE if MaskManager.masks[MaskManager.MASK_COLOR.BLUE] else Color(1, 1, 1, 0.3)


func _on_mask_changed(_new_color: MaskManager.MASK_COLOR) -> void:
	_update_hud()


func _on_mask_collected(color: MaskManager.MASK_COLOR) -> void:
	match color:
		MaskManager.MASK_COLOR.RED:
			red_mask_icon.modulate = Color.WHITE
		MaskManager.MASK_COLOR.GREEN:
			green_mask_icon.modulate = Color.WHITE
		MaskManager.MASK_COLOR.BLUE:
			blue_mask_icon.modulate = Color.WHITE

	_update_hud()


func _update_hud() -> void:
	red_mask_icon.texture.region = ACTIVE_REGION if MaskManager.is_red_on else INACTIVE_REGION
	green_mask_icon.texture.region = ACTIVE_REGION if MaskManager.is_green_on else INACTIVE_REGION
	blue_mask_icon.texture.region = ACTIVE_REGION if MaskManager.is_blue_on else INACTIVE_REGION

extends ColorRect


func mask_color_activate() -> void:
	self.visible = true


func mask_color_deactivate() -> void:
	self.visible = false

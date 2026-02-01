extends Node2D

@onready var music_manager: MusicManager = $MusicManager
@onready var level_container: Node2D = $LevelContainer


var multistream_music = load("res://assets/music/main_level/main_level_audio_stream.tres")

var level_1 = preload('uid://bbvot6xuyplai')


func _ready() -> void:
	music_manager.fade_music_in(multistream_music)
	level_container.add_child(level_1.instantiate())
	MaskManager.mask_changed.connect(_on_mask_color_changed)


func _on_mask_color_changed() -> void:
	var current_color = MaskManager.current_color
	if current_color == MaskManager.MASK_COLOR.NONE:
		music_manager.crossfade_sync_stream([0])
	elif current_color == MaskManager.MASK_COLOR.RED:
		music_manager.crossfade_sync_stream([0, 1])
	elif current_color == MaskManager.MASK_COLOR.GREEN:
		music_manager.crossfade_sync_stream([0, 2])
	elif current_color == MaskManager.MASK_COLOR.BLUE:
		music_manager.crossfade_sync_stream([0, 3])

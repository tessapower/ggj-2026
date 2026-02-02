extends Node2D

@onready var music_manager: MusicManager = $MusicManager
@onready var level_container: Node2D = $LevelContainer


var multistream_music = load("res://assets/music/main_level/main_level_audio_stream.tres")

var level_1 = preload('uid://bbvot6xuyplai')
var level_2 = preload('uid://dmqwm1whvogj4')
var level_3 = preload('uid://b13r1irqeg4q')

var on_level_two = false


func _ready() -> void:
	music_manager.fade_music_in(multistream_music)
	level_container.add_child(level_1.instantiate())
	MaskManager.mask_changed.connect(_on_mask_color_changed)
	GamestateManager.level_complete.connect(_on_level_complete)


func _on_level_complete() -> void:
	var current_level = level_container.get_child(0)
	level_container.remove_child(current_level)
	if !on_level_two:
		level_container.add_child(level_2.instantiate())
		on_level_two = true
	else:
		level_container.add_child(level_3.instantiate())


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

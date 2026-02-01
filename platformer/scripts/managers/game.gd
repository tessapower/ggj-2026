extends Node2D

@onready var music_manager: MusicManager = $MusicManager
@onready var level_container: Node2D = $LevelContainer


var multistream_music = load("res://assets/music/main_level/main_level_audio_stream.tres")

var level_1 = preload('uid://bbvot6xuyplai')


func _ready() -> void:
	music_manager.fade_music_in(multistream_music)
	level_container.add_child(level_1.instantiate())

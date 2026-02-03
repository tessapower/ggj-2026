extends Node2D

var multistream_music = preload("res://assets/music/main_level/main_level_audio_stream.tres")

func _ready() -> void:
	# Start playing music
	MusicManager.fade_music_in(multistream_music)

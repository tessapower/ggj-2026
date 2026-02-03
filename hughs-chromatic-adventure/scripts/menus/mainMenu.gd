extends Control

@export_file("*.tscn") var level_1: String

var multistream_music = preload("res://assets/music/main_level/main_level_audio_stream.tres")


func _ready() -> void:
	# Start playing music
	MusicManager.fade_music_in(multistream_music)


func _on_play() -> void:
	TransitionManager.fade_to_scene(level_1)


func _on_exit() -> void:
	get_tree().quit()

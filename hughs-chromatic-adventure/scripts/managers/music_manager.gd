extends Node

const mute_db := -80.0
const default_music_db := 0.0
const track_fade_time := 2.0
const sync_fade_time := 0.5
const lpf_resonance_time := 0.2

var current_music_player : AudioStreamPlayer


@onready var audio_stream_01 : AudioStreamPlayer = $AudioStreamPlayer1
@onready var audio_stream_02 : AudioStreamPlayer = $AudioStreamPlayer2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_music_player = audio_stream_01

	# TEST
	"""
	fade_music_in(t) - starts with 0
	crossfade_sync_stream([0,1,2,3]) - 1=red, 2=green, 3=blue, call with [0,1] for red, etc.
	var timer:SceneTreeTimer = get_tree().create_timer(10.0)
	timer.timeout.connect(func(): crossfade_sync_stream([0,1]))
	var timer2:SceneTreeTimer = get_tree().create_timer(20.0)
	timer2.timeout.connect(func(): crossfade_sync_stream([0,2]))
	var lpf_timer:SceneTreeTimer = get_tree().create_timer(10.0)
	lpf_timer.timeout.connect(func(): low_pass_sweep(40, 5))
	"""

func fade_music_in(track: AudioStream, fade_time=track_fade_time) -> void:
	current_music_player.stream = track
	current_music_player.volume_db = mute_db

	# Set default playback to only first track if synchronized
	if (track is AudioStreamSynchronized):
		track.set_sync_stream_volume(0, default_music_db)

		# Mute other tracks
		for i in range(1, track.stream_count):
			track.set_sync_stream_volume(i, mute_db)

	current_music_player.play()

	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(current_music_player, "volume_db", default_music_db, fade_time)


func fade_music_out(fade_time=track_fade_time) -> void:
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	tween.tween_property(current_music_player, "volume_db", mute_db, fade_time)


func crossfade_music_to(track: AudioStream) -> void:
	fade_music_out() # Fade out first player

	# Switch current Player:
	current_music_player = audio_stream_01 if current_music_player == audio_stream_02 else audio_stream_02

	fade_music_in(track) # Fade in second player


func crossfade_sync_stream(active_tracks: Array[int]):
	# Fail silently if not playing synchronized tracks
	if (current_music_player.stream is not AudioStreamSynchronized):
		return

	var track : AudioStreamSynchronized = current_music_player.stream

	for i in range(track.stream_count):
		if i not in active_tracks:
			# Start mute transition
			var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_EXPO)
			tween.tween_method(
				func(b): track.set_sync_stream_volume(i, b),
				track.get_sync_stream_volume(i),
				mute_db,
				sync_fade_time
				)

		else:
			# Start unmute transition
			var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
			tween.tween_method(
				func(b): track.set_sync_stream_volume(i, b),
				track.get_sync_stream_volume(i),
				default_music_db,
				sync_fade_time
				)

		track.set_sync_stream_volume(i, mute_db)


func low_pass_sweep(end_freq, time, resonance=0.7):
	var lpf = AudioServer.get_bus_effect(1, 0)

	# Update resonance
	var reso_tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	reso_tween.tween_property(
		lpf, "resonance",
		resonance,
		lpf_resonance_time
	)

	var ease_type = Tween.EASE_IN if lpf.cutoff_hz < end_freq else Tween.EASE_OUT
	var freq_tween = create_tween().set_ease(ease_type).set_trans(Tween.TRANS_EXPO)
	freq_tween.tween_property(
		lpf, "cutoff_hz",
		end_freq,
		time
	)

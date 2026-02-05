extends PathFollow2D

@export_category("Curve Properties")
@export_range(0, 60.0) var max_speed: float # pixels per second
@export_range(0, 0.5) var slow_ratio: float # percent along the path
@export_range(0, 10.0) var end_pause: float # seconds

@export var is_reactive: bool

var current_speed = 0.0
var is_stopped = false
var direction = 1
var end_timer = 0.0

func process_end():
	if not is_stopped and not loop:
		if is_equal_approx(0.0, progress_ratio):
			direction = 1
			stop()
		elif is_equal_approx(1.0, progress_ratio):
			direction = -1
			stop()

func process_timer(delta):
	if is_stopped:
		end_timer += delta
	if end_timer > end_pause:
		end_timer = 0.0
		start(delta)

func stop():
	is_stopped = true
	current_speed = 0.0

func start(delta):
	is_stopped = false
	current_speed = max_speed * direction * delta

func process_move(delta):
	if loop:
		current_speed = max_speed * delta
	progress += current_speed

func _physics_process(delta: float) -> void:
	process_end()
	process_timer(delta)
	process_move(delta)

extends RigidBody2D

@onready var stretch_sound = $StretchSound
@onready var launch_sound = $LaunchSound
@onready var collision_sound = $CollisionSound

const DRAG_LIM_MAX: Vector2 = Vector2(0, 60)
const DRAG_LIM_MIN: Vector2 = Vector2(-60, 0)
const IMPULSE_MULT: float = 20.0
const FIRE_DELAY: float = 0.25

var _dead: bool = false
var _dragging: bool = false
var _released: bool = false
var _start: Vector2 = Vector2.ZERO
var _drag_start: Vector2 = Vector2.ZERO
var _dragged_vector: Vector2 = Vector2.ZERO
var _last_dragged_position: Vector2 = Vector2.ZERO
var _last_drag_amount: float = 0.0
var _fired_time: float = 0.0
var _last_collision_count: int = 0

func _ready():
	_start = global_position

func _physics_process(delta):
	update_debug_label()
	
	if _released:
		_fired_time += delta
		if _fired_time > FIRE_DELAY:
			play_collision()
	else:
		if !_dragging:
			return
		else:
			if Input.is_action_just_released("drag"):
				release_it()
			else:
				drag_it()

func update_debug_label() -> void:
	var s = "g_pos: %s contacts: %s\n" % [Utils.vec2_to_str(global_position), get_contact_count()]
	s += "dragging: %s released: %s\n" % [_dragging, _released]
	s += "start: %s drag_start: %s dragged_vector: %s\n" % [
		Utils.vec2_to_str(_start),
		Utils.vec2_to_str(_drag_start),
		Utils.vec2_to_str(_dragged_vector)
	]
	s += "last_dragged_position: %s last_drag_amount: %.1f\n" % [
		Utils.vec2_to_str(_last_dragged_position),
		_last_drag_amount
	]
	s += "ang: %.1f linear: %s fired_time: %.1f" % [angular_velocity, Utils.vec2_to_str(linear_velocity), _fired_time]
	SignalManager.on_update_debug_label.emit(s)

func play_collision() -> void:
	if (_last_collision_count == 0 && get_contact_count() > 0 && !collision_sound.playing):
		collision_sound.play()
	_last_collision_count = get_contact_count()

func grab_it() -> void:
	_dragging = true
	_drag_start = get_global_mouse_position()
	_last_dragged_position = _drag_start

func drag_it() -> void:
	var gmp = get_global_mouse_position()
	
	_last_drag_amount = (_last_dragged_position - gmp).length()
	_last_dragged_position = gmp
	
	if _last_drag_amount > 0 && !stretch_sound.playing:
		stretch_sound.play()
	
	_dragged_vector = gmp - _drag_start
	_dragged_vector.x = clampf(_dragged_vector.x, DRAG_LIM_MIN.x, DRAG_LIM_MAX.x)
	_dragged_vector.y = clampf(_dragged_vector.y, DRAG_LIM_MIN.y, DRAG_LIM_MAX.y)
	global_position = _start + _dragged_vector

func release_it() -> void:
	_dragging = false
	_released = true
	freeze = false
	apply_central_impulse(get_impulse())
	stretch_sound.stop()
	launch_sound.play()

func get_impulse() -> Vector2:
	return _dragged_vector * -1 * IMPULSE_MULT

func die() -> void:
	if _dead:
		return
	_dead = true
	SignalManager.on_animal_died.emit()
	queue_free()

func _on_screen_exited():
	die()

func _on_input_event(viewport, event: InputEvent, shape_idx):
	if _dragging or _released:
		return
	if event.is_action("drag"):
		grab_it()

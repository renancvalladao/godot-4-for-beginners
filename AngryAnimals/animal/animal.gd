extends RigidBody2D

var _dead: bool = false
var _dragging: bool = false
var _released: bool = false
var _start: Vector2 = Vector2.ZERO
var _drag_start: Vector2 = Vector2.ZERO
var _dragged_vector: Vector2 = Vector2.ZERO
var _last_dragged_position: Vector2 = Vector2.ZERO
var _last_drag_amount: float = 0.0
var _fired_time: float = 0.0

func _ready():
	_start = global_position

func _physics_process(delta):
	update_debug_label()

func update_debug_label() -> void:
	var s = "g_pos: %s\n" % Utils.vec2_to_str(global_position)
	s += "dragging: %s released: %s\n" % [_dragging, _released]
	s += "start: %s drag_start: %s\n" % [Utils.vec2_to_str(_start), Utils.vec2_to_str(_drag_start)]
	s += "last_dragged_position: %s last_drag_amount: %.1f\n" % [
		Utils.vec2_to_str(_last_dragged_position),
		_last_drag_amount
	]
	s += "ang: %.1f linear: %s fired_time: %.1f" % [angular_velocity, Utils.vec2_to_str(linear_velocity), _fired_time]
	SignalManager.on_update_debug_label.emit(s)

func grab_it() -> void:
	_dragging = true
	_drag_start = get_global_mouse_position()
	_last_dragged_position = _drag_start

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

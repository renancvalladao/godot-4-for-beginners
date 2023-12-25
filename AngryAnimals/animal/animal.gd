extends RigidBody2D

var _dead: bool = false

func _ready():
	pass

func _physics_process(delta):
	update_debug_label()

func update_debug_label() -> void:
	var s = "g_pos: %s\n" % Utils.vec2_to_str(global_position)
	s += "ang: %.1f linear: %s" % [angular_velocity, Utils.vec2_to_str(linear_velocity)]
	SignalManager.on_update_debug_label.emit(s)

func die() -> void:
	if _dead:
		return
	_dead = true
	SignalManager.on_animal_died.emit()
	queue_free()

func _on_screen_exited():
	die()

func _on_input_event(viewport, event: InputEvent, shape_idx):
	if event.is_action("drag"):
		print(event)

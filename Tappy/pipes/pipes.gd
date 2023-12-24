extends Node2D

const SCROLL_SPEED: float = 50.0

func _ready():
	pass

func _process(delta):
	position.x -= SCROLL_SPEED * delta

func _on_screen_exited():
	queue_free()

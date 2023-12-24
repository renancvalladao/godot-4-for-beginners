extends Node2D

const SCROLL_SPEED: float = 120.0

func _ready():
	pass

func _process(delta):
	position.x -= SCROLL_SPEED * delta

func player_scored() -> void:
	GameManager.increment_score()

func _on_screen_exited():
	queue_free()

func _on_pipe_body_entered(body):
	if body.is_in_group(GameManager.GROUP_PLANE):
		body.die()

func _on_laser_body_entered(body):
	if body.is_in_group(GameManager.GROUP_PLANE):
		player_scored()

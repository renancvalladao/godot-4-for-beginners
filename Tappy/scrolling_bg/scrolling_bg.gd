extends ParallaxBackground

const SPEED: float = 120.0

func _ready():
	GameManager.on_game_over.connect(on_game_over)

func _process(delta):
	scroll_offset.x += SPEED * delta * -1

func on_game_over() -> void:
	set_process(false)

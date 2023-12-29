extends Control

@onready var sound = $Sound

func _ready():
	SignalManager.on_level_selected.connect(on_level_selected)

func _process(delta):
	pass

func on_level_selected(level_num: int) -> void:
	var level_selection = GameManager.get_level_selection(level_num)
	var frame_image = ImageManager.get_random_frame_image()
	
	pass

func _on_exit_button_pressed():
	SoundManager.play_button_click(sound)
	SignalManager.on_game_exit_pressed.emit()

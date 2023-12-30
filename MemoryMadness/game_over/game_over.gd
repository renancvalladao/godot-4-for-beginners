extends Control

@onready var moves_label = $NinePatchRect/MC/VB/HB/MovesLabel

func _ready():
	pass

func _process(delta):
	pass

func _on_exit_button_pressed():
	hide()
	SignalManager.on_game_exit_pressed.emit()

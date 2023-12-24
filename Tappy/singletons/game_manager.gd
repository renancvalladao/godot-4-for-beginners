extends Node

var game_scene: PackedScene = preload("res://game/game.tscn")

func load_game_scene() -> void:
	get_tree().change_scene_to_packed(game_scene)

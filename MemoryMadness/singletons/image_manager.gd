extends Node

var _items_images: Array = []

func _ready():
	load_item_images()

func add_file_to_list(fn: String, path: String) -> void:
	var full_path = path + "/" + fn
	
	var ii_dict = {
		"item_name": fn.rstrip(".png"),
		"item_texture": load(full_path)
	}
	
	_items_images.append(ii_dict)

func load_item_images() -> void:
	var path = "res://assets/glitch"
	var dir = DirAccess.open(path)
	
	if !dir:
		print("ERROR: ", path)
		return
	
	var file_names = dir.get_files()
	
	for fn in file_names:
		if !".import" in fn:
			add_file_to_list(fn, path)

func get_random_item_image() -> Dictionary:
	return _items_images.pick_random()

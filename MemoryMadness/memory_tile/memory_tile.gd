extends TextureButton

@onready var frame_image = $FrameImage
@onready var item_image = $ItemImage

var _item_name: String

func _ready():
	pass

func get_item_name() -> String:
	return _item_name

func setup(ii_dict: Dictionary, fi: CompressedTexture2D) -> void:
	frame_image.texture = fi
	item_image.texture = ii_dict.item_texture
	_item_name = ii_dict.item_name

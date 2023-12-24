extends CharacterBody2D

signal on_plane_died

@onready var animation_player = $AnimationPlayer
@onready var animated_sprite_2d = $AnimatedSprite2D

const GRAVITY: float = 1900.0
const POWER: float = -400.0

func _ready():
	pass

func _physics_process(delta):
	velocity.y += GRAVITY * delta # Actually delta is not needed here
	
	fly()
	
	move_and_slide()
	
	if is_on_floor():
		die()

func fly() -> void:
	if Input.is_action_just_pressed("fly"):
			velocity.y = POWER
			animation_player.play("fly")

func die() -> void:
	animated_sprite_2d.stop()
	on_plane_died.emit()
	set_physics_process(false)
	

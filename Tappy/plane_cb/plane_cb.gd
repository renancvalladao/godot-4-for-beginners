extends CharacterBody2D

const GRAVITY: float = 1900.0
const POWER: float = -400.0

func _ready():
	pass

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	
	if Input.is_action_just_pressed("fly"):
		velocity.y = POWER
	
	move_and_slide()

extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Jump with W or Space
	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_SPACE):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY

	# A = left, D = right
	var direction := 0.0

	if Input.is_key_pressed(KEY_A):
		direction -= 1.0

	if Input.is_key_pressed(KEY_D):
		direction += 1.0

	# Movement
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Die if player falls off the map
	if global_position.y > 100:
		get_tree().reload_current_scene()

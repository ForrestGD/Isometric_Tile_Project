extends CharacterBody2D

const SPEED = 60.0

func cartesian_to_isometric(cart: Vector2) -> Vector2:
	return Vector2(cart.x - cart.y, (cart.x + cart.y) / 2)

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		direction.y /= 2
		#direction = cartesian_to_isometric(direction)
		direction = direction.normalized()
		self.velocity = direction * SPEED
	else:
		self.velocity = Vector2.ZERO
	move_and_slide()

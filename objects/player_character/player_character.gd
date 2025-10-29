extends CharacterBody2D

const SPEED_MULTIPLIER: int = 100

signal toggle_inventory()

@export var inventory: InventoryData
@export var speed: float = 60.0

func cartesian_to_isometric(cart: Vector2) -> Vector2:
	return Vector2(cart.x - cart.y, (cart.x + cart.y) / 2)

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		direction = cartesian_to_isometric(direction)
		#direction.y /= 2
		direction = direction.normalized()
		
		self.velocity = direction * speed * SPEED_MULTIPLIER * delta
	else:
		self.velocity = Vector2.ZERO
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_inventory"):
		toggle_inventory.emit()

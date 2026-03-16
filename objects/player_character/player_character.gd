extends CharacterBody2D

const SPEED_MULTIPLIER: int = 100

signal toggle_inventory()

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D
var face_direction := "se"
var animation := "idle_se"

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
		
		#select animation to play
		animation = "walk_"
		if direction.y >= 0:
			animation += "s"
		else:
			animation += "n"
		if direction.x >= 0:
			animation += "e"
		else:
			animation += "w"
		self.velocity = direction * speed * SPEED_MULTIPLIER * delta
	else:
		#adjust when north facing idle animations are put in
		animation = "idle_se"

		self.velocity = Vector2.ZERO
	animatedSprite.play(animation)
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_inventory"):
		toggle_inventory.emit()

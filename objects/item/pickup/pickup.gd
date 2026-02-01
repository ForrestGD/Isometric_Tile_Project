extends RigidBody2D

@export var socket_data: SocketData
@onready var sprite: Sprite2D = $Sprite2D
var t_move: float = 0.0
var amplitude: float = 2.0
var frequency: float = 1.0
var y_init: float

func _ready() -> void:
	sprite.texture = socket_data.item.icon
	y_init = position.y

func _physics_process(delta: float) -> void:
	t_move += delta * frequency
	position.y = amplitude * sin(t_move) + y_init

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.inventory.pickup_socket_data(socket_data):
		queue_free()

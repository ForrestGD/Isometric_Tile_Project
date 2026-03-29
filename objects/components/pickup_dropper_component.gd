extends Node
class_name PickupDropper

const PICKUP = preload("res://objects/item/pickup/pickup.tscn")

func drop_item(item: ItemData, quantity: int, position: Vector2) -> void:
	var pickup = PICKUP.instantiate()
	pickup.socket_data.item = item
	if quantity > 1:
		pickup.socket_data.quantity = quantity
	else:
		pickup.socket_data.quantity = 1
	pickup.position = position
	get_parent().get_parent().add_child(pickup)

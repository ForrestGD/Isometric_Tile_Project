class_name SocketData
extends Resource

const MAX_STACK_SIZE: int = 99

@export var item: ItemData
@export_range(1, MAX_STACK_SIZE) var quantity: int = 1: set = set_quantity

func can_add_single_other(other_socket_data: SocketData) -> bool:
    return item == other_socket_data.item \
        and item.stackable \
        and quantity < MAX_STACK_SIZE 

func can_merge_with_other(other_socket_data: SocketData) -> bool:
    return item == other_socket_data.item \
        and item.stackable \
        and quantity + other_socket_data.quantity <= MAX_STACK_SIZE 

func merge_with_other(other_socket_data: SocketData) -> void:
    quantity += other_socket_data.quantity

func create_single_socket_data() -> SocketData:
    var ret_socket_data: SocketData = duplicate()
    ret_socket_data.quantity = 1
    quantity -= 1
    return ret_socket_data

func set_quantity(value: int) -> void:
    quantity = value
    if value > 1 and not item.stackable:
        quantity = 1
        push_error("%s is not stackable, quantity set to 1" % item.name)
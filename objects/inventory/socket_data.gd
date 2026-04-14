extends Resource
class_name SocketData

const MAX_STACK_SIZE: int = 99

@export var item: ItemData
@export_range(1, MAX_STACK_SIZE) var quantity: int = 1: set = set_quantity

func can_add_single_other(other_socket_data: SocketData) -> bool:
    return item == other_socket_data.item \
        and 1 + other_socket_data.quantity <= item.maximum_quantity 

func can_merge_with_other(other_socket_data: SocketData) -> bool:
    return item.name == other_socket_data.item.name \
        and quantity + other_socket_data.quantity <= item.maximum_quantity 

func merge_with_other(other_socket_data: SocketData) -> void:
    print("{0} items in this stack, {1} items in other stack, total of {2} items}".format([quantity, other_socket_data.quantity, quantity + other_socket_data.quantity]))
    quantity += other_socket_data.quantity

func create_single_socket_data() -> SocketData:
    var ret_socket_data: SocketData = duplicate()
    ret_socket_data.quantity = 1
    quantity -= 1
    return ret_socket_data

func set_quantity(value: int) -> void:
    quantity = value
    if value > item.maximum_quantity:
        quantity = item.maximum_quantity
        push_error("%s is not stackable, quantity set to item's maximum quantity" % item.name)
class_name InventoryData
extends Resource

signal inventory_interact(inventory_data: InventoryData, index: int, button: int)
signal inventory_updated(inventory_data: InventoryData)

@export var socket_data: Array[SocketData]

func on_socket_clicked(index: int, button: int) -> void:
	inventory_interact.emit(self, index, button)

func select_socket_data(index: int) -> SocketData:
	var ret_data: SocketData = socket_data[index]
	if ret_data:
		socket_data[index] = null
		inventory_updated.emit(self)
		return ret_data
	else:
		return null

func deselect_socket_data(data: SocketData, index: int) -> SocketData:
	var temp_data: SocketData = socket_data[index]
	var ret_data: SocketData
	if temp_data and temp_data.can_merge_with_other(data):
		temp_data.merge_with_other(data)
	else:
		socket_data[index] = data
		ret_data = temp_data
	inventory_updated.emit(self)
	return ret_data

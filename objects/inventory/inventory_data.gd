extends Resource
class_name InventoryData

signal inventory_interact(inventory_data: InventoryData, index: int, button: int)
signal inventory_updated(inventory_data: InventoryData)

@export var socket_data: Array[SocketData]

func on_socket_clicked(index: int, button: int) -> void:
	inventory_interact.emit(self, index, button)

func grab_socket_data(index: int) -> SocketData:
	var ret_data: SocketData = socket_data[index]
	if ret_data:
		socket_data[index] = null
		inventory_updated.emit(self)
		return ret_data
	else:
		return null

func drop_socket_data(data: SocketData, index: int) -> SocketData:
	var data_at_index: SocketData = socket_data[index]
	var ret_data: SocketData
	if data_at_index and data_at_index.can_merge_with_other(data):
		socket_data[index].merge_with_other(data)
	else:
		socket_data[index] = data
		ret_data = data_at_index
	inventory_updated.emit(self)
	return ret_data

func drop_single_socket_data(data: SocketData, index: int) -> SocketData:
	if not socket_data[index]:
		socket_data[index] = data.create_single_socket_data()
	elif socket_data[index].can_add_single_other(data):
		socket_data[index].merge_with_other(data.create_single_socket_data())
	inventory_updated.emit(self)
	if data.quantity > 0:
		return data
	else:
		return null

func pickup_socket_data(data: SocketData) -> bool:
	for index in socket_data.size():
		if socket_data[index] and socket_data[index].can_merge_with_other(data):
			socket_data[index].merge_with_other(data)
			inventory_updated.emit(self)
			# print("there are now {0} items in the stack".format([socket_data[index].quantity]))
			return true
	for index in socket_data.size():
		if not socket_data[index]:
			socket_data[index] = data.duplicate()
			inventory_updated.emit(self)
			return true
	return false
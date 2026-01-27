extends PanelContainer

const SOCKET = preload("res://objects/inventory/socket.tscn")

@onready var item_grid: GridContainer = $MarginContainer/ItemGrid

func set_inventory_data(data: InventoryData) -> void:
	data.inventory_updated.connect(populate_item_grid)
	populate_item_grid(data)

func clear_inventory_data(data: InventoryData) -> void:
	data.inventory_updated.disconnect(populate_item_grid)

func populate_item_grid(data: InventoryData) -> void:
	for child in item_grid.get_children():
		child.queue_free()

	for s in data.socket_data:
		var socket = SOCKET.instantiate()
		item_grid.add_child(socket)

		socket.socket_clicked.connect(data.on_socket_clicked)

		if s:
			socket.set_socket_data(s) 

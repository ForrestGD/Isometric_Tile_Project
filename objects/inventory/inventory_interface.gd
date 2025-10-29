class_name InventoryInterface
extends Control

var selected_socket_data: SocketData

@onready var player_inventory: PanelContainer = $PlayerInventory
@onready var selected_socket: PanelContainer = $SelectedSocket

func set_player_inventory_data(inventory_data: InventoryData) -> void:
	inventory_data.inventory_interact.connect(on_inventory_interact)
	player_inventory.set_inventory_data(inventory_data)

func _physics_process(delta: float) -> void:
	if selected_socket.visible:
		selected_socket.global_position = get_global_mouse_position() + Vector2(4, 4)

func on_inventory_interact(inventory_data: InventoryData, index: int, button: int) -> void:
	match[selected_socket_data, button]:
		[null, MOUSE_BUTTON_LEFT]:
			selected_socket_data = inventory_data.select_socket_data(index)
		[_, MOUSE_BUTTON_LEFT]:
			selected_socket_data = inventory_data.deselect_socket_data(selected_socket_data, index)
	update_selected_socket()
		
func update_selected_socket() -> void:
	if selected_socket_data:
		selected_socket.set_socket_data(selected_socket_data)
		selected_socket.show()
	else:
		selected_socket.hide() 

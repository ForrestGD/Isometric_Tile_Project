class_name InventoryInterface
extends Control

var grabbed_socket_data: SocketData
var external_inventory_owner: Node = null

@onready var player_inventory: PanelContainer = $PlayerInventory
@onready var external_inventory: PanelContainer = $ExternalInventory
@onready var grabbed_socket: PanelContainer = $GrabbedSocket

func set_player_inventory_data(inventory_data: InventoryData) -> void:
	inventory_data.inventory_interact.connect(on_inventory_interact)
	player_inventory.set_inventory_data(inventory_data)

func set_external_inventory(_external_inventory_owner) -> void:
	external_inventory_owner = _external_inventory_owner
	
	var external_inventory_data = external_inventory_owner.inventory
	external_inventory_data.inventory_interact.connect(on_inventory_interact)
	external_inventory.set_inventory_data(external_inventory_data)
	
	external_inventory.show()

func clear_external_inventory() -> void:
	if external_inventory_owner:
		var external_inventory_data = external_inventory_owner.inventory
		external_inventory_data.inventory_interact.disconnect(on_inventory_interact)
		external_inventory.clear_inventory_data(external_inventory_data)
		
		external_inventory.hide()
		external_inventory_owner = null

func _physics_process(delta: float) -> void:
	if grabbed_socket.visible:
		grabbed_socket.global_position = get_global_mouse_position() + Vector2(4, 4)

func on_inventory_interact(inventory_data: InventoryData, index: int, button: int) -> void:
	match[grabbed_socket_data, button]:
		[null, MOUSE_BUTTON_LEFT]:
			grabbed_socket_data = inventory_data.grab_socket_data(index)
		[_, MOUSE_BUTTON_LEFT]:
			grabbed_socket_data = inventory_data.drop_socket_data(grabbed_socket_data, index)
		[null, MOUSE_BUTTON_RIGHT]:
			pass
		[_, MOUSE_BUTTON_RIGHT]:
			grabbed_socket_data = inventory_data.drop_single_socket_data(grabbed_socket_data, index)
	update_selected_socket()
		
func update_selected_socket() -> void:
	if grabbed_socket_data:
		grabbed_socket.set_socket_data(grabbed_socket_data)
		grabbed_socket.show()
	else:
		grabbed_socket.hide() 

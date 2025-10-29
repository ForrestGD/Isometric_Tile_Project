extends Node2D

@onready var player_character: CharacterBody2D = $PlayerCharacter
@onready var inventory_interface: Control = $UI/InventoryInterface

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_character.toggle_inventory.connect(toggle_inventory_interface)
	inventory_interface.set_player_inventory_data(player_character.inventory)

func toggle_inventory_interface() -> void:
	inventory_interface.visible = not inventory_interface.visible
	if inventory_interface.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

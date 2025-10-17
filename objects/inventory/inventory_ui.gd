extends Control

@onready var inventory: Inventory = preload("res://objects/inventory/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open: bool = false

func update_slots():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])


func _ready():
	update_slots()
	close()

func close():
	visible = false
	is_open = false

func open():
	visible = true
	is_open = true

func _process(delta):
	if Input.is_action_just_pressed("toggle_inventory"):
		if is_open:
			update_slots()
			close()
		else:
			update_slots()
			open()

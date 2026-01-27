extends StaticBody2D

signal toggle_inventory(external_inventory_owner: Node)

@export var inventory: InventoryData
@onready var interactable: Interactable = $Interactable

func _ready() -> void:
	interactable.interacted.connect(_on_interact)

func _on_interact(root: Node, interactor: Interactor) -> void:
	toggle_inventory.emit(self)

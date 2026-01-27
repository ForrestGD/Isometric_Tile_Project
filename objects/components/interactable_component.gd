class_name Interactable
extends Area2D

@onready var interactable_area: CollisionPolygon2D = $InteractableArea
var hovered: bool = false

signal interacted(root: Node, interactor: Interactor)

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_exited() -> void:
	hovered = false

func _on_mouse_entered() -> void:
	hovered = true
	
func interact(interactor: Interactor) -> void:
	interacted.emit(self.get_parent(), interactor)
	print("interacted with {0}".format([self.get_parent().name]))

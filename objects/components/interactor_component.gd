class_name Interactor
extends Area2D

var interactables_list: Array[Interactable] = []
@onready var label_container: BoxContainer = $BoxContainer

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exit)

func _sort_by_closest_hovered(a: Interactable, b: Interactable) -> bool:
	if a.hovered and not b.hovered:
		return true
	elif b.hovered and not a.hovered:
		return false
	elif a.global_transform.origin.distance_to(self.global_transform.origin) \
	< b.global_transform.origin.distance_to(self.global_transform.origin):
		return true
	else:
		return false

func _physics_process(delta: float) -> void:
	interactables_list.sort_custom(_sort_by_closest_hovered)
	if interactables_list.size() > 0:
		label_container.visible = true
		label_container.global_position = interactables_list[0].global_position
	else:
		label_container.visible = false

func _input(event: InputEvent) -> void:
	if not event is InputEventKey or not event.is_action_pressed("interact"): return
	if interactables_list.size() > 0:
		interactables_list[0].interact(self as Interactor)

func _on_area_entered(area: Area2D) -> void:
	if area is Interactable:
		print("entered {0} interaction area".format([area.name]))
		interactables_list.append(area as Interactable)
		print("{0} interactable objects".format([interactables_list.size()]))

func _on_area_exit(area: Area2D) -> void:
	if area is Interactable:
		print("exited {0} interaction area".format([area.name]))
		var index = interactables_list.find(area)
		if index > -1:
			interactables_list.remove_at(index)
			print("{0} remaining interactable objects".format([interactables_list.size()]))

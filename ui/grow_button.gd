extends AgingComponent
@export var aging_increment = 1.0

func _ready():
	connect("pressed", _on_pressed)

# func _process(delta):
#     pass

func _on_pressed():
	for aging_component in get_tree().get_nodes_in_group(AgingComponent.group_name):
		if(aging_component is AgingComponent):
			aging_component.current_age += aging_increment
		else:
			push_error(aging_component.name + " node is not AgingComponent")

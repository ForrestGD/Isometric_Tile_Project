class_name AgingComponent
extends Node

##track age of object, and when age reaches threshold, can replaces scene with next scene
signal age_changed(new_age : float, last_age : float)
signal age_threshold_reached(maximum_age : int)


var current_state = 0
var sprite : Sprite2D

@export var current_age = 0.0 : 
	set(value):
		if(current_age != value):
			var last_age = current_age
			current_age = value
			emit_signal("age_changed", current_age, last_age)

			if(current_age >= lifespan_array[current_state] && current_state < lifespan_array.size() - 1):
				current_age = 0.0
				current_state += 1
				if(sprite != null && !_threshold_reached):
					sprite.region_rect.position.x = current_state * sprite.region_rect.size.x
				if(current_state == lifespan_array.size() - 1):
					emit_signal("age_threshold_reached", current_state)
					_threshold_reached = true
				
@export var lifespan_array : Array[float] = [1.0]

#internal members
var _threshold_reached = false

static var group_name = "AgingComponent"
# Called when the node enters the scene tree for the first time.
func _ready():
	if(sprite == null):
		sprite = get_parent().get_node("Sprite2D")
	add_to_group(group_name)

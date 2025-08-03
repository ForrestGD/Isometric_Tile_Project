class_name AgingComponent
extends Node

##track age of object, and when age reaches threshold, can replaces scene with next scene

signal age_changed(new_age : float, last_age : float)
signal age_threshold_reached(new_scene : Node2D)

##target is the root object of this scene, if no target is set, uses the parent of this component
@export var target : Node2D
@export var current_age = 0.0 :
	set(value):
		if(current_age != value):
			var last_age = current_age
			current_age = value
			emit_signal("age_changed", current_age, last_age)

			if(current_age >= age_threshold):
				var new_scene : Node2D
				if(next_scene != null && !_threshold_reached):
					new_scene = _create_next_scene()
					target.queue_free()
					
				emit_signal("age_threshold_reached", new_scene)
				_threshold_reached = true
@export var age_threshold = 1.0
@export_file var next_scene

static var group_name = "AgingComponent"

#internal members
var _threshold_reached = false

func _ready():
	if(target == null):
		target = get_parent()
	add_to_group(group_name)

func _create_next_scene():
	var instance : Node2D = load(next_scene).instantiate()
	target.get_parent().add_child(instance)
	instance.global_transform = target.global_transform
	return instance

extends Control

var is_open: bool = false

func _ready():
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
			close()
		else:
			open()
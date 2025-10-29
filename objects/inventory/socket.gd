extends PanelContainer

signal socket_clicked(index: int, button: int)

@onready var texture_rect: TextureRect = $MarginContainer/TextureRect
@onready var quantity_label: Label = $QuantityLabel

func set_socket_data(data: SocketData) -> void:
	var item_data = data.item
	texture_rect.texture = item_data.icon
	tooltip_text = "%s\n%s" % [item_data.name, item_data.description]

	if data.quantity > 1 && item_data.stackable:
		quantity_label.text = "x%s" % data.quantity
		quantity_label.show()
	else:
		quantity_label.hide()


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
	and (event.button_index == MOUSE_BUTTON_LEFT or event.button_index == MOUSE_BUTTON_RIGHT) \
	and event.is_pressed():
		socket_clicked.emit(get_index(), event.button_index)

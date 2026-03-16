extends Node
class_name Plant

@export var plant_data: PlantData = null
@onready var interactable: Interactable = $Interactable
@onready var sprite: Sprite2D = $Sprite2D

static var group_name: String = "plant_group"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if plant_data == null:
		queue_free()
	else:
		sprite.texture = plant_data.sprite
		update_plant_data()
		add_to_group(group_name)

func update_plant_data() -> void:
	interactable.enabled = plant_data.stage_data[plant_data.current_stage_index].interactable
	sprite.region_rect = Rect2( \
		plant_data.sprite_size.x * plant_data.current_stage_index \
		, 0 \
		, plant_data.sprite_size.x \
		, plant_data.sprite_size.y \
	)

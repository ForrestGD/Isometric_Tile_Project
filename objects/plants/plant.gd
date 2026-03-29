extends Node2D
class_name Plant

@export var plant_data: PlantData = null
@onready var interactable: Interactable = $Interactable
@onready var sprite: Sprite2D = $Sprite2D
@onready var pickup_dropper: PickupDropper = $PickupDropper

var current_stage_index: int = 0
var current_age: float = 0.0
static var group_name: String = "plant_group"

func update_plant() -> void:
	interactable.enabled = plant_data.stage_list[current_stage_index].interactable
	sprite.region_rect = Rect2( \
		plant_data.sprite_size.x * current_stage_index \
		, 0 \
		, plant_data.sprite_size.x \
		, plant_data.sprite_size.y \
	)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if plant_data == null:
		queue_free()
	else:
		sprite.texture = plant_data.sprite
		sprite.offset.y -= plant_data.sprite_size.y / 2
		update_plant()
		add_to_group(group_name)
		interactable.interacted.connect(_plant_interact)

func _physics_process(delta: float) -> void:
	current_age += delta
	var transitions_list: Array[TransitionData] = plant_data.get_transitions_from_stage(current_stage_index)
	if transitions_list.size() >= 0:
		for transition in transitions_list:
			if current_age >= transition.time:
				current_age -= transition.time
				current_stage_index = transition.to_stage_index
				update_plant()
				break
	
func _plant_interact(_root: Node, _interactor: Interactor) -> void:
	var current_stage: StageData = plant_data.stage_list[current_stage_index]
	if interactable.enabled and current_stage.item:
		pickup_dropper.drop_item(current_stage.item, 1, self.position)

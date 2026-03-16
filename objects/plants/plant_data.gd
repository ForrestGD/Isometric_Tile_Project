extends Resource
class_name PlantData

@export var sprite: AtlasTexture
@export var sprite_size: Vector2i
@export var stage_data: Array[StageData]

var current_stage_index: int = 0
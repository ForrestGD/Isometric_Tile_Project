extends Resource
class_name PlantData

@export var sprite: AtlasTexture
@export var sprite_size: Vector2i

#stage graph information
@export var stage_list: Array[StageData]
@export var edge_list: Array[TransitionData]

func get_transitions_from_stage(stage_index: int) -> Array[TransitionData]:
    var ret: Array[TransitionData] = []
    for edge in edge_list:
        if edge.from_stage_index == stage_index:
            ret.append(edge)
    return ret
extends Resource
class_name TransitionData

enum CONDITION{
    NONE,
    ON_HARVEST,
    DAY_ONLY,
    NIGHT_ONLY
}

@export var from_stage_index: int = 0
@export var to_stage_index: int = -1
@export var time: float = 1.0
@export var precondition: CONDITION = CONDITION.NONE
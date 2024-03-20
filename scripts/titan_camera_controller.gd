extends Camera2D

class_name TitanCamera;

@export var target: TitanController
@export var lerp_speed: float = 2;
@export var frozen: bool = false;

func _process(delta: float) -> void:
	if(not frozen):
		position = lerp(position, target.position, delta * lerp_speed);

extends Camera2D

class_name TitanCamera;

@export var target: TitanController
@export var lerp_speed: float = 2;
@export var frozen: bool = false;

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout;
	
	if(!is_multiplayer_authority()):
		enabled = false;

func shake(force: float, bias: Vector2 = Vector2.ONE) -> void:
	randomize();
	position += Vector2(randf_range(-1, 1), randf_range(-1, 1)) * force * bias;

func _process(delta: float) -> void:
	if(not frozen):
		position = lerp(position, target.position, delta * lerp_speed);

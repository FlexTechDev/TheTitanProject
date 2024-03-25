@tool

extends CelestialBody

class_name Planet;

@onready var orbiting_body: CelestialBody = get_parent();

@export var angle: float = 0;
@export var radius: float = 2;
@export var maps: Array[MapData];

func _process(delta: float) -> void:
	if(orbiting_body != null):
		global_position = orbiting_body.global_position + (Vector2(cos(deg_to_rad(-angle)), sin(deg_to_rad(-angle)))*radius);
		$LightOccluder2D.global_rotation = deg_to_rad(-angle);

extends Camera2D

class_name MapCamera;

@export var target: CelestialBody;

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("settings")):
		target = null;

func _process(delta: float) -> void:
	if(target != null):
		if(target is Planet):
			return;
		
		global_position = target.global_position;
		
		zoom = lerp(zoom, Vector2(150,150), delta * 10);
	else:
		global_position = Vector2.ZERO;
		
		zoom = lerp(zoom, Vector2(1,1), delta * 10);

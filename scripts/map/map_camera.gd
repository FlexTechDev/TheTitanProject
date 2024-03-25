extends Camera2D

class_name MapCamera;

@onready var selection_ui: Sprite2D = $SelectionUI;

@export var target: CelestialBody;

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("settings")):
		target = null;

func _process(delta: float) -> void:
	if(target != null):
		selection_ui.global_position = target.global_position;
		selection_ui.rotation += 0.1 * delta;
		selection_ui.global_scale = target.global_scale * 1.3;
		
		if(target is Planet):
			global_position = target.get_parent().global_position;
		else:
			global_position = target.global_position
		
		zoom = lerp(zoom, Vector2(150,150), delta);
	else:
		selection_ui.global_scale = Vector2.ZERO;
		
		zoom = lerp(zoom, Vector2(1,1), delta * 5);

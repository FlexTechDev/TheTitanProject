@tool

extends Area2D

class_name CelestialBody;

var selectable: bool = false;

@export var light: PointLight2D;
@export var camera: MapCamera;
@export var color: Color = Color.WHITE;

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		var sub_viewport: SubViewport = EditorInterface.get_editor_viewport_2d();
		global_scale = Vector2.ONE/sub_viewport.get_screen_transform().get_scale();
		if(light != null):
			light.energy = clamp(sub_viewport.get_screen_transform().get_scale().length()/150, 0, 0.2);
	else:
		global_scale = Vector2.ONE/get_viewport().get_camera_2d().zoom;
		if(light != null):
			light.energy = clamp(get_viewport().get_camera_2d().zoom.length()/150, 0, 0.2);

func _input(event: InputEvent) -> void:
	if(event is InputEventMouseButton):
		if(event.is_action_pressed("left_click") and selectable):
			camera.target = self;

func _on_mouse_entered():
	selectable = true;

func _on_mouse_exited():
	selectable = false;

extends Control

class_name MapListPanel;

var current_target: CelestialBody;

@onready var map_panel_ui: PackedScene = preload("res://scenes/ui/star_map_ui/map_panel.tscn");

@export var button_distance: float = 100;
@export var map_camera: MapCamera;

func _physics_process(delta: float) -> void:
	if(map_camera.target != null):
		position = map_camera.target.get_global_transform_with_canvas().origin;
	
	if(map_camera.target is Planet):
		for button: Button in get_children():
			var angle: float = (2*PI) - (((2*PI)/get_child_count()) * (button.get_index() + 1));
			var x: float = cos(angle);
			var y: float = sin(angle);
			button.position = lerp(button.position, (Vector2(x, y) * button_distance) - button.pivot_offset, delta * 2);
			button.scale = lerp(button.scale, Vector2.ONE, delta * 3);
	
	if(current_target != map_camera.target):
		for child: Button in get_children():
			child.queue_free();
		
		current_target = map_camera.target;
		
		if(map_camera.target is Planet):
			change_target();

func _on_map_selected() -> void:
	for button: Button in get_children():
		if(button.is_hovered()):
			get_tree().change_scene_to_packed(map_camera.target.maps[button.get_index()].map_scene);

func change_target() -> void:
	for map_data: MapData in map_camera.target.maps:
		var map_panel_ui_instance: Button = map_panel_ui.instantiate();
		map_panel_ui_instance.text = map_data.map_name;
		
		map_panel_ui_instance.pressed.connect(_on_map_selected);
		
		add_child(map_panel_ui_instance);
		
		map_panel_ui_instance.position = Vector2.ZERO - map_panel_ui_instance.pivot_offset;
		map_panel_ui_instance.scale = Vector2.ZERO;

extends VBoxContainer

class_name MapListPanel;

var current_target: CelestialBody;

@onready var map_panel_ui: PackedScene = preload("res://scenes/ui/star_map_ui/map_panel.tscn");

@export var map_camera: MapCamera;

func _physics_process(delta: float) -> void:
	if(current_target != map_camera.target and map_camera.target is Planet):
		change_target();
	elif(current_target != map_camera.target):
		for child: Button in get_children():
			child.queue_free();

func _on_map_selected() -> void:
	for button: Button in get_children():
		if(button.is_hovered()):
			get_tree().change_scene_to_packed(map_camera.target.maps[button.get_index()].map_scene);

func change_target() -> void:
	for child: Button in get_children():
		child.queue_free();
	
	for map_data: MapData in map_camera.target.maps:
		var map_panel_ui_instance: Button = map_panel_ui.instantiate();
		map_panel_ui_instance.text = map_data.map_name;
		
		map_panel_ui_instance.pressed.connect(_on_map_selected);
		
		add_child(map_panel_ui_instance);
	
	current_target = map_camera.target;

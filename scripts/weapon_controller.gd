extends Area2D

class_name WeaponController;

var parent_titan_camera: TitanCamera;

@export var weapon_function: WeaponFunction;
@export var chamber_location: Node2D;
@export var barrel_location: Node2D;
@export var right_hand_position: Node2D;
@export var left_hand_position: Node2D;

func pick_up(hands: Node2D) -> void:
	position = hands.position;
	
	parent_titan_camera = hands.titan_camera;
	
	get_parent().remove_child(self);
	hands.add_child(self);

func drop() -> void:
	var last_position = global_position;
	var scene = get_parent().get_tree().current_scene;
	
	get_parent().remove_child(self);
	scene.add_child(self);
	
	parent_titan_camera = null;
	
	global_position = last_position;
	rotation = 0;

func start_shoot() -> void:
	weapon_function._start_shoot(self);

func stop_shoot() -> void:
	weapon_function._stop_shoot(self);

func reload() -> void:
	weapon_function._reload(self);

func _process(delta: float) -> void:
	weapon_function._manual_process(delta);

extends Node2D;

class_name MapShip;

var angle: float = 0;
var radius: float = 1;
var last_position: Vector2;

@export var camera: MapCamera;

func _process(delta: float) -> void:
	global_scale = Vector2.ONE/get_viewport().get_camera_2d().zoom;
	
	if(camera.target != null):
		global_position = lerp(global_position, camera.target.global_position, delta * 5);
	
	if(last_position.distance_to(global_position) > 0.001):
		global_rotation = (global_position - last_position).angle();
	
	last_position = global_position;

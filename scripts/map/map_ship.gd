extends Node2D;

class_name MapShip;

var angle: float = 0;
var radius: float = 1;
var last_position: Vector2;

@export var camera: MapCamera;

func _process(delta: float) -> void:
	global_scale = Vector2.ONE/get_viewport().get_camera_2d().zoom;
	
	if(camera.target != null and camera.target is Planet):
		angle = lerp(angle, camera.target.angle, delta * 3);
		radius = lerp(radius, camera.target.radius, delta * 5);
		
		global_position = camera.target.get_parent().global_position + (Vector2(cos(deg_to_rad(-angle)),sin(deg_to_rad(-angle))) * radius);
	elif(camera.target == null):
		return;
	else:
		angle = lerp(angle, camera.target.get_child(3).angle, delta * 3);
		radius = lerp(radius, camera.target.get_child(3).radius, delta * 5);
		
		global_position = camera.target.global_position + (Vector2(cos(deg_to_rad(-angle)),sin(deg_to_rad(-angle))) * radius);
	
	if(last_position.distance_to(global_position) > 0.001):
		global_rotation = (global_position - last_position).angle();
	
	last_position = global_position;

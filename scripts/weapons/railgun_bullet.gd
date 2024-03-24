extends Node2D

class_name RailgunBullet;

var light_1: PointLight2D;
var light_2: PointLight2D;

@onready var line: Line2D = $Line2D;

func place(point_a: Vector2, point_b: Vector2, starting_width: float) -> void:
	light_1 = PointLight2D.new();
	light_1.texture = load("res://assets/ui/light.png");
	light_1.color = line.default_color;
	light_1.shadow_enabled = true;
	
	line.add_point(point_a, 0);
	
	line.add_child(light_1);
	light_1.global_position = point_a;
	
	light_2 = PointLight2D.new();
	light_2.texture = load("res://assets/ui/light.png");
	light_2.color = line.default_color;
	light_2.shadow_enabled = true;
	
	line.add_point(point_b, 1);
	
	line.add_child(light_2);
	light_2.global_position = point_b;
	
	line.width = starting_width;
	
	await get_tree().create_timer(0.5).timeout;
	queue_free();

func _process(delta: float) -> void:
	line.width = lerp(line.width, 0.0, delta * 4);
	light_1.energy = lerp(light_1.energy, 0.0, delta * 4);
	light_2.energy = lerp(light_2.energy, 0.0, delta * 4);

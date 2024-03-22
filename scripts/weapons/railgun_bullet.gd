extends Node2D

class_name RailgunBullet;

@onready var line: Line2D = $Line2D;

func place(point_a: Vector2, point_b: Vector2, starting_width: float) -> void:
	line.add_point(point_a, 0);
	line.add_point(point_b, 1);
	line.width = starting_width;
	
	await get_tree().create_timer(0.5).timeout;
	queue_free();

func _process(delta: float) -> void:
	line.width = lerp(line.width, 0.0, delta * 4);

extends Node2D

class_name RailgunBullet;

func place(point_a: Vector2, point_b: Vector2, starting_width: float) -> void:
	$Line2D.add_point(point_a, 0);
	$Line2D.add_point(point_b, 1);
	$Line2D.width = starting_width;
	
	await get_tree().create_timer(0.5).timeout;
	queue_free();

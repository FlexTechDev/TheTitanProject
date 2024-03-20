extends Area2D

class_name Bullet;

var velocity: Vector2 = Vector2.ZERO;

func _process(delta: float) -> void:
	global_position += velocity * delta;

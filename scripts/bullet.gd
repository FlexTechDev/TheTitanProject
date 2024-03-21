extends Area2D

class_name Bullet;

var velocity: Vector2 = Vector2.ZERO;

func _ready() -> void:
	await get_tree().create_timer(5).timeout;
	queue_free();

func _process(delta: float) -> void:
	global_position += velocity * delta;

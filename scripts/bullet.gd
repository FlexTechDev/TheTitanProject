extends Area2D

class_name Bullet;

var velocity: Vector2 = Vector2.ZERO;

@export var is_slowed_over_time: bool = false;

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout;
	queue_free();

func _process(delta: float) -> void:
	global_position += velocity * delta;
	
	if(is_slowed_over_time):
		scale = lerp(scale, Vector2.ZERO, delta * 20);
		velocity *= 80 * delta;


func _on_body_entered(body: Node2D) -> void:
	if(body is DummyController):
		var health_component: TitanHealthComponent = body.get_node("TitanHealthComponent");
		health_component.take_damage(5);
	
	queue_free();

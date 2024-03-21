extends StaticBody2D

class_name DummyController;

func _on_damage_taken(damage: float):
	$AnimatedSprite2D.play("hit");

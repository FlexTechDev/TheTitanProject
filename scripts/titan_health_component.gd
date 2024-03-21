extends Node

class_name TitanHealthComponent;

signal damage_taken;

@export var health: float = 100;

func take_damage(damage: float) -> void:
	emit_signal("damage_taken", damage);
	health -= damage;

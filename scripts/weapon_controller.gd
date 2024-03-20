extends StaticBody2D

class_name WeaponController;

@export var weapon_function: WeaponFunction;
@export var chamber_location: Node2D;
@export var barrel_location: Node2D;

func shoot():
	weapon_function._shoot(self);

func reload():
	weapon_function._reload(self);

extends WeaponFunction

class_name AA12WeaponFunction;

@export var bullet: PackedScene;

func _shoot(weapon_controller: WeaponController) -> void:
	super._shoot(weapon_controller);
	
	var bullet_instance: Bullet = bullet.instantiate();

func _reload(weapon_controller: WeaponController) -> void:
	super._reload(weapon_controller);

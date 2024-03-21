extends WeaponFunction

class_name AA12WeaponFunction;

var mag_ammo: int = 24;
var current_ammo: int = mag_ammo;
var bullet_speed: float = 1000;
var shooting: bool = false;
var fire_rate: float = 100;

var weapon_controller: WeaponController;

@export var bullet: PackedScene;

func _start_shoot(weapon_controller: WeaponController) -> void:
	super._start_shoot(weapon_controller);
	
	self.weapon_controller = weapon_controller;
	
	shooting = true;
	
	fire();

func _stop_shoot(weapon_controller: WeaponController) -> void:
	super._stop_shoot(weapon_controller);
	
	self.weapon_controller = weapon_controller;
	
	shooting = false;

func _reload(weapon_controller: WeaponController) -> void:
	super._reload(weapon_controller);
	
	self.weapon_controller = weapon_controller;
	
	current_ammo = mag_ammo;

func fire() -> void:
	if(shooting):
		weapon_controller.parent_titan_camera.shake(1);
		
		var bullet_instance: Bullet = bullet.instantiate();
		weapon_controller.get_tree().current_scene.add_child(bullet_instance);
		
		bullet_instance.global_position = weapon_controller.barrel_location.global_position;
		bullet_instance.global_rotation = weapon_controller.barrel_location.global_rotation;
		
		bullet_instance.velocity = Vector2(bullet_speed, 0).rotated(bullet_instance.global_rotation);
		
		current_ammo -= 1;
		
		await weapon_controller.get_tree().create_timer(5/fire_rate).timeout;
		
		fire();

func _manual_process(delta: float) -> void:
	super._manual_process(delta);

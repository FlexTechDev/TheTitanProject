extends WeaponFunction

class_name BB32WeaponFunction;

var mag_ammo: int = 24;
var current_ammo: int = mag_ammo;
var bullet_speed: float = 1000;
var shooting: bool = false;
var fire_rate: float = 130;
var burst_gap: float = 0.15;
var shots_per_burst: int = 4;
var reload_time: float = 1;

var current_shot: int = 0;

var weapon_controller: WeaponController;

@export var bullet: PackedScene;
@export var muzzle_flash: PackedScene;

func _start_shoot(weapon_controller: WeaponController) -> void:
	super._start_shoot(weapon_controller);
	
	self.weapon_controller = weapon_controller;
	
	shooting = true;
	
	fire();

func _stop_shoot(weapon_controller: WeaponController) -> void:
	super._stop_shoot(weapon_controller);
	
	self.weapon_controller = weapon_controller;
	
	current_shot = 0;
	
	shooting = false;

func _reload(weapon_controller: WeaponController) -> void:
	super._reload(weapon_controller);
	
	self.weapon_controller = weapon_controller;
	
	await weapon_controller.get_tree().create_timer(reload_time).timeout;
	
	current_ammo = mag_ammo;
	
	weapon_controller._on_reload_end();

func fire() -> void:
	if(shooting and current_shot < shots_per_burst):
		var direction = Vector2(cos(weapon_controller.global_rotation), sin(weapon_controller.global_rotation));
		weapon_controller.parent_titan_camera.shake(2, -direction);
		
		var muzzle_flash_instance: GPUParticles2D = muzzle_flash.instantiate();
		weapon_controller.get_tree().current_scene.add_child(muzzle_flash_instance);
		
		muzzle_flash_instance.global_position = weapon_controller.barrel_location.global_position;
		muzzle_flash_instance.global_rotation = weapon_controller.barrel_location.global_rotation;
		
		muzzle_flash_instance.emitting = true;
		
		var bullet_instance: Bullet = bullet.instantiate();
		weapon_controller.get_tree().current_scene.add_child(bullet_instance);
		
		bullet_instance.global_position = weapon_controller.barrel_location.global_position;
		bullet_instance.global_rotation = weapon_controller.barrel_location.global_rotation;
		
		bullet_instance.velocity = Vector2(bullet_speed, 0).rotated(bullet_instance.global_rotation);
		
		current_ammo -= 1;
		
		await weapon_controller.get_tree().create_timer(5/fire_rate).timeout;
		
		current_shot += 1;
		
		fire();
	elif(shooting and current_shot >= shots_per_burst):
		await weapon_controller.get_tree().create_timer(burst_gap).timeout;
		current_shot = 0;
		fire();

func _manual_process(delta: float) -> void:
	super._manual_process(delta);

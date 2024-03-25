extends WeaponFunction

class_name R5WeaponFunction;

var num_mags: int = 5;
var mag_ammo: int = 1;
var current_ammo: int = mag_ammo;
var charging: bool = false;
var charge_time: float = 1.5;
var reload_time: float = 2;

var weapon_controller: WeaponController;

@export var muzzle_flash: PackedScene;
@export var railgun_bullet: PackedScene;

func _start_shoot(weapon_controller: WeaponController) -> void:
	super._start_shoot(weapon_controller);
	
	self.weapon_controller = weapon_controller;
	
	charging = true;
	
	await weapon_controller.get_tree().create_timer(charge_time).timeout;
	
	if(current_ammo > 0):
		fire(weapon_controller);

func _stop_shoot(weapon_controller: WeaponController) -> void:
	super._stop_shoot(weapon_controller);
	
	charging = false;
	
	self.weapon_controller = weapon_controller;

func _reload(weapon_controller: WeaponController) -> void:
	super._reload(weapon_controller);
	
	self.weapon_controller = weapon_controller;
	
	await weapon_controller.get_tree().create_timer(reload_time).timeout;
	
	current_ammo = mag_ammo;
	
	num_mags -= 1;
	
	weapon_controller._on_reload_end();

func fire(weapon_controller: WeaponController) -> void:
	if(!charging):
		return;
	
	var direction = Vector2(cos(weapon_controller.global_rotation), sin(weapon_controller.global_rotation));
	if(weapon_controller.parent_titan_camera != null):
			weapon_controller.parent_titan_camera.shake(40, -direction);
	
	var muzzle_flash_instance: GPUParticles2D = muzzle_flash.instantiate();
	weapon_controller.get_tree().current_scene.add_child(muzzle_flash_instance);
	
	muzzle_flash_instance.global_position = weapon_controller.barrel_location.global_position;
	muzzle_flash_instance.global_rotation = weapon_controller.barrel_location.global_rotation;
	
	muzzle_flash_instance.emitting = true;
	
	var railgun_bullet_instance: RailgunBullet = railgun_bullet.instantiate();
	weapon_controller.get_tree().current_scene.add_child(railgun_bullet_instance);
	
	current_ammo -= 1;
	
	var raycast: RayCast2D = weapon_controller.get_node("RayCast2D");
	
	if(raycast.is_colliding()):
		railgun_bullet_instance.place(weapon_controller.barrel_location.global_position, raycast.get_collision_point(), 2.5);
		if(raycast.get_collider() is DummyController):
			var health_component: TitanHealthComponent = raycast.get_collider().get_node("TitanHealthComponent");
			health_component.take_damage(40);
		
		if(raycast.get_collider() is DestructableTileMap):
			var tiles: DestructableTileMap = raycast.get_collider();
			tiles.destroy_tiles_from_point(raycast.get_collision_point(), 2.5);
	else:
		railgun_bullet_instance.place(weapon_controller.barrel_location.global_position, weapon_controller.barrel_location.global_position + (direction * raycast.target_position.length()), 2.5);

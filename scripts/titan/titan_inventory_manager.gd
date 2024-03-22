extends Area2D

class_name TitanInventoryManager;

signal gun_picked_up;
signal gun_dropped;

var pickupable_weapon: WeaponController;
var active_weapon: WeaponController;

@export var titan_camera: TitanCamera;

func try_pick_up() -> void:
	if(pickupable_weapon != null and active_weapon == null):
		pickupable_weapon.pick_up(self);
		active_weapon = pickupable_weapon;
		
		gun_picked_up.emit(active_weapon);

func try_drop() -> void:
	if(active_weapon != null):
		active_weapon.drop();
		active_weapon = null;
		
		gun_dropped.emit();

func _on_area_entered(body: Area2D) -> void:
	if(body is WeaponController):
		pickupable_weapon = body;

func _on_area_exited(body: Area2D) -> void:
	if(body == pickupable_weapon):
		pickupable_weapon = null;

func _process(delta: float) -> void:
	if(active_weapon != null):
		var direction_to_mouse: float = global_position.angle_to_point(get_global_mouse_position());
		global_rotation = lerp_angle(global_rotation, direction_to_mouse, delta * active_weapon.aim_time);

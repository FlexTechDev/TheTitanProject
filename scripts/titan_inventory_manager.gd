extends Area2D

class_name TitanInventoryManager;

var pickupable_weapon: WeaponController;
var active_weapon: WeaponController;

@export var titan_camera: TitanCamera;

func try_pick_up() -> void:
	if(pickupable_weapon != null):
		pickupable_weapon.pick_up(self);
		active_weapon = pickupable_weapon;

func try_drop() -> void:
	if(active_weapon != null):
		active_weapon.drop();
		active_weapon = null;

func _on_area_entered(body: Area2D) -> void:
	if(body is WeaponController):
		pickupable_weapon = body;

func _on_area_exited(body: Area2D) -> void:
	if(body == pickupable_weapon):
		pickupable_weapon = null;

func _process(delta: float) -> void:
	var direction_to_mouse: float = get_parent().get_angle_to(get_global_mouse_position());
	
	rotation = direction_to_mouse;

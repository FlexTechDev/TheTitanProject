extends Area2D

class_name TitanInventoryManager;

signal gun_picked_up;
signal gun_dropped;

var weapons_in_range: Array[WeaponController];
var pickupable_weapon: WeaponController;
var active_weapon: WeaponController;

@onready var pick_up_label: Button = $Label;

@export var titan_camera: TitanCamera;

func try_pick_up() -> void:
	if(pickupable_weapon != null and active_weapon == null):
		pickupable_weapon.remove_child(pick_up_label);
		add_child(pick_up_label);
		pick_up_label.visible = false;
		
		active_weapon = pickupable_weapon;
		
		pickupable_weapon.pick_up(self);
		
		gun_picked_up.emit(active_weapon);

func try_drop() -> void:
	if(active_weapon != null):
		active_weapon.drop();
		active_weapon = null;
		
		gun_dropped.emit();

func _on_area_entered(body: Area2D) -> void:
	if(body is WeaponController):
		weapons_in_range.append(body);

func _on_area_exited(body: Area2D) -> void:
	if(body is WeaponController):
		if(body == pickupable_weapon):
			if(pick_up_label.get_parent() != self):
				pickupable_weapon.remove_child(pick_up_label);
				add_child(pick_up_label);
			
			pickupable_weapon = null;
			
			pick_up_label.visible = false;
		
		if(weapons_in_range.has(body)):
			var index: int = weapons_in_range.find(body);
			weapons_in_range.remove_at(index);

func _process(delta: float) -> void:
	for weapon in weapons_in_range:
		if(pickupable_weapon != null and weapon != pickupable_weapon and global_position.distance_to(weapon.global_position) < global_position.distance_to(pickupable_weapon.global_position)):
			pickupable_weapon = weapon;
			
			pick_up_label.visible = true;
			remove_child(pick_up_label);
			
			pickupable_weapon.add_child(pick_up_label);
			pick_up_label.global_position = weapon.global_position;
		elif(pickupable_weapon == null and active_weapon == null):
			pickupable_weapon = weapon;
			
			pick_up_label.visible = true;
			remove_child(pick_up_label);
			
			pickupable_weapon.add_child(pick_up_label);
			pick_up_label.global_position = weapon.global_position;
	
	if(active_weapon != null):
		var direction_to_mouse: float = global_position.angle_to_point(get_global_mouse_position());
		global_rotation = lerp_angle(global_rotation, direction_to_mouse, delta * active_weapon.aim_time);

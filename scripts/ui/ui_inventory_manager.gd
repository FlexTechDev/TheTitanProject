extends TextureRect

class_name UIInventoryManager;

var current_weapon: WeaponController;

@onready var mag_number: Label = $MagNumber;
@onready var weapon_texture: TextureRect = $WeaponTexture;

func _ready() -> void:
	var titan_component_manager: TitanComponentManager = get_parent().get_parent().get_parent().get_parent() as TitanComponentManager;
	titan_component_manager.titan_inventory_manager.gun_picked_up.connect(_on_gun_picked_up);
	titan_component_manager.titan_inventory_manager.gun_dropped.connect(_on_gun_dropped);
	
	titan_component_manager.titan_input_controller.fire_input.connect(_on_gun_fire);
	titan_component_manager.titan_input_controller.fire_input_ended.connect(_on_gun_fire_ended);
	titan_component_manager.titan_input_controller.reload_input.connect(_on_gun_reloaded);

func _on_gun_reloaded() -> void:
	if(current_weapon.weapon_function.get("num_mags") != null):
		if(current_weapon.weapon_function.num_mags > 0):
			$MagTexture.modulate = Color.WHITE;
			mag_number.text = str(current_weapon.weapon_function.num_mags - 1);

func _on_gun_fire() -> void:
	pass

func _on_gun_fire_ended() -> void:
	var mag_percentage: float = float(current_weapon.weapon_function.current_ammo)/float(current_weapon.weapon_function.mag_ammo);
	$MagTexture.modulate = lerp(Color.INDIAN_RED, Color.WHITE, mag_percentage);

func _on_gun_picked_up(active_weapon: WeaponController) -> void:
	weapon_texture.texture = active_weapon.sprite.texture;
	current_weapon = active_weapon;
	
	if(current_weapon.weapon_function.get("num_mags") != null):
		mag_number.text = str(current_weapon.weapon_function.num_mags);
		var mag_percentage: float = float(current_weapon.weapon_function.current_ammo)/float(current_weapon.weapon_function.mag_ammo);
		$MagTexture.modulate = lerp(Color.INDIAN_RED, Color.WHITE, mag_percentage);

func _on_gun_dropped() -> void:
	weapon_texture.texture = null;
	mag_number.text = "0";
	current_weapon = null;
	$MagTexture.modulate = Color.WHITE

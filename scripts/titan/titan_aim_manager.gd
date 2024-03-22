extends Sprite2D

class_name TitanAimManager

@onready var true_aim: Sprite2D = $Sprite2D;

@export var titan_inventory_manager: TitanInventoryManager;

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(delta: float) -> void:
	global_position = get_global_mouse_position();
	
	if(titan_inventory_manager.active_weapon != null):
		true_aim.visible = true;
		true_aim.global_position = titan_inventory_manager.global_position + Vector2(cos(titan_inventory_manager.global_rotation), sin(titan_inventory_manager.global_rotation)) * titan_inventory_manager.global_position.distance_to(global_position);
	else:
		true_aim.visible = false;

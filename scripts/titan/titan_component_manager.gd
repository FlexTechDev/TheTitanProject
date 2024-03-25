extends Node2D

class_name TitanComponentManager

@export var titan_controller: TitanController;
@export var titan_camera: TitanCamera;
@export var titan_aim_manager: TitanAimManager;
@export var titan_animator: TitanAnimator;
@export var titan_inventory_manager: TitanInventoryManager;
@export var titan_input_controller: TitanInputController;
@export var titan_visual_manager: TitanVisualManager;

func _ready() -> void:
	set_multiplayer_authority(name.to_int());
	
	if(!is_multiplayer_authority() and get_tree().current_scene.name != "playground"):
		$hud.set_process(false);
		$hud.visible = false;

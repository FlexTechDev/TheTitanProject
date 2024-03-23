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
	if(multiplayer.multiplayer_peer.get_connection_status() != multiplayer.multiplayer_peer.CONNECTION_DISCONNECTED):
		return;
	
	set_multiplayer_authority(name.to_int());

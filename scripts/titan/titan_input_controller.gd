extends Node

class_name TitanInputController;

signal fire_input;
signal fire_input_ended;
signal reload_input;
signal interacted;

@export var titan_controller: TitanController
@export var titan_inventory_manager: TitanInventoryManager;

func _input(event: InputEvent) -> void:
	if(!is_multiplayer_authority()):
		return;
	
	if(event is InputEventKey):
		var input_vector: Vector2 = Vector2(Input.get_axis("left","right"),Input.get_axis("up","down")).normalized();
		
		titan_controller.move(input_vector);
		
		if(event.is_action_pressed("jump")):
			titan_controller.try_jump();
		
		if(event.is_action_pressed("interact")):
			titan_inventory_manager.try_pick_up();
			interacted.emit(get_parent());
		if(event.is_action_pressed("drop")):
			titan_inventory_manager.try_drop();
		
		if(event.is_action_pressed("reload")):
			if(titan_inventory_manager.active_weapon != null):
				titan_inventory_manager.active_weapon.reload();
				reload_input.emit();
		
	if(event is InputEventMouseButton):
		if(event.is_action_pressed("shoot") and titan_inventory_manager.active_weapon != null):
			fire_input.emit();
			titan_inventory_manager.active_weapon.start_shoot();
		if(event.is_action_released("shoot") and titan_inventory_manager.active_weapon != null):
			fire_input_ended.emit();
			titan_inventory_manager.active_weapon.stop_shoot();

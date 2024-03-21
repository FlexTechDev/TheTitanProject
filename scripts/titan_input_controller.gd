extends Node

class_name TitanInputController;

@export var titan_controller: TitanController
@export var titan_inventory_manager: TitanInventoryManager;

func _input(event: InputEvent) -> void:
	if(event is InputEventKey):
		var input_vector: Vector2 = Vector2(Input.get_axis("left","right"),Input.get_axis("up","down")).normalized();
		
		titan_controller.move(input_vector);
		
		if(event.is_action_pressed("jump")):
			titan_controller.try_jump();
		
		if(event.is_action_pressed("interact")):
			titan_inventory_manager.try_pick_up();
		if(event.is_action_pressed("drop")):
			titan_inventory_manager.try_drop();
		
		if(event.is_action_pressed("reload")):
			titan_inventory_manager.active_weapon.reload();
		
	if(event is InputEventMouseButton):
		if(event.is_action_pressed("shoot") and titan_inventory_manager.active_weapon != null):
			titan_inventory_manager.active_weapon.start_shoot();
		if(event.is_action_released("shoot") and titan_inventory_manager.active_weapon != null):
			titan_inventory_manager.active_weapon.stop_shoot();

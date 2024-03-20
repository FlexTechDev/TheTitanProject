extends Node

class_name TitanInputController;

var last_x_scale: float = 1;

@export var titan_controller: TitanController

func _input(event: InputEvent) -> void:
	if(event is InputEventKey):
		var input_vector: Vector2 = Vector2(Input.get_axis("left","right"),Input.get_axis("up","down")).normalized();
		
		titan_controller.move(input_vector);
		
		if(event.is_action_pressed("left") and last_x_scale == 1):
			titan_controller.scale.x = -1;
			last_x_scale = -1;
		if(event.is_action_pressed("right") and last_x_scale == -1):
			titan_controller.scale.x = -1;
			last_x_scale = 1;
		
		if(event.is_action_pressed("jump")):
			titan_controller.try_jump();

extends CharacterBody2D

class_name TitanController;

@onready var animator: TitanAnimator = $TitanAnimator;

@export var z_velocity: float = 0;
@export var z_position: float = 0;
@export var true_position: Vector2 = position;
@export var move_speed: float = 3500;
@export var jump_force: float = 100;
@export var in_air: bool = false;
@export var on_floor: bool = true;
@export var last_movement_input: Vector2 = Vector2.ZERO;

func try_jump() -> void:
	if(on_floor):
		z_velocity = jump_force;
		in_air = true;
		on_floor = false;

func move(input_vector: Vector2) -> void:
	velocity = input_vector * move_speed * get_process_delta_time();
	
	last_movement_input = input_vector;

func _physics_process(delta: float) -> void:
	z_position += z_velocity * delta;
	
	if(z_position > 0):
		z_velocity -= 9.8;
	else:
		in_air = false;
		z_position = 0;
		z_velocity = 0;
		on_floor = true;
	
	position.y = true_position.y - z_position;

func _process(delta: float) -> void:
	move_and_slide();
	
	true_position += velocity * delta;

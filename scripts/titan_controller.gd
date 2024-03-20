extends CharacterBody2D

class_name TitanController;

var z_velocity: float = 0;
var z_position: float = 0;
var in_air: bool = false;
var last_movement_input: Vector2 = Vector2.ZERO;

@onready var true_position: Vector2 = position;
@onready var animator: TitanAnimator = $TitanAnimator;

@export var move_speed: float = 3500;
@export var jump_force: float = 100;

func try_jump() -> void:
	z_velocity = jump_force;
	in_air = true;

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
	
	position.y = true_position.y - z_position;

func _process(delta: float) -> void:
	if(last_movement_input == Vector2.ZERO and animator.current_state != TitanAnimator.TITAN_STATE.IDLE):
		animator.set_state(TitanAnimator.TITAN_STATE.IDLE);
	
	if(last_movement_input != Vector2.ZERO):
		animator.set_state(TitanAnimator.TITAN_STATE.RUNNING);
	
	if(in_air):
		animator.set_state(TitanAnimator.TITAN_STATE.IN_AIR);
	
	move_and_slide();
	
	true_position += velocity * delta;

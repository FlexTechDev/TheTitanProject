extends AnimatedSprite2D

class_name TitanAnimator;

@onready var titan_inventory_manager: TitanInventoryManager = $HoldingPoint;
@onready var right_hand: Node2D = $RightHand;
@onready var left_hand: Node2D = $LeftHand;

@export var titan_controller: TitanController;

enum TITAN_STATE
{
	IDLE,
	RUNNING,
	IN_AIR,
	FLYING,
	LAYING
}

var last_x_scale: float = 1;
var current_state: TITAN_STATE;

func _process(delta: float) -> void:
	if(titan_controller.last_movement_input == Vector2.ZERO and current_state != TitanAnimator.TITAN_STATE.IDLE):
		set_state(TitanAnimator.TITAN_STATE.IDLE);
	
	if(titan_controller.last_movement_input != Vector2.ZERO):
		set_state(TitanAnimator.TITAN_STATE.RUNNING);
	
	if(titan_controller.in_air):
		set_state(TitanAnimator.TITAN_STATE.IN_AIR);
	
	if(titan_inventory_manager.active_weapon != null):
		left_hand.global_position = titan_inventory_manager.active_weapon.left_hand_position.global_position;
		right_hand.global_position = titan_inventory_manager.active_weapon.right_hand_position.global_position;
	else:
		left_hand.position = Vector2(-5, 6);
		right_hand.position = Vector2(5, 6);
	
	if(!is_multiplayer_authority() and get_tree().current_scene.name != "playground"):
		return;
	
	var direction_to_mouse: Vector2 = get_parent().global_position - get_global_mouse_position();
	if(direction_to_mouse.x > 0 and last_x_scale == 1):
		get_parent().scale.x = -1;
		last_x_scale = -1;
	if(direction_to_mouse.x < 0 and last_x_scale == -1):
		get_parent().scale.x = -1;
		last_x_scale = 1;

func set_state(state: TITAN_STATE) -> void:
	match state:
		TITAN_STATE.IDLE:
			play("idle");
			current_state = TITAN_STATE.IDLE;
		TITAN_STATE.RUNNING:
			play("running");
			current_state = TITAN_STATE.RUNNING;
		TITAN_STATE.IN_AIR:
			play("in_air");
			current_state = TITAN_STATE.IN_AIR;
		TITAN_STATE.FLYING:
			play("flying");
			current_state = TITAN_STATE.FLYING;
		TITAN_STATE.LAYING:
			play("laying");
			current_state = TITAN_STATE.LAYING;

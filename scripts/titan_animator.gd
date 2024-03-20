extends AnimatedSprite2D

class_name TitanAnimator;

enum TITAN_STATE
{
	IDLE,
	RUNNING,
	IN_AIR,
	FLYING,
	LAYING
}

var current_state: TITAN_STATE;

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

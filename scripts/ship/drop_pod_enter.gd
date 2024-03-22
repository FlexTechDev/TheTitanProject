extends StaticBody2D

class_name DropPodEnter;

var enterable: bool = false;

@onready var ship_lobby_manager: ShipLobbyManager = get_tree().current_scene.get_node("ShipLobbyManager");

func _on_interacted_with(body: TitanComponentManager) -> void:
	ship_lobby_manager.titans_on_ship[body] = true;
	ship_lobby_manager.check_titans_ready();

func _on_body_entered(body: Node2D) -> void:
	if(body is TitanController):
		body.get_parent().titan_input_controller.interacted.connect(_on_interacted_with);
		
		$Sprite2D.play("open");
		enterable = true;
		$Label.visible = true;

func _on_body_exited(body: Node2D) -> void:
	if(body is TitanController):
		body.get_parent().titan_input_controller.interacted.disconnect(_on_interacted_with);
		
		$Sprite2D.play("close");
		enterable = false;
		$Label.visible = false;

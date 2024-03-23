extends StaticBody2D

class_name ShipMissionManager;

var interactable: bool = false;

func _on_body_entered(body: Node2D) -> void:
	if(body is TitanController):
		interactable = true;
		
		$Label.visible = true;

func _on_body_exited(body: Node2D) -> void:
	if(body is TitanController):
		interactable = false;
		
		$Label.visible = true;

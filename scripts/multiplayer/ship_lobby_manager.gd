extends Node

class_name ShipLobbyManager;

var titans_on_ship: Dictionary;

@export var scene_to_drop_to: PackedScene

func _ready() -> void:
	titans_on_ship[get_tree().current_scene.get_node("Titan")] = false;

func check_titans_ready() -> void:
	for titan in titans_on_ship:
		if(titans_on_ship[titan] == false):
			return;
	
	get_tree().change_scene_to_packed(scene_to_drop_to);

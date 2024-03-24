extends Control;

class_name FriendPanel;

func _on_join_pressed() -> void:
	Steam.joinLobby(0);

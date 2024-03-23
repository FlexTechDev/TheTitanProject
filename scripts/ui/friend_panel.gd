extends Control;

class_name FriendPanel;

var lobby_id: int = 0;

func _on_join_pressed() -> void:
	Steam.joinLobby(lobby_id);

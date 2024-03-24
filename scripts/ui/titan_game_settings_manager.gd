extends TabContainer;

class_name TitanGameSettingsManager;

@onready var friend_panel = preload("res://scenes/player/hud/friend_panel.tscn");

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("settings")):
		visible = !visible;
		if(visible):
			load_friends();
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE;
		else:
			Input.mouse_mode = Input.MOUSE_MODE_HIDDEN;

func load_friends() -> void:
	for friend in get_friends_in_lobbies():
		var friend_panel_instance: FriendPanel = friend_panel.instantiate();
		$TabBar/VBoxContainer.add_child(friend_panel_instance);
		friend_panel_instance.get_node("Label").text = str(friend);

func get_friends_in_lobbies() -> Dictionary:
	var results: Dictionary = {}

	for i in range(0, Steam.getFriendCount()):
		var steam_id: int = Steam.getFriendByIndex(i, Steam.FRIEND_FLAG_IMMEDIATE)
		var game_info: Dictionary = Steam.getFriendGamePlayed(steam_id)

		if game_info.is_empty():
			# This friend is not playing a game
			continue
		else:
			# They are playing a game, check if it's the same game as ours
			var app_id: int = game_info['id']
			var lobby = game_info['lobby']

			if app_id != Steam.getAppID() or lobby is String:
				# Either not in this game, or not in a lobby
				continue

			results[steam_id] = lobby

	return results

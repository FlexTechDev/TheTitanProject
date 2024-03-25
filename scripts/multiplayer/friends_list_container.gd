extends VBoxContainer

class_name FriendsListContainer;

@export var friend_panel: PackedScene;

func refresh() -> void:
	var friend_lobbies: Dictionary = get_lobbies_with_friends();
	
	for friend in friend_lobbies:
		var friend_panel_instance: Control = friend_panel.instantiate();
		friend_panel_instance.get_node("Label").text = Steam.getFriendPersonaName(friend)
		
		if(friend_lobbies[friend] == "not in any game"):
			friend_panel_instance.modulate.a = 0.2;
		if(friend_lobbies[friend] == "not in this game"):
			friend_panel_instance.modulate.a = 0.5;
		
		add_child(friend_panel_instance);

func get_lobbies_with_friends() -> Dictionary:
	var results: Dictionary = {}

	for i in range(0, Steam.getFriendCount()):
		var steam_id: int = Steam.getFriendByIndex(i, Steam.FRIEND_FLAG_IMMEDIATE)
		var game_info: Dictionary = Steam.getFriendGamePlayed(steam_id)

		if game_info.is_empty():
			results[steam_id] = "not in any game";
		else:
			# They are playing a game, check if it's the same game as ours
			var app_id: int = game_info['id']
			var lobby = game_info['lobby']

			if app_id != Steam.getAppID() or lobby is String:
				# Either not in this game, or not in a lobby
				results[steam_id] = "not in this game";

			results[steam_id] = lobby;

	return results;

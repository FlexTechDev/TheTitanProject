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
	for friend in Steam.getUserSteamFriends():
		var friend_panel_instance: FriendPanel = friend_panel.instantiate();
		$TabBar/VBoxContainer.add_child(friend_panel_instance);
		friend_panel_instance.get_node("Label").text = friend.name;

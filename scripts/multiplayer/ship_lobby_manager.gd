extends Node

class_name ShipLobbyManager;

var lobby_id: int = 0;
var steam_id: int = 0;
var steam_username: String = "";
var lobby_name: String = "";

@export var titans_on_ship: Dictionary;
@export var titan: PackedScene;
@export var scene_to_drop_to: PackedScene

func _ready() -> void:
	OS.set_environment("SteamAppID", str(480));
	OS.set_environment("SteamGameID", str(480));
	
	Steam.steamInitEx();
	
	var initialize_response: Dictionary = Steam.steamInitEx( true, 480 );
	
	Steam.lobby_created.connect(_on_lobby_created);
	Steam.lobby_joined.connect(_on_lobby_joined);
	
	create_lobby("test");

func create_lobby(lobby_name: String) -> void:
	self.lobby_name = lobby_name;
	Steam.createLobby(Steam.LOBBY_TYPE_PUBLIC);

func _on_lobby_created(connect: int, lobby_id: int) -> void:
	self.lobby_id = lobby_id;
	
	Steam.setLobbyJoinable(lobby_id, true);
	
	Steam.setLobbyData(lobby_id, "name", lobby_name);
	
	spawn_titan();

func _on_lobby_joined(lobby: int, permissions: int, locked: bool, response: int) -> void:
	if(lobby_id == lobby):
		return;
	
	lobby_id = lobby;
	spawn_titan();

func spawn_titan(id: int = 1) -> void:
	var titan_instance: TitanComponentManager = titan.instantiate();
	
	titan_instance.name = str(id);
	
	get_tree().current_scene.add_child(titan_instance);
	
	titans_on_ship[titan_instance] = false;

func check_titans_ready() -> void:
	for titan in titans_on_ship:
		if(titans_on_ship[titan] == false):
			return;
	
	get_tree().change_scene_to_packed(scene_to_drop_to);

func _process(delta: float) -> void:
	Steam.run_callbacks();

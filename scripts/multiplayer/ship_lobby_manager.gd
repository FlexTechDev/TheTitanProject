extends Node

class_name ShipLobbyManager;

var lobby_id: int = 0;
var steam_id: int = 0;
var steam_username: String = "";
var lobby_name: String = "";

@export var titans_on_ship: Dictionary;
@export var titan: PackedScene;
@export var scene_to_drop_to: PackedScene

func _init() -> void:
	OS.set_environment("SteamAppID", str(480));
	OS.set_environment("SteamGameID", str(480));

func _ready() -> void:
	var initialize_response: Dictionary = Steam.steamInitEx( true, 480 );
	print("Did Steam initialize?: %s " % initialize_response);
	
	Steam.lobby_created.connect(_on_lobby_created);
	Steam.lobby_joined.connect(_on_lobby_joined);
	Steam.steam_server_connected.connect(_on_steam_connected);
	Steam.steam_server_connect_failed.connect(_on_steam_connection_failed);
	
	create_lobby("test");

func _on_steam_connected() -> void:
	print("connected to steam");

func _on_steam_connection_failed() -> void:
	print("failed to connect to steam");

func create_lobby(lobby_name: String) -> void:
	self.lobby_name = lobby_name;
	Steam.createLobby(Steam.LOBBY_TYPE_PUBLIC);

func _on_lobby_created(connect: int, lobby_id: int) -> void:
	self.lobby_id = lobby_id;
	
	Steam.setLobbyJoinable(lobby_id, true);
	
	Steam.setLobbyData(lobby_id, "name", lobby_name);

func _on_lobby_joined(lobby: int, permissions: int, locked: bool, response: int) -> void:
	if(lobby_id == lobby):
		return;
	
	lobby_id = lobby;

func _process(delta: float) -> void:
	Steam.run_callbacks();

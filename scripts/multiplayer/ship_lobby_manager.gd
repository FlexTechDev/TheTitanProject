extends Node

class_name ShipLobbyManager;

var network_port: int = 7007;
var network_address: String = "127.0.0.1";
var network: ENetMultiplayerPeer;

@export var titans_on_ship: Dictionary;
@export var titan: PackedScene;
@export var scene_to_drop_to: PackedScene

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("test_bind")):
		join();
	if(event.is_action_pressed("host")):
		create();

func create() -> void:
	network = ENetMultiplayerPeer.new();
	
	network.create_server(network_port);
	
	multiplayer.multiplayer_peer = network;
	
	multiplayer.peer_connected.connect(spawn_titan);
	spawn_titan();

func join() -> void:
	network = ENetMultiplayerPeer.new();
	
	network.create_client(network_address, network_port);
	
	multiplayer.multiplayer_peer = network;

func spawn_titan(id: int = 1) -> void:
	var titan_instance: TitanComponentManager = titan.instantiate();
	
	titan_instance.name = str(id);
	
	get_tree().current_scene.add_child.call_deferred(titan_instance);
	
	titans_on_ship[titan_instance] = false;

func check_titans_ready() -> void:
	for titan in titans_on_ship:
		if(titans_on_ship[titan] == false):
			return;
	
	get_tree().change_scene_to_packed(scene_to_drop_to);

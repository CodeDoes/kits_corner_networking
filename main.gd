# main.gd
extends VBoxContainer
var enet: ENetConnection
const PORT = 7000
const DEFAULT_SERVER_IP  = "127.0.0.1"
var is_host = false
func _ready():
	var client_id = int(OS.get_cmdline_args()[1])
	var peer = ENetMultiplayerPeer.new()
	is_host = client_id == 1
	if is_host:
		peer.create_server(PORT)
	else:
		peer.create_client(DEFAULT_SERVER_IP,PORT)
	multiplayer.peer_connected.connect(func(client_id):
		if multiplayer.is_server():
			spawn_client(client_id)
	)
	multiplayer.multiplayer_peer = peer
	%CurrentUser.text = "Client "+ str(client_id) + (" Is Host" if is_host else "")
	if multiplayer.is_server():
		
		spawn_client(multiplayer.get_unique_id())
	print(OS.get_cmdline_args())
		
		
func spawn_client(client_id:int):
	var label_text = "Client "+str(client_id)
	prints("Spawning", label_text)
	var client = preload("res://client.tscn").instantiate()
	#client.get_node("Label").text = label_text
	client.name = str(client_id)
	#client.set_multiplayer_authority(client_id)
	%Clients.add_child(client,true)

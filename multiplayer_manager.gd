extends Node

var peer = ENetMultiplayerPeer.new()
const PORT = 7000
const ADDRESS = "127.0.0.1"

func host_game():
	var error = peer.create_server(PORT, 2)
	if error != OK:
		print("Failed to host: ", error)
		return
	multiplayer.multiplayer_peer = peer
	print("Hosting Level 1...")
	
	# CHANGE THIS LINE BELOW:
	get_tree().change_scene_to_file("res://main.tscn") 

func join_game():
	var error = peer.create_client(ADDRESS, PORT)
	if error != OK:
		print("Failed to join: ", error)
		return
	multiplayer.multiplayer_peer = peer
	print("Joining Level 2...")
	
	# KEEP THIS AS LEVEL 2:
	get_tree().change_scene_to_file("res://level_2.tscn")

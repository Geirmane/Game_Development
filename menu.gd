extends Control

# This now acts as the 'Host' button for Week 4
func _on_button_pressed():
	# Instead of just changing the scene, we start the server first
	MultiplayerManager.host_game()

# This now acts as the 'Join' button for Week 4
func _on_button_2_pressed():
	# Instead of going to Level 2, we connect to the Host
	MultiplayerManager.join_game()

extends Node2D

@onready var portal = $Portal # Ensure your Portal node in the scene tree is named 'Portal'

func _ready():
	# Hide the UI and the Portal at the start of the game
	if has_node("UI/LevelLabel"):
		$UI/LevelLabel.hide()
	
	if portal:
		portal.hide()
		portal.monitoring = false # Prevents Naruto from entering it before it appears

func transition_to_level_2():
	print("Itachi defeated! Portal appearing...")
	
	# 1. Show the Portal with a fade-in effect
	if portal:
		portal.show()
		portal.monitoring = true # Now Naruto can trigger it
		var tween = create_tween()
		portal.modulate.a = 0
		tween.tween_property(portal, "modulate:a", 1.0, 1.0)
	
	# 2. Update the UI Notification
	if has_node("UI/LevelLabel"):
		$UI/LevelLabel.text = "LEVEL CLEAR! ENTER THE PORTAL"
		$UI/LevelLabel.show()
	
	# 3. Unlock the Camera so Naruto can walk to the portal
	var camera_tween = create_tween()
	# Adjust 1150 if your portal is further to the right
	camera_tween.tween_property($Player_Naruto/Camera2D, "limit_left", 1150, 1.5)
	
	# 4. Slight difficulty increase for the engine
	Engine.time_scale = 1.1

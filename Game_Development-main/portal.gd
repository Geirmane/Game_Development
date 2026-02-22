extends Area2D

# This is the path to your Level 2 scene file
@export_file("*.tscn") var next_level_path = "res://level_2.tscn"

func _ready():
	# Connect the signal automatically so you don't have to do it in the editor
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	# Check if the player is the one who touched the portal
	if body.is_in_group("Player"):
		print("Teleporting to Level 2...")
		get_tree().change_scene_to_file(next_level_path)

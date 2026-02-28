extends Control

# This triggers when you click 'Button' (Level 1)
func _on_button_pressed():
	# Path must match your main scene file exactly
	get_tree().change_scene_to_file("res://main.tscn")

# This triggers when you click 'Button2' (Level 2)
func _on_button_2_pressed():
	# Path must match your level 2 file exactly
	get_tree().change_scene_to_file("res://level_2.tscn")

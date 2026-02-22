extends Area2D

@export var boost_force: float = -800.0 # Negative is UP in Godot

func _on_body_entered(body):
	if body.name == "Player_Naruto":
		if body.has_method("apply_jump_boost"):
			body.apply_jump_boost(boost_force)
			# Optional: Play a sound or animation

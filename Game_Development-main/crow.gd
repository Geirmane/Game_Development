extends Area2D

@export var speed: float = 400
var velocity: Vector2 = Vector2(-1, 0)

func _physics_process(delta):
	position += velocity * speed * delta
	
	if has_node("Sprite2D"):
		$Sprite2D.flip_h = false

func _on_body_entered(body):
	if body.name == "Player_Naruto" or body.is_in_group("Player"):
		
		if body.get("is_attacking") == true:
			queue_free()
			return 
		
		if body.get("is_dodging") == true:
			return 
		
		# Restarting level as per Activity 2 requirements
		get_tree().reload_current_scene()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

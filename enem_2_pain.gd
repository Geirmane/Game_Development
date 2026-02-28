extends CharacterBody2D

# --- STATS & UI ---
@export var speed: float = 160.0
@export var attack_range: float = 95.0
@export var max_health: float = 100.0
var current_health: float = 100.0

# --- NODES & TEXTURES ---
@onready var sprite = $Sprite2D
@onready var normal_texture = preload("res://Pictures/pain1.png")
@onready var attack_texture = preload("res://Pictures/painattack.png")
# Ensure this matches your Scene Tree hierarchy exactly
@onready var health_bar = $CanvasLayer/ProgressBar 
@onready var player = get_tree().get_first_node_in_group("Player")

var is_attacking: bool = false

func _ready():
	# 1. Initialize Health and HUD
	current_health = max_health
	if health_bar:
		health_bar.max_value = max_health
		health_bar.value = current_health
	
	# 2. Add to group so Naruto can find him
	add_to_group("Enemies")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if player and not is_attacking:
		var dist_x = player.global_position.x - global_position.x
		
		if abs(dist_x) > attack_range:
			var direction = sign(dist_x)
			velocity.x = direction * speed
			if sprite:
				sprite.flip_h = direction < 0
		else:
			velocity.x = 0

	move_and_slide()

# --- COMBAT LOGIC ---

func _on_attack_area_body_entered(body):
	# Added is_inside_tree() to prevent the timer crash
	if is_inside_tree() and body.is_in_group("Player") and not is_attacking:
		is_attacking = true
		
		if sprite and attack_texture:
			sprite.texture = attack_texture
		
		if body.has_method("take_damage"):
			body.take_damage(10)
		
			
		if sprite and normal_texture:
			sprite.texture = normal_texture
		
		is_attacking = false

func take_damage(amount: float):
	current_health -= amount
	
	if health_bar:
		health_bar.value = current_health
	
	if current_health <= 0:
		# Return to Menu when defeated
		get_tree().change_scene_to_file("res://menu.tscn")

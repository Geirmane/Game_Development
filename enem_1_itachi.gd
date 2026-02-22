extends CharacterBody2D

@export var health: int = 10
@export var crow_scene: PackedScene
@export var throw_delay: float = 6.0
@export var burst_count: int = 6
@export var crow_scale: Vector2 = Vector2(0.25, 0.25)
@export var spawn_interval: float = 0.2

# --- SCALE VARIABLES ---
@export var attack_scale: Vector2 = Vector2(1.65, 1.65) 
var original_scale: Vector2

@onready var throw_texture = preload("res://Pictures/itachit.png")
@onready var health_bar = $ProgressBar
@onready var sprite = $Sprite2D

var original_texture: Texture2D
var timer: float = 0.0

func _ready():
	add_to_group("Enemies")
	timer = throw_delay
	
	if sprite:
		original_texture = sprite.texture
		original_scale = sprite.scale 
		# Normal Pose: Set this so he faces Naruto (Left)
		sprite.flip_h = true 
		
	if health_bar:
		health_bar.max_value = health
		health_bar.value = health

func _physics_process(delta):
	if health > 0:
		handle_timers(delta)
	else:
		# Ensure he stays dead/stopped if health is 0
		timer = throw_delay

func handle_timers(delta):
	timer -= delta
	if timer <= 0:
		spawn_staggered_burst()
		timer = throw_delay

func spawn_staggered_burst():
	if crow_scene == null: return
	
	# --- CHANGE TO ATTACK POSE ---
	if sprite and throw_texture:
		sprite.texture = throw_texture
		sprite.scale = attack_scale
		# Flip logic: Set to 'false' because itachit.png is drawn facing left already
		sprite.flip_h = false 

	print("Itachi releasing staggered swarm...")
	for i in range(burst_count):
		# Stop spawning if he dies during the burst
		if health <= 0: break
		
		var crow = crow_scene.instantiate()
		get_parent().add_child(crow)
		
		# Position the crows slightly in front of Itachi
		var y_offset = randf_range(-120, 120)
		crow.global_position = global_position + Vector2(-60, y_offset)
		crow.scale = crow_scale
		
		# Small delay between each crow
		await get_tree().create_timer(spawn_interval).timeout

	# --- RESET TO NORMAL POSE ---
	if sprite and original_texture and health > 0:
		sprite.texture = original_texture
		sprite.scale = original_scale
		sprite.flip_h = true # Reset to face left for normal pose

func take_damage(amount: int):
	health -= amount
	if health_bar:
		health_bar.value = health
	
	print("Itachi HP: ", health)
	
	if health <= 0:
		die()

func die():
	print("Itachi defeated!")
	# Stop the physics loop so no more crows spawn
	set_physics_process(false)
	
	# Trigger the level transition in the Main script
	var main_scene = get_parent()
	if main_scene.has_method("transition_to_level_2"):
		main_scene.transition_to_level_2()
	
	queue_free()

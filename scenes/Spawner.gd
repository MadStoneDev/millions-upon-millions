extends Node2D

@export var enemy_scene: PackedScene
@export var speed: float = 100.0
@export var follow_distance: float = 200.0 # Distance to start following the player
@export var spawn_count: int = 5 # Number of enemies to spawn
@export var spawn_delay: float = 1.0 # Delay between spawns in seconds

var player: Node2D = null

func _ready():
	# Find the player in the scene tree
	player = get_tree().root.get_node("Level/Player") # Replace with actual path to your player node

	if player:
		# Start spawning enemies
		for i in range(spawn_count):
			# Delay spawn for each enemy
			call_deferred("spawn_enemy", i * spawn_delay)

	else:
		print("Error: Player not found.")

func spawn_enemy(delay_time: float):
	# Wait for the delay time
	yield(get_tree().create_timer(delay_time), "timeout")
	
	if enemy_scene:
		# Create a new PathFollow2D node for each enemy
		var path_follow = PathFollow2D.new()
		
		# Randomly position the PathFollow2D along the Path2D's length
		path_follow.offset = randi() % int(get_parent().curve.get_baked_length())
		
		# Add PathFollow2D to the Path2D
		get_parent().add_child(path_follow)

		# Instantiate the enemy and add it as a child of PathFollow2D
		var enemy_instance = enemy_scene.instantiate() as CharacterBody2D
		path_follow.add_child(enemy_instance)
		
		# Attach a script to control the enemy's movement
		var enemy_script = preload("res://scripts/EnemyMovement.gd").new()
		enemy_instance.add_child(enemy_script)
		enemy_script.initialize(player, speed, follow_distance)

	else:
		print("Error: enemy_scene is not assigned in the Inspector.")


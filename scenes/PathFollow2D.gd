extends PathFollow2D

@export var enemy_scene: PackedScene
@export var speed: float = 100.0
@export var follow_distance: float = 200.0 # Distance to start following the player

var player: Node2D = null
var enemy_instance: CharacterBody2D = null

func _ready():
	# Check if enemy_scene is assigned
	if enemy_scene:
		# Instantiate the enemy from the PackedScene
		enemy_instance = enemy_scene.instantiate() as CharacterBody2D
		add_child(enemy_instance)
		
		# Find the player in the scene tree (assuming player is already in the scene)
		player = get_tree().root.get_node("Level/Player") # Replace with the actual path to your player node

	else:
		print("Error: enemy_scene is not assigned in the Inspector.")

func _process(delta):
	if not enemy_instance:
		return
	
	if player:
		var distance_to_player = global_position.distance_to(player.global_position)
		
		if distance_to_player > follow_distance:
			# Move along the path
			progress += speed * delta
		else:
			# Switch to following the player
			var direction = (player.global_position - enemy_instance.global_position).normalized()
			enemy_instance.velocity = direction * speed
			
			# Move the enemy using the calculated velocity
			enemy_instance.move_and_slide()


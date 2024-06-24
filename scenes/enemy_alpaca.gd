extends CharacterBody2D


@onready var player : Node2D = null
const SPEED  : float = 100.0


func _ready():
	player = get_tree().root.get_node("Level/Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if player:
		var direction = (player.position - position).normalized()
		var velocity = direction * SPEED
		velocity = move_and_slide()

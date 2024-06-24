extends CharacterBody2D


const SPEED = 50.0


var current_direction = "right"
@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	
	if direction:
		velocity = direction * SPEED
		
		if direction.x > 0:
			current_direction = "right"
			animated_sprite.play("walk_right")
		elif direction.x < 0:
			current_direction = "left"
			animated_sprite.play("walk_left")
		elif direction.y > 0:
			current_direction = "down"
			animated_sprite.play("walk_down")
		elif direction.y < 0:
			current_direction = "up"
			animated_sprite.play("walk_up")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
		animated_sprite.play("idle_" + current_direction)

	move_and_slide()

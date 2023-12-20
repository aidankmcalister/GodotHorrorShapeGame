extends CharacterBody2D

@export var speed = 400
@export var friction = 7
@export var acceleration = 5
var targetRotation = 0.0
var rotationSpeed = 5.0 # Adjust the speed as needed

func _physics_process(delta):
	player_movement(delta)

func get_input(delta):
	var input = Vector2()
	if Input.is_action_pressed('right'):
		input.x += 1
	if Input.is_action_pressed('left'):
		input.x -= 1
	if Input.is_action_pressed('down'):
		input.y += 1
	if Input.is_action_pressed('up'):
		input.y -= 1
	return input

func player_movement(delta):
	var direction = get_input(delta)
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration * delta)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction * delta)
	move_and_slide()

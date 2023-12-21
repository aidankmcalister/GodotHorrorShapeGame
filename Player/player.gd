extends CharacterBody2D

@export var speed = 400
@export var friction = 7
@export var acceleration = 5
var targetRotation = 0.0
var rotationSpeed = 5.0
var push_force = 5

func _physics_process(delta):
	player_movement(delta)

func get_input(_delta):
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
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)

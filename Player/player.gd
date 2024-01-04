extends CharacterBody2D

@export var speed = 160
@export var friction = 7
@export var acceleration = 5

var dash_direction = Vector2()
var dash_speed = 250.0
var can_dash = true

var targetRotation = 0.0
var rotationSpeed= 40.0
var push_force = 5.0
var look = true
var is_grabbing = false
var direction = 0
var visibility_lvl = 1
#Items / Abilities

var has_dash = true
var has_flashlight = false

func _physics_process(delta):
	player_movement(delta)
	
	if has_dash:
		dash_movement(delta)
		
	if has_flashlight:
		$FlashlightBox.show()
		if look:
			$FlashlightBox.look_at(get_global_mouse_position())
	else:
		$FlashlightBox.hide()

#General Player Movement

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
	direction = get_input(delta)
	if direction.length() > 0:
		if is_grabbing:
			velocity = velocity.lerp(direction.normalized() * (speed * 0.6), acceleration * delta)
		else:
			velocity = velocity.lerp(direction.normalized() * speed, acceleration * delta)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction * delta)
	var collision = move_and_collide(velocity * delta)
	if collision:
		#print("I collided with ", collision.get_collider())
		if collision.get_collider().is_in_group("shapes"):
			collision.get_collider().apply_central_impulse(-collision.get_normal() * push_force)

# Dash

func dash_movement(delta):
	if Input.is_action_pressed('dash') and can_dash:
		can_dash = false
		dash_direction = direction.normalized()
		velocity = dash_direction * dash_speed
		velocity *= 1.0 - (friction * delta)
		$Dash_Cooldown.start()
	#if Input.is_action_pressed('cloak') and cloak_wait_timer.is_stopped():
		#visibility_lvl = 0
		#cloak_wait_timer.start()
		#cloak_duration_timer.start()
		#var tween = create_tween()
		#tween.tween_property($Sprite2D, "modulate", Color(0, 0, 0, 0.5), 0.5)

func _on_dash_cooldown_timeout():
	can_dash = true

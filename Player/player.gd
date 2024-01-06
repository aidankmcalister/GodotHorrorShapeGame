extends CharacterBody2D

@export var speed = 160
@export var friction = 7
@export var acceleration = 5

var dash_direction = Vector2()
var dash_speed = 450
var can_dash = true
var is_dashing = false

var targetRotation = 0.0
var rotationSpeed= 40.0
var push_force = 5.0
var look = true
var is_grabbing = false
var direction = 0
var visibility_lvl = 1
var light_lvl = 1

#Items / Abilities

var has_dash = true
var has_flashlight = true

func _physics_process(delta):
	player_movement(delta)
	
	if has_dash:
		dash_movement(delta)
		
	if has_flashlight:
		$FlashlightBox.show()
		flashlight_lvl()
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
		
	move_and_slide()
	
	# TODO: FIX PUSHING
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("shapes"):
			collision.get_collider().apply_central_impulse(-collision.get_normal() * push_force)

# Dash

func dash_movement(_delta):
	if Input.is_action_pressed('dash') and can_dash:
		can_dash = false
		is_dashing = true
		dash_direction = direction.normalized()
		dash_visual()
		velocity = dash_direction * dash_speed
		$Dash_Cooldown.start()

func _on_dash_cooldown_timeout():
	can_dash = true

func dash_visual():
	
	var tween = create_tween()
	tween.tween_property($Sprite2D, "scale", Vector2(.04, .04), .1) \
	.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($Sprite2D, "modulate", Color(0, 0, 0, 0.5), 0.5) \
	.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.connect("finished", on_tween_finished)

func on_tween_finished():
	$Dash_Duration.start()

func _on_dash_duration_timeout():
	var tween = create_tween()
	tween.tween_property($Sprite2D, "scale", Vector2(.05, .05), .3) \
	.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($Sprite2D, "modulate", Color(255, 255, 255, .5), 0.5) \
	.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	is_dashing = false

# Flashlight

func flashlight_lvl():
	print(light_lvl)

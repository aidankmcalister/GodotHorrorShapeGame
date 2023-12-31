extends CharacterBody2D

@onready var global = get_node("/root/Global")
@onready var light_ray = $LightRayCast

@export var speed = 160
@export var friction = 7
@export var acceleration = 5

var dash_direction = Vector2()
var dash_speed = 450
var can_dash = true
var is_dashing = false
var is_in_light = false

var ray_length = 96
var targetRotation = 0.0
var rotationSpeed= 40.0
var push_force = 5.0
var look = true
var is_grabbing = false
var direction = 0 

## Items / Abilities 

# Dash

var has_dash = false

# Flashlight

var has_flashlight = true
var flashlight_level : float = 100.0
var flashlight_change_rate : float = 1.0
var flashlight_change_interval : float = .1
var flashlight_time_passed : float = 0.0



func _physics_process(delta):
	player_movement(delta)
	light_raycast()
	if has_dash:
		dash_movement(delta)
		
	if has_flashlight:
		$FlashlightBox.show()
		$FlashlightBox/Flashlight.energy = flashlight_level / 100
		$PointLight2D.energy = flashlight_level / 100
		change_flashlight_lvl(delta)
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
	
	## TODO: FIX PUSHING
	
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
	tween.connect("finished", on_tween_finished)

func on_tween_finished():
	$Dash_Duration.start()

func _on_dash_duration_timeout():
	var tween = create_tween()
	tween.tween_property($Sprite2D, "scale", Vector2(.05, .05), .3) \
	.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	is_dashing = false

# Flashlight

func change_flashlight_lvl(delta):
	flashlight_time_passed += delta
	#print(flashlight_level)
	if is_in_light:
		flashlight_level += flashlight_change_rate
		flashlight_level = clamp(flashlight_level, 0, 100)
		flashlight_time_passed = 0.0
	
	elif flashlight_time_passed >= flashlight_change_interval:
		flashlight_level -= flashlight_change_rate
		flashlight_level = clamp(flashlight_level, 0, 100)
		flashlight_time_passed = 0.0
		if $FlashlightBox/Flashlight.energy <= 0:
			print("game over")

func light_raycast():
	var current_closest_distance = 1000
	var current_closest_light_node = null
	
	for i in global.LIGHTS.size():
		if global.LIGHTS[i].global_position.distance_to(global_position) <  current_closest_distance:
			current_closest_distance = global.LIGHTS[i].global_position.distance_to(global_position)
			current_closest_light_node = global.LIGHTS[i]
			light_ray.target_position = (global.LIGHTS[i].global_position - light_ray.global_position).limit_length(100)
			
	if light_ray.is_colliding() and light_ray.get_collider().is_in_group("light"):
		is_in_light = true
	else:
		is_in_light = false

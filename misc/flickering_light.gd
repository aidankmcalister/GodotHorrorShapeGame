extends Node2D

#@onready var ray = $Ray

#@onready var player = get_node("/root/Main/CanvasGroup/Player")
#var ray_length = 96


func _process(_delta):
	#var to_player = player.global_transform.origin - global_transform.origin
	#ray.target_position = to_player.normalized() * ray_length
	#if to_player < Vector2(110, 110):
		#print(ray.get_collider())
		#if ray.is_colliding() and ray.get_collider() == player:
			#player.is_in_light = true
		#else:
			#player.is_in_light = false
	pass

func _on_flicker_timer_wait_timeout():
	var tween = create_tween()
	$flicker_timer_duration.wait_time = randf_range(0.1, 0.3)
	$flicker_timer_duration.start()
	tween.tween_property($PointLight2D, "energy", randf_range(0.4, 0.7), .02)

func _on_flicker_timer_duration_timeout():
	var tween = create_tween()
	tween.tween_property($PointLight2D, "energy", 1.0, .02)
	$flicker_timer_wait.wait_time = randf_range(0.5, 1.0)
	$flicker_timer_wait.start()

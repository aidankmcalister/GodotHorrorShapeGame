extends Node2D

@onready var ray = $Ray

@onready var player = get_node("/root/Main/CanvasGroup/Player")
var ray_length = 96

func _process(delta):
	var to_player = player.global_transform.origin - global_transform.origin
	ray.target_position = to_player.normalized() * ray_length
	if ray.is_colliding() && ray.get_collider() == player:
		print("yes")

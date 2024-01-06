extends StaticBody2D

@onready var player = get_node("/root/Main/CanvasGroup/Player")

func _physics_process(delta):
	if player.is_dashing:
		$CollisionShape2D.set_deferred("disabled", true)
	else:
		$CollisionShape2D.set_deferred("disabled", false)

#func _on_area_2d_body_entered(body):
	#if body.is_in_group("player"):
		#if body.is_dashing:
			#collision_box.set_deferred("disabled", true)
			#print(collision_box.is_disabled())

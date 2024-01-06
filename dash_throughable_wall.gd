extends StaticBody2D

@onready var player = get_node("/root/Main/CanvasGroup/Player")

func _physics_process(_delta):
	if player.is_dashing:
		$CollisionShape2D.set_deferred("disabled", true)
	else:
		$CollisionShape2D.set_deferred("disabled", false)

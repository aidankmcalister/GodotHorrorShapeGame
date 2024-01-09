extends Area2D

@onready var player = get_node('/root/Main/CanvasGroup/Player')

func _process(delta):
	rotate(1)

func _on_body_entered(body):
	if body == player:
		player.has_dash = true
		tweens()
		$Timer.start()

func tweens():
	var tween = create_tween()
	var tween2 = create_tween()
	tween.tween_property($Sprite2D, "scale", Vector2(0.04, 0.04), .2) \
	.set_trans(Tween.TRANS_CUBIC)
	tween2.tween_property($PointLight2D, "energy", 1, .2) \
	.set_trans(Tween.TRANS_BOUNCE)
	
	tween.tween_property($Sprite2D, "scale", Vector2(0, 0), .2) \
	.set_trans(Tween.TRANS_CUBIC)
	tween2.tween_property($PointLight2D, "energy", 0, .2) \
	.set_trans(Tween.TRANS_BOUNCE)

func _on_timer_timeout():
	queue_free()

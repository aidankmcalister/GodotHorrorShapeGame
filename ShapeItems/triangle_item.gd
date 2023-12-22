extends RigidBody2D

var shape = "triangle"

func handle_consumed():
	queue_free()

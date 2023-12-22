extends RigidBody2D

var shape = "square"

func handle_consumed():
	queue_free()

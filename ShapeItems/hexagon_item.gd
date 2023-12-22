extends RigidBody2D

var shape = "hexagon"

func handle_consumed():
	queue_free()

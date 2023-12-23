extends RigidBody2D

@onready var player = get_parent().get_node("Player")

var shape = "hexagon"

func handle_consumed():
	queue_free()

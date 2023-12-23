extends RigidBody2D

@onready var player = get_parent().get_node("Player")

var shape = "square"

func push_movement():
	print("pushing square")

func handle_consumed():
	queue_free()

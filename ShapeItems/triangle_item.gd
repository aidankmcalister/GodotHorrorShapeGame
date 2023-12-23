extends RigidBody2D

@onready var player = get_parent().get_node("Player")

var shape = "triangle"

func push_movement():
	print("pushing tringle")

func handle_consumed():
	queue_free()

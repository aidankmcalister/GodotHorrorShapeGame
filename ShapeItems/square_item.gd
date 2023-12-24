extends RigidBody2D

@onready var player = get_parent().get_parent().get_node("Player")

var shape = "square"


func handle_consumed():
	queue_free()

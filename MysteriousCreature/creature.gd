extends Node2D

var hexagon_texture = preload("res://Shapes/Hexagon.png")
var square_texture = preload("res://Shapes/Square.png")
var triangle_texture = preload("res://Shapes/Triangle.png")

@export var light_level = 1

func _ready():
	pass

func increase_light_level():
	light_level += 1
	match light_level:
		2:
			print('Lore for light level 2')
		3:
			print('Lore for light level 3')
		4:
			print('Lore for light level 4')
		5:
			print('Lore for light level 5')

func change_shape(shape_to_change):
	$Sprite2D.texture = shape_to_change
	if shape_to_change == hexagon_texture:
		$HexagonCollision.set_deferred("disabled", false)
		$TriangleCollision.set_deferred("disabled", true)
		$SquareCollision.set_deferred("disabled", true)
		$Area2D/HexagonAreaCollision.set_deferred("disabled", false)
		$Area2D/TriangleAreaCollision.set_deferred("disabled", true)
		$Area2D/SquareAreaCollision.set_deferred("disabled", true)
	if shape_to_change == square_texture:
		$HexagonCollision.set_deferred("disabled", true)
		$TriangleCollision.set_deferred("disabled", true)
		$SquareCollision.set_deferred("disabled", false)
		$Area2D/HexagonAreaCollision.set_deferred("disabled", true)
		$Area2D/TriangleAreaCollision.set_deferred("disabled", true)
		$Area2D/SquareAreaCollision.set_deferred("disabled", false)
	if shape_to_change == triangle_texture:
		$HexagonCollision.set_deferred("disabled", true)
		$TriangleCollision.set_deferred("disabled", false)
		$SquareCollision.set_deferred("disabled", true)
		$Area2D/HexagonAreaCollision.set_deferred("disabled", true)
		$Area2D/TriangleAreaCollision.set_deferred("disabled", false)
		$Area2D/SquareAreaCollision.set_deferred("disabled", true)

func _on_area_2d_body_entered(body):
	if body.is_in_group("shapes"):
		match body.shape:
			"square":
				change_shape(square_texture)
			"triangle":
				change_shape(triangle_texture)
			"hexagon":
				change_shape(hexagon_texture)
		body.handle_consumed()
		increase_light_level()

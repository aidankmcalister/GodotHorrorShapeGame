extends Node2D

var hexagon_texture = preload("res://Shapes/Hexagon 2.png")
var square_texture = preload("res://Shapes/Square2.png")
var triangle_texture = preload("res://Shapes/Triangle 2.png")

func _ready():
	change_texture(hexagon_texture)

func _process(_delta):
	pass

func change_texture(texture_to_change):
	$Sprite2D.texture = texture_to_change

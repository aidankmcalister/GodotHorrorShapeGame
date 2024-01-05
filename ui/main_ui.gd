extends Control

func _ready():
	$DialogueBox/CanvasLayer.visible = false

func _process(_delta):
	pass

func update_dialogue(text):
	$DialogueBox/CanvasLayer.visible = true
	$DialogueBox/CanvasLayer/Panel/Label.change_text(text)

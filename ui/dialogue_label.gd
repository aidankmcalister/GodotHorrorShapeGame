extends Label

@onready var canvas_layer = get_parent().get_parent()
@onready var audio_player = get_parent().get_node("AudioStreamPlayer")
@onready var timer = get_parent().get_node("Timer")

var time = 1.5
var tween = null

func _ready():
	typewriter_effect()

func _process(delta):
	pass

func typewriter_effect():
	tween = create_tween()
	tween.tween_property(self, "visible_ratio", 1.0, time).set_trans(Tween.TRANS_LINEAR)

func change_text(inputted_text):
	visible_ratio = 0.0
	text = inputted_text
	typewriter_effect()
	tween.tween_callback(timer.start)

func _on_timer_timeout():
	canvas_layer.visible = false

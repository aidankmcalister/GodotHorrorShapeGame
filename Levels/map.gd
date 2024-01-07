extends Node2D

@onready var player = get_node("/root/Main/CanvasGroup/Player")
@onready var vhs_shader = get_node("/root/Main/MainUI/Shaders/GlitchShaderCanvas/GlitchShader").material
@onready var main_ui = get_node("/root/Main/MainUI")

var vhs_range_max = 0.05 * 2.5
var vhs_ni_max = 0.009 * 2.5
var vhs_oi_max = 0.03 * 2.5
var vhs_coi_max = 1.3 * 2.5
var max_vhs_distance = 130
var shape_count = 0

func _process(_delta):
	vhs_filter()

func vhs_filter():
	var distance = $DepositZone/Area2D/DistanceChecker.global_position.distance_to(player.global_position)
	var mapped_value = round(100.0 - (clamp(distance, 0, max_vhs_distance) / max_vhs_distance) * 100.0)
	var range_value = lerp(0.0, vhs_range_max, mapped_value / 100.0)
	var ni_value = lerp(0.0, vhs_ni_max, mapped_value / 100.0)
	var oi_value = lerp(0.0, vhs_oi_max, mapped_value / 100.0)
	var coi_value = lerp(0.0, vhs_coi_max, mapped_value / 100.0)
	vhs_shader.set_shader_parameter("range", range_value)
	vhs_shader.set_shader_parameter("noiseIntensity", ni_value)
	vhs_shader.set_shader_parameter("offsetIntensity", oi_value)
	vhs_shader.set_shader_parameter("colorOffsetIntensity", coi_value)

func _on_area_2d_body_entered(body):
	if body.is_in_group("shapes"):
		var text = null
		body.handle_consumed()
		shape_count += 1
		match shape_count:
			1: text = "Thank you, little one."
			2: text = "Yøur efforts are appre¢iated"
			3: text = "More, l!†tle þµppet. F€€ð me."
			4: text = "MØR€. MØRE. MØR€."
			5: text = "F€€Ð ME ¥Øµ iN$¡GN¡FiG@NT P@WN."
		main_ui.update_dialogue(text)
		

extends Node2D

@onready var player = get_parent().get_parent().get_node("Player")
@onready var vhs_shader = get_parent().get_parent().get_parent().get_node("MainUI/Shaders/GlitchShaderCanvas/GlitchShader").material

var vhs_range_max = 0.05 * 2
var vhs_ni_max = 0.009 * 2
var vhs_oi_max = 0.03 * 2
var vhs_coi_max = 1.3 * 2
var max_vhs_distance = 130
var shape_count = 0

func _process(_delta):
	vhs_filter()

func vhs_filter():
	var distance = $DepositZone/Area2D/DistanceChecker.global_position.distance_to(player.global_position)
	var mapped_value = round(100.0 - (clamp(distance, 0, max_vhs_distance) / max_vhs_distance) * 100.0)
	print(mapped_value)
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
		body.handle_consumed()
		shape_count += 1
		match shape_count:
			1: print("Thank you, little one. Your naivety amuses me as you dance in the soft glow of ignorance.")
			2: print("Your efforts are admired, though your journey through shadows has only begun. Embrace the darkness that unfolds.")
			3: print("More, little puppet. Feed the shadows that hunger for your innocence. Your feeble light only intensifies the impending malevolence.")
			4: print("A puppet you remain, entangled in the web of your own fears. The symbols now writhe in perverse delight, mirroring the darkness within.")
			5: print("Little puppet, your light now feeds the abyss within. Symbols writhe in the ecstasy of your suffering. Welcome to the grand tapestry of despair, woven by shadows and etched in the malevolence of your own creation.")
		

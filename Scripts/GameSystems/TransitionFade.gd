extends TextureRect
class_name TransitionFade

signal screen_filled
signal transition_completed


func _ready():
	if get_child_count() == 0:
		var tween := Tween.new()
		add_child(tween)

func _start_transition_sequence(old_texture : Texture):

	var tween = $Tween as Tween
	var delay : float = 0.4
	texture = old_texture
	material = material as ShaderMaterial
	material.set("shader_param/interFactor", 0.0)
	material.set("shader_param/screenMix", 0.0)
	yield(get_tree().create_timer(delay), "timeout")

	tween.interpolate_property(material, "shader_param/interFactor", 0.0, 1.0, 1.2, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_all_completed")
	yield(get_tree().create_timer(delay), "timeout")

	emit_signal("screen_filled")
	tween.interpolate_property(material, "shader_param/screenMix", 0.0, 1.0, 0.8, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_all_completed")
	yield(get_tree().create_timer(delay), "timeout")

	texture = null
	emit_signal("transition_completed")
	print('End')
	pass

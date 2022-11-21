extends ColorRect


func _normalize_screen_position(_vec :Vector2) -> Vector2:
	return Vector2( lerp(-0.35 , 1.35, _vec.x / 1024.0), 1.0 -(_vec.y / 600.0)  )



func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and (event.pressed and not event.is_echo() ):
			var pos =  _normalize_screen_position( get_global_mouse_position() )
			material.set_shader_param( "pulseCenter" , pos)
			$Anim.stop()
			$Anim.play("_DebugPulse")
	pass

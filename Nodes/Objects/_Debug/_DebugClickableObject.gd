extends ClickableObject

func _process_input(_viewport, event, _shape):
	._process_input(_viewport, event, _shape)
	if mouse_pressed:
		print(name, " Mouse Pressed")
	pass

func _process_mouse_inside():
	._process_mouse_inside()
	print(name, " Mouse In")
	pass

func _process_mouse_out():
	._process_mouse_out()
	print(name, " Mouse Out")
	pass


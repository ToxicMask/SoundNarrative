extends ClickableObject


func _process_input(_viewport, event, _shape):
	._process_input(_viewport, event, _shape)
	if mouse_pressed:
		print("CLICK")
	pass

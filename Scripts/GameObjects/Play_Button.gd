extends ClickableObject

var hold_pressed = false


func _process_input(_viewport, event, _shape):
	._process_input(_viewport, event, _shape)
	if mouse_pressed and not hold_pressed:
		_play_tape()
	pass

func _play_tape():
	print("PLAY: TAPE")
	self.modulate = Color.darkgray
	hold_pressed = true
	yield (get_tree().create_timer(1), "timeout")
	self.modulate = Color.white
	hold_pressed = false

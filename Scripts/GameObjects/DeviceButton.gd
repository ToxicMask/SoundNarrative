extends ClickableObject
class_name DeviceButton

signal button_pressed
signal button_released

var hold_pressed = false

func _process_input(_viewport, event, _shape):
	._process_input(_viewport, event, _shape)
	if mouse_pressed and not hold_pressed:
		_press_button()
	pass

func _press_button():
	self.modulate = Color.darkgray
	hold_pressed = true
	emit_signal("button_pressed")

func _realese_button():
	self.modulate = Color.white
	hold_pressed = false
	emit_signal("button_released")

func _set_disable_hitbox(_disable : bool = true):
	$ClickArea.disabled = _disable
	if _disable:
		self.modulate = Color.darkgray
	else:
		self.modulate = Color.white

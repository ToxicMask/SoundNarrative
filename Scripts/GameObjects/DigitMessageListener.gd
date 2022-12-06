extends MessageListener
class_name DigitMessageListener

var valid_digits : String = "0123456789"

func _listen_message(digit_key):
	if digit_key in valid_digits:
		emit_signal("message_received", digit_key)
	pass

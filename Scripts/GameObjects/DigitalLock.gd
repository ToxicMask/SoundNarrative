extends AbstractLock
class_name DigitalLock

var max_password_length : int = 1 # Max size of the password
var current_password : String = ""

signal password_display(password)
signal correct_password
signal wrong_password

func _ready():
	max_password_length = key_password.length()
	if max_password_length == 0:
		print("WARNING:", get_path() , "--NO PASSWORD")
	pass

func _add_password_digit(new_digit):
	if not locked:
		return

	if current_password.length() < max_password_length:
		current_password += new_digit
		print("Digit: ",current_password)
		emit_signal("password_display", current_password)
		pass
	pass

func _clear_password():
	if not locked:
		return

	current_password = ""
	print("Clear ",current_password)
	emit_signal("password_display", current_password)
	pass

func _enter_password():
	if not locked:
		return

	var result = _check_password(current_password)
	if result :
		print("CORRECT")
		emit_signal("correct_password")
	else:
		print("WRONG")
		_clear_password()
		emit_signal("wrong_password")
	pass

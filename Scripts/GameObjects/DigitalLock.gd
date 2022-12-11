extends AbstractLock
class_name DigitalLock


signal password_display(password)
signal correct_password
signal wrong_password

export (AudioStream) var click_sample : AudioStream = null
export (AudioStream) var clear_sample : AudioStream = null
export (AudioStream) var accept_sample : AudioStream = null
export (AudioStream) var denied_sample : AudioStream = null

var max_password_length : int = 1 # Max size of the password
var current_password : String = ""

onready var sfx_player : AudioStreamPlayer = $SFXPlayer

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
		#print("Digit: ",current_password)
		sfx_player.stream = click_sample
		sfx_player.play()
		emit_signal("password_display", current_password)
		
	pass

func _clear_password():
	if not locked:
		return

	current_password = ""
	print("Clear ",current_password)
	sfx_player.stream = clear_sample
	sfx_player.play()
	emit_signal("password_display", current_password)
	pass

func _enter_password():
	if not locked:
		return

	var result = _check_password(current_password)
	if result :
		print("CORRECT")
		sfx_player.stream = accept_sample
		sfx_player.play()
		emit_signal("correct_password")
	else:
		sfx_player.stream = denied_sample
		sfx_player.play()
		print("WRONG")
		current_password = ""
		emit_signal("password_display", current_password)
		emit_signal("wrong_password")
	pass

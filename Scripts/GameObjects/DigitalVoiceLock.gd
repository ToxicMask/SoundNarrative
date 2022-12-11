extends AbstractLock
class_name DigitalVoiceLock

signal started_hearing
signal stopped_hearing

signal password_display(password)
signal correct_password
signal wrong_password


var is_hearing := false

var max_password_length : int = 1 # Max size of the password
var current_password : String = ""


# Callbacks
func _enter_tree():
	_connect_tape_recorder()
	pass

func _ready():
	max_password_length = key_password.length()
	if max_password_length == 0:
		print("WARNING:", get_path() , "--NO PASSWORD")
	pass


# Signals Connections
func _connect_tape_recorder():
	var recorder_group = get_tree().get_nodes_in_group("TapeRecorder")
	if not recorder_group.empty():
		var tape_recorder : TapeRecorder = recorder_group[0]
		if tape_recorder:
			if not tape_recorder.is_connected("tape_state_changed", self, "_check_tape_state"):
				var _err = null
				_err = tape_recorder.connect("tape_state_changed", self, "_check_tape_state")
			_check_tape_state(tape_recorder.current_tape_state)
	pass


# Checking Functions
func _check_tape_state(current_state: int):
	if not self.locked:
		return

	if $DeviceAnim.is_playing() and $DeviceAnim.current_animation == "DeviceWrongPass":
		return

	if current_state == TapeRecorder.PLAYING:
		$DeviceAnim.play("DeviceHearing")
		emit_signal("started_hearing")
	else:
		$DeviceAnim.play("DeviceNotHearing")
		emit_signal("stopped_hearing")
	pass


# Lock Functions
func _unlock():
	._unlock()
	$DeviceAnim.play("DeviceUnlocked")
	pass

func _add_password_digit(new_digit):
	if not locked:
		return

	if $DeviceAnim.is_playing() and $DeviceAnim.current_animation == "DeviceWrongPass":
		return

	if current_password.length() < max_password_length:
		current_password += new_digit
		print("Digit: ",current_password)
		emit_signal("password_display", current_password)
		pass
	
	if current_password.length() >= max_password_length:
		_enter_password()
	pass



func _clear_password():
	if not locked:
		return

	if $DeviceAnim.is_playing() and $DeviceAnim.current_animation == "DeviceWrongPass":
		return

	current_password = ""
	print("Clear ",current_password)
	emit_signal("password_display", current_password)
	pass



func _enter_password():
	if not locked:
		return
	
	if $DeviceAnim.is_playing() and $DeviceAnim.current_animation == "DeviceWrongPass":
		return

	var result = _check_password(current_password)
	if result :
		print("CORRECT")
		$DigitLabel. modulate = Color("32d728")
		$SFXPlayer.play()
		emit_signal("correct_password")
	else:
		print("WRONG")
		emit_signal("wrong_password")
		$DeviceAnim.play("DeviceWrongPass")
		yield($DeviceAnim, "animation_finished")
		var recorder_group = get_tree().get_nodes_in_group("TapeRecorder")
		if not recorder_group.empty():
			var tape_recorder : TapeRecorder = recorder_group[0]
			if tape_recorder:
				_check_tape_state(tape_recorder.current_tape_state)
		current_password = ""
		emit_signal("password_display", current_password)
	pass

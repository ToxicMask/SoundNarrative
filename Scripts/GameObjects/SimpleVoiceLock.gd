extends AbstractLock
class_name SimpleVoiceLock

signal started_hearing
signal stopped_hearing

var is_hearing := false



func _enter_tree():
	_connect_tape_recorder()
	pass

func _ready():
	$MessageListener.std_message = self.key_password
	pass

func _connect_tape_recorder():
	var recorder_group = get_tree().get_nodes_in_group("TapeRecorder")

	if not recorder_group.empty():
		print("Found it")
		var tape_recorder : TapeRecorder = recorder_group[0]
		if tape_recorder:
			if not tape_recorder.is_connected("tape_state_changed", self, "_check_tape_state"):
				var _err = null
				_err = tape_recorder.connect("tape_state_changed", self, "_check_tape_state")
			_check_tape_state(tape_recorder.current_tape_state)
	pass

func _check_tape_state(current_state: int):

	if not self.locked:
		return

	if current_state == TapeRecorder.PLAYING:
		emit_signal("started_hearing")
	else:
		emit_signal("stopped_hearing")
	pass

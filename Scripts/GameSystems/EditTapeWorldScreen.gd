extends WorldScreen
class_name EditTapeWorldScreen

"""
Debugger Input
"""

func _input(event):

	if event is InputEventKey:
		if event.is_pressed() and not event.is_echo():
			match (event.scancode):
				KEY_Q:
					$KeepDataReceiver._get_tape_data()
					pass
				KEY_W:
					$KeepDataReceiver._save_tape_data()
					pass
				KEY_E:
					$KeepDataReceiver._clear_tape_data()
					pass
	pass

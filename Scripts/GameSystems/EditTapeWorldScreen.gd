extends Node2D
class_name EditTapeWorldMenu

"""
Debugger Input
"""

func _ready():
	var _err= $KeepDataController.connect("update_data_on_receiver", self, "_report")

func _report(arg):
	print(arg)

func _input(event):

	if event is InputEventKey:
		if event.is_pressed() and not event.is_echo():
			match (event.scancode):
				KEY_Q:
					$KeepDataController._get_data("TAPE_CUSTOM")
					pass
				KEY_W:
					var new_tape = TapeKeepData.new()
					$KeepDataController._save_data(new_tape, "TAPE_CUSTOM")
					pass
				KEY_E:
					$KeepDataController._clear_data()
					pass
	pass

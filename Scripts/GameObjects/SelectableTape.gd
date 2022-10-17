extends ClickableObject
class_name SelectionTape

export(Resource) var tape_info 

signal insert_tape_selection (tape_info)

	

func _ready():
	_update_display()
	var _err = self.connect("mouse_click", self, "_emit_tape_selection")
	pass

func _emit_tape_selection(_event):
	emit_signal("insert_tape_selection", tape_info)
	pass

func _get_tape_info():
	return tape_info

func _update_display():
	tape_info = tape_info as TapeInfo
	$NameLabel.text = tape_info.name


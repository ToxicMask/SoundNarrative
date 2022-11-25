extends Node
class_name TapeRecorderController


func _get_tape_recorder():
	var recorder_array = get_tree().get_nodes_in_group("TapeRecorder")
	if not recorder_array.empty():
		return recorder_array[0]
	else:
		return null
	pass

func _hide_hud_tape_recorder():
	var tape_recorder = _get_tape_recorder() as TapeRecorder
	if tape_recorder:
		tape_recorder._hide_hud()
	pass

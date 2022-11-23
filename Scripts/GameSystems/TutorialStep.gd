extends Control
class_name TutorialStep


var current_step : int = 0

func _ready():
	var tape_recorder = get_tree().get_nodes_in_group("TapeRecorder")[0] as TapeRecorder
	if tape_recorder:
		var _err = null
		_err = tape_recorder.connect("hud_showed", self, "_check_tutorial_progress", [2])
		_err = tape_recorder.connect("eject_pressed", self, "_check_tutorial_progress", [3])
		_err = tape_recorder.connect("tape_inserted", self, "_check_tutorial_progress", [4])
	_hide_all_steps()
	pass


func _check_tutorial_progress(expected_step : int):
	if current_step == expected_step:
		_show_step(current_step+1)
	pass


func _show_step(new_step : int):
	#print("Step" + str(new_step) )
	_hide_all_steps()
	var control_node : Control = get_node_or_null("Step" + str(new_step) )
	if control_node:
		control_node.show()
		current_step = new_step
		
	pass

func _hide_all_steps():
	for c in get_children():
		c = c as CanvasItem
		c.hide()
	pass

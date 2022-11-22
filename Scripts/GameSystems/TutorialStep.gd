extends Control
class_name TutorialStep

func _ready():
	_hide_all_steps()
	pass

func _show_step(current_step : int):
	_hide_all_steps()
	var control_node : Control = get_node_or_null("Step" + str(current_step) )
	if control_node:
		control_node.show()
	pass

func _hide_all_steps():
	for c in get_children():
		c = c as CanvasItem
		c.hide()
	pass

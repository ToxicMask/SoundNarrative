extends KinematicBody2D

"""
Abstract Clickable Object

"""

class_name ClickableObject

signal mouse_click (_event)


var mouse_hover   := false
var mouse_pressed := false


func _ready():
	_set_signal_std_connections()
	pass

func _set_signal_std_connections():
	var _err= null 
	# Connect input event to here
	_err = self.connect("input_event", self, "_process_input")
	_err = self.connect("mouse_entered", self, "_process_mouse_inside")
	_err = self.connect("mouse_exited", self, "_process_mouse_out")
	pass

func _process_input(_viewport, event, _shape):
	# Mouse Click Event
	if event is InputEventMouseButton:
		if event.is_pressed(): 
			if not mouse_pressed:
				mouse_pressed = true
				emit_signal("mouse_click", event)
		elif !event.is_pressed() and mouse_pressed: # Released
			mouse_pressed = false
	pass

func _process_mouse_inside():
	mouse_hover = true
	Input.set_default_cursor_shape(Input.CURSOR_DRAG)
	pass

func _process_mouse_out():
	mouse_hover = false
	mouse_pressed = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	pass

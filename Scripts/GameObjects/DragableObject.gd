extends ClickableObject

"""
Abstract DragableObject
"""

class_name DragableObject

# Signals
signal mouse_move()

# Variables
var mouse_drag : bool = false
var can_return_to_origin : bool = true
var original_position = Vector2.ZERO


func _process_input(_viewport, event, _shape):
	._process_input(_viewport, event, _shape)
	_drag_movement_input()
	pass

func _release_object():
	self.mouse_drag = false
	if can_return_to_origin:
		_return_to_origin()

func _set_original_position(new_pos : Vector2):
	self.original_position = new_pos
	pass

func _return_to_origin():
	self.global_position = original_position
	pass

func _drag_movement_input():
	# Check if object is about to Drag
	if (mouse_drag == false) and (mouse_pressed == true):
		mouse_drag = true
		Input.set_default_cursor_shape(Input.CURSOR_MOVE)
	pass

	# Process Released drag
	if mouse_drag and not mouse_pressed:
		_release_object()
	pass

func _drag_mouse_move(delta):
	if mouse_drag:
		emit_signal("mouse_move")
		self.global_position =  lerp(self.position, get_viewport().get_mouse_position(), 50 * delta)
	pass

func _process_mouse_inside():
	._process_mouse_inside()
	pass

func _process_mouse_out():
	._process_mouse_out()
	_release_object()
	pass

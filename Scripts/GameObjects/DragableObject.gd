extends ClickableObject

class_name DragableObject


signal mouse_move()

var mouse_drag : bool = false
var can_return_to_origin : bool = true

var original_position = Vector2.ZERO


func _ready():
	original_position = self.global_position
	pass 

func _process_input(_viewport, event, _shape):
	._process_input(_viewport, event, _shape)

	# Check if object is about to Drag
	if (mouse_drag == false) and (mouse_pressed == true):
		mouse_drag = true
		Input.set_default_cursor_shape(Input.CURSOR_MOVE)
		if DEBUG:
			print("Drag")

	# Process Released drag
	if mouse_drag and not mouse_pressed:
		release_object()


	pass

# Process Phycys
func _process(delta):
	# Process Drag
	if mouse_drag:
		emit_signal("mouse_move")
		self.global_position =  lerp(self.position, get_viewport().get_mouse_position(), 50* delta)
	pass

func release_object():
	mouse_drag = false
	if can_return_to_origin:
		_return_to_origin()


func _return_to_origin():
	self.global_position = original_position


func _process_mouse_inside():
	._process_mouse_inside()
	pass

func _process_mouse_out():
	._process_mouse_out()
	release_object()
	pass

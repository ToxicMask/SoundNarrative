extends DragableObject

func _ready():
	_set_original_position(self.global_position)
	pass

func _process(delta):
	_drag_mouse_move(delta)
	pass


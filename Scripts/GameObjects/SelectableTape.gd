extends ClickableObject
class_name SelectionTape

export(Resource) var tape_info 

signal insert_tape_selection (tape_info)

func _enter_tree():
	_update_display()
	pass


func _ready():
	$Sprite.material = $Sprite.material.duplicate()
	var _err = self.connect("mouse_click", self, "_emit_tape_selection")
	pass

func _emit_tape_selection():
	emit_signal("insert_tape_selection", tape_info)
	pass

func _get_tape_info():
	return tape_info

func _update_display():
	tape_info = tape_info as TapeInfo
	$NameLabel.text = tape_info.name
	$Sprite.modulate = tape_info.tape_color

func _process_mouse_inside():
	._process_mouse_inside()
	$Sprite.material.set_shader_param("line_color", Color.white)
	pass

func _process_mouse_out():
	._process_mouse_out()
	$Sprite.material.set_shader_param("line_color", Color.transparent)
	pass


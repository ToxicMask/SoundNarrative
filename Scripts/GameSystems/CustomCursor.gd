extends Node
class_name CustomCursor

export (Texture) var  mouse_texture : Texture
export (Texture) var  click_texture : Texture

var click_pressed : bool = false


func _ready():
	Input.set_custom_mouse_cursor(mouse_texture)
	pass


func _input(event):
	
	if event is InputEventMouseButton:
		if event.is_pressed() and not click_pressed:
			click_pressed = true
			Input.set_custom_mouse_cursor(click_texture)
		elif not event.is_pressed() and click_pressed:
			click_pressed = false
			Input.set_custom_mouse_cursor(mouse_texture)
	pass

extends "res://Scripts/GameObjects/ClickableObject.gd"

class_name DragableObject

var mouse_hold : bool = false

export var return_to_origin : = false

var original_position = Vector2.ZERO


func _ready():
	original_position = self.global_position
	pass 

func process_input(_viewport, event, _shape):
	.process_input(_viewport, event, _shape)
	
	if mouse_pressed:
		self.global_position = get_viewport().get_mouse_position()
	
	elif return_to_origin:
		self.global_position = original_position


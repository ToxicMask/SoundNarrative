extends KinematicBody2D

class_name ClickableObject

const DEBUG = true

signal mouse_click (_event)
signal mouse_move (_event)

var mouse_hover   := false
var mouse_pressed := false

func _ready():
	print(name)
	var _err= self.connect("input_event", self, "process_input")
	# Connect input event to here
	pass

func process_input(_viewport, event, _shape):
	
	# Mouse Click Event
	if event is InputEventMouseButton:
		if event.is_pressed(): 
			if not mouse_pressed:
				mouse_pressed = true
				emit_signal("mouse_move", event)
				if DEBUG:
					print("Just Clicked")
			else:
				if DEBUG:
					print("StillClicking")
				pass
		elif !event.is_pressed() and mouse_pressed: # Released
			mouse_pressed = false
			if DEBUG:
				print("Just Released")
		
		#print ("Mouse pressed =%s".replace("%s", str(mouse_pressed)))
	
	# Mouse Move
	elif event is InputEventMouseMotion:
		if DEBUG:
			print("%sJust Moved!"%get_tree().get_frame())
	pass

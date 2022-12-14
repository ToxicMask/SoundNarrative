extends Node
class_name ScreenControl

"""
Control Screen Settings
"""

func _enter_tree():
	#Delete on Web
	if OS.has_feature('web'):
		self.queue_free()
		print("FULLSCREEN DELETED")
	
	# Standalone on desktop
	elif OS.has_feature('pc') and OS.has_feature('standalone'):
		OS.window_fullscreen = true
	pass

func _input(event):
	if event is InputEventKey:
		if event.is_pressed() and not event.echo:
			if event.scancode == KEY_F11:
				OS.window_fullscreen = not OS.window_fullscreen
	pass

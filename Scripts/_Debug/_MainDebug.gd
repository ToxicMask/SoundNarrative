extends Node2D
class_name _MainDebug


var active : bool = false
var main_parent : Main = null

func _ready():
	if not get_parent() is Main or not OS.is_debug_build():
		print( self.get_path() , " Deleted")
		self.queue_free()
	else:
		main_parent = get_parent()


func _input(event):
	# Input Event Key
	if not event is InputEventKey:
		return


	# Just Pressed
	if event.is_pressed() and (not event.is_echo()):
		# Set Active Debug
		if  event is InputEventWithModifiers:
			# F12 + Ctrl+ Alt
			if event.scancode == KEY_F12 and event.alt:
				active = !active
				print("DEBUG ACTIVE: ", active)
		
		if active:
			match(event.scancode):
				KEY_1:
					print("CHANGE SCENE: World0")
					main_parent._change_world_scene("World0")
				KEY_2:
					print("CHANGE SCENE: World1")
					main_parent._change_world_scene("World1")
				KEY_3:
					print("CHANGE SCENE: World2")
					main_parent._change_world_scene("World2")
				KEY_4:
					print("CHANGE SCENE: World3")
					main_parent._change_world_scene("World3")
				
				KEY_0:
					print("CHANGE SCENE: Test0")
					main_parent._change_world_scene("TEST0")
				KEY_9:
					print("CHANGE SCENE: Test1")
					main_parent._change_world_scene("TEST1")
	pass

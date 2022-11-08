extends Node2D
class_name Main


#Execute Function of Game Manager
#	Uses to Start and End The Game
#	Set Play Variablens ()
#	Change WorldScreens & Menus



# Game Systems

# HUDs
export (PackedScene) var tape_recorder_packed: PackedScene


# World Scenes
export (Dictionary) var world_scene_dict: Dictionary
var current_world_scene_key := ""


"""
Callbacks
"""
func _ready():
	_add_keep_data()
	_change_world_scene("MainMenu")
	pass


"""
OS Operations
"""

func _start_new_game():
	_change_world_scene("StartGame")
	pass

func _quit_app():
	get_tree().quit()
	pass


"""
Add Direct Children
"""

func _add_tape_recorder_hud():
	if self.has_node("TapeRecorder"):
		return
	var instance =  tape_recorder_packed.instance()
	var _err = null
	add_child(instance)
	pass

	
func _add_keep_data():
	if self.has_node("KeepDataManager"):
		return
	var new_instance = KeepDataManager.new()
	add_child(new_instance)
	pass


"""
Scene Managment
"""

func _change_world_scene(world_key : String):
	get_tree().call_group("DeleteOnChangeScene","queue_free")
	if world_scene_dict.has(world_key):
		#print("NEW_SCENE: ", world_key)
		current_world_scene_key = world_key
		var new_world = world_scene_dict[current_world_scene_key].instance() 
		add_child(new_world)
	else:
		print( "@%s::%s is not in Dictionary." % [get_path(), world_key] )
	pass


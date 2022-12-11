extends Node2D
class_name Main


#Execute Function of Game Manager
#	Uses to Start and End The Game
#	Set Play Variables ()
# Add and Remove Tape Recorder From Scene
#	Change WorldScreens & Menus



# Game Systems

# HUDs
export (PackedScene) var tape_recorder_packed: PackedScene


# World Scenes
export (Dictionary) var world_scene_dict: Dictionary
var current_world_scene_key := ""

# Transition Elements
onready var fade_rect = $ScreenVisualEffects/TransitionFade as TransitionFade

"""
Callbacks
"""
func _ready():
	_change_world_scene("MainMenu", false)
	_add_keep_data()
	pass


"""
Scene // OS Operations
"""

func _start_new_game():
	_change_world_scene("StartGame", false)
	pass

func _go_to_credits():
	_change_world_scene("Credits", false)
	pass

func _quit_app():
	get_tree().quit()
	pass


"""
Manage Direct Children
// Global Game Data
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

func _clear_game_data():
	var delete_array = ["TapeRecorder"]
	for d in delete_array:
		_remove_main_child(d)
	var keep_data = get_node_or_null("KeepDataManager") as KeepDataManager
	if keep_data:
		keep_data._clear_data()
		
	pass

func _remove_main_child(name : String):
	var node = self.get_node_or_null(name)
	if node != null:
		self.remove_child(node)
		node.queue_free()
	pass

"""
Scene Managment
"""

func _change_world_scene(world_key : String, with_transition : bool = true):
	if world_scene_dict.has(world_key):
		if with_transition:
			# Screen Shoot
			fade_rect.mouse_filter = Control.MOUSE_FILTER_STOP
			var screen_shot = _create_screen_shot()
			fade_rect._start_transition_sequence(screen_shot)
			get_tree().call_group("DeleteOnChangeScene","queue_free")
			yield(fade_rect, "screen_filled")

			# Change World
			current_world_scene_key = world_key
			var new_world = world_scene_dict[current_world_scene_key].instance() 
			add_child(new_world)
			yield(fade_rect, "transition_completed")

			# Return to Normal
			fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
			
		else:
			# Delete Old World
			get_tree().call_group("DeleteOnChangeScene","queue_free")
			
			# Change World
			current_world_scene_key = world_key
			var new_world = world_scene_dict[current_world_scene_key].instance() 
			add_child(new_world)
			

	else:
		print( "@%s::%s is not in Dictionary." % [get_path(), world_key] )
	pass


func _create_screen_shot() -> Texture:
	var img = get_viewport().get_texture().get_data()
	img.flip_y()
	var tex = ImageTexture.new()
	tex.create_from_image(img)
	return tex

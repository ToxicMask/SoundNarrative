extends Node2D
class_name Main

"""
Execute Function of Game Manager

Uses to Start and End The Game

Set Play Variablens ()

Change WorldScenes & Menus

ManageHud Elements

"""
# Menus
export (PackedScene) var main_menu_packed : PackedScene
# HUDs
export (PackedScene) var tape_recorder_packed: PackedScene


# World Scenes
export (PackedScene) var test0_world : PackedScene
export (PackedScene) var test1_world : PackedScene
onready var world_scene_dict: Dictionary = {
	"TEST0": test0_world,
	"TEST1": test1_world,
}
var current_world_scene_key := ""


# Callbacks
func _ready():
	_add_start_menu()
	_change_world_scene("MainMenu")
	pass


func _change_world_scene(world_key : String):
	if world_scene_dict.has(world_key):
		#print("NEW_SCENE: ", world_key)
		get_tree().call_group("WorldScene","queue_free")
		get_tree().call_group("DeleteOnChangeScene","queue_free")
		current_world_scene_key = world_key
		var new_world = world_scene_dict[current_world_scene_key].instance() 
		add_child(new_world)
	else:
		print( "@%s::%s is not in Dict." % [get_path(), world_key] )
	pass


func _start_new_game():
	var menu_node = get_node_or_null("MainMenu")
	if menu_node:
		menu_node.queue_free()
	_change_world_scene("TEST1")
	pass

func _quit_app():
	get_tree().quit()
	pass



func _add_start_menu():
	var instance =  main_menu_packed.instance()
	var _err = null
	_err = instance.connect("new_game", self, "_start_new_game")
	_err = instance.connect("close_app", self, "_quit_app")
	add_child(instance)
	pass


func _add_tape_recorder_hud():
	var instance =  tape_recorder_packed.instance()
	var _err = null
	add_child(instance)
	pass
	

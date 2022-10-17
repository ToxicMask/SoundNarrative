extends Node2D
class_name Main

"""
Execute Function of Game Manager

Uses to Start and End The Game

Set Play Variablens ()

Change WorldScenes & Menus

ManageHud Elements

"""

export (PackedScene) var main_menu_packed : PackedScene
export (PackedScene) var tape_recorder_packed: PackedScene

export (Dictionary) var world_scene_dict: Dictionary
var current_world_scene_key := ""


func _ready():
	_add_start_menu()
	_change_world_scene("MainMenu")
	pass


func _change_world_scene(world_key : String):
	print("NEW_SCENE: ", world_key)
	if world_scene_dict.has(world_key):
		get_tree().call_group("WorldScene","queue_free")
		current_world_scene_key = world_key
		var new_world = world_scene_dict[current_world_scene_key].instance() 
		add_child(new_world)
	pass


func _start_new_game():
	var menu_node = get_node_or_null("MainMenu")
	if menu_node:
		menu_node.queue_free()
	_change_world_scene("HELLO")
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
	

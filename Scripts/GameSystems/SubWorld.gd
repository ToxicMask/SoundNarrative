extends Node2D
class_name SubWorld


var world_node : WorldScreen

signal sub_world_changed(new_index)

func _subworld_enter():
	$SoundController._update_sound_mixer()
	pass


func _change_sub_world(new_index : int):
	emit_signal("sub_world_changed", new_index)
	pass

func _go_to_next_scene(scene_id):
	if world_node:
		world_node._go_to_next_scene(scene_id)
	else:
		print("NULL WORLD NODE")
	pass

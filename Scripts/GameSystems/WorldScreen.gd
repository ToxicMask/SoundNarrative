extends Node2D
class_name WorldScreen


func _enter_tree():
	self.add_to_group("DeleteOnChangeScene")
	pass

func _go_to_next_scene(scene_id : String):
	var tape_control = _get_tape_recorder_controller()
	if tape_control:
		tape_control._hide_hud_tape_recorder()
	get_tree().call_group("Main", "_change_world_scene", scene_id)
	pass

func _get_tape_recorder_controller():
	return get_node_or_null("TapeRecorderController")

func _get_sound_controller():
	return get_node_or_null("SoundController")

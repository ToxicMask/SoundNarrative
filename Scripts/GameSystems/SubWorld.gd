extends Node2D
class_name SubWorld

signal next_scene()
signal sub_world_changed(new_index)


func _change_sub_world(new_index : int):
	emit_signal("sub_world_changed", new_index)
	pass

func _go_to_next_scene():
	emit_signal("next_scene")
	pass

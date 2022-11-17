extends Node2D
class_name SubWorld


signal sub_world_changed(new_index)


func _change_sub_world(new_index : int):
	emit_signal("sub_world_changed", new_index)
	pass


extends Node2D
class_name WorldScreen


func _enter_tree():
	self.add_to_group("DeleteOnChangeScene")
	pass

func _ready():
	var main = get_parent() as Main

	main._add_tape_recorder_hud()


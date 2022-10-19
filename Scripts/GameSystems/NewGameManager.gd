extends Node
class_name NewGameManager

export (Array, Resource) var tape_files =  []

func _ready():
	_set_new_game_data()
	pass

func _set_new_game_data():
	
	for i in range(tape_files.size()):
		var data_node = TapeKeepData.new()
		var tape_info = tape_files[i]
		if tape_info:
			data_node.tape_info = tape_info
			$KeepDataController._save_data(data_node, "TAPE_%d" %[i])
	pass

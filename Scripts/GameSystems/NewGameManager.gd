extends Node
class_name NewGameManager


var keep_data_array : Array = []

func _ready():
	_prepare_new_game_data()
	pass

func _prepare_new_game_data():
	var new_node = TapeInventoryKeepData.new()
	new_node.name = "TapeInventoryKeepData"
	new_node.unlocked_tape_id = ["Evil Laugh"]
	new_node.has_custom_tape = true
	new_node.custom_tape_info = TapeInfo.new()
	new_node.custom_tape_info.name = "Custom Tape"
	keep_data_array.append(new_node)
	pass

func _set_new_game_data():
	# Add Prepared data
	for i in range(keep_data_array.size()):
		var keep_node = keep_data_array[i] as Node
		$KeepDataController._save_data(keep_node, keep_node.name)
	pass

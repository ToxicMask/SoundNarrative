extends Node
class_name NewGameManager

# Node to create and add Player Data to Keep Data
# 	Requires KeepDataController as child
#	Create if child requirements are not found



var keep_data_array : Array = []

func _ready():
	# Node Setups
	if get_node_or_null("KeepDataController") == null:
		var new_data_controller = KeepDataController.new()
		new_data_controller.name = "KeepDataController"
		new_data_controller.receiver_id = self.name
		self.add_child(new_data_controller)
	
	# Setup
	_prepare_new_game_data()
	pass

func _prepare_new_game_data():
	var new_node = TapeInventoryKeepData.new()
	new_node.name = "TapeInventoryKeepData"
	new_node.unlocked_tape_id = []
	new_node.has_custom_tape = false
	new_node.custom_tape_info = TapeInfo.new()
	new_node.custom_tape_info.name = "Custom_Tape"
	keep_data_array.append(new_node)
	pass

func _set_new_game_data():
	# Add Prepared data
	for i in range(keep_data_array.size()):
		var keep_node = keep_data_array[i] as Node
		$KeepDataController._save_data(keep_node, keep_node.name)
	pass

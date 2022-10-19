extends WorldScreen
class_name EditTapeWorldScreen

func _enter_tree():
	self.add_to_group("KeepDataReceiver")

func _input(event):

	if event is InputEventKey:
		if event.is_pressed() and not event.is_echo():
			match (event.scancode):
				KEY_G:
					_get_tape_data()
					pass
				KEY_S:
					_save_tape_data()
					pass
				KEY_C:
					_clear_tape_data()
					pass


func _get_tape_data():
	print("GET DATA SAVED")
	get_tree().call_group("KeepDataManager", "_update_data_to_receiver", "CUSTOM_TAPE", self.name)
	pass

func _save_tape_data():
	print("TAPE DATA SAVED")
	var new_info = Node2D.new()
	new_info.name = "CUSTOM_TAPE"
	get_tree().call_group("KeepDataManager", "_set_data", new_info)
	pass

func _clear_tape_data():
	get_tree().call_group("KeepDataManager", "_clear_data")
	pass

func _update_data (data_node: Node, receiver_name : String):
	if self.name != receiver_name:
		return
	print(data_node)
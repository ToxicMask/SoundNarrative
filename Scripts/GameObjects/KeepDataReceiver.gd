extends Node
class_name KeepDataReceiver
	

signal update_data_on_receiver(data_node)

export (String) var data_node_id : String = "CUSTOM_TAPE"
export (String) var receiver_id : String = "Receiver"

"""
Data Receiver Data Functions
"""

func _enter_tree():
	self.add_to_group("KeepDataReceiver")

func _get_tape_data():
	print("GET DATA SAVED")
	get_tree().call_group("KeepDataManager", "_update_data_to_receiver", "CUSTOM_TAPE", self.receiver_id)
	pass

func _save_tape_data():
	print("TAPE DATA SAVED")
	var data_node = EditTapeKeepData.new()
	get_tree().call_group("KeepDataManager", "_set_data", data_node, data_node_id)
	pass

func _clear_tape_data():
	print("TAPE DATA CLEARED")
	get_tree().call_group("KeepDataManager", "_clear_data")
	pass

func _update_data (data_node: Node, _receiver_id : String):
	if self.receiver_id != _receiver_id:
		return
	emit_signal("update_data_on_receiver", data_node)
	print(data_node)

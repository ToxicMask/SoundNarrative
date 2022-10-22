extends Node
class_name KeepDataController

# Node to control interactions with Keep Data Node on Main

signal update_data_on_receiver(data_node)

export (String) var receiver_id : String = ""

"""
Data Receiver Data Functions
"""

func _enter_tree():
	self.add_to_group("KeepDataReceiver")

func _get_data(data_node_id : String):
	get_tree().call_group("KeepDataManager", "_update_data_to_receiver", data_node_id, self.receiver_id)
	pass

func _save_data(data_node : Node, data_node_id: String):
	get_tree().call_group("KeepDataManager", "_set_data", data_node, data_node_id)
	pass

func _clear_data():
	get_tree().call_group("KeepDataManager", "_clear_data")
	pass

func _update_data (data_node: Node, _receiver_id : String):
	if self.receiver_id != _receiver_id:
		return
	emit_signal("update_data_on_receiver", data_node)
	pass

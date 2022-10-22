extends Node2D
class_name KeepDataManager


#KeepData - Container
#	Serves to Keep Data Between Changes Scenes
#	Preference to be child of "Main"

func _init():
	self.name = "KeepDataManager"
	pass

func _enter_tree():
	add_to_group("KeepDataManager")
	pass

func _set_data(data_node: Node, data_id : String):

	if data_node.is_inside_tree():
		print("ERROR: NODE INSIDE TREE")
		return

	# Create new instance if not exist
	data_node.name = data_id
	var _node = get_node_or_null(data_node.name)
	if _node:
		remove_child(_node)
		add_child(data_node)
		_node.queue_free()
	else:
		add_child(data_node)


func _clear_data():
	for c in get_children():
		c = c as Node
		c.queue_free()


func _update_data_to_receiver(data_name : String, receiver_name: String):
	var data_node = get_node_or_null(data_name)
	if data_node != null:
		get_tree().call_group("KeepDataReceiver", "_update_data", data_node, receiver_name)


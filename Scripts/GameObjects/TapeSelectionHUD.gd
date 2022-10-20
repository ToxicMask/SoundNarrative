extends Node2D
class_name TapeSelectionHUD


func _ready():
	# Update Unlocked Tapes
	$KeepDataController._get_data("TapeInventoryKeepData")
	pass

func _update_tape_data(data_node: Node):
	print("TAPE RECEIVED ", data_node.name)

	if data_node is TapeInventoryKeepData:
		data_node = data_node as TapeInventoryKeepData
		var unlocked_list = data_node.unlocked_tape_id as Array
		# Check each child
		for c in get_children():
			if c is SelectionTape:
				c = c as SelectionTape
				var tape_name = c.tape_info.name
				if unlocked_list.has(tape_name) and tape_name != "CustomTape":
					print("SHOW ", c)
					c.show()
				else:
					print("HIDE ", c)
					c.hide()
		
		if data_node.has_custom_tape:
			var custom = self.get_node("CustomTape") as SelectionTape
			custom.show()
			custom.tape_info = data_node.custom_tape_info
			custom._update_display()
		else:
			var custom = self.get_node("CustomTape") as SelectionTape
			custom.hide()
			print("HIDE ", custom)

	pass

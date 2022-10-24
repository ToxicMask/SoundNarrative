extends ClickableObject


export (String) var tape_id : String = "INSERT_TITLE"
export (bool) var custom_tape : bool = false


func _ready():
	#._ready()
	var _err = self.connect("mouse_click", self, "_try_update_data")
	_err = $KeepDataController.connect("update_data_on_receiver", self, "_update_keep_data")
	# Config Name
	$KeepDataController.receiver_id = $KeepDataController.receiver_id + str(self.get_instance_id())
	pass


func _process(_delta):
	# Mouse Hover
	if mouse_hover:
		self.modulate = Color.royalblue
	else:
		self.modulate = Color.white
	pass


func _process_input(_viewport, event, _shape):
	._process_input(_viewport, event, _shape)
	pass

func _try_update_data(_event):
	print("TRY TO UPDATE")
	$KeepDataController._get_data("TapeInventoryKeepData")
	pass

func _update_keep_data(data_node : Node):
	
	if data_node is TapeInventoryKeepData:
		data_node = data_node as TapeInventoryKeepData
		print("UPDATED : ", data_node)
		print(data_node.name)
		if custom_tape and not data_node.unlocked_tape_id.has(tape_id):
			data_node.has_custom_tape = true
			data_node.unlocked_tape_id.append("CUSTOM_TAPE")
			data_node.custom_tape_info = TapeInfo.new()
		elif not data_node.unlocked_tape_id.has(tape_id):
			data_node.unlocked_tape_id.append(tape_id)
	pass
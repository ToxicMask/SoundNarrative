extends ClickableObject


export (String) var tape_id : String = "INSERT_TITLE"
export (bool) var custom_tape : bool = false

export (Color) var normal_color : Color = Color.white
export (Color) var hover_color : Color = Color.gray

func _ready():
	#._ready()
	var _err = self.connect("mouse_click", self, "_pick_up")
	_err = $KeepDataController.connect("update_data_on_receiver", self, "_update_keep_data")
	# Config Name
	$KeepDataController.receiver_id = $KeepDataController.receiver_id + str(self.get_instance_id())
	pass


func _process(_delta):
	# Mouse Hover
	if mouse_hover:
		self.modulate = hover_color 
	else:
		self.modulate = normal_color
	pass


func _process_input(_viewport, event, _shape):
	._process_input(_viewport, event, _shape)
	pass

func _pick_up(_event = null):
	_try_update_data()
	self.hide()
	$PickUpSFX.play()
	yield(get_tree().create_timer(1.1), "timeout")
	queue_free()
	pass

func _try_update_data():
	#print("TRY TO UPDATE")
	$KeepDataController._get_data("TapeInventoryKeepData")
	pass

func _update_keep_data(data_node : Node):
	
	if data_node is TapeInventoryKeepData:
		data_node = data_node as TapeInventoryKeepData
		#print("UPDATED : ", data_node)
		#print(data_node.name)
		if custom_tape and not data_node.unlocked_tape_id.has(tape_id):
			data_node.has_custom_tape = true
			data_node.unlocked_tape_id.append("CUSTOM_TAPE")
			data_node.custom_tape_info = TapeInfo.new()
			data_node.custom_tape_info.name = "CUSTOM"
		elif not data_node.unlocked_tape_id.has(tape_id):
			data_node.unlocked_tape_id.append(tape_id)
	pass

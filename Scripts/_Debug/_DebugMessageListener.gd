extends MessageListener
class_name _DebugMessageListener


func _listen_message(msg_key):
	print("%s - Key Received: %s" % [name, msg_key])
	pass
extends Node



func _ready():
	if not self.is_in_group("MessageListener"):
		self.add_to_group("MessageListener")
	pass 

func _listen_message(msg_key):
	print("%s - Key Received: %s" % [name, msg_key])
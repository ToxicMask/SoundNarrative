extends Node
class_name MessageListener

signal message_received()
export (String) var std_message : String = "INSERT_MESSAGE"

func _ready():
	if not self.is_in_group("MessageListener"):
		self.add_to_group("MessageListener")
	pass 

func _listen_message(msg_key):
	if str(msg_key) == std_message:
		emit_signal("message_received")
	pass


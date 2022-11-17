extends Node2D
class_name AbstractLock

signal unlocked

var locked : bool = true

export (String) var key_password : String = "";


func _check_password(password) -> bool:
	if key_password == password:
		_unlock();
		return true
	else:
		return false
	pass


func _unlock():
	if locked:
		locked = false
		emit_signal("unlocked")
	pass
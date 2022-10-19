extends WorldScreen
class_name StarGameScreen

func _next_scene():
	get_tree().call_group("Main", "_change_world_scene", "World1")
	pass

extends WorldScreen
class_name CreditsScreen


func _next_scene():
	get_tree().call_group("Main", "_change_world_scene", "MainMenu", false)
	pass

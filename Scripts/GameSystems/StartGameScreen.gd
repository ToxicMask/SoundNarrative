extends WorldScreen
class_name StarGameScreen

func _next_scene():
	$NewGameManager._set_new_game_data()
	get_tree().call_group("Main", "_change_world_scene", "TEST1")
	pass

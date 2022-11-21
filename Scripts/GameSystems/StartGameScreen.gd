extends WorldScreen
class_name StarGameScreen

func _next_scene():
	$NewGameManager._set_new_game_data()
	get_tree().call_group("Main", "_add_tape_recorder_hud")
	get_tree().call_group("Main", "_change_world_scene", "Scene0")
	pass

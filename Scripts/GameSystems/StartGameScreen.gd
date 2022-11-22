extends WorldScreen
class_name StarGameScreen

func _go_to_next_scene(scene_id):
	get_tree().call_group("Main", "_add_tape_recorder_hud")
	$NewGameManager._set_new_game_data()
	._go_to_next_scene(scene_id) # Do the scene Transition
	pass

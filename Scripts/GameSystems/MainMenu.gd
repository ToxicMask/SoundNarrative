extends CanvasLayer
class_name MainMenu



func _start_new_game():
	get_tree().call_group("Main", "_start_new_game")
	pass

func _close_app():
	get_tree().call_group("Main", "_quit_app")
	pass

extends CanvasLayer
class_name MainMenu


func _enter_tree():
	get_tree().call_group("Main", "_clear_game_data")
	pass


func _start_new_game():
	get_tree().call_group("Main", "_start_new_game")
	pass
	
func _go_to_credits():
	get_tree().call_group("Main", "_go_to_credits")
	pass

func _close_app():
	get_tree().call_group("Main", "_quit_app")
	pass

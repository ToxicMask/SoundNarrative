extends CanvasLayer
class_name MainMenu



func _start_new_game():
	get_tree().call_group("Main", "_start_new_game")
	pass

func _close_app():
	get_tree().call_group("Main", "_quit_app")
	pass


func _on_PlayButton_pressed():
	_start_new_game()
	pass 


func _on_QuitButton_pressed():
	_close_app()
	pass 

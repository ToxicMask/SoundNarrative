extends CanvasLayer
class_name MainMenu

signal new_game
signal close_app


func _start_new_game():
	emit_signal("new_game")
	pass

func _close_app():
	emit_signal("close_app")
	pass


func _on_PlayButton_pressed():
	_start_new_game()
	pass 


func _on_QuitButton_pressed():
	_close_app()
	pass 

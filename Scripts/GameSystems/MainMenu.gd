extends Node
class_name MainMenu

export (Array, Texture) var random_textures = []

func _enter_tree():
	if self.is_in_group("DeleteOnChangeScene"):
		self.add_to_group("DeleteOnChangeScene")
	get_tree().call_group("Main", "_clear_game_data")

func _ready():
	if not random_textures.empty():
		randomize()
		var index = int(rand_range(0, 1000)) % random_textures.size()
		$AllEllements/TextureRect.texture = random_textures[index]
	
	if OS.has_feature('web'):
		$AllEllements/CenterElements/ButtonContainer/QuitButton.hide()
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

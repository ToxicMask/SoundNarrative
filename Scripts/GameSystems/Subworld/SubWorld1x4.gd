extends SubWorld

export (Texture) var open_texture : Texture = null

func _open_door():
	$WorldRender.texture = open_texture;
	$GoNextSceneInteractable.show()
	pass

func _go_to_next_scene():
	get_tree().call_group("Main", "_change_world_scene", "MainMenu")
	pass

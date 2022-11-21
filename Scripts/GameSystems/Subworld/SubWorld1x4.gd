extends SubWorld

export (Texture) var open_texture : Texture = null

func _open_door():
	$WorldRender.texture = open_texture;
	$GoNextSceneInteractable.show()
	pass

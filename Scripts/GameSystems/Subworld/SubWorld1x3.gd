extends SubWorld

export (Texture) var revealed_texture : Texture = null

func _reveal_table_content():
	$WorldRender.texture = revealed_texture;
	$PickUpTape.show()
	pass

extends ClickableObject

export (Color) var hover_color := Color.green
var normal_color := Color.white


func _ready():
	normal_color = $Sprite.self_modulate
	pass


func _process_mouse_inside():
	._process_mouse_inside()
	$Sprite.self_modulate = hover_color
	pass

func _process_mouse_out():
	._process_mouse_out()
	$Sprite.self_modulate = normal_color
	pass

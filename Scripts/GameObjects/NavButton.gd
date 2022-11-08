extends Button

export (NodePath) var subworld_path
export (int) var next_subworld_index := 0

func _ready():
	var subworld = get_node(subworld_path)
	var _err = self.connect("pressed", subworld, "_change_sub_world", [next_subworld_index])
	pass

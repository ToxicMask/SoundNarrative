extends Node2D
class_name WorldNavigation

signal subworld_changed

export (NodePath) var world_path : String

export (Array, PackedScene) var subworld_packs : Array
var subworld_instances = []
var current_subworld : int = 0

func _ready():
	if not subworld_packs.empty():
		_create_subworld_instances(subworld_packs)
	_set_subworld(current_subworld)
	pass


func _create_subworld_instances(array_packs : Array):
	var world_node = get_node_or_null(world_path)
	for i in range(array_packs.size()):
		var instance = (subworld_packs[i]as PackedScene).instance() as SubWorld
		instance.world_node = world_node
		subworld_instances.append(instance)
	pass


func _set_subworld( index : int):
	# Remove Sub World
	if 0 < get_child_count():
		var old_subworld = get_child(0) 
		if old_subworld != null:
			remove_child(old_subworld)
	
	# Set Subworld in Tree
	# Is it is in index range
	if index < subworld_instances.size():
		var instance = subworld_instances[index] as SubWorld
		instance.connect("sub_world_changed", self, "_set_subworld", [], CONNECT_ONESHOT)
		add_child(instance)
		# Update counter
		current_subworld = index
	
	# Emit Signal
	emit_signal("subworld_changed")
	pass


func _exit_tree():
	for s in subworld_instances:
		(s as Node).queue_free()
	pass

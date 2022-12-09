extends Node
class_name SoundMixerController


"""
Sound Mixer Controller
"""

const MAX_VOLUME = 6.0
const MIN_VOLUME = -72.0
const VOLUME_STEP = 1.5

onready var sm_node := get_parent() as SoundMixer




func _ready():
	if sm_node == null:
		print("No SOUND MIXER:: CONTROLLER FREE")
		self.queue_free()
	pass

func _input(_event):

	if Input.is_action_just_pressed("ui_audio_down"):
		_update_master_volume(-VOLUME_STEP)
		pass
	
	if Input.is_action_just_pressed("ui_audio_up"):
		_update_master_volume(+VOLUME_STEP)
		pass

	if Input.is_action_just_pressed("ui_audio_mute"):
		sm_node._toggle_master_mute()
	pass

func _update_master_volume(delta_volume : float):

	var old_volume : float = sm_node.master_volume_db
	var new_volume : float = clamp(old_volume + delta_volume, MIN_VOLUME, MAX_VOLUME)

	sm_node._set_volume("Master", new_volume)
	print(new_volume)
	pass
extends Node
class_name SoundMixer

"""
For managing Overall sound control

Plays sounds envolving ambiende and music

SFX should be played in individual Nodes

# Adaptable with Singletons
"""


"""
STATICS AND CALLBACKS

"""

func _enter_tree():
	if not self.is_in_group("SoundMixer"):
		self.add_to_group("SoundMixer")
	pass


static func _get_instance(tree : SceneTree):
	var sound_mixer_array = tree.get_nodes_in_group("SoundMixer")
	if not sound_mixer_array.empty():
		return sound_mixer_array[0]
	else:
		return null
	pass



"""

MUSIC

"""

func _set_music(music_sample: AudioStreamSample):
	$MusicPlayer.stream = music_sample
	pass

func _play_music():
	$MusicPlayer.play()
	pass

func _clear_music():
	$MusicPlayer.stop()
	$MusicPlayer.stream = null
	pass



"""

Ambience

"""
	
func _set_ambience(ambience_sample: AudioStreamSample):
	$AmbiencePlayer.stream = ambience_sample
	pass

func _play_ambience():
	$AmbiencePlayer.play()
	pass

func _clear_ambience():
	$AmbiencePlayer.stop()
	$AmbiencePlayer.stream = null
	pass 



"""
Volume

"""
func _set_volume(bus_name: String, volume_db : float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), volume_db)
	pass

func _set_muted(bus_name: String, muted_bool: bool):
	AudioServer.set_bus_mute(AudioServer.get_bus_index(bus_name), muted_bool)
	pass

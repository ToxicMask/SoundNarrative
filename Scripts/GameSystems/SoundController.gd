extends Node
class_name SoundController

export (AudioStream) var music_stream : AudioStream = null
export (AudioStream) var ambience_stream : AudioStream = null

export (bool) var autoplay := false


func _ready():
	if autoplay:
		_update_sound_mixer()
	pass

func _update_sound_mixer():
	var sound_mixer = SoundMixer._get_instance(get_tree()) as SoundMixer

	sound_mixer._set_music(music_stream)
	sound_mixer._set_ambience(ambience_stream)
	sound_mixer._play_music()
	sound_mixer._play_ambience()
	pass

func _update_music(new_music: AudioStream):
	var sound_mixer = SoundMixer._get_instance(get_tree()) as SoundMixer

	music_stream = new_music
	sound_mixer._set_music(music_stream)
	sound_mixer._play_music()
	pass

func _update_ambience(new_ambience: AudioStream):
	var sound_mixer = SoundMixer._get_instance(get_tree()) as SoundMixer

	ambience_stream = new_ambience
	sound_mixer._set_ambience(ambience_stream)
	sound_mixer._play_ambience()
	pass

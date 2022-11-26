extends Node

export (AudioStream) var music_stream : AudioStream = null
export (AudioStream) var ambience_stream : AudioStream = null

export (bool) var autoplay := false

func _ready():
	var sound_mixer = SoundMixer._get_instance(get_tree()) as SoundMixer

	sound_mixer._set_music(music_stream)
	sound_mixer._set_ambience(ambience_stream)

	if autoplay:
		sound_mixer._play_music()
		sound_mixer._play_ambience()
	pass

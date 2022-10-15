extends AudioStreamPlayer

signal audio_message(msg_key)


var custom_tape_content = []

func _play_audio(time_start: float = 0.0):
	print("PLAYTAPE: %s" % [time_start] )
	
	if custom_tape_content.empty():
		self.play(time_start)
		emit_signal("audio_message", "I HEARD THAT!")
	else:
		_play_custom_audio()

func _play_custom_audio(time_start: float = 0.0):
	print("CREATE THE DAMN CODE", time_start)
	emit_signal("audio_message", "GRELLO!")

extends AudioStreamPlayer

signal tape_finished

var custom_tape_content = []



func _play_audio(time_start: float = 0.0):
	print("PLAYTAPE: %s" % [time_start] )
	
	if custom_tape_content.empty():
		self.play()
		yield(self, "finished")
		print("DONE")
		emit_signal("tape_finished")
	else:
		_play_custom_audio()

func _play_custom_audio():
	print("CREATE THE DAMN CODE")
	emit_signal("tape_finished")

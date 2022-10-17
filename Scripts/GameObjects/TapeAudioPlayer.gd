extends AudioStreamPlayer

#""Serve Para ser tocada no player""

# Signals
signal audio_finished

# Preloads
onready var tape_sample = preload("res://Assets/Audio/593320__mosart1955__evil-laugh.mp3")

# Selected Tape Object
onready var selected_tape_object = TapeObject.new(self, [tape_sample, tape_sample], ["Hehe!", "HAHE2!"])


# Control tapes
func _play_audio(time_start: float = 0.0):
	selected_tape_object._play_content(time_start)
	pass

func _stop_audio():
	selected_tape_object._stop_content()
	pass

func _end_audio():
	emit_signal("audio_finished")
	pass


# Miscelaneus
func _emit_message(msg_key):
	get_tree().call_group("MessageListener", "_listen_message", msg_key)
	pass

func _get_selected_tape_length() -> float:
	return selected_tape_object._get_tape_length()

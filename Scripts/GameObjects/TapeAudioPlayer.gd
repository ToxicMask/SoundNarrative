extends "res://Scripts/GameObjects/TapeNode.gd"

signal tape_finished
signal audio_message(msg_key)


#""Serve Para ser tocada no player""

func _ready():
	var _err = null
	_err = connect("finished", self, "_end_audio")
	pass

func _play_audio(time_start: float = 0.0):
	print("PLAYTAPE: %s" % [time_start] )
	self.play(time_start)
	emit_signal("audio_message", "I HEARD THAT!")

func _stop_audio():
	self.stop()
	_end_audio()
	pass

func _end_audio():
	emit_signal("tape_finished")


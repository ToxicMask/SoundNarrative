class_name TapeObject

signal audio_message(msg_key)
signal tape_finished

var audio_player : AudioStreamPlayer = null
var content_array : Array = []
var message_array : Array = []
var content_index : int = 0
var is_playing : bool = false

# Callbacks
func _init(_audio_player, _content_array : Array = [], _message_array : Array = []):
	# Config Audio Player
	audio_player = _audio_player
	var _err = null
	_err = audio_player.connect("finished", self, "_next_content_sample")
	_err = self.connect("audio_message", audio_player, "_emit_message")
	_err = self.connect("tape_finished", audio_player, "_end_audio")
	# Config Content
	content_array = _content_array
	content_index = 0
	# Config Message Array
	message_array = _message_array
	pass


# Content Managment
func _set_tape_content(new_content : Array):
	content_array = new_content
	content_index = 0
	pass


# Control Play Tape
func _play_content(start_pos : float):
	if content_array.size() == 0:
		return
	elif content_array.size() == 1:
		audio_player.stream = content_array[0]
		audio_player.seek(start_pos)
		is_playing = true
		yield(audio_player.get_tree(), "idle_frame")
		audio_player.call_deferred("play")
		print("ONETAPE: ", start_pos)
		
	else:
		var time_left : float = start_pos
		for c in content_array:
			c = c as AudioStreamSample
			var sample_length = c.get_length() # Found a bug
			if time_left < sample_length:
				audio_player.stream = c
				print("MULTITAPE: ", start_pos)
				audio_player.seek(time_left)
				is_playing = true
				yield(audio_player.get_tree(), "idle_frame")
				print(audio_player.get_playback_position ( ))
				audio_player.call_deferred("play")
				break
			else:
				time_left = time_left - sample_length
				if time_left <= 0:
					_stop_content()
					break
				content_index +=1
	pass

func _stop_content():
	is_playing = false
	audio_player.stop()
	content_index = 0
	emit_signal("tape_finished")
	pass

func _next_content_sample():
	# Check if tape is playing
	if not is_playing:
		return

	# Emit Completed Content Sample Message
	_check_send_msg()
	
	# Next Sample
	content_index +=1

	# End of Tape?
	if content_array.size() <= content_index:
		_stop_content()
		pass
	else:
		audio_player.stream = content_array[content_index]
		audio_player.play()
		pass
	pass

# Message Functions
func _check_send_msg():
	# check if its in in msg array
	if content_index <= message_array.size()-1:
		var msg_key = message_array[content_index]
		if msg_key != null and msg_key != "":
			_send_message(msg_key)
	pass

func _send_message(msg_key: String):
	emit_signal("audio_message", msg_key)
	pass


# Miscelaneus
func _get_tape_length() -> float:
	if content_array.empty():
		return 0.0
	else:
		var time_count: float = 0
		for c in content_array:
			c = c as AudioStream
			if c != null:
				time_count += c.get_length()
		return time_count
	pass

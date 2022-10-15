extends Node2D

class_name TapeRecorder

onready var play_button := $PlayButton
onready var pause_button := $PauseButton
onready var stop_button := $StopButton
onready var goback_button := $GoBackButton
onready var gofoward_button := $GoFowardButton
onready var tape_node := $TapeAudioPlayer

#enum TAPE_STATE {PLAYING, PAUSE, GOBACK, GOFOWARD, OFF}
#var current_tapestape = TAPE_STATE.OFF

var is_playing = false
var current_tapetime  = 0.0


func _ready():
	var _err = null
	#Buttons
	_err = play_button.connect("button_pressed", self, "_play_tape")
	_err = pause_button.connect("button_pressed", self, "_pause_tape")
	_err = stop_button.connect("button_pressed", self, "_stop_tape")
	#_err = goback_button.connect("button_pressed", self, "_stop_tape")
	#_err = gofoward_button.connect("button_pressed", self, "_stop_tape")

	# Tape Node
	_err = tape_node.connect("finished", self, "_end_tape")
	pass

func _process(delta):
	if is_playing:
		current_tapetime += delta
		_update_timestamp_display()

	"""
	match (current_tapestape):
		TAPE_STATE.PLAYING:
			current_tapetime += delta
			_update_timestamp_display()
		
		TAPE_STATE.GOBACK:
			current_tapetime -= delta *2
			current_tapetime = clamp( current_tapetime, 0, 6)
			_update_timestamp_display()
		
		TAPE_STATE.GOFOWARD:
			current_tapetime += delta *2
			current_tapetime = clamp( current_tapetime, 0, 6)
			_update_timestamp_display()
	"""
		


func _play_tape():
	pause_button._realese_button()
	if is_playing:
		return
	is_playing = true
	#if current_tapestape == TAPE_STATE.PLAYING:
	#	return
	#current_tapestape = TAPE_STATE.PLAYING
	tape_node._play_audio(current_tapetime)
	print("PLAY")

func _pause_tape():
	if not is_playing:
		return
	play_button._realese_button()
	is_playing = false
	tape_node.stop()
	print("PAUSE")


func _stop_tape():
	is_playing = false
	current_tapetime  = 0.0
	tape_node.stop()
	_release_all_buttons()
	_update_timestamp_display()
	print("STOP")

func _goback_tape():
	pass

func _gofoward_tape():
	pass





func _end_tape():
	# In case the tape ended on its on
	if is_playing:
		is_playing = false
		current_tapetime  = 0.0
		_release_all_buttons()
		_update_timestamp_display()
		print("END")
	pass
	

func _release_all_buttons():
	play_button._realese_button()
	pause_button._realese_button()
	stop_button._realese_button()
	goback_button._realese_button()
	gofoward_button._realese_button()




func _update_timestamp_display():
	$TimeStamp_Label.text = "%02d:%02d" %[int(current_tapetime/60), int(current_tapetime)]

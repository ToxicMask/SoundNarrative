extends Node2D

class_name TapeRecorder

onready var play_button := $PlayButton
onready var pause_button := $PauseButton
onready var stop_button := $StopButton
onready var goback_button := $GoBackButton
onready var gofoward_button := $GoFowardButton
onready var tape_node := $TapeAudioPlayer


var is_playing = false
var current_tapetime  = 0.0


func _ready():
	var _err = null
	_err = play_button.connect("button_pressed", self, "_play_tape")
	_err = pause_button.connect("button_pressed", self, "_pause_tape")
	_err = stop_button.connect("button_pressed", self, "_stop_tape")
	_err = tape_node.connect("tape_finished", self, "_stop_tape")
	pass

func _process(delta):
	if is_playing:
		current_tapetime += delta
		_update_timestamp_display()

func _play_tape():
	pause_button._realese_button()
	if is_playing:
		return
	is_playing = true
	tape_node._play_audio(current_tapetime)

func _pause_tape():
	play_button._realese_button()
	is_playing = false
	tape_node.stop()


func _stop_tape():
	is_playing = false
	current_tapetime  = 0.0
	_release_all_buttons()
	_update_timestamp_display()
	print("STOP")

func _end_tape():
	pass
	

func _release_all_buttons():
	play_button._realese_button()
	pause_button._realese_button()
	stop_button._realese_button()

func _update_timestamp_display():
	$TimeStamp_Label.text = "%02d:%02d" %[int(current_tapetime/60), int(current_tapetime)]

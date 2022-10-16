extends Node2D

class_name TapeRecorder

onready var play_button := $PlayButton
onready var pause_button := $PauseButton
onready var stop_button := $StopButton
onready var goback_button := $GoBackButton
onready var gofoward_button := $GoFowardButton
onready var tape_node := $TapeAudioPlayer

enum {PLAYING, PAUSED, GOBACK, GOFOWARD, OFF}
var current_tape_state = OFF
var current_tapetime : float = 0.0

enum {SHOW, HIDE}
var current_hud_state = HIDE
var show_position = Vector2(1024, 600)
var hide_position = Vector2(1024, 810)


"""
Callbacks
	Input -> Show / Hide in HUD
	Ready -> Prepare connections
	Process ->  Update Tape Time
"""

func _input(_event):
	if Input.is_action_just_pressed("ui_hud_audio"):
		if current_hud_state == SHOW:
			_hide_hud()
		else:
			_show_hud()
	pass

func _ready():
	# Configure Hide HUD
	self._hide_hud()
	# ERROR VAR
	var _err = null
	# Buttons Connection
	_err = play_button.connect("button_pressed", self, "_play_tape")
	_err = pause_button.connect("button_pressed", self, "_pause_tape")
	_err = stop_button.connect("button_pressed", self, "_stop_tape")
	_err = goback_button.connect("button_pressed", self, "_goback_tape")
	_err = gofoward_button.connect("button_pressed", self, "_gofoward_tape")

	# Tape Node
	_err = tape_node.connect("tape_finished", self, "_end_tape")
	_err = tape_node.connect("audio_message", self, "_emit_message")
	pass

func _process(delta):
	# Update timetape
	var tape_length : float = tape_node.stream.get_length()
	match (current_tape_state):
		PLAYING:
			current_tapetime += delta
			_update_timestamp_display()
		
		GOBACK:
			current_tapetime -= delta *2
			current_tapetime = clamp(current_tapetime, 0, tape_length)
			_update_timestamp_display()
		
		GOFOWARD:
			current_tapetime += delta *2
			current_tapetime = clamp(current_tapetime, 0, tape_length)
			_update_timestamp_display()
	pass
		

"""
Button Functions
		Play
		Pause
		Stop
		Go Back
		Go Foward
"""

func _play_tape():
	# Control Condition
	if current_tape_state ==  PLAYING:
		return
	current_tape_state =  PLAYING

	# Reset Tape 
	var tape_length : float = tape_node.stream.get_length()
	if current_tapetime >= tape_length:
		_end_tape()
		return


	# Clear Buttons
	pause_button._realese_button()
	goback_button._realese_button()
	gofoward_button._realese_button()
	
	# Play Audio in time
	tape_node._play_audio(current_tapetime)
	print("PLAY")
	pass


func _pause_tape():
	# Clear Buttons
	play_button._realese_button()
	goback_button._realese_button()
	gofoward_button._realese_button()

	# Set State
	current_tape_state = PAUSED
	
	#Stop tape
	tape_node._stop_audio()
	print("PAUSE")
	pass


func _stop_tape():
	#Control State
	current_tape_state = OFF
	current_tapetime  = 0.0
	#Control Audio
	tape_node.stop()
	#Clear Buttons
	_release_all_buttons()
	# Update Display
	_update_timestamp_display()
	print("STOP")
	pass

func _goback_tape():
	#Clear Buttons
	play_button._realese_button()
	pause_button._realese_button()
	gofoward_button._realese_button()

	# Set State
	current_tape_state = GOBACK

	# Stop Audio
	tape_node.stop()
	pass

func _gofoward_tape():
	#Clear Buttons
	play_button._realese_button()
	pause_button._realese_button()
	goback_button._realese_button()

	#Set State
	current_tape_state = GOFOWARD

	# Stop audio
	tape_node.stop()
	pass


"""
State Control Functions
"""
func _end_tape():
	# In case the tape ended on its on
	if current_tape_state == PLAYING:
		current_tape_state = OFF
		current_tapetime  = 0.0
		_release_all_buttons()
		_update_timestamp_display()
		print("END")
	pass
	
"""
HUD FUNCTIONS
"""
func _show_hud():
	current_hud_state = SHOW
	self.position = show_position
	pass

func _hide_hud():
	current_hud_state = HIDE
	self.position = hide_position
	pass

func _update_timestamp_display():
	$TimeStamp_Label.text = "%02d:%02d" %[int(current_tapetime/60), int(current_tapetime)]
	pass


"""
Message Functions
"""

func _emit_message(msg_key):
	get_tree().call_group("MessageListener", "_listen_message", msg_key)

"""
Miscelaneus
"""
func _release_all_buttons():
	play_button._realese_button()
	pause_button._realese_button()
	stop_button._realese_button()
	goback_button._realese_button()
	gofoward_button._realese_button()
	pass


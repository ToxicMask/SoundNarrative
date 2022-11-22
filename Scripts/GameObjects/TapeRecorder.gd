extends Node2D
class_name TapeRecorder


# Display Signals
signal hud_hid
signal hud_showed

# Action Button Signals
signal play_pressed
signal pause_pressed
signal stop_pressed
signal goback_pressed
signal gofoward_pressed
signal eject_pressed

# Tape Signals
signal tape_inserted

# Buttons Variables
onready var play_button := $PlayButton
onready var pause_button := $PauseButton
onready var stop_button := $StopButton
onready var goback_button := $GoBackButton
onready var gofoward_button := $GoFowardButton
onready var eject_button := $EjectButton
onready var tape_node := $TapeAudioPlayer
onready var selection_hud := $SelectionHUD

enum {PLAYING, PAUSED, GOBACK, GOFOWARD, OFF, EJECTED}
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
		_toggle_hud()
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
	_err = eject_button.connect("button_pressed", self, "_show_selection")

	# Tape Node
	_err = tape_node.connect("audio_finished", self, "_end_tape")

	# Tape Selection
	selection_hud._connect_insert_tape(self, "_insert_new_tape")
	_err = selection_hud.connect("visibility_changed", self, "_check_hide_selection")
	# Fist Tape Insertion
	#_insert_first_tape()

	pass

func _process(delta):
	# Update timetape
	var tape_length : float = tape_node._get_selected_tape_length()
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
	
	# Emit Signal
	emit_signal("play_pressed")
	
	# Control Condition
	if current_tape_state == PLAYING:
		return
	current_tape_state =  PLAYING
	# Reset Tape 
	var tape_length : float = tape_node._get_selected_tape_length()
	if current_tapetime >= tape_length:
		_end_tape()
		return


	# Clear Buttons
	pause_button._realese_button()
	goback_button._realese_button()
	gofoward_button._realese_button()
	
	# Play Audio in time
	tape_node._play_audio(current_tapetime)
	

	pass

func _pause_tape():

	# Emit Signal
	emit_signal("pause_pressed")
	
	# Clear Buttons
	play_button._realese_button()
	goback_button._realese_button()
	gofoward_button._realese_button()

	# Set State
	current_tape_state = PAUSED
	
	#Stop tape
	tape_node._stop_audio()
	pass

func _stop_tape():
	
	# Emit Signal
	emit_signal("stop_pressed")
	
	#Control State
	current_tape_state = OFF
	current_tapetime  = 0.0
	#Control Audio
	tape_node._stop_audio()
	#Clear Buttons
	_release_all_buttons()
	# Update Display
	_update_timestamp_display()
	pass

func _goback_tape():
	
	# Emit Signal
	emit_signal("goback_pressed")
	
	#Clear Buttons
	play_button._realese_button()
	pause_button._realese_button()
	gofoward_button._realese_button()

	# Set State
	current_tape_state = GOBACK

	# Stop Audio
	tape_node._stop_audio()
	pass

func _gofoward_tape():
	
	# Emit Signal
	emit_signal("gofoward_pressed")
	
	#Clear Buttons
	play_button._realese_button()
	pause_button._realese_button()
	goback_button._realese_button()

	#Set State
	current_tape_state = GOFOWARD

	# Stop audio
	tape_node._stop_audio()
	pass


"""
State Control Functions
"""
func _insert_new_tape(new_tape_info):
	
	# Emit Signal
	emit_signal("tape_inserted")
	
	tape_node._set_selected_tape(new_tape_info)
	_hide_selection()
	$TapeSprite.modulate = new_tape_info.tape_color
	pass

func _end_tape():
	# In case the tape ended on its on
	if current_tape_state == PLAYING:
		current_tape_state = OFF
		current_tapetime  = 0.0
		_release_all_buttons()
		_update_timestamp_display()
	pass


"""
HUD FUNCTIONS
"""

func _toggle_hud():
	if current_hud_state == SHOW:
		_hide_hud()
	else:
		_show_hud()
	pass

func _show_hud():
	emit_signal("hud_showed")
	current_hud_state = SHOW
	self.position = show_position
	$RevealButton/RevelSprite.flip_v = true
	pass

func _hide_hud():
	emit_signal("hud_hid")
	current_hud_state = HIDE
	self.position = hide_position
	$RevealButton/RevelSprite.flip_v = false
	self._hide_selection()
	self._stop_tape()
	pass

func _show_selection():
	emit_signal("eject_pressed")
	current_tape_state = EJECTED
	if not selection_hud.visible:
		selection_hud.show()
	self._stop_tape()
	_disable_all_buttons(true)
	$Backdrop.self_modulate = Color.gray
	pass

func _hide_selection():
	current_tape_state = OFF
	if selection_hud.visible:
		selection_hud.hide()
	eject_button._realese_button()
	_disable_all_buttons(false)
	$Backdrop.self_modulate = Color.white
	pass

func _update_timestamp_display():
	$TimeStamp_Label.text = "%02d:%02d" %[int(current_tapetime/60), int(current_tapetime)]
	pass


"""
Miscelaneus
"""

func _check_hide_selection():
	if not selection_hud.visible:
		_hide_selection()

func _insert_first_tape():
	var first_tape = get_tree().get_nodes_in_group("SelectionTape")[0]
	if first_tape:
		self._insert_new_tape(first_tape._get_tape_info())
	pass

func _disable_all_buttons(disable : bool = true):
	play_button._set_disable_hitbox(disable)
	pause_button._set_disable_hitbox(disable)
	stop_button._set_disable_hitbox(disable)
	goback_button._set_disable_hitbox(disable)
	gofoward_button._set_disable_hitbox(disable)
	pass

func _release_all_buttons():
	play_button._realese_button()
	pause_button._realese_button()
	stop_button._realese_button()
	goback_button._realese_button()
	gofoward_button._realese_button()
	pass

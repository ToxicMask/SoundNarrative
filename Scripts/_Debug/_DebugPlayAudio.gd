extends Node

export (AudioStream) var new_sample : AudioStream = null 
export (float) var delay: float = 0.0

var current_time = 0.0
var is_playing = false

func _ready():
	current_time = 0.0
	$AudioStreamPlayer.stream = new_sample
	$AudioStreamPlayer.play(delay)
	pass

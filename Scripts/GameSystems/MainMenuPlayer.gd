extends AudioStreamPlayer
class_name MainMenuPlayer

export (AudioStream) var click_sample : AudioStream = null
export (AudioStream) var hover_sample : AudioStream = null


func _play_click():
	self.stream = click_sample
	self.play()
	pass

func _play_hover():
	self.stream = hover_sample
	self.play()
	pass



extends AudioStreamPlayer

# Inner Class
class TapeContent:

	var audio_player : AudioStreamPlayer = null

	var content_queue := []
	var play_queue := []

	var current_

	func _init(_audio_player):
		print("NEW TAPE")
		audio_player = _audio_player
		pass

	func _play_content(start_pos : float):
		print("PLAY CONTENT:")
		print(start_pos)
		pass
	
	func _stop_content():
		pass
	
	
# Objects
var tape_content = null


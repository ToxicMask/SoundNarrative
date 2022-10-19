extends Node2D
class_name EditedTapeInfo


var tape_info : TapeInfo = TapeInfo.new()


func _create_tape_info(_name: String = "Edited Tape",_description : String = "", _content_array : Array = [], _msg_array : Array = [], _tape_color : Color = Color.gray ):
	var new_info : TapeInfo = TapeInfo.new()
	new_info.name = _name
	new_info.description = _description
	new_info.content_array = _content_array
	new_info.msg_array = _msg_array
	new_info.tape_color = _tape_color
	return new_info


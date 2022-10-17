extends OptionButton

enum OPTIONS {OFF, TECNO, HAPPY, ANGRY, CYBORG}

export (OPTIONS) var opt

func _ready():
	var options = OPTIONS.keys()
	for op in options:
		add_item(op)
	pass # Replace with function body.


extends Label

var showing : bool = false 

var max_time : float = 1.5
var time : float = 0

func _process(delta: float) -> void:
	time = clampf(time - delta, 0, max_time)
	if showing:
		if time > 0:
			show()
		else:
			showing = false
			hide()
	
func _show():
	showing = true
	time = max_time

extends Label

var showing : bool = false 

var max_time : float = 1.5
var time : float = 0

func _process(delta: float) -> void:
	time = clampf(time - delta, 0, max_time)
	modulate.a = clampf(modulate.a - delta * 1.1, 0, 255)
	if showing:
		if time > 0:
			show()
		else:
			showing = false
			hide()
	
func _show():
	showing = true
	modulate.a = 1
	time = max_time

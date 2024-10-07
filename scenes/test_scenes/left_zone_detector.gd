extends Panel

@export var is_left : bool = true

func detect_mouse():
	if is_left:
		Session.set_camera_left()
	else:
		Session.set_camera_right()
		
func reset_mouse():
	Session.reset_camera_status()

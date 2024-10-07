extends Panel

func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var rect = get_global_rect()
	if rect.has_point(mouse_pos):
		block_session()
	else:
		unblock_session()

func block_session():
	print("blocked")
	Session.block()
	
func unblock_session():
	print("unblocked")
	Session.unblock()

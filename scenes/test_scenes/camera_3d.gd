extends Camera3D
@export var max_fov : float = 100.0
@export var min_fov : float = 40

@export var camera_speed : float = 10
func _process(delta):
	move_camera_with_mouse(delta)

func move_camera_with_mouse(delta):
	#return
	##Get the displacement from the center
	#var mouse_diff = get_viewport().get_mouse_position() - get_viewport().size / 2.0
	##print(mouse_diff)
	#var current_rotation = rotation
	#current_rotation = rotation + Vector3(-mouse_diff.y, -mouse_diff.x, 0) * sensitivity * delta
	#rotation.x = clamp(current_rotation.x, deg_to_rad(-40), deg_to_rad(-20))
	#rotation.y = clamp(current_rotation.y, deg_to_rad(-50), deg_to_rad(-10))
	
	if Input.is_action_pressed("ui_right"):
		translate(Vector3.RIGHT * delta * camera_speed)
	if Input.is_action_pressed("ui_left"):
		translate(Vector3.LEFT * delta * camera_speed)
		

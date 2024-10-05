extends Camera3D
@export var max_fov : float = 100.0
@export var min_fov : float = 40

var min_angle = -PI / 4 # Минимальный угол (примерно -45 градусов)
var max_angle = PI / 4 # Максимальный угол (примерно 45 градусов)

func _process(_delta):
	return

func move_camera_with_mouse(delta):
	var sensitivity = 0.002
	
	#Get the displacement from the center
	var mouse_diff = get_viewport().get_mouse_position() - get_viewport().size / 2.0
	#print(mouse_diff)
	var current_rotation = rotation
	current_rotation = rotation + Vector3(-mouse_diff.y, -mouse_diff.x, 0) * sensitivity * delta
	rotation.x = clamp(current_rotation.x, deg_to_rad(-40), deg_to_rad(-20))
	rotation.y = clamp(current_rotation.y, deg_to_rad(-50), deg_to_rad(-10))
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		fov = clampf(fov + 5, min_fov, max_fov)
	if event.is_action_pressed("ui_down"):
		fov = clampf(fov - 5, min_fov, max_fov)
		

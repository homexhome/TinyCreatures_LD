extends Camera3D
@export var max_fov : float = 100.0
@export var min_fov : float = 40
@export var max_x : float = 5
@export var min_x : float = -25
@export var camera_speed : float = 10
@export var camera_up_speed : float = 10

@export var path_follow : PathFollow3D
@export var path : Path3D

func _ready() -> void:
	Event.game_paused.connect(reset_time_scroll_momentum)

func _process(delta):
	move_camera_with_mouse(delta)
	time_scroll_momentum = clampf(time_scroll_momentum - delta, 0, max_time_scroll_momentum)
	if time_scroll_momentum > 0:
		if scrolling_forward:
			path_follow.progress += delta * camera_up_speed
		else:
			path_follow.progress -= delta * camera_up_speed
			
var scrolling_forward : bool = true
var time_scroll_momentum : float = 0.0
var max_time_scroll_momentum : float = 0.0
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
		if path.global_position.x >= max_x : return
		path.translate(Vector3.RIGHT * delta * camera_speed)
	if Input.is_action_pressed("ui_left"):
		if path.global_position.x <= min_x : return
		path.translate(Vector3.LEFT * delta * camera_speed)
	if Input.is_action_pressed("ui_up"):
		path_follow.progress += delta * camera_speed
	if Input.is_action_pressed("ui_down"):
		path_follow.progress -= delta * camera_speed
	if Input.is_action_just_released("scroll_up"):
		scrolling_forward = true
		time_scroll_momentum = max_time_scroll_momentum
		path_follow.progress += delta * camera_up_speed
	if Input.is_action_just_released("scroll_down"):
		scrolling_forward = false
		time_scroll_momentum = max_time_scroll_momentum
		path_follow.progress -= delta * camera_up_speed
		
func reset_time_scroll_momentum():
	time_scroll_momentum = 0

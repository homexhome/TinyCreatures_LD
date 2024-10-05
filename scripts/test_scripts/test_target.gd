extends MeshInstance3D

@export var mesh_to_take : MeshInstance3D
@export var camera : Camera3D

@export var ui : UIControl

var mouse_position_3D : Vector3

func _physics_process(delta: float) -> void:
	var window_size = DisplayServer.window_get_size()
	var viewport = get_viewport()
	var mouse_position = viewport.get_mouse_position()
	#print("Mouse : ", mouse_position, "window size : ", window_size)
	if (mouse_position.x < 0 or mouse_position.x > window_size.x or
			mouse_position.y < 0 or mouse_position.y > window_size.y):
				if mouse_position.x <= 0 :
					if camera.global_position.x <= camera.min_x : return
					camera.translate(Vector3.LEFT* delta * camera.camera_speed)
				elif mouse_position.x >= window_size.x:
					if camera.global_position.x >= camera.max_x : return
					camera.translate(Vector3.RIGHT * delta * camera.camera_speed)
				return

	if is_instance_valid(ui.active_monster_button):
		var space_state = get_world_3d().direct_space_state
		var origin= camera.project_ray_origin(mouse_position)
		var direction = camera.project_ray_normal(mouse_position)
		var ray_length = camera.far
		var end = origin + direction * ray_length
		var query = PhysicsRayQueryParameters3D.create(origin, end, 1)
		var result = space_state.intersect_ray(query)
		mouse_position_3D = end

		if not result.is_empty() and is_instance_valid(ui.active_monster_button):
			mesh_to_take.show()
			mouse_position_3D = result["position"]
			#print("Расстояние : ", (mouse_position_3D - origin).length())
			mesh_to_take.global_position = mouse_position_3D
		else:
			mesh_to_take.hide()
		
func _input(event: InputEvent) -> void:
	if mesh_to_take.visible and event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			ui.monster_spawn_from_button(mouse_position_3D)
		

extends MeshInstance3D

@export var mesh_to_take : MeshInstance3D
@export var camera : Camera3D
@export var color_yes : Color
@export var color_no : Color
@export var ui : UIControl
@export var mesh_with_material : Mesh
@export var shape_raycast : Shape3D
var mouse_position_3D : Vector3
@export var path_visual_node : MeshInstance3D
var max_offset_x_to_move_camera : float = 100

func _ready():
	mesh_to_take.hide()

func _physics_process(delta: float) -> void:
	var window_size = DisplayServer.window_get_size()
	var viewport = get_viewport()
	var mouse_position = viewport.get_mouse_position()
	if Session.blocked:
		mesh_to_take.hide()
	#else:
	##print("Mouse : ", mouse_position, "window size : ", window_size)
		#if (mouse_position.x  < 0 or mouse_position.x > window_size.x or
				#mouse_position.y < 0 or mouse_position.y > window_size.y):
					#if mouse_position.x  <= 0 :
						#if camera.path.global_position.x <= camera.min_x : return
						#camera.path.translate(Vector3.LEFT* delta * camera.camera_speed)
					#elif mouse_position.x >= window_size.x:
						#if camera.path.global_position.x >= camera.max_x : return
						#camera.path.translate(Vector3.RIGHT * delta * camera.camera_speed)
					#return

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
			mouse_position_3D = result["position"]
			var shape_query : PhysicsShapeQueryParameters3D = PhysicsShapeQueryParameters3D.new()
			shape_query.collision_mask = 2
			shape_query.shape = shape_raycast
			shape_query.transform.origin = mouse_position_3D
			var shape_result = space_state.intersect_shape(shape_query)
			mesh_to_take.show()
			if shape_result.is_empty():
				Session.unblock_spawn()
				mesh_with_material.get_material().set_albedo(color_yes)
				mesh_with_material.get_material().set_emission(color_yes)
			else:
				Session.block_spawn()
				mesh_with_material.get_material().set_albedo(color_no)
				mesh_with_material.get_material().set_emission(color_no)

			mesh_to_take.global_position = mouse_position_3D
		else:
			mesh_to_take.hide()
		
func _input(event: InputEvent) -> void:
	if Session.blocked:
		return
	if mesh_to_take.visible and event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			ui.monster_spawn_from_button(mouse_position_3D)
			mesh_to_take.hide()
		

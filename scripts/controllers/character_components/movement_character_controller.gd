extends BaseCharacterComponent
class_name MovementCharacterController

var movement_speed : float = 10
var nav_agent : NavigationAgent3D

var minimum_distance_to_attack

func initialize():
	character = get_parent()
	var char_stats : CharacterStats = character.get_character_stats()
	movement_speed = char_stats.movement_speed
	nav_agent = get_node_or_null("NavigationAgent3D")
	minimum_distance_to_attack = char_stats.minimum_distance_to_attack
	if nav_agent == null:
		push_error("Forgot to add nav agent")
	

func component_physics_process(delta):
	_nav_movement(delta)

func _nav_movement(delta):
	if !need_movement: return
	nav_agent.target_position = movement_target
	var target = nav_agent.get_next_path_position()

	#var space_state = get_world_3d().direct_space_state
	#var query = PhysicsRayQueryParameters3D.create(target,target + Vector3.DOWN *9)
	#var result = space_state.intersect_ray(query)
	#if not result.is_empty():
		#character.global_position = character.global_position.lerp(result["position"],movement_speed * delta)
	
	character.global_position = character.global_position.lerp(target,movement_speed * delta)
func stop():
	need_movement = false

var need_movement : bool = false
var movement_target : Vector3
func move_to(target_pos : Vector3):
	if check_target_distance(target_pos) : 
		need_movement = false
		return
	movement_target = target_pos
	need_movement = true
	

func check_target_distance(target_pos: Vector3):
	if character.global_position.distance_squared_to(target_pos) <= minimum_distance_to_attack * minimum_distance_to_attack:
		return true
	return false

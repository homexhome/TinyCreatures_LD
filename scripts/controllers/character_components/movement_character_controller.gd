extends BaseCharacterComponent
class_name MovementCharacterController

var movement_speed : float = 10
var nav_agent : NavigationAgent3D

var minimum_distance_to_attack
@export var animation_player : AnimationPlayer
var path_vertices_array : Array[Vector3]
var current_path_pos : Vector3

func initialize():
	character = get_parent()
	var char_stats : CharacterStats = character.get_character_stats()
	movement_speed = char_stats.movement_speed
	nav_agent = get_node_or_null("NavigationAgent3D")
	minimum_distance_to_attack = char_stats.minimum_distance_to_attack
	if nav_agent == null:
		push_error("Forgot to add nav agent")
	var nav_node = get_tree().get_first_node_in_group("NavigationMarks")
	if nav_node == null: push_error("Navigation marks node is null!")
	else: path_vertices_array = nav_node.take_path_array()
	if character.is_in_group("Attackers"):
		current_path_pos = path_vertices_array.pop_front()
	if animation_player == null:
		push_error("Animation player in movement controller is null")

func component_physics_process(delta):
	_nav_movement(delta)
	pick_destination()

func _nav_movement(delta):
	if !need_movement: 
		if !character.animation_busy and !target_movement:
			animation_player.play(character.anim_lib_name+"idle")
		return
	nav_agent.target_position = movement_target
	var target = nav_agent.get_next_path_position()
	update_rotation(delta)
	if check_movement_distance(target): return
	character.global_position = character.global_position.lerp(target,movement_speed * delta)
	play_walk_anim()

func update_rotation(delta):
	var target_position = movement_target
	var new_transform = character.transform.looking_at(target_position, Vector3.UP)
	character.transform  = character.transform.interpolate_with(new_transform, rotation_speed * delta)
	character.rotation.x = 0
	character.rotation.z = 0


var rotation_speed = 10
var min_rotation_angle = deg_to_rad(5.0)
func play_walk_anim():
	if character.animation_busy == false:
		if animation_player.current_animation !="walk":
			animation_player.play(character.anim_lib_name+"walk")

func stop():
	target_movement = false

var max_distance_to_nav_target : float = 2
func pick_destination():
	if is_instance_valid(character.current_target) == false:
		target_movement = false
	if target_movement or is_instance_valid(character.current_target): return
	if !character.is_in_group("Attackers"): return
	if character.global_position.distance_squared_to(current_path_pos) <= max_distance_to_nav_target * max_distance_to_nav_target:
		if path_vertices_array.size() > 0:
			current_path_pos = path_vertices_array.pop_front()
	else:

		movement_target = current_path_pos
		need_movement = true
		
var target_movement : bool = false
var need_movement : bool = false
var movement_target : Vector3
func move_to(target_pos : Vector3):
	if is_instance_valid(character.current_target) == false:
		target_movement = false
		need_movement = true
		return
	if check_target_distance(target_pos) : 
		target_movement = false
		return
	movement_target = target_pos
	need_movement = true
	target_movement = true

func check_target_distance(target_pos: Vector3):
	if character.global_position.distance_squared_to(target_pos) <= minimum_distance_to_attack * minimum_distance_to_attack:
		return true
	return false

func check_movement_distance(target_pos: Vector3):
	if character.global_position.distance_squared_to(target_pos) <= 0.2:
		return true
	return false

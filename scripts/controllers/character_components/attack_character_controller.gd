extends BaseCharacterComponent
class_name AttackCharacterComponent

var current_attack_damage : float
var type : CharacterStats.COMBAT_TYPE

var attack_damage : float
var attack_speed : float
var cast_speed : float

var attack_cooldown : float = 0
var minimum_distance_to_attack : float = 1

@export var melee_area : Area3D = null
@export var agressive_area : Area3D 
var projectile : PackedScene = null

@export var projectile_start_path : Node3D
var current_target : Character

func initialize():
	character = get_parent()
	var char_stats : CharacterStats = character.get_character_stats()
	type = char_stats.type
	attack_speed = char_stats.attack_speed
	cast_speed = char_stats.cast_speed
	minimum_distance_to_attack = char_stats.minimum_distance_to_attack
	attack_damage = char_stats.attack_damage
	projectile = char_stats.projectile_scene
	if type == CharacterStats.COMBAT_TYPE.CLOSE_COMBAT and melee_area == null:
		push_error("Melee character doest have damage area")
	if type == CharacterStats.COMBAT_TYPE.ARCHER and projectile == null:
		push_error("Projectile doesn't exists for archer")
	if type == CharacterStats.COMBAT_TYPE.ARCHER and projectile_start_path == null:
		push_error("Projectile start path doesn't exists for archer")
	if melee_area != null:
		melee_area.monitoring = true
	check_for_target()

func component_process(delta):
	attack_cooldown = clampf(attack_cooldown - delta, 0, attack_speed)
	if !is_instance_valid(current_target):
		current_target = null

func component_physics_process(delta):
	if is_instance_valid(current_target):
		if check_target_distance(current_target.global_position):
			attack()
			character.stop()
		else:
			character.move_to(current_target.global_position)
		update_rotation(delta)

func check_target_distance(target_pos: Vector3):
	if character.global_position.distance_squared_to(target_pos) <= minimum_distance_to_attack * minimum_distance_to_attack:
		return true
	return false

func check_for_target():
	var valid_targets : Array = []
	var distance : float = 99999
	if !is_instance_valid(current_target):
		for body in agressive_area.get_overlapping_bodies():
			if validate_target(body):
				valid_targets.append(body)

		for body in valid_targets:
			var distance_to = character.global_position.distance_squared_to(body.global_position) 
			if distance_to < distance:
				distance = distance_to
				current_target = body
				
var rotation_speed = 10
var min_rotation_angle = deg_to_rad(5.0)

func update_rotation(delta):
	var target_position = current_target.transform.origin
	var new_transform = character.transform.looking_at(target_position, Vector3.UP)
	character.transform  = character.transform.interpolate_with(new_transform, rotation_speed * delta)
	character.rotation.x = 0
	character.rotation.z = 0

func validate_target(target: Character):
	if character.is_in_group("Defenders") and target.is_in_group("Attackers"):
		return true
	elif character.is_in_group("Attackers") and target.is_in_group("Defenders"):
		return true
	return false

func attack():
	if attack_cooldown > 0: return
	if type == CharacterStats.COMBAT_TYPE.CLOSE_COMBAT:
		area_attack(melee_area)
	if type == CharacterStats.COMBAT_TYPE.ARCHER or type == CharacterStats.COMBAT_TYPE.MAGE:
		var proj = projectile.instantiate()
		Projectiles.add_child(proj)
		proj.setup_projectile(current_target, type,attack_damage, character, projectile_start_path.global_position)
	attack_cooldown = attack_speed
	

func area_attack(damage_area : Area3D):
	for body in damage_area.get_overlapping_bodies():
		if character.is_in_group("Defenders") and body.is_in_group("Attackers"):
			body.take_damage(attack_damage,character, type)
		elif character.is_in_group("Attackers") and body.is_in_group("Defenders"):
			body.take_damage(attack_damage,character, type)

func target_attack(target : Character):
	if (character.is_in_group("Defenders") and target.is_in_group("Defenders")) or (character.is_in_group("Attackers") and target.is_in_group("Attackers")):
		push_error("Trying to attack same team! Attacker : ",character)
		return

	target.take_damage(attack_damage,character,type)

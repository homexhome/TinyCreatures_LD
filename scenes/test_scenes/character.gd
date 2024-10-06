extends Node3D
class_name Character
@export var character_stats : CharacterStats


var components_array : Array = []

var health_component
var movement_controller
var attack_controller

signal took_damage_signal
signal on_death_signal

var current_target

func _ready():
	for child in get_children():
		if child is BaseCharacterComponent:
			child.initialize()
			components_array.append(child)
	check_controller(CONTROLLER_TYPE.HEALTH)
	check_controller(CONTROLLER_TYPE.MOVING)
	check_controller(CONTROLLER_TYPE.ATTACK)

func _process(delta):
	for component in components_array:
		component.component_process(delta)

func _physics_process(delta):
	for component in components_array:
		component.component_physics_process(delta)

func get_character_stats():
	return character_stats

func is_alive() -> bool:
	return health_component.is_alive()

func move_to(target_pos : Vector3):
	movement_controller.move_to(target_pos)

func stop():
	movement_controller.stop()

func death():
	on_death_signal.emit()
	queue_free()

func take_damage(damage : float, damage_owner : Character, _attack_type : CharacterStats.COMBAT_TYPE):
	return health_component.take_damage(damage, damage_owner,_attack_type)

enum CONTROLLER_TYPE {HEALTH, MOVING, ATTACK}
func check_controller(type : CONTROLLER_TYPE):
	match type:
		CONTROLLER_TYPE.HEALTH:
			if !is_instance_valid(health_component):
				for component in components_array:
					if component.has_method("is_alive"):
						health_component = component
						break
		CONTROLLER_TYPE.MOVING:
			if !is_instance_valid(movement_controller):
				for component in components_array:
					if component.has_method("_nav_movement"):
						movement_controller = component
						break
		CONTROLLER_TYPE.ATTACK:
			if !is_instance_valid(attack_controller):
				for component in components_array:
					if component.has_method("attack"):
						attack_controller = component
						break

func set_current_target(target):
	current_target = target
	print("set target ",target)

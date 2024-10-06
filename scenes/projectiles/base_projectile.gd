extends Node3D
class_name BaseProjectile

var target : Character
var type : CharacterStats.COMBAT_TYPE
var damage : float = 0
@export var area_on_target_impact : Blast = null
var character_owner : Character
@export var speed : float
var initialized : bool = false

func setup_projectile(_target : Character, _type : CharacterStats.COMBAT_TYPE, _damage : float, _character_owner : Character, start_position : Vector3):
	target = _target
	type = _type
	damage = _damage
	character_owner = _character_owner
	global_position = start_position
	initialized = true

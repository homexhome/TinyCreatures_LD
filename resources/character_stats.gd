extends Resource
class_name CharacterStats

enum COMBAT_TYPE {CLOSE_COMBAT, ARCHER, MAGE}
@export var type : COMBAT_TYPE
@export var max_health : float = 100
@export var attack_damage : float = 20
@export var movement_speed : float = 3 
@export var attack_speed : float = 3 
@export var cast_speed : float = 3 

@export var minimum_distance_to_attack : float = 1
@export var projectile_scene : PackedScene
@export_group("Recieving Combat Damage Modifiers")
@export var recieving_close_combat_damage_modifier : float = 1.0
@export var recieving_archer_damage_modifier : float = 1.0
@export var recieving_magic_damage_modifier : float = 1.0




extends Resource

enum COMBAT_TYPE {CLOSE_COMBAT, ARCHER, MAGE}
@export var type : COMBAT_TYPE
@export var max_health : float = 100
@export var attack_damage : float = 20
@export var movement_speed : float = 3 
@export var attack_speed : float = 3 
@export var cast_speed : float = 3 

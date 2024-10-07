extends BaseCharacterComponent

var max_health : float = 1000
var current_health : float = 1000
@export var audio : AudioStreamPlayer3D

func _ready() -> void:
	GameManager.register_final_target(get_parent())

func initialize():
	character = get_parent()

func take_damage(damage : float, _damage_owner : Character, _attack_type : CharacterStats.COMBAT_TYPE):
	if _damage_owner.is_in_group("Defenders"): return
	print(damage)
	var temp_health = current_health - damage
	current_health = temp_health
	if current_health <= 0:
		Event.event_game_lost()
		return
	else:
		audio.play()

func is_alive():
	return true

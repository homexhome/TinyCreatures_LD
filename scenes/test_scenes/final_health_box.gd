extends BaseCharacterComponent

var max_health : float = 1000
var current_health : float = 1000
@export var audio : AudioStreamPlayer3D
@export var health_text : Node3D
func _ready() -> void:
	GameManager.register_final_target(get_parent())

func initialize():
	character = get_parent()

func take_damage(damage : float, _damage_owner : Character, _attack_type : CharacterStats.COMBAT_TYPE):
	if _damage_owner.is_in_group("Defenders"): return
	print(damage)
	var temp_health = current_health - damage
	current_health = temp_health
	health_text.show()
	health_text.set_text(current_health,max_health,character)
	if current_health <= 0:
		Event.event_game_lost()
		return
	else:
		audio.play()

func is_alive():
	return true

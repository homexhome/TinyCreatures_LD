extends BaseCharacterComponent
class_name HealthCharacterComponent

var current_health : float 
var max_health : float 


var recieving_close_combat_damage_modifier : float = 1.0
var recieving_archer_damage_modifier : float = 1.0
var recieving_magic_damage_modifier : float = 1.0

func initialize():
	character = get_parent()
	var char_stats = character.get_character_stats()
	max_health = char_stats.max_health
	current_health = max_health
	recieving_close_combat_damage_modifier = char_stats.recieving_close_combat_damage_modifier
	recieving_archer_damage_modifier = char_stats.recieving_archer_damage_modifier
	recieving_magic_damage_modifier = char_stats.recieving_magic_damage_modifier

func is_alive() -> bool:
	return current_health > 0

func take_damage(damage : float, _damage_owner : Character, _attack_type : CharacterStats.COMBAT_TYPE):
	print("Character : ", character, " taking damage : ", damage, " from : ", _damage_owner)

	if !is_alive() : return
	var temp_health = current_health - get_modified_damage(damage, _attack_type)
	current_health = temp_health
	if current_health <= 0:
		on_death()
		return
	else:
		character.took_damage_signal.emit()

func get_modified_damage(damage, attack_type : CharacterStats.COMBAT_TYPE) -> float:
	match attack_type:
		CharacterStats.COMBAT_TYPE.CLOSE_COMBAT:
			return damage * recieving_close_combat_damage_modifier

		CharacterStats.COMBAT_TYPE.ARCHER:
			return damage * recieving_archer_damage_modifier
		CharacterStats.COMBAT_TYPE.MAGE:
			return damage * recieving_magic_damage_modifier
	return 0

func on_death():
	character.on_death_signal.emit()

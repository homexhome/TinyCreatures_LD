extends BaseProjectile

var activated : bool = false

func _process(delta):
	if !initialized: return
	if !is_instance_valid(target): queue_free()
	if activated: return
	if global_position.distance_squared_to(target.global_position) >= 0.1 :
		global_position = global_position.lerp(target.global_position,speed * delta)
	else:
		if type == CharacterStats.COMBAT_TYPE.ARCHER:
			target.take_damage(damage, character_owner, type)
			queue_free()
		elif type == CharacterStats.COMBAT_TYPE.MAGE:
			if area_on_target_impact == null:
				push_error("area on impact is is_null")
				return
			else:
				if activated: return
				activated = true
				area_on_target_impact.finished.connect(free_projectile)
				area_on_target_impact.explode(damage,character_owner,type)

func free_projectile():
	queue_free()

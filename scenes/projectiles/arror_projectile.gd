extends BaseProjectile

func _process(delta):
	if !initialized: return
	if !is_instance_valid(target): queue_free()
	if global_position != target.global_position:
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
				area_on_target_impact.explode(damage,character_owner,type)
				area_on_target_impact.finished.connect(queue_free)

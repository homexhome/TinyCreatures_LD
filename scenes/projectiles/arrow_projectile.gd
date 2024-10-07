extends BaseProjectile

var activated : bool = false

func _process(delta):
	if !initialized: return
	if !is_instance_valid(target): 
		queue_free()
		return
	if activated: return
	if global_position.distance_squared_to(target.global_position) >= 0.3 :
		update_rotation(delta, target.global_position)
		global_position = global_position.lerp(target.global_position + Vector3.UP / 2,speed * delta)
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
				
var rotation_speed = 50
func update_rotation(delta, _target):
	var target_position = _target
	var new_transform = transform.looking_at(target_position)
	transform  = transform.interpolate_with(new_transform, rotation_speed * delta)
	rotation.x = 0
	rotation.z = 0
	
func free_projectile():
	queue_free()

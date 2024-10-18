extends Area3D

var current_defenders_inside : Dictionary
@export var burn_damage : float = 10
@onready var burn_box = preload("res://scenes/mobs/burn_box.tscn")
func _check_and_burn_bodies():
	var duplicate_dict : Dictionary = current_defenders_inside.duplicate()
	for body in get_overlapping_bodies():
		if body.is_in_group("Defenders"):
			duplicate_dict.erase(body)
			if current_defenders_inside.has(body):
				body.take_damage(burn_damage,null, CharacterStats.COMBAT_TYPE.MAGE)
			else:
				var box = burn_box.instantiate()
				body.add_child(box)
				current_defenders_inside[body] = box
	for exited_body in duplicate_dict:
		if !is_instance_valid(exited_body) or  !is_instance_valid(duplicate_dict[exited_body]): continue
		duplicate_dict[exited_body].queue_free()
		duplicate_dict.erase(exited_body)

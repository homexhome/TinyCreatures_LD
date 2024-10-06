extends Node

func check_validity(target, asker):
	if is_instance_valid(asker) == false: return false
	if is_instance_valid(target) == false: return false
	if asker.is_in_group("Defenders") and target.is_in_group("Attackers"):
		return true
	elif asker.is_in_group("Attackers") and target.is_in_group("Defenders"):
		return true
	return false

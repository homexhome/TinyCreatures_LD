extends Node

func check_validity(target, asker):
	if asker.is_in_group("Defenders") and target.is_in_group("Attackers"):
		return true
	elif asker.is_in_group("Attackers") and target.is_in_group("Defenders"):
		return true
	return false

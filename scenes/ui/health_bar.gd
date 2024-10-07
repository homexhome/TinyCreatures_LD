extends Node3D

@export var label : Label3D
@export var attack_color : Color
@export var defend_color : Color
func set_text(curr,max,character):
	if character.is_in_group("Attackers"):
		label.set_modulate(attack_color)
	else:
		label.set_modulate(defend_color)
	label.text = str(curr, " / ", max)

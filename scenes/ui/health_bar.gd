extends Node3D

@export var label : Label3D

func set_text(curr,max):
	label.text = str(curr, " / ", max)

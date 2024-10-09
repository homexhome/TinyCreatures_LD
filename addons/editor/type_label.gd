@tool
extends Label


func set_label_text(id : int):
	print(id)
	match id:
		0:
			text = "Melee"
		1:
			text = "Archer"
		2:
			text = "Mage"

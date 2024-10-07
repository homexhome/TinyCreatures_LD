extends Label

@export var label : Label
@export var anim_player : AnimationPlayer
func _ready() -> void:
	Session.bones_amount_changed.connect(update_label)
	
func update_label():
	text = str("BONES : ", Session.current_bones)
	if Session.extra_bones > 0:
		label.text = str("+",Session.extra_bones)
		label._show()
		
func shake():
	anim_player.play("shake")

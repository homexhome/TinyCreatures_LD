extends AudioStreamPlayer
@export var ui_hover_sound : AudioStreamOggVorbis
@export var ui_pressed_sound : AudioStreamOggVorbis

func _enter_tree() -> void:
	get_tree().node_added.connect(add_item_to_sounds)

func add_item_to_sounds(node : Node):
	if node is Button:
		if !node.mouse_entered.is_connected(play_hover):
			node.mouse_entered.connect(play_hover)
		if !node.pressed.is_connected(play_pressed):
			node.pressed.connect(play_pressed)
	
	
func play_hover():
	pitch_scale = randf_range(0.9,1.1)
	stream = ui_hover_sound
	play()

func play_pressed():
	pitch_scale = randf_range(0.9,1.1)
	stream = ui_pressed_sound
	play()

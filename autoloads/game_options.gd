extends Control

func _ready() -> void:
	draw.connect(pause_game)
	hidden.connect(unpause_game)
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		handle_options_input()

func pause_game():
	get_tree().paused = true
	
func unpause_game():
	get_tree().paused = false


func handle_options_input():
	if get_parent().visible:
		get_parent().hide()
		unpause_game()
	else:
		get_parent().show()
		pause_game()

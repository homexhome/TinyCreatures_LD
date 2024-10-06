extends Control

@export var back_button : Button
@export var to_menu_button : Button

@export var main_menu_scene_path : String

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
		if GameManager.current_state == GameManager.GAME_STATE.MENU:
			back_button.show()
			to_menu_button.hide()
		if GameManager.current_state == GameManager.GAME_STATE.GAME:
			back_button.show()
			to_menu_button.show()
		pause_game()
		
func go_to_main_menu():
	get_tree().change_scene_to_file(main_menu_scene_path)
	handle_options_input()

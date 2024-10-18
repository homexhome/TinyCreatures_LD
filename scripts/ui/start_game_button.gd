extends Button
@export var scene_to_load : String
@export var loading_screen : Control
func _ready() -> void:
	pressed.connect(_on_pressed)
	ResultScreen.reset_game_over()
	
func _on_pressed():
	loading_screen.show()
	GameManager.change_game_state(GameManager.GAME_STATE.GAME)
	get_tree().change_scene_to_file(scene_to_load) 

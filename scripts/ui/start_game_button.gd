extends Button
@export var scene_to_load : String

func _ready() -> void:
	pressed.connect(_on_pressed)
	
func _on_pressed():
	GameManager.change_game_state(GameManager.GAME_STATE.GAME)
	get_tree().change_scene_to_file(scene_to_load) 

extends Control

var game_over : bool = false
@export var won : Control
@export var lost : Control
@export var main_menu_scene_path : String
var current_a : float

var speed = 5

func _ready() -> void:
	Event.game_lost.connect(game_lost)
	Event.game_won.connect(game_won)
	current_a = get_modulate().a

func _process(delta: float) -> void:
	if visible:
		modulate = Color(get_modulate().r, 
								  get_modulate().g, 
								  get_modulate().b, 
								  current_a)
		current_a +=  delta * speed
		
func game_won():
	show()
	won.show()
	lost.hide()
	
func game_lost():
	show()
	won.hide()
	lost.show()
	
func reset_game_over():
	hide()
	game_over = false
	modulate = Color(get_modulate().r, 
								  get_modulate().g, 
								  get_modulate().b, 
								  0)
	current_a = get_modulate().a

func go_to_menu():
	get_tree().change_scene_to_file(main_menu_scene_path)
	GameManager.change_game_state(GameManager.GAME_STATE.MENU)
	reset_game_over()

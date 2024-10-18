extends Control

var current_time : int = 300
var time_to_win : int = 0

var game_started : bool = false 

@export var timer : Timer
@export var label : Label

func _ready() -> void:
	Event.skeleton_spawned.connect(start_time)

func handle_time():
	if current_time == 0 :
		return
		
	if current_time == 1:
		current_time = 0
		Event.event_game_won()
		return
		
	current_time = current_time - 1
	var sec = current_time % 60
	var sec_string = sec
	if sec < 10:
		sec_string = str(0,sec)
	label.text = str(current_time/60, " : ", sec_string)

func start_time():
	if game_started: return
	game_started = true
	Event.start_battle_game()
	timer.start()

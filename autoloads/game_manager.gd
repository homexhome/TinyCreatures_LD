extends Node

enum GAME_STATE {MENU,GAME}
var current_state : GAME_STATE = GAME_STATE.MENU
var final_target 
func change_game_state(state : GAME_STATE):
	current_state = state

func register_final_target(target):
	final_target = target

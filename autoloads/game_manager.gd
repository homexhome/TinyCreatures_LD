extends Node

enum GAME_STATE {MENU,GAME}
var current_state : GAME_STATE = GAME_STATE.MENU

func change_game_state(state : GAME_STATE):
	current_state = state
	

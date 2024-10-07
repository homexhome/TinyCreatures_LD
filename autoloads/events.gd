extends Node


signal game_paused
signal game_started
signal skeleton_spawned
signal game_won
signal game_lost

func event_game_paused():
	game_paused.emit()

func start_battle_game():
	game_started.emit()

func event_skeleton_spawned():
	skeleton_spawned.emit()

func event_game_won():
	game_won.emit()
	
func event_game_lost():
	game_lost.emit()

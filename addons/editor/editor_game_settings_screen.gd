@tool
extends Control

@export var game_settings : GameGlobals

@export var starting_bones_line : LineEdit
@export var starting_enemies_count : LineEdit
@export var max_enemies_line : LineEdit
@export var time_for_enemies_spawn_line : LineEdit
@export var chance_to_increase_wave_count_line : LineEdit

func _ready() -> void:
	draw.connect(parse_game_globals)

func parse_game_globals():
	starting_bones_line.text = str(game_settings.starting_bones)
	starting_enemies_count.text = str(game_settings.starting_enemies_count)
	max_enemies_line.text = str(game_settings.max_enemies_count)
	time_for_enemies_spawn_line.text = str(game_settings.time_for_enemies_to_spawn)
	chance_to_increase_wave_count_line.text = str(game_settings.chance_to_increase_wave_count)

func save():
	game_settings.starting_bones = int(starting_bones_line.text)
	game_settings.starting_enemies_count = int(starting_enemies_count.text)
	game_settings.max_enemies_count = float(max_enemies_line.text)
	game_settings.time_for_enemies_to_spawn = float(time_for_enemies_spawn_line.text)
	game_settings.chance_to_increase_wave_count = float(chance_to_increase_wave_count_line.text)
	ResourceSaver.save(game_settings,game_settings.resource_path)
	parse_game_globals()

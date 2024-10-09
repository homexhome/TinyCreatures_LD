@tool
extends Control

@export var game_settings : GameGlobals
@export var res_path : String

@export var starting_bones_line : LineEdit
@export var starting_enemies_count : LineEdit
@export var max_enemies_line : LineEdit
@export var time_for_enemies_spawn_line : LineEdit
@export var chance_to_increase_wave_count_line : LineEdit


func _ready() -> void:
	draw.connect(parse_game_globals)

func parse_game_globals():
	game_settings = ResourceLoader.load(res_path,"",ResourceLoader.CACHE_MODE_IGNORE_DEEP)
	starting_bones_line.text = str(game_settings.starting_bones)
	starting_enemies_count.text = str(game_settings.starting_enemies_count)
	max_enemies_line.text = str(game_settings.max_enemies_count)
	time_for_enemies_spawn_line.text = str(game_settings.time_for_enemies_to_spawn)
	chance_to_increase_wave_count_line.text = str(game_settings.chance_to_increase_wave_count)

func save():
	var new_game_res = ResourceLoader.load(res_path,"",ResourceLoader.CACHE_MODE_IGNORE_DEEP).duplicate()
	new_game_res.starting_bones = int(starting_bones_line.text)
	new_game_res.starting_enemies_count = int(starting_enemies_count.text)
	new_game_res.max_enemies_count = float(max_enemies_line.text)
	new_game_res.time_for_enemies_to_spawn = float(time_for_enemies_spawn_line.text)
	new_game_res.chance_to_increase_wave_count = float(chance_to_increase_wave_count_line.text)
	var err = ResourceSaver.save(new_game_res,res_path)
	print("Save result is ", err)
	parse_game_globals()

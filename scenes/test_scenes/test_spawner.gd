extends Node3D

@export var characters_to_spawn : Array[PackedScene]
@export var mobs_node : Node3D
var characters : Array
var min_mobs : int = 1
var max_mobs : int = 8

var current_mobs : int = 3
@export var spawn_places_node : Node3D
var spawn_places : Array
@export var timer : Timer
var game_started

var chance_to_increase_next_wave = 0.5

func _ready() -> void:
	current_mobs = Session.game_globals.starting_enemies_count
	max_mobs = Session.game_globals.max_enemies_count
	timer.wait_time = Session.game_globals.time_for_enemies_to_spawn
	chance_to_increase_next_wave =  Session.game_globals.chance_to_increase_wave_count / 100
	Event.game_started.connect(start_spawn)
	for child in spawn_places_node.get_children():
		spawn_places.append(child)
	for character in characters_to_spawn:
		var ch = character.instantiate()
		characters.append(ch)
		await get_tree().process_frame

func start_spawn():
	game_started = true
	timer.start()
	spawn_hostile_wave()

func spawn_hostile_wave():
	if !game_started: return
	var current_mob_to_spawn_array = []
	for i in range(current_mobs):
		current_mob_to_spawn_array.append(characters_to_spawn.pick_random())
		
	if randf() > chance_to_increase_next_wave:
		current_mobs = clampi(current_mobs + 1, min_mobs, max_mobs)
	for char in current_mob_to_spawn_array:
		var new_char = characters.pick_random().duplicate()
		mobs_node.add_child(new_char)
		new_char.global_position = spawn_places.pick_random().global_position

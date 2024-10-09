@tool
extends Control
var character : CharacterStats
@export var type_button : MenuButton
@export var type_label : Label
@export var name_label : Label


var character_name : String
var type : CharacterStats.COMBAT_TYPE
var max_health : float = 100
var attack_damage : float = 20
var movement_speed : float = 3 
var attack_speed : float = 3 
var cast_speed : float = 3 
var minimum_distance_to_attack : float = 1
var recieving_close_combat_damage_modifier : float = 1.0
var recieving_archer_damage_modifier : float = 1.0
var recieving_magic_damage_modifier : float = 1.0
var cost_on_death : int = 50
var cost_to_create : int = 0

@export var max_health_label : Label
@export var max_health_line : LineEdit

@export var attack_damage_label : Label
@export var attack_damage_line : LineEdit

@export var movement_speed_label : Label
@export var movement_speed_line : LineEdit

@export var attack_speed_label: Label
@export var attack_speed_line: LineEdit

@export var cast_speed_label : Label
@export var cast_speed_line : LineEdit

@export var minimum_distance_to_attack_label : Label
@export var minimum_distance_to_attack_line : LineEdit

@export var recieving_close_combat_damage_modifier_label : Label
@export var recieving_close_combat_damage_modifier_line : LineEdit

@export var recieving_archer_damage_modifier_label : Label
@export var recieving_archer_damage_modifier_line : LineEdit

@export var recieving_magic_damage_modifier_label : Label
@export var recieving_magic_damage_modifier_line : LineEdit

@export var cost_on_death_label : Label
@export var cost_on_death_line : LineEdit

@export var cost_to_create_label : Label
@export var cost_to_create_line : LineEdit
var char_res_path : String

func _ready() -> void:
	type_button.get_popup().id_pressed.connect(type_label.set_label_text.bind())


func setup_character_edit_window(res_path : String):
	char_res_path = res_path
	parse_character()

func parse_character():
	character = ResourceLoader.load(char_res_path,"",ResourceLoader.CACHE_MODE_IGNORE_DEEP)
	name_label.text = character.character_name
	type_label.set_label_text(character.type)
	max_health_line.text = str(character.max_health)
	attack_damage_line.text = str(character.attack_damage)
	movement_speed_line.text = str(character.movement_speed)
	attack_speed_line.text = str(character.attack_speed)
	cast_speed_line.text = str(character.cast_speed)
	minimum_distance_to_attack_line.text = str(character.minimum_distance_to_attack)
	recieving_close_combat_damage_modifier_line.text  = str(character.recieving_close_combat_damage_modifier)
	recieving_archer_damage_modifier_line.text  = str(character.recieving_archer_damage_modifier)
	recieving_magic_damage_modifier_line.text  = str(character.recieving_magic_damage_modifier)
	cost_on_death_line.text  = str(character.cost_on_death)
	cost_to_create_line.text  = str(character.cost_to_create)

func save_character():
	var new_stats = ResourceLoader.load(char_res_path,"",ResourceLoader.CACHE_MODE_IGNORE_DEEP)
	new_stats.type = get_type()
	new_stats.max_health = float(max_health_line.text)
	new_stats.attack_damage = float(attack_damage_line.text)
	new_stats.movement_speed = float(movement_speed_line.text)
	new_stats.attack_speed = float( attack_speed_line.text)
	new_stats.cast_speed= float( cast_speed_line.text)
	new_stats.minimum_distance_to_attack= float( minimum_distance_to_attack_line.text)
	new_stats.recieving_close_combat_damage_modifier= float( recieving_close_combat_damage_modifier_line.text)
	new_stats.recieving_archer_damage_modifier= float( recieving_archer_damage_modifier_line.text )
	new_stats.recieving_magic_damage_modifier= float( recieving_magic_damage_modifier_line.text)
	new_stats.cost_on_death= int( cost_on_death_line.text)
	new_stats.cost_to_create= int( cost_to_create_line.text)
	var err = ResourceSaver.save(new_stats,char_res_path)
	parse_character()

func get_type():
	match type_label.text:
		"Melee":
			return 0
		"Archer":
			return 1
		"Mage":
			return 2
			
func set_visuals():
	update_type_label()
	name_label.text = character_name
	

func update_type_label():
	type_label.set_label_text(type)

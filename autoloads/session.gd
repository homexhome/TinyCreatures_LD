extends Node

var current_bones : int = 1000
var starting_bones : int = 1000
var extra_bones : int = 0
signal bones_amount_changed
@export var game_globals : GameGlobals

var blocked : bool = false
var spawn_blocked : bool = false

var camera_on_left : bool = false
var camera_on_right : bool = false

func _ready() -> void:
	starting_bones = game_globals.starting_bones

func set_camera_left():
	camera_on_left = true

func set_camera_right():
	camera_on_right = true
	
func reset_camera_status():
	camera_on_right = false
	camera_on_left = false
	
func flush_session():
	current_bones = starting_bones
	extra_bones = 0
	bones_amount_changed.emit()

func add_bones(amount : int):
	current_bones += amount
	extra_bones = amount
	bones_amount_changed.emit()
	extra_bones = 0
	
	
func remove_bones(amount : int):
	if blocked: return
	current_bones = clampi(current_bones - amount, 0, 999999)
	extra_bones = 0
	bones_amount_changed.emit()

func block():
	blocked = true 
	
func unblock():
	blocked = false

func block_spawn():
	spawn_blocked = true
	
func unblock_spawn():
	spawn_blocked = false

func check_if_can_spend(amount):
	return current_bones - amount < 0

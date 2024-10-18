@tool
extends GridContainer
@export var directory : String
@export var char_stats_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		child.queue_free()

func on_draw():
	for child in get_children():
		child.queue_free()
	var dir = DirAccess.open(directory)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
			create_character_scene(directory+file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

func create_character_scene(file_name):
	var char_stats = char_stats_scene.instantiate()
	add_child(char_stats)
	char_stats.setup_character_edit_window(file_name)

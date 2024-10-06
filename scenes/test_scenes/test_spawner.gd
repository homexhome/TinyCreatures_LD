extends Node3D

@export var characters_to_spawn : Array[PackedScene]
@export var mobs_node : Node3D

func spawn_hostiles():
	for char in characters_to_spawn:
		var new_char = char.instantiate()
		mobs_node.add_child(new_char)
		new_char.global_position = global_position + Vector3.FORWARD * randf_range(-1,1)

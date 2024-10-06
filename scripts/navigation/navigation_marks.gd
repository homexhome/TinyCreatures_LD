extends Node3D

@export var paths_array : Array[Path3D]

func take_path_array():
	var path = paths_array.pick_random()
	var new_array : Array[Vector3] = []
	for vector in path.get_curve().get_baked_points():
		new_array.append(vector + path.global_position)
	return new_array

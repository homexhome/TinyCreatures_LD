extends Node3D

@export var scenes_to_preload_array : Array[PackedScene]
@export var place_to_load : Node3D
@export var scene_to_load : String

func _ready() -> void:
	for scene in scenes_to_preload_array:
		var _scene = scene.instantiate()
		place_to_load.add_child(_scene)
		await get_tree().physics_frame
		_scene.queue_free()
	get_tree().change_scene_to_file(scene_to_load) 

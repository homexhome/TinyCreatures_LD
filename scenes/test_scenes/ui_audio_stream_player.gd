extends AudioStreamPlayer

@export var skeleton_spawning_sounds_array : Array[AudioStreamOggVorbis] = []
@export var denied_sound : AudioStreamOggVorbis

func spawn_skeleton():
	var delta_s = skeleton_spawning_sounds_array.pick_random()
	while stream ==delta_s:
		delta_s = skeleton_spawning_sounds_array.pick_random()
	stream = delta_s
	pitch_scale = randf_range(0.8, 1.2)
	play()

func deny_spawn():
	stream = denied_sound
	play()
	

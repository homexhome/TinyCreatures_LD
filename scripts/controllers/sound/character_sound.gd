extends AudioStreamPlayer3D
class_name CharacterSound

@export var death_sound : AudioStreamOggVorbis
@export var damage_sound : AudioStreamOggVorbis
@export var attack_sound : AudioStreamOggVorbis

func play_special_sound(sound_name : String):
	match sound_name:
		"death":
			stream = death_sound
		"damage":
			stream = damage_sound
		"attack":
			stream = attack_sound
	pitch_scale = randf_range(0.8,1.2)
	play()

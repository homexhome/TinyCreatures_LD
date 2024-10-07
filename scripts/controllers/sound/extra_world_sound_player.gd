extends AudioStreamPlayer
@export var start_sound : AudioStreamOggVorbis
@export var lose_sound : AudioStreamOggVorbis
@export var win_sound  : AudioStreamOggVorbis

func _ready() -> void:
	Event.game_started.connect(play_special_sound.bind("start"))

func play_special_sound(sound_name : String):
	match sound_name:
		"win":
			stream = win_sound
		"lose":
			stream = lose_sound
		"start":
			stream = start_sound
	play()

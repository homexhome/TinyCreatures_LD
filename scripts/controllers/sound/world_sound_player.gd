extends AudioStreamPlayer

@export var ambient_sound : AudioStreamOggVorbis
@export var battle_sound : AudioStreamOggVorbis

var first_stream_volume
var second_stream_volume
@export var is_ambient : bool = false
var change_speed : float = 10
var max_sound : float = -9
func _ready() -> void:
	#first_stream_volume = stream.get_sync_stream_volume(0)
	#second_stream_volume = stream.get_sync_stream_volume(1)
	#
	#Event.game_started.connect(play_special_sound("battle"))
	Event.game_started.connect(battle_started)

#var is_battle_started : bool
#func _process(delta: float) -> void:
	#if !is_battle_started:
		#if stream.get_sync_stream_volume(0) <= max_sound:
			#stream.set_sync_stream_volume(0, first_stream_volume + delta * change_speed) 
		#if stream.get_sync_stream_volume(1) >= -60:
			#stream.set_sync_stream_volume(1, second_stream_volume - delta * change_speed) 
	#else:
		#if stream.get_sync_stream_volume(1) <= max_sound:
			#stream.set_sync_stream_volume(1, second_stream_volume + delta * change_speed) 
		#if stream.get_sync_stream_volume(0) >= -60:
			#stream.set_sync_stream_volume(0, first_stream_volume - delta * change_speed)
	#first_stream_volume = stream.get_sync_stream_volume(0)
	#second_stream_volume = stream.get_sync_stream_volume(1)
var is_battle_started : bool = false
func battle_started():
	is_battle_started = true
	is_ambient = !is_ambient
	
func play_special_sound(sound_name : String):
	match sound_name:
		"ambient":
			stream.set
		"battle":
			stream = battle_sound
	play()
func _process(delta: float) -> void:
	if is_ambient:
		if get_volume_db() >= -59:
			set_volume_db(get_volume_db() - get_process_delta_time() * change_speed)
	else:
		if get_volume_db() <= -15:
			set_volume_db(get_volume_db() + get_process_delta_time() * change_speed)
	#if is_battle_started: return
	#stream.set_sync_stream_volume(1, -30) 
	#second_stream_volume = stream.get_sync_stream_volume(1)
	#is_battle_started = true
	#
	#

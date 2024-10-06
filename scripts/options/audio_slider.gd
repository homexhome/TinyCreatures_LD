extends HSlider

func _ready():
	value_changed.connect(_on_value_changed)
	
	
func _restore_slider():
	value = db_to_linear(0)
	
func _on_value_changed(_value : float):
	if _value == 0:
		AudioServer.set_bus_mute(0, true)
	else:
		if AudioServer.is_bus_mute(0):
			AudioServer.set_bus_mute(0, false)
		AudioServer.set_bus_volume_db(0, linear_to_db(_value))
		print(AudioServer.get_bus_volume_db(0), " bus db")

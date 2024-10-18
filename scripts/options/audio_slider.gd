extends HSlider
@export var bus_id : int = 0
func _ready():
	value_changed.connect(_on_value_changed)
	
	
func _restore_slider():
	value = db_to_linear(0)
	
func _on_value_changed(_value : float):
	if _value == 0:
		AudioServer.set_bus_mute(bus_id, true)
	else:
		if AudioServer.is_bus_mute(bus_id):
			AudioServer.set_bus_mute(bus_id, false)
		AudioServer.set_bus_volume_db(bus_id, linear_to_db(_value))
		print(AudioServer.get_bus_volume_db(bus_id), " bus db")

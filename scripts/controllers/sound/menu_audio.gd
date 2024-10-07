extends AudioStreamPlayer

var max_volume : float = -15
var speed : float = 10
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if volume_db <= max_volume:
		set_volume_db(volume_db + delta * speed)

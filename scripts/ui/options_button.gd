extends Button

func _ready() -> void:
	pressed.connect(GameOptions.handle_options_input)

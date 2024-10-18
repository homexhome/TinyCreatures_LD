extends MeshInstance3D

var showing : bool = false
var max_a : float = 0.2
var current_a : float = 0
var speed : float = 3

var color : Color
var material 
var rising : bool = true

@export var ui : Control
func _ready() -> void:
	material = get_surface_override_material(0)

func _process(delta: float) -> void:
	if is_instance_valid(ui.active_monster_button) == false : 
		if visible: hide()
		set_showing(false)
		return
	if visible == false: show()
	if rising:
		if current_a >= max_a:
			rising = false
			return
		material.albedo_color = Color(material.albedo_color.r, 
								  material.albedo_color.g, 
								  material.albedo_color.b, 
								  current_a)
		current_a +=  delta / speed
	else:
		if current_a <= 0:
			rising = true
			return
		material.albedo_color = Color(material.albedo_color.r, 
								  material.albedo_color.g, 
								  material.albedo_color.b, 
								  current_a)
		current_a = clampf(current_a - delta / speed, 0, 200)
	#print(current_a," ", rising)

func set_showing(value : bool):
	if !value:
		showing = false
		current_a = 0
		material.albedo_color = Color(material.albedo_color.r, 
								  material.albedo_color.g, 
								  material.albedo_color.b, 
								  current_a)
	else:
		showing = true

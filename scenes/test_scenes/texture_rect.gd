extends Button
class_name MonsterButton
@export var id : int = 1
@export var mesh_to_inst : PackedScene
@export var bone_cost : int = 100
@export var ui : UIControl

func _ready():
	pressed.connect(_on_pressed)

func print_name():
	print(name)

func _on_pressed():
	ui.active_monster_button_set(self)

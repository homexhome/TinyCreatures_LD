extends Button
class_name MonsterButton
@export var id : int = 1
@export var mesh_to_inst : PackedScene
@export var bone_cost : int = 100
@export var ui : UIControl
@export var character_stats_to_spawn : CharacterStats
@export var cost_label : Label
var spawned
func _ready():
	spawned = mesh_to_inst.instantiate()
	spawned.queue_free()
	
	bone_cost = character_stats_to_spawn.cost_to_create
	pressed.connect(_on_pressed)
	update_cost_label()

func update_cost_label():
	cost_label.text = str(bone_cost)

func print_name():
	print(name)

func _on_pressed():
	ui.active_monster_button_set(self)

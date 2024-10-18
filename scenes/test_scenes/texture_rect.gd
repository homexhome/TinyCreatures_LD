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

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("1") and id == 1:
		select()
	if event.is_action_pressed("2") and id == 2:
		select()
	if event.is_action_pressed("3") and id == 3:
		select()
		
func select():
	grab_focus()
	ui.active_monster_button_set(self)
	pressed.emit()

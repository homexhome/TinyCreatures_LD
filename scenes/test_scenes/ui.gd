extends Control
class_name UIControl
@export var place_to_load : Node3D
@export var label_to_feedback : Label
var current_container_monsters : Array = []
var active_monster_button : MonsterButton
@export var ui_sound : AudioStreamPlayer


func _ready() -> void:
	Event.game_lost.connect(hide)
	Event.game_won.connect(hide)
	
func monster_spawn_from_button(target_pos : Vector3):
	if is_instance_valid(active_monster_button) == false: return
	if Session.spawn_blocked: return
	if Session.check_if_can_spend(active_monster_button.bone_cost):
		label_to_feedback.shake()
		ui_sound.deny_spawn()
		return
	if active_monster_button.mesh_to_inst != null:
		Session.remove_bones(active_monster_button.bone_cost)
		ui_sound.spawn_skeleton()
		Event.event_skeleton_spawned()
		var new_mob = active_monster_button.mesh_to_inst.instantiate()
		place_to_load.add_child(new_mob)
		new_mob.global_position = target_pos
		active_monster_button = null
		get_viewport().gui_release_focus()

func active_monster_button_set(new_active_button : MonsterButton):
	active_monster_button = new_active_button

func _input(event: InputEvent) -> void:
	if is_instance_valid(active_monster_button) == false: return
	if event.is_action_pressed("reset_pick"):
		Session.block()
		active_monster_button = null
		get_viewport().gui_release_focus()

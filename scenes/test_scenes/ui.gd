extends Control
class_name UIControl
@export var place_to_load : Node3D

var current_container_monsters : Array = []
var active_monster_button : MonsterButton

func monster_spawn_from_button(target_pos : Vector3):
	if is_instance_valid(active_monster_button) == false: return
	if active_monster_button.mesh_to_inst != null:
		var new_mob = active_monster_button.mesh_to_inst.instantiate()
		place_to_load.add_child(new_mob)
		new_mob.global_position = target_pos

func active_monster_button_set(new_active_button : MonsterButton):
	active_monster_button = new_active_button

extends Node3D
class_name Blast
@export var particles : GPUParticles3D
@export var area : Area3D

var target : Character
var type : CharacterStats.COMBAT_TYPE
var damage : float = 0
var character_owner : Character

signal finished

func explode(_damage, _character_owner, _type):
	for body in area.get_overlapping_bodies():
		if ValidityChecker.check_validity(body,_character_owner):
			body.take_damage(_damage, _character_owner, type)
	particles.finished.connect(finish_blast)
	particles.set_emitting(true)
	
func finish_blast():
	finished.emit()

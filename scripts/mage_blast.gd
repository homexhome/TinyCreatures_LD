extends Node3D
@export var particles : GPUParticles3D
@export var area : Area3D

var target : Character
var type : CharacterStats.COMBAT_TYPE
var damage : float = 0
var character_owner : Character

signal finished

func explode(_damage, _character_owner, _type):
	#for body in 
	pass

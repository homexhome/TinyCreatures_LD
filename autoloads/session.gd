extends Node

var current_bones : int = 1000
var starting_bones : int = 1000
var extra_bones : int = 0
signal bones_amount_changed

var blocked : bool = false

func flush_session():
	current_bones = starting_bones
	extra_bones = 0
	bones_amount_changed.emit()

func add_bones(amount : int):
	current_bones += amount
	extra_bones = amount
	bones_amount_changed.emit()
	extra_bones = 0
	
	
func remove_bones(amount : int):
	if blocked: return
	current_bones = clampi(current_bones - amount, 0, 999999)
	extra_bones = 0
	bones_amount_changed.emit()

func block():
	blocked = true 
	
func unblock():
	blocked = false

extends Node2D
@export var enemy_list : Array[CharacterBody2D] = []

var victory_trigger: bool = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
		if check_all_enemies_dead():
			trigger_victory()

func check_all_enemies_dead() -> bool:
	if enemy_list.is_empty():
		return false
	for enemy in enemy_list:
		if is_instance_valid(enemy) and not enemy.is_queued_for_deletion():
			return false 	
	return true 
func trigger_victory() -> void:
	victory_trigger = true
	get_tree().change_scene_to_file("res://scenes/winner.tscn")

	

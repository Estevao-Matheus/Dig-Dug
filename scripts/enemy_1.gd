extends Area2D

@onready var _animated_sprite = $AnimatedSprite2D

signal enemy_hit

var is_dead: bool = false
var inflation_level: int = 0

func _ready() -> void:
	add_to_group("enemies")

func get_hit_by_hook(hook: Area2D) -> void:
	if is_dead:
		return
		
	print("Acertado pelo hook!")
	is_dead = true
	enemy_hit.emit()
	
	if hook.player_ref and hook.player_ref.has_method("register_target"):
		hook.player_ref.register_target(hook, self)
		
	_animated_sprite.play("death")
	_animated_sprite.pause()
	_animated_sprite.frame = 0

func inflate() -> bool:
	if inflation_level < 3:
		inflation_level += 1
		_animated_sprite.frame = inflation_level
		print("Nivel de inflação: ", inflation_level)
		return false
		
	if inflation_level == 3:
		die()
		return true
		
	return false

func deflate() -> void:
	if inflation_level > 0:
		inflation_level -= 1
		_animated_sprite.frame = inflation_level
		print("Nivel de deflação: ", inflation_level)
	else:
		release_enemy()

func release_enemy() -> void:
	is_dead = false
	if get_parent().has_method("resume_walking"):
		get_parent().resume_walking()

func die() -> void:
	queue_free()
	if owner:
		owner.queue_free()

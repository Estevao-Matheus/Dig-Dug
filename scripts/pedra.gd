extends Area2D

@export var fall_speed: float = 180.0
@onready var _animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var is_falling: bool = false
var is_breaking: bool = false
var start_y: float = 0.0

func _ready() -> void:
	add_to_group("stones")
	_animated_sprite.play("idle")

func start_stone_fall() -> void:
	if is_falling or is_breaking: return
	
	_animated_sprite.play("tween")
	await _animated_sprite.animation_finished
	
	_animated_sprite.play("idle")
	start_y = global_position.y
	is_falling = true

func _physics_process(delta: float) -> void:
	if not is_falling or is_breaking: return

	global_position.y += fall_speed * delta
	
	for area in get_overlapping_areas():
		if area.name == "Enemy_collision":
			is_falling = false
			is_breaking = true
			area.get_parent()._on_area_entered(self)
			execute_destruction()
			return
		elif area.is_in_group("enemies"):
			is_falling = false
			is_breaking = true
			area.limpar_e_morrer(null)
			execute_destruction()
			return

func _on_body_entered(body: Node2D) -> void:
	if is_falling and not is_breaking and body is TileMapLayer:
		if global_position.y > start_y + 8:
			is_falling = false
			is_breaking = true
			execute_destruction()

func execute_destruction() -> void:
	monitoring = false 
	monitorable = false
	_animated_sprite.play("break")
	await _animated_sprite.animation_finished
	queue_free()

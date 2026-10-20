extends CharacterBody2D

const SPEED = 50.0
@export var target: CharacterBody2D

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var _animated_sprite: AnimatedSprite2D = $Area2D/AnimatedSprite2D
@onready var wait_time: float = 5.0

var can_move: bool = true
var center_position: Vector2
var going_to_center: bool = false

func _ready() -> void:
	if has_node("Area2D"):
		$Area2D.enemy_hit.connect(_on_enemy_hit)
	if target:
		center_position = target.global_position	
	
	get_tree().create_timer(wait_time).timeout.connect(func(): going_to_center = true)

func _physics_process(delta: float) -> void:
	if not can_move:
		velocity = Vector2.ZERO
		return
		
	if going_to_center:
		global_position = global_position.move_toward(center_position, SPEED * delta)
		animation_control()
		if global_position.distance_to(center_position) < 5.0:
			going_to_center = false
		return
		
	var direction = to_local(navigation_agent_2d.get_next_path_position()).normalized()
	velocity = direction * SPEED
	move_and_slide()

func go_to_target() -> void:
	navigation_agent_2d.target_position = target.global_position
	animation_control()
   
func _on_timer_timeout() -> void:
	if not going_to_center:
		go_to_target()
	
func animation_control() -> void:
	if velocity.x < -0.1:
		_animated_sprite.play("move_right")
	elif velocity.x > 0.1:
		_animated_sprite.play("move_left")
		
	if going_to_center:
		_animated_sprite.play("ghost_move")
		 		
func _on_enemy_hit() -> void:
	can_move = false

func resume_walking() -> void:
	can_move = true

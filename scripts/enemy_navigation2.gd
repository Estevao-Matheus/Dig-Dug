extends CharacterBody2D

const SPEED = 50.0
@export var target : CharacterBody2D
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var _animated_sprite: AnimatedSprite2D = $Area2D/AnimatedSprite2D
@onready var wait_time : float = 7.0
@onready var fire_spawn_point: Marker2D = $FireSpawnPoint

@export var fire_attack_scene: PackedScene = preload("res://scenes/fire_attack.tscn")
@export var attack_distance: float = 80.0 
@export var y_alignment_tolerance: float = 16.0 
@export var attack_cooldown: float = 4.0 

var can_move: bool = true
var center_position: Vector2
var going_to_center: bool = false
var is_attacking: bool = false
var can_attack: bool = true

func _ready() -> void:
	if has_node("Area2D"):
		$Area2D.enemy_hit.connect(_on_enemy_hit)
	if target:
		center_position = target.global_position	
	get_tree().create_timer(wait_time).timeout.connect(func(): going_to_center = true)

func _physics_process(delta: float):
	if not can_move:
		velocity = Vector2.ZERO
		return

	if is_attacking:
		velocity = Vector2.ZERO
		return
		
	if going_to_center:
		global_position = global_position.move_toward(center_position, SPEED * delta)
		animation_control()
		if global_position.distance_to(center_position) < 5.0:
			going_to_center = false
		return
		
	if target:
		navigation_agent_2d.target_position = target.global_position
		check_and_attack()
		
	var direction = to_local(navigation_agent_2d.get_next_path_position()).normalized()
	velocity = direction * SPEED
	move_and_slide()

func go_to_target():
	if target:
		navigation_agent_2d.target_position = target.global_position
		animation_control()
   
func _on_timer_timeout() -> void:
	if not going_to_center:
		go_to_target()
	
func animation_control():
	if is_attacking:
		return 
		
	if velocity.x < - 0.1:
		_animated_sprite.play("move_right")
	elif velocity.x > 0.1:
		_animated_sprite.play("move_left")
	if going_to_center:
		_animated_sprite.play("ghost_move")

func check_and_attack() -> void:
	if not target or not can_attack or is_attacking or not can_move:
		return
	var current_distance = global_position.distance_to(target.global_position)
	var y_difference = abs(global_position.y - target.global_position.y)
	if current_distance <= attack_distance and y_difference <= y_alignment_tolerance:
		execute_fire_attack()

func execute_fire_attack() -> void:
	is_attacking = true
	can_attack = false
	velocity = Vector2.ZERO
	
	var direction_to_player = target.global_position.x - global_position.x
	var fire_animation_name = "attack_right"
	
	var spawn_position = fire_spawn_point.position
	
	if direction_to_player < 0:
		fire_animation_name = "attack_left"
		_animated_sprite.play("move_right") 
		spawn_position.x = -spawn_position.x
	else:
		fire_animation_name = "attack_right"
		_animated_sprite.play("move_left")
		
	if fire_attack_scene:
		var fire_instance = fire_attack_scene.instantiate() as Area2D
		add_child(fire_instance)
		fire_instance.position = spawn_position
		fire_instance.start_attack(fire_animation_name)
		await fire_instance.tree_exited
		
	is_attacking = false
	get_tree().create_timer(attack_cooldown).timeout.connect(func(): can_attack = true)

func _on_enemy_hit() -> void:
	print("Acertou inimigo: ")
	can_move = false

func resume_walking() -> void:
	can_move = true

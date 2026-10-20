extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"

const HOOK_SCENE = preload("res://scenes/hook.tscn")

var facing_right: bool = true
var is_pumping: bool = false

@onready var raycast_right: RayCast2D = $RayCast2D_Right
@onready var raycast_left: RayCast2D = $RayCast2D_Left
@onready var raycast_up: RayCast2D = $RayCast2D_Up
@onready var raycast_down: RayCast2D = $RayCast2D_Down
@onready var enemy_collision: Area2D = $Enemy_collision

signal send_tile(vector: Vector2i)

const SPEED = 190.0
var score: int = 0
var life: int = 1

var current_hook: Area2D = null
var current_enemy: Area2D = null
var pump_timer: float = 0.0
const PUMP_RATE: float = 0.25 

func _ready() -> void:
	if not enemy_collision.area_entered.is_connected(_on_area_entered):
		enemy_collision.area_entered.connect(_on_area_entered)

func _physics_process(delta: float) -> void:
	if _animated_sprite.animation.begins_with("death"):
		velocity = Vector2.ZERO
		move_and_slide()
		return
		
	if is_pumping and is_instance_valid(current_enemy):
		velocity = Vector2.ZERO
		move_and_slide()
		
		pump_timer += delta
		if pump_timer >= PUMP_RATE:
			pump_timer = 0.0 
			
			if Input.is_action_pressed("attack"):
				update_pump_animation(true)
				var enemy_died = current_enemy.inflate()
				if enemy_died:
					clear_attack_state()
			else:
				update_pump_animation(false)
				current_enemy.deflate()
				if not current_enemy.is_dead:
					clear_attack_state()
		return

	if get_slide_collision_count() > 0:
		var collision_point = get_slide_collision(0)
		var adjusted_point = collision_point.get_position() - collision_point.get_normal()
		var collision_vector2i: Vector2i = tile_map_layer.local_to_map(adjusted_point)
		send_tile.emit(collision_vector2i)
		var colided = collision_point.get_collider()
		if colided and colided.is_in_group("boundaries"):
			print(colided)
			print("colidiu com barreira")
		else:
			score += 10
		
	if Input.is_action_just_pressed("attack") and not is_instance_valid(current_hook):
		attack()
		
	var direction = Input.get_vector("left", "right", "up", "down")
	if Input.is_action_pressed("right"):
		if raycast_right.is_colliding():
			_animated_sprite.play("walk_digging_right")
		else:	
			_animated_sprite.play("walk_right")
		_animated_sprite.flip_h = false
		facing_right = true
		direction.y = 0
	elif Input.is_action_pressed("left"):
		if raycast_left.is_colliding():
			_animated_sprite.play("walk_digging_left")
		else:	
			_animated_sprite.play("walk_left")
		_animated_sprite.flip_h = false
		facing_right = false
		direction.y = 0
	elif Input.is_action_pressed("up"):
		if raycast_up.is_colliding():
			_animated_sprite.play("walk_digging_up")
		else:	
			_animated_sprite.play("walk_up")
		_animated_sprite.flip_h = not facing_right
		direction.x = 0
	elif Input.is_action_pressed("down"):
		if raycast_down.is_colliding():
			_animated_sprite.play("walk_digging_down")
		else:
			_animated_sprite.play("walk_down")	
		_animated_sprite.flip_h = facing_right
		direction.x = 0
	else:
		direction = Vector2.ZERO
		
	direction = direction.normalized()
	velocity = (direction * SPEED)			
	move_and_slide()
	
	if direction == Vector2.ZERO:
		global_position = global_position.snapped(Vector2(16, 16))
		
func attack() -> void:
	var hook_instance = HOOK_SCENE.instantiate()
	hook_instance.player_ref = self
	current_hook = hook_instance
	
	var hook_sprite = hook_instance.get_node("AnimatedSprite2D")
	var current_anim = _animated_sprite.animation
	var offset = Vector2.ZERO
	var front_dist = 16.0  
	var down_dist = 8.0    
	
	if "right" in current_anim:
		offset = Vector2(front_dist + 15, down_dist)
		hook_sprite.play("attack_right")
	elif "left" in current_anim:
		offset = Vector2(-front_dist - 2, down_dist)
		hook_sprite.play("attack_left")
	elif "up" in current_anim:
		offset = Vector2(down_dist, -front_dist)
		hook_sprite.play("attack_up")
	elif "down" in current_anim:
		offset = Vector2(down_dist, front_dist + 12)
		hook_sprite.play("attack_down")
		
	hook_instance.global_position = global_position + offset		
	get_parent().add_child(hook_instance)
	
func update_pump_animation(holding: bool) -> void:
	if not holding:
		return
		
	is_pumping = true
	var current_anim = _animated_sprite.animation
	
	if "right" in current_anim and _animated_sprite.animation != "pumping_right":
		_animated_sprite.play("pumping_right")
	elif "left" in current_anim and _animated_sprite.animation != "pumping_left":
		_animated_sprite.play("pumping_left")
	elif "up" in current_anim and _animated_sprite.animation != "pumping_up":
		_animated_sprite.play("pumping_up")
	elif "down" in current_anim and _animated_sprite.animation != "pumping_down":
		_animated_sprite.play("pumping_down")

func register_target(hook: Area2D, enemy: Area2D) -> void:
	current_hook = hook
	current_enemy = enemy
	is_pumping = true
	pump_timer = 0.0
	update_pump_animation(true)

func clear_attack_state() -> void:
	is_pumping = false
	if is_instance_valid(current_hook):
		current_hook.clear_hook()
	current_hook = null
	current_enemy = null
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies") or area.is_in_group("stones"):
		life -= 1
		Global.final_score = score
		var current_anim = _animated_sprite.animation
		
		if "right" in current_anim and _animated_sprite.animation != "death_right":
			_animated_sprite.play("death_right")
		elif "left" in current_anim and _animated_sprite.animation != "death_left":
			_animated_sprite.play("death_left")
		elif "up" in current_anim and _animated_sprite.animation != "death_up":
			_animated_sprite.play("death_up")
		elif "down" in current_anim and _animated_sprite.animation != "death_down":
			_animated_sprite.play("death_down")
			
		enemy_collision.set_deferred("monitoring", false)
		enemy_collision.set_deferred("monitorable", false)	
		await get_tree().create_timer(1.0).timeout
		if is_inside_tree() and get_tree() != null:
			get_tree().change_scene_to_file("res://scenes/game_over.tscn")

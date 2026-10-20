extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

var is_stuck: bool = false 
var player_ref: CharacterBody2D = null
var attached_enemy: Area2D = null

func _ready() -> void:
	add_to_group("attack")
	sprite.frame_changed.connect(_on_frame_changed)
	sprite.animation_finished.connect(_on_animation_finished)
	
	if not area_entered.is_connected(_on_area_entered):
		area_entered.connect(_on_area_entered)
		
	sprite.centered = true 
	_on_frame_changed()

func _on_area_entered(area: Area2D) -> void:
	if is_stuck:
		return
		
	if area.is_in_group("enemies"):
		is_stuck = true
		sprite.pause()
		attached_enemy = area
		
		if area.has_method("get_hit_by_hook"):
			area.get_hit_by_hook(self)

func _on_frame_changed() -> void:
	if is_stuck:
		return 
		
	var current_anim = sprite.animation
	var texture = sprite.sprite_frames.get_frame_texture(current_anim, sprite.frame)
	
	if not texture or not (texture is AtlasTexture):
		return
		
	var region = texture.region
	var width = region.size.x
	var height = region.size.y
	
	collision.position = Vector2.ZERO
	
	if "attack_right" in current_anim:
		collision.position.x = width / 2.5
	elif "attack_left" in current_anim:
		collision.position.x = -width / 2.5
	elif "attack_up" in current_anim:
		collision.position.y = -height / 2.5
	elif "attack_down" in current_anim:
		collision.position.y = height / 2.5

func clear_hook() -> void:
	queue_free()

func _on_animation_finished() -> void:
	if not is_stuck:
		queue_free()

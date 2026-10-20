extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	add_to_group("enemy_attacks")

func start_attack(animation_name: String) -> void:
	if animation_player.has_animation(animation_name):
		animation_player.play(animation_name)
	else:
		animation_player.play("attack_right")
		
	animation_player.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(_anim_name: String) -> void:
	queue_free()

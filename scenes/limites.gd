extends CharacterBody2D

func _ready() -> void:
		add_to_group("boundaries")
		for child in get_children():
			child.add_to_group("boundaries")
func _physics_process(delta: float) -> void:
	move_and_slide()

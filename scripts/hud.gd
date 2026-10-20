extends CanvasLayer
@export var player: CharacterBody2D 
@onready var score_number: Label = $Control/VBoxContainer/ScoreNumber
@onready var h_box_container: HBoxContainer = $Control/VBoxContainer2/HBoxContainer
const LIFE_TEXTURE = preload("res://Assets/life_sprite.png")


func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	score_number.text = str(player.score)
	
	pass

func update_lives_display(current_lives: int) -> void:
	for child in h_box_container.get_children():
		child.queue_free()
		
	for i in range(current_lives):
		var new_life_sprite = TextureRect.new()
		new_life_sprite.texture = LIFE_TEXTURE
		new_life_sprite.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		h_box_container.add_child(new_life_sprite)

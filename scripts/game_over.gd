extends CanvasLayer
@onready var score_number: Label = $MarginContainer2/VBoxContainer/ScoreNumber



func _ready() -> void:
	score_number.text = str(Global.final_score)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level1.tscn")
	pass 


func _on_button_2_pressed() -> void:
	get_tree().quit()
	pass 

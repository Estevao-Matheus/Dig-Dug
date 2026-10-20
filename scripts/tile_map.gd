extends TileMapLayer
@onready var tile_map_layer: TileMapLayer = $"."
@onready var player: CharacterBody2D = $"../CharacterBody2D"

const digged_Space : Vector2i = Vector2i(10,2)

func _ready() -> void:
	if player:
		player.send_tile.connect(tile_digging)
		
	pass # Replace with function body.
func _process(delta: float) -> void:
	pass
func tile_digging(vector : Vector2i) -> void :
	#print("função chamada",vector)
	tile_map_layer.set_cell(vector,0,digged_Space)
	check_stone(vector)

func check_stone (vector_digged: Vector2i) -> void:
		var above_block = vector_digged + Vector2i(0, -1)
		for stone in get_tree().get_nodes_in_group("stones"):
			var stone_coordinates = tile_map_layer.local_to_map(stone.global_position)
			if stone_coordinates == above_block:
				stone.start_stone_fall()

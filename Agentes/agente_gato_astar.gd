extends CharacterBody2D

@onready var tile_map = $"../TileMap"

@export var starting_direction : Vector2 = Vector2(0,1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

var astar_grid: AStarGrid2D
var current_id_path: Array[Vector2i]

func _ready():
	astar_grid = AStarGrid2D.new()
	astar_grid.region = tile_map.get_used_rect()
	var used_cells = tile_map.get_used_cells(0)
	astar_grid.offset = astar_grid.region.position
	astar_grid.cell_size = Vector2(16,16)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()
	
	for cell in used_cells:
		var tile_data = tile_map.get_cell_tile_data(0, cell)
		if tile_data == null or tile_data.get_custom_data("wall") == true:
			astar_grid.set_point_solid(cell)
		else:
			astar_grid.set_point_solid(cell, false)
func _input(event):
	if event.is_action_pressed('scroll_up'):
		$Camera2D.zoom = $Camera2D.zoom - Vector2(0.1, 0.1)
	if event.is_action_pressed('scroll_down'):
		$Camera2D.zoom = $Camera2D.zoom + Vector2(0.1, 0.1)
	if event.is_action_pressed("move") == false:
		return
		
	var id_path = astar_grid.get_id_path(
		tile_map.local_to_map(global_position),
		tile_map.local_to_map(get_parent().end_room.position)
	).slice(1)
	
	if id_path.is_empty() == false:
		current_id_path = id_path

func _physics_process(delta):
	
	if current_id_path.is_empty():
		return
	var target_position = tile_map.map_to_local(current_id_path.front())
	global_position = global_position.move_toward(target_position, 1)
	var input_direction = to_local(target_position).normalized()
	update_animation_parameters(input_direction)
	velocity = input_direction.normalized() * 200
	pick_new_state()
	if global_position == target_position:
		current_id_path.pop_front()
	
func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/Walk/blend_position", move_input)
		
func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
	

extends Node2D

var Room = preload("res://Objetos/room.tscn")
var Player = preload("res://Agentes/agente_gato_astar.tscn")
var Cofre = preload("res://Objetos/cofre.tscn")
@onready var Map = $TileMap
var tile_size = 16
var num_rooms = 20
var min_size = 4
var max_size = 10
var hspread = 50
var cull = 0.5

var path
var start_room = null
var end_room = null
var play_mode = false
var player = null
var full_rect = Rect2i()
var astar_grid: AStarGrid2D
var current_id_path: Array[Vector2i]
var topleft
func _ready():
	randomize()
	make_rooms()

func make_rooms():
	for i in range(num_rooms):
		var pos = Vector2(randf_range(-hspread, hspread), 0)
		var r = Room.instantiate()
		var w = min_size + randi() % (max_size - min_size)
		var h = min_size + randi() % (max_size - min_size)
		r.make_room(pos, Vector2(w,h) * tile_size)
		$Rooms.add_child(r)
	$Timer.start()
	await($Timer.timeout)
	var room_positions = []
	for room in $Rooms.get_children():
		if randf() < cull:
			room.queue_free()
		else:
			room.freeze = true
			room_positions.append(Vector2(room.position.x, room.position.y))
	await(get_tree().create_timer(1.1).timeout)
	path = find_mst(room_positions)
	make_map()
	setup_astargrid()
	player = Player.instantiate()
	add_child(player)
	player.position = start_room.position
	play_mode = true
	var new_node = Cofre.instantiate()
	new_node.position = end_room.position
	add_child(new_node)
func _draw():
	for room in $Rooms.get_children():
		draw_rect(Rect2(room.position-room.size, room.size *2),
				Color(32,228,0), false)
	if path:
		for p in path.get_point_ids():
			for c in path.get_point_connections(p):
				var pp = path.get_point_position(p)
				var cc = path.get_point_position(c)
				draw_line(Vector2(pp), Vector2(cc), Color(1,1,0), 15, true)
func _process(_delta):
	queue_redraw()
	
func find_mst(nodes):
	path = AStar2D.new()
	path.add_point(path.get_available_point_id(), nodes.pop_front())
	
	while nodes:
		var min_dist = INF
		var min_pos = null
		var pos = null
		for p1 in path.get_point_ids():
			var p_temp = path.get_point_position(p1)
			for p2 in nodes:
				if p_temp.distance_to(p2)<min_dist:
					min_dist = p_temp.distance_to(p2)
					min_pos = p2
					pos = p_temp
		var n = path.get_available_point_id()
		path.add_point(n, min_pos)
		path.connect_points(path.get_closest_point(pos,true), n)
		nodes.erase(min_pos)
	return path

func make_map():
	Map.clear()
	find_start_room()
	find_end_room()
	
	for room in $Rooms.get_children():
		var r = Rect2i(room.position - room.size, room.get_node("CollisionShape2D").shape.extents*2)
		full_rect = full_rect.merge(r)
	topleft = Map.local_to_map(full_rect.position)
	print(topleft)
	var bottomright = Map.local_to_map(full_rect.end)
	for x in range(topleft.x, bottomright.x):
		for y in range(topleft.y, bottomright.y):
			Map.set_cell(0,Vector2i(x,y),4, Vector2i(0,0),0)
	
	var corridors = []
	for room in $Rooms.get_children():
		var s = (room.size / tile_size).floor()
		var ul = (room.position/ tile_size).floor() - s
		for x in range(2,s.x*2-1):
			for y in range(2,s.y*2-1):
				Map.set_cell(0, Vector2i(ul.x + x, ul.y + y), 0, Vector2i(0, 0), 0)
		var p = path.get_closest_point(room.position,true)
		for conn in path.get_point_connections(p):
			if not conn in corridors:
				var start = Map.local_to_map(path.get_point_position(p))
				var end = Map.local_to_map(path.get_point_position(conn))
				carve_path(start,end)
		corridors.append(p)
		room.get_node("CollisionShape2D").disabled = true

func carve_path(start, end):
	var x_diff = sign(end.x - start.x)
	var y_diff = sign(end.y - start.y)
	
	if x_diff == 0: x_diff = pow(-1.0, randi() % 2)
	if y_diff == 0: y_diff = pow(-1.0, randi() % 2)
		
	var x_y = start
	var y_x = end
	
	if randi() % 2 > 0:
		x_y = end
		y_x = start

	for x in range(start.x, end.x, x_diff):
		#await get_tree().process_frame
		Map.set_cell(0, Vector2i(x, x_y.y), 0, Vector2i(0, 0), 0);
		Map.set_cell(0, Vector2i(x, x_y.y + y_diff), 0, Vector2i(0, 0), 0);
	for y in range(start.y, end.y, y_diff):
		#await get_tree().process_frame
		Map.set_cell(0, Vector2i(y_x.x, y), 0, Vector2i(0, 0), 0);
		Map.set_cell(0, Vector2i(y_x.x + x_diff, y), 0, Vector2i(0, 0), 0);
func setup_astargrid():
	pass
func find_start_room():
	var min_x = INF
	for room in $Rooms.get_children():
		if room.position.x < min_x:
			start_room = room
			min_x = room.position.x

func find_end_room():
	var max_x = -INF
	for room in $Rooms.get_children():
		if room.position.x > max_x:
			end_room = room
			max_x = room.position.x

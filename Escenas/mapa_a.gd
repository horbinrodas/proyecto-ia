extends Node2D

var MyNodeScene = preload("res://Objetos/book.tscn")
var cofre_array = []

func _ready():
	pass
	
func create_and_place_node(position: Vector2):
	var new_node = MyNodeScene.instantiate()
	new_node.position = position
	add_child(new_node)
	cofre_array.append(new_node)
	
func get_area2d_array():
	return cofre_array

func _input(event):
	if event.is_action_pressed("move"):
		create_and_place_node(get_global_mouse_position())

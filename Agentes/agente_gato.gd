extends CharacterBody2D

@export var move_speed : float = 40
@export var starting_direction : Vector2 = Vector2(0,1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var nav_agent := $NavigationAgent2D
#@onready var areas = get_parent().cofre_array
var current_node: int = 0

func _ready():
	animation_tree.set("parameters/Idle/blend_position", starting_direction)
	
func _physics_process(_delta):
	#if not areas.is_empty():
	#	nav_agent.target_position = areas[current_node].position
	if global_position.distance_to(nav_agent.target_position) == 0:
		return
		current_node = current_node + 1
	var input_direction = to_local(nav_agent.get_next_path_position()).normalized()
	input_direction = input_direction.normalized()
	update_animation_parameters(input_direction)
	
	velocity = input_direction.normalized() * move_speed
	move_and_slide()
	
	pick_new_state()
	
func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/Walk/blend_position", move_input)
func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")

func _input(event):
	if event.is_action_pressed("move"):
		nav_agent.target_position = get_global_mouse_position()
		
func _on_area_2d_body_entered(body):
	if("npc_id" in body):
		$"../CanvasLayer/DialogoFNPC".start(body.npc_id)


func _on_area_2d_body_exited(body):
	if("npc_id" in body):
		$"../CanvasLayer/DialogoFNPC".end_conversation()

func add_Coin():
	var root_node = get_tree().get_root()
	var canvas_layer = root_node.find_node("CanvasLayer", true, false)
	if canvas_layer:
		canvas_layer.handleCoinCollected()
	else:
		print("Error: Nodo CanvasLayer2 no encontrado")

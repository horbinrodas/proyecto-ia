extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_nivel_1_pressed():
	get_tree().change_scene_to_file("res://Escenas/mapa_d_edvin.tscn")


func _on_nivel_2_pressed():
	get_tree().change_scene_to_file("res://Escenas/mapa_d_jessica.tscn")	

func _on_nivel_random_pressed():
	get_tree().change_scene_to_file("res://Escenas/random.tscn")


func _on_salir_pressed():
	get_tree().change_scene_to_file("res://Objetos/main_menu.tscn")

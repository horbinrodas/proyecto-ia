extends CharacterBody2D

func _ready():
	pass 

func _physics_process(_delta):
	pass
	
func _on_area_2d_body_entered(body):
	if (body.is_in_group("inte")):
		Global_Dialogos.npc_1 = true; 

func _on_area_2d_body_exited(body):
	if (body.is_in_group("inte")):
		Global_Dialogos.npc_1 = false;

extends Area2D

func _on_body_entered(body):
	if (body.is_in_group("posion_2")):
		Global_Dialogos.posiones += 1;
		print(Global_Dialogos.posiones);
		queue_free();

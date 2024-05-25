extends Area2D

func _on_body_entered(body):
	if (body.is_in_group("hacha")):
		Global_Dialogos.hacha += 1;
		queue_free();

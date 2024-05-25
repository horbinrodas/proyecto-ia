extends Area2D

signal coinCollected

func _on_body_entered(body):
	$"../AudioStreamPlayer".playing = true
	body.add_Coin()
	queue_free()
	pass

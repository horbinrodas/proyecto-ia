extends Area2D

@onready var animation_player = $AnimationPlayer

func _on_area_entered(area):
	while area.is_in_group("gato"):
		animation_player.play("open_animation")
		await animation_player.animation_finished

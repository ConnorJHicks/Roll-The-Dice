extends Area

func _on_DeathTrigger_body_entered(body):
	if body.name == "Player":
		get_tree().reload_current_scene()

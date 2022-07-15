extends Area

export(String, FILE, "*.tscn") var NEXT_LEVEL = ""

func _on_ScoreTrigger_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene(NEXT_LEVEL)

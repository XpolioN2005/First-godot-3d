extends Control

func _on_resume_pressed() -> void:
	get_parent().is_game_paused = false

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().quit(0)

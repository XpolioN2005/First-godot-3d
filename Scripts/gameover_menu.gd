extends Control


func _ready() -> void:
	visible = false


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().quit(0)

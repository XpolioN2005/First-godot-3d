extends Control

var is_game_over = false
var is_game_paused = false

@onready var base_ui: Control = $base_ui
@onready var pause_menu: Control = $Pause_menu
@onready var gameover_menu: Control = $gameover_menu

@onready var player = %player



func _input(event):
	
	if event is InputEventKey and Input.is_action_just_pressed("esc"):
		is_game_paused = !is_game_paused


func _ready() -> void:
	base_ui.player = player


	is_game_over = false
	is_game_paused = false

func _process(_delta: float) -> void:

	if is_game_over or is_game_paused:
		get_tree().paused = true
	else:
		get_tree().paused = false


	if is_game_over:
		gameover_menu.visible = true
		base_ui.visible = false
		pause_menu.visible = false
	elif is_game_paused:

		get_tree().paused = true

		pause_menu.visible = true
		base_ui.visible = false
		gameover_menu.visible = false
	else:
		base_ui.visible = true
		pause_menu.visible = false
		gameover_menu.visible = false
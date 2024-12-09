
extends Node3D

@onready var current_level=0
@onready var enemy=preload("res://Scenes/enemy.tscn")
@onready var rand=RandomNumberGenerator.new()
@onready var dead_enemies=0
var num_of_enemy = 0
var is_wave_ongoing = false


func _process(_delta) -> void:
	start()


func spawn_eneny():
	is_wave_ongoing = true

	num_of_enemy = current_level*current_level


	for i in range(num_of_enemy):
		var instance = enemy.instantiate()
		var spawn_lenght = $spawn_area.get_child_count() -1
		var rand_num = rand.randi_range(0,spawn_lenght)
		instance.player = %player
		var pos = $spawn_area.get_child(rand_num).position
		pos.y = 0.5
		instance.position = pos
		add_child(instance)
		await get_tree().create_timer(0.5).timeout


func start():
	if num_of_enemy == dead_enemies:
		is_wave_ongoing = false
		await get_tree().create_timer(1).timeout

	if not is_wave_ongoing:
		current_level = current_level +1
		dead_enemies = 0
		print("next wave")
		spawn_eneny()
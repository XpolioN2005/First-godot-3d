
extends Node3D

@onready var rand=RandomNumberGenerator.new()

var ammo = preload("res://Scenes/ammo.tscn")
var current_powerup = [ammo]



func _ready():
	pass
func _process(_delta) -> void:
	spawn_powerup()
	start()


func spawn_powerup():
	while not current_powerup.is_empty():
		var i = current_powerup.pop_at(0)
		var instance = i.instantiate()
		var spawn_lenght = $spawn_area.get_child_count() -1
		var rand_num = rand.randi_range(0,spawn_lenght)
		var pos = $spawn_area.get_child(rand_num).position
		pos.y = 0.5
		instance.position = pos
		add_child(instance)

		

func start():
	pass
func _on_powerup_timer_timeout() -> void:
	current_powerup.append(ammo)

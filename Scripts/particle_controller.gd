extends Node3D


@onready var explotion = preload("res://Scenes/explosion.tscn")


func explode_particle(pos):
		var instance = explotion.instantiate()
		instance.position = pos
		add_child(instance)

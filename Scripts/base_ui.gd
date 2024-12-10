extends Control

@onready var score_label = $score
@onready var ammo_label = $ammo
@onready var player

func _process(_delta: float) -> void:
	score_label.text = "SCORE: " + str(player.score)
	ammo_label.text = "AMMO: " + str(player.ammo)

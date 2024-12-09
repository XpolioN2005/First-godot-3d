extends Node3D


@onready var debri = $debrie
@onready var fire = $fire
@onready var smoke = $smoke

func _ready():
	explode()


func _process(_delta):
	print(position)

func explode():
	debri.emitting = true
	smoke.emitting = true
	fire.emitting = true
	await get_tree().create_timer(2.0).timeout
	queue_free()

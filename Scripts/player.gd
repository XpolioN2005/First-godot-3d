extends CharacterBody3D

@export var speed = 600

@onready var camera = %camera
@onready var score = 0

@onready var ammo = 5


var bullet = preload("res://Scenes/bullet.tscn")



var target_pos = Vector3()
var moving_to_target = false


func _ready():
	add_to_group("player")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and Input.is_action_just_pressed("left_click"):
		var ray_result = camera.shoot_ray()
		if ray_result.has("position"):
			target_pos = ray_result["position"]
			target_pos.y = 1       
			moving_to_target = true
		else: print("CLICK ON THE PLAYING AREA PLS")

func _physics_process(delta: float) -> void:

	move_logic(target_pos,delta)
	shoot(position)
	
	move_and_slide()


func move_logic(target,delta):
	if moving_to_target:
		var direct = (target-position).normalized() #direction... not working other wise idk why | turns out the issue was due to i forgot
		var dist = position.distance_to(target)		#distance... same issue    					 | to add move_and_slide() my bad 😁!!
																									#| sry but i am to lazy to change the names

		if dist > 1 :
			velocity = direct *speed *delta *dist #distance helps so that the further the target more speed.. I found that satisfiting
		else:
			velocity = Vector3.ZERO
			moving_to_target = false


func shoot(pos):
	if Input.is_action_just_pressed("right_click") and ammo >0:
		ammo = max(0,ammo -1)
		var instance = bullet.instantiate()
		instance.camera = camera
		instance.player = %player
		instance.position = pos
		instance.pos = pos
		instance.add_to_group("bullet")
		get_tree().root.get_child(0).add_child(instance)
		instance.fire()
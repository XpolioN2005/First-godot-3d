extends CharacterBody3D


@onready var player
@onready var ui_controller = get_node("../../CanvasLayer/ui_controller")

@export var speed = 400


func _ready():
	add_to_group("enemy")

func _process(_delta):
	var direction_to_player = global_transform.origin.direction_to(player.global_transform.origin)
	var target_basis = Basis.looking_at(direction_to_player, Vector3.UP)
	transform.basis = transform.basis.slerp(target_basis, 0.1)  # Adjust 0.1 for rotation speed


func _physics_process(delta: float) -> void:
	var target_pos = player.position
	target_pos.y = 0.5

	move_ai(target_pos,delta)	
	move_and_slide()


func move_ai(target,delta):      #basically same as move_logic in player.gd {yep copied!!!}
	var direct = (target-position).normalized() #direction... not working other wise idk why | turns out the issue was due to i forgot
	var dist = position.distance_to(target)		#distance... same issue    					 | to add move_and_slide() my bad 😁!!
																							#| sry but i am to lazy to change the names

	if dist > 1 :
		velocity = direct *speed *delta 
	else:
		velocity = Vector3.ZERO

func death(body):
	player.score += 100
	queue_free()
	body.queue_free()

	get_parent().dead_enemies = get_parent().dead_enemies + 1 



func collision_detection(body: Node3D) -> void:
	if body.is_in_group("bullet"):
		death(body)
	elif body == player:
		ui_controller.is_game_over = true
		

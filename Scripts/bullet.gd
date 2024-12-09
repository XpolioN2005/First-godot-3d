extends RigidBody3D

var target_pos = Vector3()
var speed = 5000
var camera
var player

var is_shoot = false
var pos

func _ready() -> void:
	add_to_group("bullet")

	$MeshInstance3D.visible = false
	$CollisionShape3D.disabled = true

func fire() -> void:
	# print("fire(true)")
	if not is_shoot:  # Only allow the first click to set the target position
		var ray_result = camera.shoot_ray()
		if ray_result.has("position"):
			is_shoot = true
			target_pos = ray_result["position"]
			target_pos.y = 1 
		else:
			print("CLICK ON THE PLAYING AREA PLS")

func _physics_process(delta: float) -> void:

	if position.distance_to(player.position) > 150:
		print("pff")
		queue_free()



	# if player:
	# 	print(player.position)
	# else: print("no player")
	position.y = 0.5
	
	if is_shoot:
		$MeshInstance3D.visible = true
		$CollisionShape3D.disabled = false

		move_ai(target_pos,pos, delta)

func move_ai(target,current_pos, delta):
	target.y = 0.5
	var direct = (target - current_pos).normalized()  # Direction calculation
	set_linear_velocity(direct * speed *delta)  # Set velocity without considering delta for consistent motion

# func collision_detection(body: Node3D) -> void:
# 	if body.is_in_group("enemy"):
# 		print("collided")
# 		body.queue_free()

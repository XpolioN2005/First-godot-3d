extends Area3D


@export var rotation_speed: Vector3 = Vector3(0, 50, 0)  # Rotation speed (degrees per second)
@export var hover_amplitude: float = 0.5                # Hover distance
@export var hover_speed: float = 2.0                    # Hover speed (oscillations per second)

var time: float = 0.0
var initial_position: Vector3

func _ready() -> void:
	# Store the initial position to base the hover movement
	initial_position = global_transform.origin

func _process(delta: float) -> void:
	# Update time
	time += delta

	# Apply rotation
	rotation_degrees += rotation_speed * delta

	# Apply hover movement using a sine wave
	global_transform.origin.y = initial_position.y + hover_amplitude * sin(time * hover_speed)

	position.y = max(0.5, position.y)



func _on_body_entered(body:Node3D) -> void:
	if body.is_in_group("player"):
		body.ammo += 5
		queue_free()

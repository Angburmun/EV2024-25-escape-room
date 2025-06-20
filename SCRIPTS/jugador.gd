extends CharacterBody3D

const WALK_SPEED = 3.5
const JUMP_VELOCITY = 4.0
const SENSITIVITY = 0.8
const SENSITIVITY_DIVIDER = 800

#fov variables
const BASE_FOV = 75.0
const FOV_CHANGE = 1.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 9.8

@onready var head = $cabeza
@onready var camera = $cabeza/camara


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY / SENSITIVITY_DIVIDER)
		camera.rotate_x(-event.relative.y * SENSITIVITY / SENSITIVITY_DIVIDER)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (head.transform.basis * transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * WALK_SPEED
			velocity.z = direction.z * WALK_SPEED
		else:
			velocity.x = lerp(velocity.x, direction.x * WALK_SPEED, delta * 10.0)
			velocity.z = lerp(velocity.z, direction.z * WALK_SPEED, delta * 10.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * WALK_SPEED, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * WALK_SPEED, delta * 3.0)
	
	# FOV
	var velocity_clamped = clamp(velocity.length(), 0.5, WALK_SPEED * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
	
	move_and_slide()

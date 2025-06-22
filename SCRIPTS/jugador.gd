extends CharacterBody3D

const WALK_SPEED = 3.5
const JUMP_VELOCITY = 4.0
const SENSITIVITY = 0.8
const SENSITIVITY_DIVIDER = 800
var speed = WALK_SPEED

# crouch
const CROUCH_HEIGHT = -0.15
const STAND_HEIGHT = 0.75
const CROUCH_SPEED = 2.25
var is_crouching = false
var target_y = STAND_HEIGHT

# fov
const BASE_FOV = 75.0
const FOV_CHANGE = 1.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var head = $cabeza
@onready var camera = $cabeza/camara


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY / SENSITIVITY_DIVIDER)
		camera.rotate_x(-event.relative.y * SENSITIVITY / SENSITIVITY_DIVIDER)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-80), deg_to_rad(80))


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Handle crouch
	is_crouching = Input.is_action_pressed("crouch")
	if is_crouching:
		speed = CROUCH_SPEED
		target_y = CROUCH_HEIGHT
	else:
		speed = WALK_SPEED
		target_y = STAND_HEIGHT
		
	# Handle Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (head.transform.basis * transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 10.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 10.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)
	
	# FOV
	var velocity_clamped = clamp(velocity.length(), 0.5, WALK_SPEED * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
	head.position.y = lerp(head.position.y, target_y, delta * 10.0)
	
	move_and_slide()

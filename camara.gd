extends Node3D

@export var rotation_speed := 1.0
@export var vertical_min := deg_to_rad(-60)
@export var vertical_max := deg_to_rad(60)

@onready var rotation_y := $EjeY
@onready var rotation_x := $EjeY/EjeX


func _ready():
	pass

func _process(delta):
	var horizontal_input := 0.0
	var vertical_input := 0.0

	if Input.is_action_pressed("camara_derecha"):
		horizontal_input -= 1
	if Input.is_action_pressed("camara_izquierda"):
		horizontal_input += 1
	if Input.is_action_pressed("camara_arriba"):
		vertical_input -= 1
	if Input.is_action_pressed("camara_abajo"):
		vertical_input += 1
	
	rotation_y.rotate_y(horizontal_input * rotation_speed * delta)
	rotation_x.rotation.x = clamp(rotation_x.rotation.x + vertical_input * rotation_speed * delta, vertical_min, vertical_max)

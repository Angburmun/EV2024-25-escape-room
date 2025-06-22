extends Area3D

@onready var area_pos_z: float = global_transform.origin.z
@onready var habitacion_1 = $"../../habitacion1"
@onready var habitacion_2 = $"../../habitacion2"
@export var ruta_habitacion1: String = "res://ESCENAS/habitacion_1.tscn"
@export var ruta_habitacion2: String = "res://ESCENAS/habitacion_2.tscn"

func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _on_body_entered(body):
	if body.name == "jugador":
		var jugador_pos_z = body.global_transform.origin.z
		#print("Jugador Z: ", jugador_pos_z)
		#print("Area Z:    ", area_pos_z)
		
		if  jugador_pos_z > area_pos_z:
			habitacion_1.queue_free()
		else:
			habitacion_2.queue_free()

func _on_body_exited(body):
	if body.name == "jugador":
		var jugador_pos_z = body.global_transform.origin.z
		#print("Jugador Z: ", jugador_pos_z)
		#print("Area Z:    ", area_pos_z)
		
		if  jugador_pos_z > area_pos_z:
			var escena1 = load(ruta_habitacion1) as PackedScene
			habitacion_1 = escena1.instantiate()
			get_parent().get_parent().add_child(habitacion_1)
		else:
			var escena2 = load(ruta_habitacion2) as PackedScene
			habitacion_2 = escena2.instantiate()
			get_parent().get_parent().add_child(habitacion_2)

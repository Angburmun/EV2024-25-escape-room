extends Area3D

@onready var area_pos_z: float = global_transform.origin.z

@export var ruta_habitacion1: String = "res://ESCENAS/habitacion_1.tscn"
@export var ruta_habitacion2: String = "res://ESCENAS/habitacion_2.tscn"

@export var posicion_hab1: Vector3 = Vector3(0, 2, 0)
@export var posicion_hab2: Vector3 = Vector3(2.8, 2, -15)


func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _on_body_entered(body):
	if body.name == "jugador":
		var jugador_pos_z = body.global_transform.origin.z
		#print("Jugador Z: ", jugador_pos_z)
		#print("Area Z:    ", area_pos_z)
		var habitacion_1 = get_node_or_null("../../habitacion1")
		var habitacion_2 = get_node_or_null("../../habitacion2")
		
		if  jugador_pos_z > area_pos_z:
			habitacion_1.queue_free()
		else:
			habitacion_2.queue_free()

func _on_body_exited(body):
	if body.name == "jugador":
		var jugador_pos_z = body.global_transform.origin.z
		#print("Jugador Z: ", jugador_pos_z)
		#print("Area Z:    ", area_pos_z)
		var habitacion_1 = get_node_or_null("../../habitacion1")
		var habitacion_2 = get_node_or_null("../../habitacion2")
		
		if  jugador_pos_z > area_pos_z:
			var escena1 = load(ruta_habitacion1) as PackedScene
			habitacion_1 = escena1.instantiate()
			get_parent().get_parent().add_child(habitacion_1)
			habitacion_1.global_transform.origin = posicion_hab1
		else:
			var escena2 = load(ruta_habitacion2) as PackedScene
			habitacion_2 = escena2.instantiate()
			get_parent().get_parent().add_child(habitacion_2)
			habitacion_2.global_transform.origin = posicion_hab2

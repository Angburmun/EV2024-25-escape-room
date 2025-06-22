extends Area3D

@onready var area_pos_z: float = global_transform.origin.z
@onready var habitacion1 = $"../../habitacion1"
@onready var habitacion2 = $"../../habitacion2"

func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body.name == "jugador":
		var jugador_pos_z = body.global_transform.origin.z
		
		if  jugador_pos_z > area_pos_z:
			habitacion1.visible = false
			habitacion2.visible = true
		else:
			habitacion1.visible = true
			habitacion2.visible = false

extends Node3D

@onready var luz = $luz
@onready var timer = $Timer

var titilando := false

func _ready():
	timer.connect("timeout", _on_timer_timeout)
	timer.wait_time = 0.05
	timer.autostart = false

func _process(_delta):
	if Input.is_action_just_pressed("titilar_luz"):
		titilando = !titilando
		if titilando:
			timer.start()
		else:
			timer.stop()
			luz.light_energy = 1.0  # Luz normal al terminar

func _on_timer_timeout():
	if not titilando:
		return

	# Efecto tipo flicker: cambios sutiles de energía
	luz.light_energy = randf_range(0.6, 1.2)
	
	# Ajustar tiempo hasta el siguiente cambio
	timer.wait_time = randf_range(0.02, 0.1)
	timer.start()

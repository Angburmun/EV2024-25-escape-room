extends Node3D

var abierto = false
var en_movimiento = false
@onready var animation_player = $"../animation_godot"

func interact():
	if !en_movimiento:
		en_movimiento = true
		abierto = !abierto
		
		if abierto:
			animation_player.play("abrir")
		else:
			animation_player.play("cerrar")
		await get_tree().create_timer(1.0, false).timeout
		
		en_movimiento = false

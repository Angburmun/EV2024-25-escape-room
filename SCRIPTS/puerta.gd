extends CSGMesh3D

var cerrado = false
var en_movimiento = false
@onready var animation_player = $"../../animaciones"

func interact():
	if !en_movimiento:
		en_movimiento = true
		cerrado = !cerrado
		
		if cerrado:
			animation_player.play("animation_open")
		else:
			animation_player.play("animation_close")
		await get_tree().create_timer(1.0, false).timeout
		
		en_movimiento = false

extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var malla = ArrayMesh.new()
	
	# 8 vértices porque es un cuadrado
	var vertices = PackedVector3Array([
		Vector3(-1, -1, -1),	# 0
		Vector3( 1, -1, -1),	# 1
		Vector3( 1,  1, -1),	# 2
		Vector3(-1,  1, -1),	# 3
		Vector3(-1, -1,  1),	# 4
		Vector3( 1, -1,  1),	# 5
		Vector3( 1,  1,  1),	# 6
		Vector3(-1,  1,  1),	# 7
	])
	
	# Creamos el cuadrado creando las caras.
	# Tenemos que crearlas en triángulos,
	#	así que dos triángulos por cara
	# (Letras de las caras según nomenclatura de cubos de Rubik)
	var indices =  PackedInt32Array([
		0, 2, 1,  2, 0, 3,	# B
		4, 5, 6,  6, 7, 4,	# F
		0, 4, 7,  7, 3, 0,	# L
		1, 5, 6,  6, 2, 1,	# R
		3, 2, 6,  6, 7, 3,	# U
		0, 1, 5,  5, 4, 0	# D
	])
	
	
	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_INDEX] = indices
	
	malla.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	mesh = malla

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

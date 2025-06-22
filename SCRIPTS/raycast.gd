extends RayCast3D

func _process(_delta):
	if is_colliding():
		var hitObj = get_collider()
		
		if hitObj.has_method("interact") && Input.is_action_just_pressed("interact"):
			hitObj.interact()
			
		if hitObj.has_method("interact_physics") && Input.is_action_just_pressed("interact_physics"):
			hitObj.interact_physics(self)

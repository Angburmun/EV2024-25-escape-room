extends RigidBody3D

var is_held = false

func interact_physics(player):
	if !is_held:
		# Pickup
		self.global_transform.basis = player.global_transform.basis
		self.gravity_scale = 0.0
		is_held = true
	
	if is_held:
		self.linear_velocity = player.global_transform.basis.x.normalized() * 10
		self.gravity_scale = 1.0
		is_held = false

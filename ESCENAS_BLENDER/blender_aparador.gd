extends Node3D

@onready var anim_player = $AnimationPlayer


func _input(event):
	if event.is_action_pressed("ui_accept"):
		anim_player.play("CajonAction")

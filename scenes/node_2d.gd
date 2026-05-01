extends Node2D

@onready var player = $Jugador
@onready var camera = $Camera2D

func _process(delta):
	if not is_instance_valid(player):
		return
	camera.global_position = player.global_position

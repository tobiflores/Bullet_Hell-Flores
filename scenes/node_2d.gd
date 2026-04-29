extends Node2D

@onready var player = $Jugador
@onready var camera = $Camera2D

func _process(delta):
	camera.global_position = player.global_position

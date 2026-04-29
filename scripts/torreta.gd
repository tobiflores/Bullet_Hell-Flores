extends Node2D

@export var BULLET: PackedScene

@onready var armaSprite = $ArmaSprite
@onready var rayCast = $RayCast2D
@onready var reloadTimer = $RayCast2D/Recarga

func _ready():
	reloadTimer.timeout.connect(_on_reload_timeout)
	reloadTimer.start()

func shoot():
	if BULLET:
		var bullet = BULLET.instantiate()
		get_tree().current_scene.add_child(bullet)
		bullet.global_position = global_position
		bullet.direction = Vector2.RIGHT.rotated(rayCast.global_rotation)

func _on_reload_timeout():
	shoot()
	reloadTimer.start()

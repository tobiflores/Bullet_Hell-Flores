extends Node2D

@export var BULLET: PackedScene
@onready var armaSprite = $ArmaSprite
@onready var rayCast = $RayCast2D
@onready var reloadTimer = $RayCast2D/Recarga

var destino = Vector2.ZERO
var velocidad = 300
var activa = false

func _ready():
	reloadTimer.wait_time = 1.0
	reloadTimer.timeout.connect(postRecarga)

func shoot():
	if BULLET:
		var bullet = BULLET.instantiate()
		get_tree().current_scene.add_child(bullet)
		bullet.global_position = global_position
		bullet.get_node("Sprite2D").texture = preload("res://imagenes/torretaBullet.png")
		var centro = Vector2(1028, 566)
		var direccion = (centro - global_position).normalized()
		bullet.direction = direccion
		$ArmaSprite.rotation = direccion.angle()
		
func _process(delta):
	if not activa:
		global_position = global_position.move_toward(destino, velocidad * delta)
		if global_position.distance_to(destino) < 5:
			activa = true
			reloadTimer.start()

func postRecarga():
	shoot()
	reloadTimer.start()

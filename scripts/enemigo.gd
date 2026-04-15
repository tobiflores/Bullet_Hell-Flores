extends CharacterBody2D

const BULLET_SCENE = preload("res://scenes/bullet.tscn")
const MOVE_SPEED = 40.0
const SHOOT_INTERVAL = 2.0
const FAN_BULLETS = 7
const FAN_SPREAD = 60.0

var shoot_timer = 0.0
var theta: float = 0.0
var bullet_type: int = 0
var player = null

func _ready():
	player = get_tree().get_first_node_in_group("jugadores")
	print("PLAYER ENCONTRADO:", player) 

func _physics_process(delta):
	print("PLAYER EN _PROCESS:", player)
	if player:
		var dir = position.direction_to(player.position)
		velocity = dir * MOVE_SPEED
		move_and_slide()

	shoot_timer += delta
	if shoot_timer >= SHOOT_INTERVAL:
		shoot_timer = 0.0
		print("DISPARA")
		shoot_fan()

func get_vector(angle):
	theta = angle
	return Vector2(cos(theta), sin(theta))

func shoot(angle):
	var b = BULLET_SCENE.instantiate()
	b.position = global_position
	b.direction = get_vector(angle)
	b.set_property(bullet_type)
	get_tree().current_scene.call_deferred("add_child", b)

func shoot_fan():
	if not player:
		print("NO HAY PLAYER")
		return
	var angle_to_player = position.angle_to_point(player.position)
	var half_spread = deg_to_rad(FAN_SPREAD / 2.0)
	for i in range(FAN_BULLETS):
		var t = float(i) / float(FAN_BULLETS - 1)
		var angle = angle_to_player - half_spread + t * deg_to_rad(FAN_SPREAD)
		shoot(angle)

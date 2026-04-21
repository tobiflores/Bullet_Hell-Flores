extends CharacterBody2D

const BULLET_SCENE = preload("res://scenes/bullet.tscn")
const MOVE_SPEED = 90.0
const SHOOT_INTERVAL = 0.3
const FAN_BULLETS = 7
const FAN_SPREAD = 60.0
const MAX_LASERS = 25

var shoot_timer = 0.0
var theta: float = 0.0
var tipoDeBala: int = 0
var balas_disparadas = 0
var player = null
var dispare = false

func _ready():
	player = get_tree().get_first_node_in_group("jugadores")

func _physics_process(delta):
	if player:
		var dir = position.direction_to(player.position)
		velocity = dir * MOVE_SPEED
		move_and_slide()

	shoot_timer += delta
	if !dispare:
		dispare = true
		$AnimationPlayer.play("disparar")

func get_vector(angle):
	theta = angle
	return Vector2(cos(theta), sin(theta))

func shoot_fan():
	if not player:
		return
	if balas_disparadas >= MAX_LASERS:
		tipoDeBala = 1
		balas_disparadas = 0
		return
	balas_disparadas += 1
	var bala = BULLET_SCENE.instantiate()
	add_child(bala)
	var spawn = $Marker2D
	bala.global_position = spawn.global_position 
	var dir = spawn.global_position.direction_to(player.global_position)
	bala.direction = dir
	bala.tipoDeDisparo = tipoDeBala

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "disparar":
		dispare = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugadores"):
		body.vida-=20;

extends CharacterBody2D
<<<<<<< HEAD
=======

>>>>>>> 5db119b3a352ce8a6b97023e854845729d09a638
const BULLET_SCENE = preload("res://scenes/bullet.tscn")
const MOVE_SPEED = 90.0
const SHOOT_INTERVAL = 0.3
const FAN_BULLETS = 7
const FAN_SPREAD = 60.0
const MAX_LASERS = 25
<<<<<<< HEAD
=======

>>>>>>> 5db119b3a352ce8a6b97023e854845729d09a638
var shoot_timer = 0.0
var theta: float = 0.0
var tipoDeBala: int = 0
var balas_disparadas = 0
<<<<<<< HEAD
var jugador = null
var dispare = false
var enfriamiento_circulo = false
func _ready():
	jugador = get_tree().get_first_node_in_group("jugadores")
	add_to_group("enemigos")
func _physics_process(delta):
	if jugador:
		var dir = position.direction_to(jugador.position)
		velocity = dir * MOVE_SPEED
		move_and_slide()
=======
var player = null
var dispare = false

func _ready():
	player = get_tree().get_first_node_in_group("jugadores")

func _physics_process(delta):
	if player:
		var dir = position.direction_to(player.position)
		velocity = dir * MOVE_SPEED
		move_and_slide()

>>>>>>> 5db119b3a352ce8a6b97023e854845729d09a638
	shoot_timer += delta
	if !dispare:
		dispare = true
		$AnimationPlayer.play("disparar")
<<<<<<< HEAD
func obtener_vector(angle):
	theta = angle
	return Vector2(cos(theta), sin(theta))
func shoot_fan():
	if not jugador:
=======

func get_vector(angle):
	theta = angle
	return Vector2(cos(theta), sin(theta))

func shoot_fan():
	if not player:
>>>>>>> 5db119b3a352ce8a6b97023e854845729d09a638
		return
	if balas_disparadas >= MAX_LASERS:
		tipoDeBala = 1
		balas_disparadas = 0
		return
<<<<<<< HEAD
	if tipoDeBala == 1:
		if not enfriamiento_circulo:
			disparar_circulo()
		return
=======
>>>>>>> 5db119b3a352ce8a6b97023e854845729d09a638
	balas_disparadas += 1
	var bala = BULLET_SCENE.instantiate()
	add_child(bala)
	var spawn = $Marker2D
<<<<<<< HEAD
	bala.global_position = spawn.global_position
	var dir = spawn.global_position.direction_to(jugador.global_position)
	bala.direction = dir
	bala.tipoDeDisparo = tipoDeBala
	bala.set_property(tipoDeBala)
func disparar_circulo():
	enfriamiento_circulo = true
	var cantidad = 8
	for i in cantidad:
		var angulo = (2 * PI / cantidad) * i
		var bala = BULLET_SCENE.instantiate()
		get_tree().root.add_child(bala)
		bala.global_position = global_position
		bala.direction = Vector2.RIGHT.rotated(angulo)
		bala.tipoDeDisparo = 1
		bala.set_property(1)
	await get_tree().create_timer(0.5).timeout
	enfriamiento_circulo = false
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "disparar":
		dispare = false
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugadores"):
		body.vida -= 20
=======
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
>>>>>>> 5db119b3a352ce8a6b97023e854845729d09a638

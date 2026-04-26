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
var jugador = null
var dispare = false
var enfriamiento_circulo = false
var barritaEnemigo: ProgressBar
var vida = 500:
	set(value):
		vida = value
		if barritaEnemigo:
			barritaEnemigo.value = vida
		if vida <= 0:
			queue_free()

func _ready():
	jugador = get_tree().get_first_node_in_group("jugadores")
	add_to_group("enemigos")
	barritaEnemigo = get_tree().get_first_node_in_group("barra_enemigo")
	print("encontre barrita: ", barritaEnemigo)
	if barritaEnemigo:
		barritaEnemigo.max_value = 500
		barritaEnemigo.value = vida

func _physics_process(delta):
	if jugador:
		var dir = position.direction_to(jugador.position)
		velocity = dir * MOVE_SPEED
		move_and_slide()
	shoot_timer += delta
	if !dispare:
		dispare = true
		$AnimationPlayer.play("disparar")
func obtener_vector(angle):
	theta = angle
	return Vector2(cos(theta), sin(theta))
func shoot_fan():
	if not jugador:
		return
	if balas_disparadas >= MAX_LASERS:
		tipoDeBala = 1
		balas_disparadas = 0
		return
	if tipoDeBala == 1:
		if not enfriamiento_circulo:
			disparar_circulo()
		return
	balas_disparadas += 1
	var bala = BULLET_SCENE.instantiate()
	add_child(bala)
	var spawn = $Marker2D
	bala.global_position = spawn.global_position
	var dir = spawn.global_position.direction_to(jugador.global_position)
	bala.direction = dir
	bala.tipoDeDisparo = tipoDeBala
	bala.set_property(tipoDeBala)

func disparar_circulo():
	enfriamiento_circulo = true
	var cantidad = 6
	for i in cantidad:
		var angulo = (2 * PI / cantidad) * i
		var bala = BULLET_SCENE.instantiate()
		get_tree().root.add_child(bala)
		bala.global_position = global_position
		bala.direction = Vector2.RIGHT.rotated(angulo)
		bala.tipoDeDisparo = 1
		bala.set_property(1)
	await get_tree().create_timer(0.7).timeout
	enfriamiento_circulo = false

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "disparar":
		dispare = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugadores"):
		body.vida -= 20

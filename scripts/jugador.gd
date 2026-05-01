extends CharacterBody2D
const BALA_JUGADOR = preload("res://scenes/bullet_jugador.tscn")
var barrita: ProgressBar
var current_speed = 150.0
var invencible = false
var puede_disparar = true
var enemigo = null
var vida = 100:
	set(value):
		vida = value
		if barrita:
			barrita.value = vida
		if vida <= 0:
			get_tree().call_group("balas", "queue_free")
			get_tree().paused = true
			queue_free()

func _ready():
	add_to_group("jugadores")
	barrita = get_tree().get_first_node_in_group("barra_vida")
	if barrita:
		barrita.value = vida
	enemigo = get_tree().get_first_node_in_group("enemigos")
	
func _physics_process(_delta):
	if not barrita:
		barrita = get_tree().get_first_node_in_group("barra_vida")
	if not enemigo:
		enemigo = get_tree().get_first_node_in_group("enemigos")
	var input_dir = Input.get_vector("laA", "laD", "laW", "laS")
	velocity = input_dir * current_speed
	move_and_slide()
	position.x = clamp(position.x, 0, 2000)
	position.y = clamp(position.y, 0, 1200)
	var colision = get_last_slide_collision()
	if colision:
		var cuerpo = colision.get_collider()
		if cuerpo.is_in_group("enemigos") and not invencible:
			recibir_daño_contacto()
	disparar()

func disparar():
	if not is_instance_valid(enemigo) or not puede_disparar:
		return
	puede_disparar = false
	var bala = BALA_JUGADOR.instantiate()
	get_tree().root.add_child(bala)
	bala.global_position = global_position
	bala.direction = global_position.direction_to(enemigo.global_position)
	await get_tree().create_timer(1.0).timeout
	puede_disparar = true

func recibir_daño_contacto():
	invencible = true
	vida -= 20
	await get_tree().create_timer(1.0).timeout
	invencible = false
func set_status(disparo):
	match disparo:
		0:
			laser()
		1:
			veneno()
		2:
			ralentizar()

func laser():
	vida -= 10
func veneno():
	for i in range(5):
		vida -= 2
		await get_tree().create_timer(1).timeout
func ralentizar():
	vida -= 5
	current_speed = 100
	await get_tree().create_timer(2.0).timeout
	current_speed = 150.0

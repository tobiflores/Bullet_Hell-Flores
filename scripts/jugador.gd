extends CharacterBody2D

var barrita: ProgressBar
var current_speed = 150.0
var invencible = false

var vida = 100:
	set(value):
		vida = value
		if barrita:
			barrita.value=vida
		if vida <= 0:
				queue_free()

func _ready():
	add_to_group("jugadores")
	barrita = get_tree().get_first_node_in_group("barra_vida")
	if barrita:
		barrita.value = vida

func _physics_process(_delta):
	if not barrita:
		barrita = get_tree().get_first_node_in_group("barra_vida")
	var input_dir = Input.get_vector("laA", "laD", "laW", "laS")
	velocity = input_dir * current_speed
	move_and_slide()
	var colision = get_last_slide_collision()
	if colision:
		var cuerpo = colision.get_collider()
		if cuerpo.is_in_group("enemigos") and not invencible:
			recibir_daño_contacto()

func recibir_daño_contacto():
	invencible = true
	vida -= 20
	await get_tree().create_timer(1.0).timeout
	invencible = false

func set_status(bullet_type):
	match bullet_type:
		0:
			laser()
		1:
			poison()
		2:
			slow()
		3:
			paralizar()

func laser():
	vida -= 10

func poison():
	for i in range(5):
		vida -= 2
		await get_tree().create_timer(1).timeout

func slow():
	current_speed = 50

func paralizar():
	current_speed = 0
	await get_tree().create_timer(2.5).timeout
	current_speed = 150.0

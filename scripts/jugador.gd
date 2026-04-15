extends CharacterBody2D

var current_speed = 150.0

var health = 100:
	set(value):
		health = value
		$ProgressBar.value = value
		if health <= 0:
				queue_free()

func _ready():
	add_to_group("players")

func _physics_process(_delta):
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	print(input_dir)
	velocity = input_dir * current_speed
	move_and_slide()

func set_status(bullet_type):
	match bullet_type:
		0:
			fire()
		1:
			poison()
		2:
			slow()
		3:
			stun()

func fire():
	health -= 10

func poison():
	for i in range(5):
		health -= 2
		await get_tree().create_timer(1).timeout

func slow():
	current_speed = 50

func stun():
	current_speed = 0
	await get_tree().create_timer(2.5).timeout
	current_speed = 150.0

extends ProgressBar
var max = 500
var min = 0
var vida = 500
func _ready():
	add_to_group("barra_enemigo")
	max_value = max
	min_value = min
	value = vida

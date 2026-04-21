extends Area2D

@export var texture_array: Array[Texture2D]

var speed = 200
var direction = Vector2.RIGHT
var tipoDeDisparo: int = 0
var duration = 4.0

func _process(delta):
	position += direction * speed * delta
	duration -= delta
	if direction != Vector2.ZERO:
		rotation = direction.angle()

func set_property(type):
	tipoDeDisparo = type
	if texture_array.size() > type:
		$Sprite2D.texture = texture_array[type]

func _on_body_entered(body):
	if body.is_in_group("jugadores"):
		body.set_status(tipoDeDisparo)
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

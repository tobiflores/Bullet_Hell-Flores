extends Area2D

@export var texture_array: Array[Texture2D]

var speed = 200
var direction = Vector2.RIGHT
var bullet_type: int = 0
var duration = 4.0

func _process(delta):
	position += direction * speed * delta
	duration -= delta
	if duration <= 0:
		queue_free()

func set_property(type):
	bullet_type = type
	if texture_array.size() > type:
		$Sprite2D.texture = texture_array[type]

func _on_body_entered(body):
	if body.is_in_group("players"):
		body.set_status(bullet_type)
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

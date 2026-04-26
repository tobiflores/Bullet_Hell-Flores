extends Area2D
var speed = 300
var direction = Vector2.RIGHT
func _process(delta):
	position += direction * speed * delta
	if direction != Vector2.ZERO:
		rotation = direction.angle()
func _on_body_entered(body):
	if body.is_in_group("jugadores"):
		return
	if body.is_in_group("enemigos"):
		body.vida -= 10
		if body.vida <= 0:
			body.queue_free()
	queue_free()
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

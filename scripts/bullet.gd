extends Area2D

var velocity: Vector2 = Vector2()
var duration = 10

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	position += velocity * delta
	
	duration -= delta
	if duration<=0:
		queue_free()
		
func _on_body_entered(body):
	if body.is_in_group("players"):
		body.take_damage(1)
		queue_free()

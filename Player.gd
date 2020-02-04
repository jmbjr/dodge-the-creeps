extends Area2D

signal hit

export (int) var SPEED
var velocity = Vector2()
var screensize

func _ready():
	hide()
	screensize = get_viewport_rect().size
	
func _process(delta):
	velocity = get_direction()
	var new_rotation
	if velocity.length() > 0:
		$AnimatedSprite.play()
		velocity = velocity.normalized() * SPEED
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	if velocity.x != 0:
		new_rotation = PI/2 * sign(velocity.x)
		$AnimatedSprite.animation = "right"
		rotate_player(new_rotation)
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		new_rotation = 0
		$AnimatedSprite.animation = "up"
		rotate_player(new_rotation)
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.flip_v = velocity.y > 0
		
func rotate_player(new_rotation) -> void:
	$AnimatedSprite.rotation = new_rotation
	$CollisionShape2D.rotation = new_rotation
	
func get_direction() -> Vector2:
    return Vector2(
        Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
        Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up") 
    )

func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	call_deferred("set_monitoring", false)

func start(pos):
	position = pos
	show()
	monitoring = true

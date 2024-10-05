extends Area2D

signal hit

@export var speed = 400
var screenSize


func Start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _ready():
	screenSize = get_viewport_rect().size
	hide()

func _process(deltaTime):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("MoveRight"):
		velocity.x += 1
	if Input.is_action_pressed("MoveLeft"):
		velocity.x -= 1
	if Input.is_action_pressed("MoveDown"):
		velocity.y += 1
	if Input.is_action_pressed("MoveUp"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "Walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "Up"
		$AnimatedSprite2D.flip_v = velocity.y > 0

	position += velocity * deltaTime
	position = position.clamp(Vector2.ZERO, screenSize)

func _OnOverlap(body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mobTypes = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mobTypes[randi() % mobTypes.size()])

func _OnExitScreen() -> void:
	queue_free()

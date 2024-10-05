extends CanvasLayer

signal startGame

var originalMessage: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	originalMessage = $MessageLabel.text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func ShowMessage(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()
	
	
func ShowGameOver():
	ShowMessage("Game Over")
	await $MessageTimer.timeout
	
	$MessageLabel.text = originalMessage
	$MessageLabel.show()
	
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	
	
func UpdateScore(score):
	$ScoreLabel.text = str(score)


func OnStartButtonPressed() -> void:
	$StartButton.hide()
	startGame.emit()


func OnMessageTimer() -> void:
	$MessageLabel.hide()

extends Node

@export var mobScene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func GameOver() -> void:
	$HUD.ShowGameOver()
	$ScoreTimer.stop()
	$MobTimer.stop()
	
func NewGame():
	score = 0
	$HUD.UpdateScore(score)
	$HUD.ShowMessage("Get Ready")
	$Player.Start($StartPosition.position)
	$StartTimer.start()
	
func OnScoreTimer() -> void:
	score += 1
	$HUD.UpdateScore(score)
	
func OnStartTimer() -> void:
	$MobTimer.start()
	$ScoreTimer.start()

func OnMobTimer() -> void:
	var mob = mobScene.instantiate()
	
	var mobSpawnLocation = $MobPath/MobSpawnLocation
	mobSpawnLocation.progress_ratio = randf()
	
	var direction = mobSpawnLocation.rotation + PI/2
	
	mob.position = mobSpawnLocation.position
	
	direction += randf_range(-PI/4, PI/4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)

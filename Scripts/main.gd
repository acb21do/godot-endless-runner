extends Node

@onready var platform_spawner = $GameProcesses/PlatformSpawner
@onready var score_label = $Control/Score
@onready var deadzone = $Deadzone
@onready var player : Player = $Player

var score : int = 0
var speed_up_threshold = 2000
var game_over = false
var game_started = false


func _ready():
	$Player.process_mode = Node.PROCESS_MODE_INHERIT
	get_tree().paused = true


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and game_over:
		get_tree().paused = false
		get_tree().reload_current_scene()
	
	if event.is_action_pressed("ui_accept") and !game_started:
		player.game_started = true
		game_started = true
		get_tree().paused = false
		$Player.process_mode = Node.PROCESS_MODE_PAUSABLE


func _process(delta):
	if !game_over and game_started:
		score += 1
		score_label.text = str(score)
		if score % speed_up_threshold == 0:
			platform_spawner.speed_up()


func _on_deadzone_body_entered(body):
	game_over = true
	$Control.position = (Vector2(512/2, 256/2))
	score_label.text = "SCORE\n" + score_label.text
	get_tree().paused = true
	

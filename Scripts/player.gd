extends CharacterBody2D

class_name Player

@onready var animationPlayer : AnimationPlayer = $AnimationPlayer
@onready var stateMachine : Node = $StateMachine

var is_falling : bool = false
var max_jump_velocity : float = -130.0
var min_jump_velocity : float = -130.0

var tile_size : float = Global.tile_size
var max_jump_height : float = 1.5 * tile_size
var min_jump_height : float = 0.85 * tile_size
var max_speed : float = 5.0 * tile_size
var jump_duration : float = 0.6 #How long it takes to reach max jump height
var slide_duration : float = 0.5
var gravity : float = 0.0
var can_attack : bool = false
var game_started = false

func _ready():
	gravity = 2 * max_jump_height / pow(jump_duration, 2)
	max_jump_velocity = -sqrt(2 * gravity * max_jump_height)
	min_jump_velocity = -sqrt(2 * gravity * min_jump_height)
	

func apply_gravity(delta):
	velocity.y += gravity * delta
	velocity.y = clamp(velocity.y, velocity.y, gravity)

#Not used
#func apply_friction():
#	velocity.x = move_toward(velocity.x, 0, 20)
#
#
#func apply_acceleration(horizontal_direction):
#	velocity.x = move_toward(velocity.x, horizontal_direction * max_speed, 20)

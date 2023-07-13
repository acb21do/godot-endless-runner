extends PlayerState

func enter(_msg:= {}):
	#Makes the player move upwards
	player.velocity.y = player.max_jump_velocity
	#Makes the jump animation duration as long is it takes to reach max height
	var animation_length : float = player.animationPlayer.get_animation("jump").length
	var time_diff : float = abs(player.jump_duration - animation_length)
	var percentage_increase : float = (time_diff/ animation_length) * 100
	player.animationPlayer.speed_scale = (100.0 + percentage_increase)/100.0
	#Plays the jump animation
	player.animationPlayer.play("jump")


func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("down"):
		state_machine.transition_to("fall_state", {"Fast Fall": true})
	if event.is_action_pressed("attack") and player.can_attack:
		player.velocity.y = 0
		state_machine.transition_to("air_attack_forward_state")


func physics_update(delta: float) -> void:
	if player.velocity.y > 0:
		player.animationPlayer.speed_scale = 1.0 # reset anim speed
		state_machine.transition_to("fall_state")
		return
	player.apply_gravity(delta)
	player.move_and_slide()
	

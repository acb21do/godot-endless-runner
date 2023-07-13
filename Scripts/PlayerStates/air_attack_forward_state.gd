extends PlayerState


func enter(msg:= {}):
	#Enter the run state upon entering if on floor
	player.can_attack = false
	if player.is_on_floor():
		state_machine.transition_to("run_state")
		return
	player.animationPlayer.play("air_attack_forward")


func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("down"):
		state_machine.transition_to("fall_state", {"Fast Fall": true})


func physics_update(delta: float) -> void:
	if player.is_on_floor():
		state_machine.transition_to("run_state")
		return


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "air_attack_forward":
		state_machine.transition_to("fall_state")

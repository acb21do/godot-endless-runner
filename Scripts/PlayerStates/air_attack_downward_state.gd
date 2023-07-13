extends PlayerState


func enter(_msg:= {}):
	#Plays the first part of the animation then the second looping part
	player.animationPlayer.play("air_attack_down_1")
	player.animationPlayer.queue("air_attack_down_2")


func physics_update(delta: float) -> void:
	if player.is_on_floor():
		player.animationPlayer.play("air_attack_down_3")
		return
	player.apply_gravity(delta)
	player.move_and_slide()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "air_attack_down_3":
		state_machine.transition_to("run_state")

extends PlayerState

func enter(_msg:= {}):
	#Enter the fall state upon entering if not on floor
	player.animationPlayer.play("slide")


func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("up"):
		state_machine.transition_to("jump_state")
	if event.is_action_pressed("attack"):
		state_machine.transition_to("forward_attack_state")

func physics_update(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("fall_state")
		return


func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "slide"):
		state_machine.transition_to("run_state")

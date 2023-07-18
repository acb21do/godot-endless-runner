extends PlayerState


func enter(_msg:= {}):
	player.can_attack = true
	#Start jumping if the player is holding the jump key
	if Input.is_action_pressed("up"):
		state_machine.transition_to("jump_state")
		return
	#Enter the fall state upon entering if not on floor
	if not player.is_on_floor():
		state_machine.transition_to("fall_state")
		return
	player.animationPlayer.play("run")


func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("up"):
		state_machine.transition_to("jump_state")
	if event.is_action_pressed("down"):
		state_machine.transition_to("slide_state")
	if event.is_action_pressed("attack"):
		state_machine.transition_to("forward_attack_state")

func physics_update(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("fall_state")
		return
	player.move_and_slide()


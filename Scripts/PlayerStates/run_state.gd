extends PlayerState


func enter(_msg:= {}):
	#Enter the fall state upon entering if not on floor
	if not player.is_on_floor():
		state_machine.transition_to("fall")
		return
	player.animationPlayer.play("run")
	player.can_attack = true


func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("up"):
		state_machine.transition_to("jump")
	if event.is_action_pressed("down"):
		state_machine.transition_to("slide")
	if event.is_action_pressed("attack"):
		state_machine.transition_to("forward_attack")

func physics_update(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("fall_state")
		return
	player.move_and_slide()


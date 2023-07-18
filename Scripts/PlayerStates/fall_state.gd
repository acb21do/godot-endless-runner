extends PlayerState


func enter(msg:= {}):
	if msg.get("Fast Fall"):
		fast_fall()
	player.animationPlayer.play("fall")

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("down"):
		fast_fall()
	if Input.is_action_pressed("down") and Input.is_action_pressed("attack"):
		state_machine.transition_to("air_attack_downward_state")
		return

	if event.is_action_pressed("attack") and player.can_attack:
		player.velocity.y = 0
		state_machine.transition_to("air_attack_forward_state")

func physics_update(delta: float) -> void:
	if player.is_on_floor():
		state_machine.transition_to("run_state")
		return
	player.apply_gravity(delta)
	player.move_and_slide()

func fast_fall():
	player.velocity.y = 1000#150 * 4

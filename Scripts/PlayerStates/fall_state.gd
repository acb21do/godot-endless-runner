extends PlayerState


func enter(msg:= {}):
	if msg.get("Fast Fall"):
		player.velocity.y = 150 * 3
	player.animationPlayer.play("fall")

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("down"):
		player.velocity.y = 150 * 3
	if Input.is_action_pressed("down") and Input.is_action_pressed("attack"):
		state_machine.transition_to("air_attack_down_state")
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

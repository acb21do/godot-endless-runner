extends PlayerState

func enter(msg:= {}):
	player.animationPlayer.play("idle")

func update(_delta):
	if player.game_started:
		state_machine.transition_to("run_state")

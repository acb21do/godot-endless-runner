extends Node
class_name BaseState

#Each State has a state machine it is assigned to
var state_machine : StateMachine

#Unhandled Input
func handle_input(_event: InputEvent) -> void:
	pass

#Process
func update(_delta: float) -> void:
	pass

#Physics Process
func physics_update(_delta: float) -> void:
	pass

#Ready
func enter(_msg := {}) -> void:
	pass

#Called when leaving a state
func exit() -> void:
	pass

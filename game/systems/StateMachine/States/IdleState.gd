extends State
class_name IdleState

@export var animationPlayer: AnimationPlayer
@export var animation: String = "Idle"

func enter() -> void:
    if animationPlayer:
        animationPlayer.play(animation)

func exit() -> void:
    if animationPlayer:
        animationPlayer.stop()
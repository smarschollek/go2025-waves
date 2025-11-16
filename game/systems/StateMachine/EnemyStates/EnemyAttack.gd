extends State
class_name EnemyAttack

@export var animationPlayer: AnimationPlayer
@export var animation: String = "Attack"

func enter() -> void:
    if animationPlayer:
        animationPlayer.play(animation)
    
func exit() -> void:
    if animationPlayer:
        animationPlayer.stop()



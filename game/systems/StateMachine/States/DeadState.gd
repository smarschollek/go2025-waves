extends State
class_name DeadState

@export var entityToFree: Node2D
@export var animationPlayer: AnimationPlayer
@export var animation: String = "Dead"

func enter() -> void:
    if animationPlayer:
        animationPlayer.play(animation)
        await animationPlayer.animation_finished
        
    entityToFree.queue_free()

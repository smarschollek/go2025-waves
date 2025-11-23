extends State
class_name WalkingState

@export var speed: float = 100.0
@export var entity: AnimatableBody2D

@export var animationPlayer: AnimationPlayer
@export var animation: String = "Walk"

func enter() -> void:
    if animationPlayer:
        animationPlayer.play(animation)
                
func physics_update(delta: float) -> void:
    entity.position.x += speed * delta
    

extends State
class_name EnemyWalking

@export var speed = 100
@export var enemy: AnimatableBody2D

@export var animationPlayer: AnimationPlayer
@export var animation: String = "Walk"



func enter() -> void:
    if animationPlayer:
        animationPlayer.play(animation)


func exit() -> void:
    if animationPlayer:
        animationPlayer.stop()

func physics_update(delta: float) -> void:
    enemy.position.x += speed * delta * EnemyManager.speedMultiplier
    

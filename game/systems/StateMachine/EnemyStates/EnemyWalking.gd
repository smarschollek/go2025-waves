extends State
class_name EnemyWalking

@export var speed = 100
@export var enemy: AnimatableBody2D

@export var animationTree: AnimationTree
@export var animtationTreeParam: String = "parameters/conditions/is_walking"


func enter() -> void:
    if animationTree:
        animationTree[animtationTreeParam] = true

func exit() -> void:
    if animationTree:
        animationTree[animtationTreeParam] = false

func physics_update(delta: float) -> void:
    enemy.position.x += speed * delta * EnemyManager.speedMultiplier
    

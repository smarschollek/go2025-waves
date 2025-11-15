extends State
class_name EnemyAttack

@export var enemy: AnimatableBody2D

@export var animationTree: AnimationTree
@export var animtationTreeParam: String = "parameters/conditions/is_attacking"

func enter() -> void:
    animationTree[animtationTreeParam] = true
    
func exit() -> void:
    animationTree[animtationTreeParam] = false



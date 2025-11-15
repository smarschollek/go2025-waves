extends State
class_name EnemyHurt

@export var animationTree: AnimationTree
@export var animtationTreeParam: String = "parameters/conditions/is_hurt"

func enter() -> void:
    animationTree[animtationTreeParam] = true
    pass

func exit() -> void:
    animationTree[animtationTreeParam] = false
    pass

func physics_update(_delta: float) -> void:
    await animationTree.animation_finished
    previousState.emit()
    pass

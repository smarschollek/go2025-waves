extends State
class_name EnemyDead


@export var enemy: AnimatableBody2D
@export var animationTree: AnimationTree
@export var animtationTreeParam: String = "parameters/conditions/is_dead"

@export var coinsDropped := 1

func enter() -> void:
    if animationTree:
        animationTree[animtationTreeParam] = true

    await animationTree.animation_finished
    await get_tree().create_timer(0.5).timeout
    enemy.queue_free()

    MoneyManager.addMoney(coinsDropped)

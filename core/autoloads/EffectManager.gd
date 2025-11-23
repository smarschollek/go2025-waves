extends Node

var slowedStates = []

func applySlow(sprite: Node2D, walkState: WalkingState, attackState: AttackState, duration: float) -> void:
    if slowedStates.has(walkState):
        return

    slowedStates.append(walkState)

    var currentSpeed = walkState.speed
    var currenAttackInterval = attackState.attackInterval

    walkState.speed = currentSpeed * 0.5
    attackState.attackInterval = currenAttackInterval * 0.5
    sprite.modulate = Color(0, 0, 1)

    await get_tree().create_timer(duration).timeout
    
    if not is_instance_valid(walkState):
        return

    if not is_instance_valid(attackState):
        return

    if not is_instance_valid(sprite):
        return

    walkState.speed = currentSpeed
    attackState.attackInterval = currenAttackInterval
    sprite.modulate = Color(1, 1, 1)

    slowedStates.erase(walkState)

func applyDamage(sprite: Node2D):
    var currentModulate = sprite.modulate
    sprite.modulate = Color(1, 0, 0)
    await get_tree().create_timer(0.1).timeout
    sprite.modulate = currentModulate

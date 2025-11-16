extends State
class_name EnemyDead


@export var enemy: AnimatableBody2D
@export var animationPlayer: AnimationPlayer
@export var animation: String = "Dead"

@export var coinsDropped := 1

func enter() -> void:
    if animationPlayer:
        animationPlayer.play(animation)
        await animationPlayer.animation_finished

    enemy.queue_free()
    MoneyManager.addMoney(coinsDropped)

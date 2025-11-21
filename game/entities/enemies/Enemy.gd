extends AnimatableBody2D

@export var data : Attacker

func _ready() -> void:
    $Hurtbox.health = data.health
    $Hurtbox.died.connect(_on_hurtbox_died)
    $Hurtbox.receivedDamage.connect(_on_hurtbox_receivedDamage)

    $Lifebar.max_value = data.health

    $Hitbox.damage = data.attackDamage
    $StateMachine/Attack.attackInterval = data.attackInterval
    $StateMachine/Walk.speed = data.moveSpeed
        
func _physics_process(_delta: float) -> void:
    if($Hurtbox.dead):
        return

    $Lifebar.value = $Hurtbox.health
    $Lifebar.visible = $Hurtbox.health < data.health

    if $RayCast2D.is_colliding():
        $StateMachine.changeState("Attack")
    else:
        $StateMachine.changeState("Walk")

func _on_hurtbox_died() -> void:
    ReportManager.killedUnits += 1
    LevelUpManager.addXP(1)
    $StateMachine.changeState("Dead")

func _on_hurtbox_receivedDamage(_damageAmount: int, effectName: String, duration: float) -> void:
    if effectName.to_lower() == "slow":
        $StateMachine/Walk.speed = data.moveSpeed * 0.5
        $StateMachine/Attack.attackInterval = data.attackInterval * 0.5
        $AnimatedSprite2D.modulate = Color(0, 0, 1)

        await get_tree().create_timer(duration).timeout
        
        $StateMachine/Walk.speed = data.moveSpeed
        $StateMachine/Attack.attackInterval = data.attackInterval
        $AnimatedSprite2D.modulate = Color(1, 1, 1)
    else:
        var currentModulate = $AnimatedSprite2D.modulate
        $AnimatedSprite2D.modulate = Color(1, 0, 0)
        await get_tree().create_timer(0.1).timeout
        $AnimatedSprite2D.modulate = currentModulate
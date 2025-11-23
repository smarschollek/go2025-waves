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

    $AnimatedSprite2D.modulate = data.tint
        
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
    $StateMachine.changeState("Dead")
    ReportManager.killedUnits += 1

func _on_hurtbox_receivedDamage(_damageAmount: int, effectName: String, duration: float) -> void:
    if effectName.to_lower() == "slow":
        EffectManager.applySlow($AnimatedSprite2D, $StateMachine/Walk, $StateMachine/Attack, duration)
    else:
        EffectManager.applyDamage($AnimatedSprite2D)

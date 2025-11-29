extends Node2D

@export var data: Defender


var health := 0

func _ready() -> void:
    health = round(UpgradeManager.applyUpgrades(data.health, data.defenderType, UpgradeManager.UPGRADETYPES.health))
    $Hurtbox.health = data.health
    $Hurtbox.receivedDamage.connect(_on_hurtbox_receivedDamage)

    $Lifebar.max_value = health
    $Hitbox.damage = UpgradeManager.applyUpgrades(data.attackDamage, data.defenderType, UpgradeManager.UPGRADETYPES.attackDamage)
    $StateMachine/Attack.attackInterval = UpgradeManager.applyUpgrades(data.attackInterval, data.defenderType, UpgradeManager.UPGRADETYPES.attackSpeed)

func _physics_process(_delta: float) -> void:
    
    if($Hurtbox.dead):
        $StateMachine.changeState("Dead")
        return

    $Lifebar.value = $Hurtbox.health
    if $RayCast2D.is_colliding():
        $StateMachine.changeState("Attack")    
    else:
        $StateMachine.changeState("Idle")

    $Lifebar.value = $Hurtbox.health
    $Lifebar.visible = $Hurtbox.health < health

func _on_hurtbox_receivedDamage(_damageAmount: int, _effectName: String, _duration: float) -> void:
    EffectManager.applyDamage($AnimatedSprite2D)
